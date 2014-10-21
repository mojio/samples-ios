//
//  Vehicle.h
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-18.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Vehicle : NSObject

@property (nonatomic, strong) Location *location;
@property (nonatomic) double fuelLevel;
@property (nonatomic) double fuelEfficiency;
@property (nonatomic, strong) NSString *vehicleName;

@end
