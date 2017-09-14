//
//  DesignerVC.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLHairDatabase.h"

@interface DesignerVC : UIViewController

@property (nonatomic,strong) NSArray <MLHairShopVO*>*shopList;
@property (nonatomic,strong) NSArray <DesignerVO*>*designerList;
@property (weak, nonatomic) IBOutlet UITextField *findShop;
@property (weak, nonatomic) IBOutlet UITextField *chooseShop;

@property (weak, nonatomic) IBOutlet UICollectionView *designerCollectionView;



@end
