//
//  HotCVCell.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/10.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "HotCVCell.h"

@implementation HotCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _photo.layer.cornerRadius = _photo.frame.size.width/2;
    
}

@end
