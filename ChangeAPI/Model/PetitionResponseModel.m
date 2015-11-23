//
//  PetitionModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "PetitionResponseModel.h"
#import "TargetResponseModel.h"

@implementation PetitionResponseModel

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    return dateFormatter;
}

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title": @"title",
             @"status": @"status",
             @"urlStr": @"url",
             @"overview": @"overview",
             @"targets": @"targets",
             @"letterBody": @"letter_body",
             @"signatureCount": @"signature_count",
             @"imageUrlStr": @"image_url",
             @"category": @"category",
             @"goal": @"goal",
             @"createdAtDate": @"created_at",
             @"endAtDate": @"end_at",
             @"creatorName": @"creator_name",
             @"creatorUrlStr": @"creator_url",
             @"organizationName": @"organization_name",
             @"organizationUrlStr": @"organization_url"
             };
}

#pragma mark - JSON Transformers

+ (NSValueTransformer *)targetsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TargetResponseModel.class];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                                 NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)endAtDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                                 NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
