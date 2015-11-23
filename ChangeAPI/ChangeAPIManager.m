//
//  ChangeManagerAPI.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <CommonCrypto/CommonHMAC.h>

#import "ChangeAPIManager.h"
#import "QueryStringUtil.h"

static NSString *const kPetitionsPath = @"/v1/petitions";
static NSString *const kApiKey      = @"replace this with your own key";
static NSString *const kApiSecret   = @"replace this with your own secret";

@implementation ChangeAPIManager

#pragma mark - Private static methods

// ISO 8601 compliant date formatter
+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    });
    return _dateFormatter;
}

#pragma mark - Public methods

- (NSURLSessionDataTask *)petitionsWithPetitionIdsRequestModel:(PetitionIdsRequestModel *)requestModel
                                                       success:(void (^)(PetitionsResponseModel *responseModel))success
                                                       failure:(void (^)(NSError *error))failure
{
    NSError *error;
    NSDictionary *parameters = [self requestParametersWithModel:requestModel forEndpoint:kPetitionsPath error:&error];
    
    if ( error ) {
        failure(error);
        return nil;
    }
    
    return [self GET:kPetitionsPath parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject)
            {
                NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                
                NSError *error;
                PetitionsResponseModel *response = [MTLJSONAdapter modelOfClass:PetitionsResponseModel.class
                                                             fromJSONDictionary:responseDictionary error:&error];
                if ( error ) {
                    failure(error);
                }
                else {
                    success(response);
                }
            }
             failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                failure(error);
            }];
}

- (NSURLSessionDataTask *)petitionWithPetitionIdRequestModel:(PetitionIdRequestModel *)requestModel
                                                     success:(void (^)(PetitionResponseModel *responseModel))success
                                                     failure:(void (^)(NSError *error))failure
{
    NSError *error;
    NSString *endpoint = [NSString stringWithFormat:@"%@/%li", kPetitionsPath, (long)requestModel.petitionId.integerValue];
    NSMutableDictionary *parameters = [self requestParametersWithModel:requestModel forEndpoint:endpoint error:&error];
    
    if ( error ) {
        failure(error);
        return nil;
    }
    
    return [self GET:endpoint parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject)
            {
                NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                
                NSError *error;
                PetitionResponseModel *response = [MTLJSONAdapter modelOfClass:PetitionResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                if ( error ) {
                    failure(error);
                }
                else {
                    success(response);
                }
            }
             failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                failure(error);
            }];
}

- (NSURLSessionDataTask *)petitionIdWithPetitionUrlRequestModel:(PetitionUrlRequestModel *)requestModel
                                                     success:(void (^)(PetitionIdResponseModel *responseModel))success
                                                     failure:(void (^)(NSError *error))failure
{
    NSError *error;
    NSString *endpoint = [NSString stringWithFormat:@"%@/get_id", kPetitionsPath];
    NSDictionary *parameters = [self requestParametersWithModel:requestModel forEndpoint:endpoint error:&error];
    
    if ( error ) {
        failure(error);
        return nil;
    }
    
    return [self GET:endpoint parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject)
            {
                NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                
                NSError *error;
                PetitionIdResponseModel *response = [MTLJSONAdapter modelOfClass:PetitionIdResponseModel.class
                                                             fromJSONDictionary:responseDictionary error:&error];
                if ( error ) {
                    failure(error);
                }
                else {
                    success(response);
                }
            }
             failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                failure(error);
            }];
}

#pragma mark - Private methods

- (NSMutableDictionary *)requestParametersWithModel:(id<MTLJSONSerializing>)model forEndpoint:(NSString *)endpoint error:(NSError **)error
{
    NSMutableDictionary *parameters = [[MTLJSONAdapter JSONDictionaryFromModel:model error:error] mutableCopy];
    
    if ( *error ) {
        return nil;
    }
    
    [parameters setObject:kApiKey forKey:@"api_key"];
    [parameters setObject:endpoint forKey:@"endpoint"];
    [parameters setObject:[[ChangeAPIManager dateFormatter] stringFromDate:[NSDate date]] forKey:@"timestamp"];
    
    NSString *requestBody = [QueryStringUtil QueryStringFromParameters:parameters];
    //NSString *requestBody = [self queryStringFrom:parameters];
    NSString *requestSignature = [self requestSignatureFor:requestBody withAuthKey:nil];
    [parameters setObject:requestSignature forKey:@"rsig"];
    
    return parameters;
}

//
// Request Signatures: https://github.com/change/api_docs/blob/master/v1/documentation/requests.md
// More info at: https://en.wikipedia.org/wiki/Hash-based_message_authentication_code
// Found on: http://stackoverflow.com/questions/756492/objective-c-sample-code-for-hmac-sha1
//
// Creates a request signature. This is a 256-bit hexadecimal SHA-2 digest of the
// POST body or GET query string appended with the user's secret token and, for
// requests that require it, the resource authorization key.
//
// To construct a request signature, the components are ordered as follows:
// - [POST body or GET query string][secret token][authorization key, if applicable]
//
// Then, a 256-bit SHA-2 digest is created of that resulting string. This is then
// passed as a parameter, rsig./
//
- (NSString *)requestSignatureFor:(NSString *)body withAuthKey:(NSString *)authKey
{
    body = [NSString stringWithFormat:@"%@%@", body, kApiSecret];
    
    if ( authKey ) {
        body = [NSString stringWithFormat:@"%@%@", body, authKey];
    }
    
    const char *cKey  = [kApiKey cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [body cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    
    for (int i = 0; i < HMACData.length; ++i) {
        HMAC = [HMAC stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
    }
    
    return HMAC;
}

- (NSString *)queryStringFrom:(NSDictionary *)parameters
{
    NSURLComponents *components = [NSURLComponents componentsWithString:@""];
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in parameters) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:parameters[key]]];
    }
    components.queryItems = queryItems;
    
    NSString *queryStr = components.URL.relativeString;
    if ( [queryStr hasPrefix:@"?"] ) {
        queryStr = [queryStr substringFromIndex:1];
    }
    
    return queryStr;
}

@end
