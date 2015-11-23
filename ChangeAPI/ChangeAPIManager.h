//
//  ChangeAPIManager.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//
// Basic ideology taken straight from:
// - http://www.toptal.com/ios/simplifying-restful-api-use-and-data-persistence-on-ios-with-mantle-and-realm
//

#import <Foundation/Foundation.h>

#import "BaseSessionManager.h"

#import "PetitionIdsRequestModel.h"
#import "PetitionsResponseModel.h"
#import "PetitionIdRequestModel.h"
#import "PetitionResponseModel.h"
#import "PetitionUrlRequestModel.h"
#import "PetitionIdResponseModel.h"

@interface ChangeAPIManager : BaseSessionManager

- (NSURLSessionDataTask *)petitionsWithPetitionIdsRequestModel:(PetitionIdsRequestModel *)requestModel
                                                       success:(void (^)(PetitionsResponseModel *responseModel))success
                                                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)petitionWithPetitionIdRequestModel:(PetitionIdRequestModel *)requestModel
                                                     success:(void (^)(PetitionResponseModel *responseModel))success
                                                     failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)petitionIdWithPetitionUrlRequestModel:(PetitionUrlRequestModel *)requestModel
                                                        success:(void (^)(PetitionIdResponseModel *responseModel))success
                                                        failure:(void (^)(NSError *error))failure;

@end
