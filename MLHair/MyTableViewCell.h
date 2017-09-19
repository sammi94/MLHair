//
//  MyTableViewCell.h
//  MLHair
//
//  Created by sammi on 2017/8/29.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewController.h"

@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *signOutBtn;
@property (weak, nonatomic) MyTableViewController *vc;

@end
