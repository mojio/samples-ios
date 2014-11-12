//
//  ViewController.h
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-15.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import "BaseViewController.h"
@class LoginViewController;

@protocol LoginControllerDelegate <NSObject>

-(void) didLoginWithController : (LoginViewController*) loginController;

@end

@interface LoginViewController : BaseViewController

@property (nonatomic, weak) id<LoginControllerDelegate> delegate;

@end
