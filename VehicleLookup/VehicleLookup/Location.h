//
//  Location.h
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-18.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property(nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) BOOL fromLockedGPS;
@property (nonatomic, strong) NSString *lastKnownAddress;

-(id) initWithLatitude : (double)latitude andLongitude : (double)longitude;

@end
