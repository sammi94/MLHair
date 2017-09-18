//
//  AvatorTViCell.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/6.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "AvatorTViCell.h"

@interface AvatorTViCell ()


@end

@implementation AvatorTViCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avator.layer.cornerRadius = _avator.frame.size.height/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
