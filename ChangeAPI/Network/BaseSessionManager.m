//
//  BaseSessionManager.m
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import "BaseSessionManager.h"

static NSString *const kBaseURL = @"https://api.change.org";

@implementation BaseSessionManager

- (id)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    if ( self ) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

+ (id)sharedManager
{
    static BaseSessionManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

@end
