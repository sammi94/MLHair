//
//  DesignerVCell.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceImageView.h"

@interface DesignerVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AdvanceImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
