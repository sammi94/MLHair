//
//  WorksTVCell.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/11.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleVO.h"

@interface WorksTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *styleName;
@property (weak, nonatomic) StyleVO *style;
@property (weak, nonatomic) UIViewController *vC;

@end
