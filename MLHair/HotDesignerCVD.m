//
//  HotDesignerCVD.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/12.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "HotDesignerCVD.h"
#import "HotCVCell.h"
#import "BookingVC.h"

@interface HotDesignerCVD () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HotDesignerCVD

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _designerList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HotCVCell *cell = [collectionView
                       dequeueReusableCellWithReuseIdentifier:@"HotCVCell"
                       forIndexPath:indexPath];
    NSURL *url = [NSURL
                  URLWithString:_designerList[indexPath.row].photoURL];
    [cell.photo loadImageWithURL:url];
    cell.name.text = _designerList[indexPath.row].name;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingVC *designer = [_VC.storyboard
                           instantiateViewControllerWithIdentifier:@"BookingVC"];
    
    designer.data = _designerList[indexPath.row];
    designer.designer.text = designer.data.name;
    designer.shop.text = designer.data.shopName;
    designer.phoneNumber.text = designer.data.phone;
    
    [_VC.navigationController
     pushViewController:designer
     animated:true];
}


@end
