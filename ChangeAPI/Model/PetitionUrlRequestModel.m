//
//  PetitionUrlRequestModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "PetitionUrlRequestModel.h"

@implementation PetitionUrlRequestModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"petitionUrlStr": @"petition_url"
             };
}

@end
