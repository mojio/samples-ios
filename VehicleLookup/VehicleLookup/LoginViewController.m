//
//  ViewController.m
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-15.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import "LoginViewController.h"
#import "VehicleViewController.h"
#import "AFNetworking.h"
#import "AFNetworking.h"
#import "UserPrefs.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(IBAction)loginButtonPressed:(id)sender {
    NSString *username = [self.userNameField text];
    NSString *password = [self.passwordField text];
    
    [self login:username withPassword:password];
    
}

- (void) login : (NSString *)userName withPassword:(NSString *)password {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.moj.io/v1/login/%@?secretKey=%@&userOrEmail=%@&password=%@", [UserPrefs currentAppId], [UserPrefs appSecretKeySandbox], userName, password ];
    
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"object is %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSLog(@"oops, response is array");
        }
        else if ([responseObject isKindOfClass:[NSDictionary class]]){
            NSString *userID = (NSString *)[responseObject objectForKey:@"UserId"];
            NSString *mojioApiToken = (NSString*)[responseObject objectForKey:@"_id"];
            
            if (userID)
                [UserPrefs saveMojioUserId:userID];
            
            if (mojioApiToken)
                [UserPrefs saveMojioApiToken:mojioApiToken];
            
            // send message to the calling method
            [self.delegate didLoginWithController:self];
//            [self performSegueWithIdentifier:@"loginSuccess" sender:nil];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure message is %@", [error localizedDescription]);
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
