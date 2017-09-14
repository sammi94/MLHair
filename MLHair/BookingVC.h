//
//  BookingVC.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerVO.h"
#import "AdvanceImageView.h"


@interface BookingVC : UIViewController

@property (nonatomic,strong) DesignerVO *data;
@property (weak, nonatomic) IBOutlet UILabel *designer;
@property (weak, nonatomic) IBOutlet AdvanceImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *shop;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;



@end
