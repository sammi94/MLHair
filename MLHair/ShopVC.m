//
//  ShopVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/9.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "ShopVC.h"
#import "ShopTVCell.h"
#import "MLHairDatabase.h"
#import "MLAnnotion.h"

@interface ShopVC ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate>
{
    NSArray <MLHairShopVO*>*shopList;
    Location *locData;
    CLLocationCoordinate2D coordinate;
    NSString *tel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *map;


@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locData = [Location stand];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _map.delegate = self;
    _map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    shopList = [MLHairDatabase stand].shopList;
    
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self chooseShop:shopList[indexPath.row]];
}

-(void) chooseShop:(MLHairShopVO*)shop {
    
    MKCoordinateRegion region;
    coordinate = CLLocationCoordinate2DMake(shop.lat, shop.lon);
    tel = shop.phone;
    region.center = coordinate;
    region.span = MKCoordinateSpanMake(.01, .01);
    [_map setRegion:region animated:true];
    
    MLAnnotion *shopAnn = [MLAnnotion new];
    shopAnn.coordinate = coordinate;
    shopAnn.title = shop.name;
    shopAnn.subtitle = shop.time;
    shopAnn.shop = shop;
    [_map removeAnnotations:_map.annotations];
    [_map addAnnotation:shopAnn];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopTVCell *cell = [_tableView
                        dequeueReusableCellWithIdentifier:@"ShopTVCell"
                        forIndexPath:indexPath];
    
    cell.name.text = shopList[indexPath.row].name;
    cell.address.text = shopList[indexPath.row].address;
    cell.time.text = shopList[indexPath.row].time;
    cell.tel.text = shopList[indexPath.row].phone;
    CLLocation *loc = [[CLLocation alloc]
                       initWithLatitude:shopList[indexPath.row].lat
                       longitude:shopList[indexPath.row].lon];
    CGFloat distance = [loc distanceFromLocation:locData.userLoction];
    if (distance > 1000) {
        cell.distance.text = [NSString
                              stringWithFormat:@"%.2fKm",[loc distanceFromLocation:locData.userLoction]/1000];
    } else {
        cell.distance.text = [NSString
                              stringWithFormat:@"%.2fm",[loc distanceFromLocation:locData.userLoction]];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    return shopList.count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma - map
-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if (annotation == mapView.userLocation){
        return nil;
    }
    NSString *identifier = annotation.subtitle;
//    MKPinAnnotationView *result = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        MKAnnotationView *result = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(result == nil){
//        result = [[MKPinAnnotationView alloc]initWithAnnotation:annotation
//                                                reuseIdentifier:identifier];
                result = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    }else{
        result.annotation = annotation;
    }
    result.canShowCallout = true;
    UIImage *image = [UIImage imageNamed:@"剪刀圖釘.png"];
    result.image = image;
    
//            result.pinColor = MKPinAnnotationColorGreen;
//            result.pinTintColor = [UIColor brownColor];
    
    UIButton *btnPhone = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btnPhone setTitle:@"打電話" forState:UIControlStateNormal];
    [btnPhone setImage:[UIImage imageNamed:@"callPhone.png"] forState:UIControlStateNormal];
    [btnPhone sizeToFit];
    [btnPhone addTarget:self
                 action:@selector(callphone)
       forControlEvents:UIControlEventTouchUpInside];
    result.leftCalloutAccessoryView = btnPhone;
    
    UIButton *goNavigationBTN = [UIButton buttonWithType:UIButtonTypeSystem];
//    [goNavigationBTN setTitle:@"導航" forState:UIControlStateNormal];
    [goNavigationBTN setImage:[UIImage imageNamed:@"navigation.png"] forState:UIControlStateNormal];
    [goNavigationBTN sizeToFit];
    [goNavigationBTN addTarget:self
                        action:@selector(goNavigation)
              forControlEvents:UIControlEventTouchUpInside];
    result.rightCalloutAccessoryView = goNavigationBTN;
    return result;
    
}

-(void)callphone {
    
    NSURL *phoneURL = [NSURL
                       URLWithString:[NSString
                                      stringWithFormat:@"tel:%@",tel]];

    [[UIApplication sharedApplication]
     openURL:phoneURL
     options:@{}
     completionHandler:^(BOOL success) {
        
    }];
    
}

-(void)goNavigation {
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:coordinate];
    MKMapItem *mapItem = [[MKMapItem alloc]
                          initWithPlacemark:placemark];
    NSDictionary *options =
  @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [mapItem openInMapsWithLaunchOptions:options];
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
