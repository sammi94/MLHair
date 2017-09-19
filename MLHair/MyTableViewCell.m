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
    [[MLHairDatabase stand].connection signOut];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
