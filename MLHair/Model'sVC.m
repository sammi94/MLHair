//
//  Model'sVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/11.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "Model'sVC.h"

@interface Model_sVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;



@end

@implementation Model_sVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"cell"
                                  forIndexPath:indexPath];
    return cell;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (IBAction)shard:(id)sender {
}

- (IBAction)like:(id)sender {
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
