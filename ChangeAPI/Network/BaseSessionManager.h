//
//  BaseSessionManager.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface BaseSessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
