//
//  UserPrefs.m
//  SampleApp
//
//  Created by Ashish on 2014-10-20.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import "UserPrefs.h"

@implementation UserPrefs

static UserPrefs *_userPrefs = nil;

+(id) sharedInstance {
    if (_userPrefs == nil) {
        _userPrefs = [[self alloc] init];
    }
    return _userPrefs;
}

+(NSString *) currentAppId {
    return @"4ee04b80-d0bf-4f23-8ae5-641a9a6660af";
}

+(NSString *) appSecretKey {
    return @"8793794c-b244-4048-a73e-721e1378ee1b";
}

+(NSString *)appSecretKeySandbox {
    return @"403b2ab4-8a2d-4fbd-b1eb-d57b83d52ca1";
}

+(void)saveMojioApiToken:(NSString *)apiToken {
    [[NSUserDefaults standardUserDefaults] setObject:apiToken forKey:@"MojioApiToken"];
    [[NSUserDefaults standardUserDefaults] setObject:@"LoggedIn" forKey:@"IsUserLoggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)mojioApiToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"MojioApiToken"];
}

+(void) saveMojioUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"MojioUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL) isUserLoggedIn {
    NSString *isLoggedIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoggedIn"];
    if ([isLoggedIn isEqualToString:@"LoggedIn"]) {
        return YES;
    }
    return NO;
}

+(void) logout {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"MojioApiToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
