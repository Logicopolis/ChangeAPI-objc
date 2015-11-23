//
//  PetitionIDsRequestModel.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PetitionIdsRequestModel : MTLModel <MTLJSONSerializing>

// Required
@property (nonatomic, copy) NSArray *petitionIds;

// Optional
@property (nonatomic, copy) NSArray *fields;
@property (nonatomic, copy) NSNumber *pageSize;
@property (nonatomic, copy) NSNumber *page;
@property (nonatomic, copy) NSString *sort; // may be signatures_asc|signatures_desc OR time_asc|time_desc

@end
