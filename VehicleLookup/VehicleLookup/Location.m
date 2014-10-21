//
//  Location.m
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-18.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "Location.h"

@implementation Location

-(id) initWithLatitude:(double)latitude andLongitude:(double)longitude {
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
        
    }
    return self;
}

@end
