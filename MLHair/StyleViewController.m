//
//  StyleViewController.m
//  
//
//  Created by sammi on 2017/8/14.
//
//

#import "StyleViewController.h"
#import "StyleViewCell.h"
#import "HotDelegate.h"
#import <AFNetworking.h>



@interface StyleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    HotDelegate *hot;
}
@property (strong, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *hotCV;


@property NSMutableArray <NSString*>*image;
@property NSMutableArray <NSString*>*label;

@end

@implementation StyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _CollectionView.delegate = self;
    _CollectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    hot = [HotDelegate new];
    _hotCV.delegate = (id)hot;
    _hotCV.dataSource = (id)hot;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置每一行的间距
    layout.minimumLineSpacing = 8;
    
    //设置item的间距
    layout.minimumInteritemSpacing = 8;
    //设置section的边距
//    layout.sectionInset=UIEdgeInsetsMake(5, 5, 0,0 );
    
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _image.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StyleViewCell * cell = [collectionView
                            dequeueReusableCellWithReuseIdentifier:@"StyleViewCell"
                            forIndexPath:indexPath];
    
    cell.imageCell.image = [UIImage imageNamed:[_image objectAtIndex:indexPath.row]];
    
    cell.labelCell.text = [_label objectAtIndex:indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;

}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"點了第%ld個item" , (long)indexPath.row);
}

/*
-(void)updateImage {
    
    //進行連線的設定
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *imageUrl =[NSString stringWithFormat:@"/upload_image.php"];

    [manager POST:imageUrl parameters:key constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //..
        [formData appendPartWithFormData:data name:@"imageArray"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {}
    //成功
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //..
    //失敗
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //..
    }];
    
    
}
*/



@end
