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


@property NSMutableArray <NSString*>*image;
@property NSMutableArray <NSString*>*label;

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
    
    _image = [NSMutableArray new];
    _label = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
        switch (i % 3) {
            case 0:
                [_image addObject:@"image1"];
                break;
            case 1:
                [_image addObject:@"image2"];
                break;
            case 2:
                [_image addObject:@"image3"];
                break;
                
            default:
                break;
        }
        [_label addObject:[NSString stringWithFormat:@"%d號 造型",i+1]];
    }
    
    
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





















@end
