//
//  StyleViewController.m
//  
//
//  Created by sammi on 2017/8/14.
//
//

#import "StyleViewController.h"
#import "MLHairDatabase.h"
#import "StyleViewCell.h"
#import "HotDesignerCVD.h"
#import "Model'sVC.h"
#import <AFNetworking.h>

@interface StyleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    HotDesignerCVD *hotDesignerCVD;
    
    NSArray <DesignerVO*>*hotDesignerList;
    NSArray <StyleVO*>*hotStyleList;
}
@property (strong, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *hotCV;


@end

@implementation StyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataProcessing];
    
    _CollectionView.delegate = self;
    _CollectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    hotDesignerCVD = [HotDesignerCVD new];
    _hotCV.delegate = (id)hotDesignerCVD;
    _hotCV.dataSource = (id)hotDesignerCVD;
    hotDesignerCVD.VC = self;
    hotDesignerCVD.designerList = hotDesignerList;
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每一行的间距
    layout.minimumLineSpacing = 8;
    //设置item的间距
    layout.minimumInteritemSpacing = 8;
    //设置section的边距
    //layout.sectionInset=UIEdgeInsetsMake(5, 5, 0,0 );
    
    _CollectionView.collectionViewLayout = layout;
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.view.frame.size.width - 50) / 2, self.view.frame.size.height * .4);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return hotStyleList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StyleViewCell * cell = [collectionView
                            dequeueReusableCellWithReuseIdentifier:@"StyleViewCell"
                            forIndexPath:indexPath];
    
    NSURL *url = [NSURL URLWithString:hotStyleList[indexPath.row].photoURL];
    [cell.imageCell loadImageWithURL:url];
    cell.labelCell.text = hotStyleList[indexPath.row].photoDescription;
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    Model_sVC *model = [self.storyboard
                        instantiateViewControllerWithIdentifier:@"Model_sVC"];
    model.data = hotStyleList[indexPath.row];
    [self.navigationController
     pushViewController:model
     animated:true];
}

-(void)dataProcessing {
    
    MLHairDatabase *data = [MLHairDatabase stand];
    NSMutableArray <DesignerVO*>*designerList = [NSMutableArray new];
    NSMutableArray <StyleVO*>*styleList = [NSMutableArray new];
    for (MLHairShopVO *shop in data.shopList) {
        for (DesignerVO *designer in shop.designerList) {
            for (StyleVO *style in designer.worksList) {
                [styleList addObject:style];
            }
            [designerList addObject:designer];
        }
    }
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"followed"
                                        ascending:true];
    hotDesignerList = [designerList
     sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    sortDescriptor = nil;
    sortDescriptor = [NSSortDescriptor
                      sortDescriptorWithKey:@"collected"
                      ascending:true];
    hotStyleList = [styleList
                    sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    
}

- (IBAction)chooseSex:(id)sender {
    [self dataProcessing];
    if ([sender selectedSegmentIndex] == 0) {
        [self setGirlStyle];
    } else {
        [self setBoyStyle];
    }
    [_CollectionView reloadData];
}


-(void)setBoyStyle {
    [self dataProcessing];
    NSMutableArray <StyleVO*>*list = [NSMutableArray new];
    for (StyleVO *style in hotStyleList) {
        if (style.gender == 1) {
            [list addObject:style];
        }
    }
    hotStyleList = list;
}

-(void)setGirlStyle {
    NSMutableArray <StyleVO*>*list = [NSMutableArray new];
    for (StyleVO *style in hotStyleList) {
        if (style.gender == 0) {
            [list addObject:style];
        }
    }
    hotStyleList = list;
}

-(void)shotArray {
    
}















@end
