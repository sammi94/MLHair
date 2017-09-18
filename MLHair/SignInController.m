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
#import "MLHairDatabase.h"
#import "Model'sVC.h"
#import "DesignerVC.h"
#import "MyTableViewController.h"
#import "SignInVC.h"

@implementation SignInController

-(BOOL)isSignIn {
    return [FBSDKAccessToken currentAccessToken] ||
    [[GIDSignIn sharedInstance] hasAuthInKeychain];
}

-(void)signOut {
    
    if ([MLHairDatabase stand].member.signType == 2) {
        [[GIDSignIn sharedInstance] signOut];
    } else if ([MLHairDatabase stand].member.signType == 1) {
        [[FBSDKLoginManager new] logOut];
    }
    [MLHairDatabase stand].member = [MemberVO new];
    
    for (UIViewController *vc in [MLHairDatabase stand].vcs) {
        if ([vc isKindOfClass:[Model_sVC class]]) {
            [vc viewWillAppear:true];
        }
        if ([vc isKindOfClass:[DesignerVC class]]) {
            [((DesignerVC*)vc).bookingTable reloadData];
        }
        if ([vc isKindOfClass:[MyTableViewController class]]) {
            [((MyTableViewController*)vc).tableView reloadData];
            SignInVC *signInVC = [((MyTableViewController*)vc).storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
            [((MyTableViewController*)vc).navigationController pushViewController:signInVC animated:true];
        }
    }
}

@end
