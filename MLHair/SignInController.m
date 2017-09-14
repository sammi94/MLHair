//
//  SignInController.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/15.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "SignInController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@implementation SignInController

-(BOOL)isSignIn {
    return [FBSDKAccessToken currentAccessToken] ||
    [[GIDSignIn sharedInstance] hasAuthInKeychain];
}

@end
