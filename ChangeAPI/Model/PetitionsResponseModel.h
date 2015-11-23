//
//  PetitionsResponseModel.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PetitionsResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *page;
@property (nonatomic, copy) NSString *prevPageEndpoint;
@property (nonatomic, copy) NSString *nextPageEndpoint;
@property (nonatomic, copy) NSNumber *totalPages;
@property (nonatomic, copy) NSArray *petitions; // [<PetitionResponseModel>]

@end
