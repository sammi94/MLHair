//
//  BookingTVCell.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/17.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceImageView.h"
#import "IndexPathBtn.h"
#import "DesignerVC.h"

@interface BookingTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet AdvanceImageView *designerPhoto;
@property (weak, nonatomic) IBOutlet UILabel *shop;
@property (weak, nonatomic) IBOutlet UILabel *bookingDay;
@property (weak, nonatomic) IBOutlet UILabel *bookingTime;
@property (weak, nonatomic) IBOutlet UILabel *designerName;
@property (weak, nonatomic) IBOutlet IndexPathBtn *doneBtn;

@property (weak, nonatomic) DesignerVC *vc;

@end
