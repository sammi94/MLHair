//
//  HotCVCell.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/10.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceImageView.h"

@interface HotCVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AdvanceImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end
