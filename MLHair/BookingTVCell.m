//
//  BookingTVCell.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/17.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "BookingTVCell.h"

@implementation BookingTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)done:(id)sender {
    NSIndexPath *indexPath = ((IndexPathBtn*)sender).indexPath;
    
    NSLog(@"\n第%ld個section\n第%ld個row\n完工了",(long)indexPath.section,(long)indexPath.row);
}


@end
