//
//  MyTableViewCell.m
//  MLHair
//
//  Created by sammi on 2017/8/29.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MLHairDatabase.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKLoginManager.h>
#import "SignInVC.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)signOut:(id)sender {
    
    if ([MLHairDatabase stand].member.signType == 2) {
        [[GIDSignIn sharedInstance] signOut];
    } else if ([MLHairDatabase stand].member.signType == 1) {
        [[FBSDKLoginManager new] logOut];
    }
    
    [MLHairDatabase stand].member = [MemberVO new];
    [_vc.tableView reloadData];
    
    SignInVC *signInVC = [_vc.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
    [_vc.navigationController pushViewController:signInVC animated:true];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
