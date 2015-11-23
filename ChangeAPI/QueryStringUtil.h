//
//  QueryStringUtil.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFURLRequestSerialization.h>

@interface QueryStringUtil : AFHTTPRequestSerializer

+ (NSString *)QueryStringFromParameters:(NSDictionary *)parameters;

@end
