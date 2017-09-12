//
//  StyleViewCell.h
//  MLHair
//
//  Created by sammi on 2017/8/18.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceImageView.h"

@interface StyleViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet AdvanceImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *labelCell;

@end
