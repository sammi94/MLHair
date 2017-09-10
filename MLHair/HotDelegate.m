//
//  HotDelegate.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/10.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "HotDelegate.h"
#import "HotCVCell.h"

@interface HotDelegate ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HotDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCVCell" forIndexPath:indexPath];
    return cell;
}

@end
