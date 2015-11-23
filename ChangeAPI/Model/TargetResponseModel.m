//
//  TargetModel.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "TargetResponseModel.h"

@implementation TargetResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name": @"name",
             @"title": @"title",
             @"type": @"type",
             @"targetArea": @"target_area"
             };
}

@end
