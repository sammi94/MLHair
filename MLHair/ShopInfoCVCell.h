//
//  ShopInfoCVCell.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/16.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceImageView.h"

@interface ShopInfoCVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AdvanceImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *numberOfDesigner;



@end
