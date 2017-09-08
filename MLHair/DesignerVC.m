//
//  DesignerVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "DesignerVC.h"
#import "DesignerVCell.h"
#import "MLHairDatabase.h"


@interface DesignerVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    MLHairDatabase *data;
}
@property (weak, nonatomic) IBOutlet UICollectionView *designerCV;



@end

@implementation DesignerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [MLHairDatabase stand];
    _designerCV.delegate = self;
    _designerCV.dataSource = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width * .42, self.view.frame.size.height * .4);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return data.designerList.count;
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DesignerVCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"DesignerVCell"
                                  forIndexPath:indexPath];
//    NSURL *url = [NSURL URLWithString:data.designerList[indexPath.row].URLphoto];
//    NSData *imageData = [NSData dataWithContentsOfURL:url];
//    cell.photo.image = [UIImage imageWithData:imageData];
//    cell.name.text = data.designerList[indexPath.row].name;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
