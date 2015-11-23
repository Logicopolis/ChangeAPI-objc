//
//  PetitionUrlRequestModel.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PetitionUrlRequestModel : MTLModel <MTLJSONSerializing>

// Required
@property (nonatomic, copy) NSString *petitionUrlStr;

@end
