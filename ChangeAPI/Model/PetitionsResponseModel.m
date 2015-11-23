//
//  PetitionsResponseModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "PetitionsResponseModel.h"
#import "PetitionResponseModel.h"

@implementation PetitionsResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"page": @"page",
             @"prevPageEndpoint": @"prev_page_endpoint",
             @"nextPageEndpoint": @"next_page_endpoint",
             @"totalPages": @"total_pages",
             @"petitions": @"petitions"
             };
}

#pragma mark - JSON Transformers

+ (NSValueTransformer *)petitionsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:PetitionResponseModel.class];
}

@end
