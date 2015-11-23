//
//  TargetModel.h
//  ChangeAPI
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TargetResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type; // us_government or custom
@property (nonatomic, copy) NSString *targetArea; // if applicable, in the US a two-letter state abbreviation

@end
