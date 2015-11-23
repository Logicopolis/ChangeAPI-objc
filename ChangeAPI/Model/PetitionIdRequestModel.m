//
//  PetitionIdRequestModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "PetitionIdRequestModel.h"

@implementation PetitionIdRequestModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"petitionId": @"petition_id",
             @"fields": @"fields"
             };
}

@end
