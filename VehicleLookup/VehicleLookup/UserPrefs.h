//
//  UserPrefs.h
//  SampleApp
//
//  Created by Ashish on 2014-10-20.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPrefs : NSObject

+(NSString *) currentAppId;
+(NSString *) appSecretKey;
+(NSString *)appSecretKeySandbox;


+ (void) saveMojioApiToken : (NSString *) apiToken;
+ (NSString *) mojioApiToken;

+ (void) saveMojioUserId : (NSString *) userId;

+ (void) logout;
+ (BOOL) isUserLoggedIn;

+(id) sharedInstance;

@end
