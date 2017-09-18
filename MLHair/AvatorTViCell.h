//
//  AvatorTViCell.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/6.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceImageView.h"

@interface AvatorTViCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AdvanceImageView *avator;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mail;


@end
