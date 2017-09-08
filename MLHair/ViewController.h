//
//  ViewController.h
//  MLHair
//
//  Created by sammi on 2017/7/24.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "MasterViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController<GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

