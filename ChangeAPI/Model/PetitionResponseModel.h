//
//  PetitionModel.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PetitionResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSString *overview;
@property (nonatomic, copy) NSArray  *targets; // [<TargetModel>]
@property (nonatomic, copy) NSString *letterBody;
@property (nonatomic, copy) NSNumber *signatureCount; // int
@property (nonatomic, copy) NSString *imageUrlStr;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSNumber *goal; // int
@property (nonatomic, copy) NSDate   *createdAtDate; // ISO-8601 datetime
@property (nonatomic, copy) NSDate   *endAtDate; // ISO-8601 datetime
@property (nonatomic, copy) NSString *creatorName;
@property (nonatomic, copy) NSString *creatorUrlStr;
@property (nonatomic, copy) NSString *organizationName;
@property (nonatomic, copy) NSString *organizationUrlStr;

@end
