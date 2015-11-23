//
//  PetitionIDsRequestModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "PetitionIdsRequestModel.h"

@implementation PetitionIdsRequestModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"petitionIds": @"petition_ids",
             @"fields": @"fields",
             @"pageSize": @"page_size",
             @"page": @"page",
             @"sort": @"sort"
             };
}

#pragma mark - JSON Transformers

+ (NSValueTransformer *)petitionIdsJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *idsArray, BOOL *success, NSError *__autoreleasing *error) {
        return [idsArray componentsJoinedByString:@","];
    } reverseBlock:^id(NSString *ids, BOOL *success, NSError *__autoreleasing *error) {
        return [ids componentsSeparatedByString:@","];
    }];
}

+ (NSValueTransformer *)fieldsJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *fieldsArray, BOOL *success, NSError *__autoreleasing *error) {
        return [fieldsArray componentsJoinedByString:@","];
    } reverseBlock:^id(NSString *fields, BOOL *success, NSError *__autoreleasing *error) {
        return [fields componentsSeparatedByString:@","];
    }];
}

@end
