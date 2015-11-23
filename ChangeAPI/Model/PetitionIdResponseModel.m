//
//  PetitionIdResponseModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "PetitionIdResponseModel.h"

@implementation PetitionIdResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"petitionId": @"petition_id"
             };
}

@end
