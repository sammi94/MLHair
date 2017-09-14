//
//  Model'sVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/11.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "Model'sVC.h"
#import "AdvanceImageView.h"
#import "ModelCVCell.h"

@interface Model_sVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *designer;
@property (weak, nonatomic) IBOutlet AdvanceImageView *photo;

@end

@implementation Model_sVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    NSURL *url = [NSURL URLWithString:_data.photoList[0]];
    [_photo loadImageWithURL:url];
    _designer.text = [NSString stringWithFormat:@"設計師：%@",_data.designerName];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.height/7, self.view.frame.size.height/7);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModelCVCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"ModelCVCell"
                                  forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:_data.photoList[indexPath.row]];
    [cell.photo loadImageWithURL:url];
    return cell;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    return _data.photoList.count;
}

- (IBAction)shard:(id)sender {
}

- (IBAction)like:(id)sender {
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSURL *url = [NSURL URLWithString:_data.photoList[indexPath.row]];
    [_photo loadImageWithURL:url];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
