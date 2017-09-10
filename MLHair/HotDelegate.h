//
//  HotDelegate.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/10.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotDelegate : NSObject

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section;
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
