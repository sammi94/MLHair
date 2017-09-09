//
//  MapViewController.m
//  MLHair
//
//  Created by sammi on 2017/8/14.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"
#import <MapKit/MapKit.h>
#import "MLHairDatabase.h"

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *manager;
}
@property (weak, nonatomic) IBOutlet MKMapView *map;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [Location stand].manager;
    _map.delegate = self;
    _map.userTrackingMode = MKUserTrackingModeFollowWithHeading;

    
    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(_shop.lat, _shop.lon);
    region.span = MKCoordinateSpanMake(.01, .01);
    [_map setRegion:region animated:true];
    
    MKPointAnnotation *shopAnn = [MKPointAnnotation new];
    

    shopAnn.coordinate = region.center;
    shopAnn.title = _shop.name;
    shopAnn.subtitle = _shop.address;
    [_map addAnnotation:shopAnn];
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:region.center];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [mapItem openInMapsWithLaunchOptions:options];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if (annotation == mapView.userLocation){
        return nil;
    }
    NSString *identifier = annotation.subtitle;
    MKPinAnnotationView *result = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    //    MKAnnotationView *result = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(result == nil){
        result = [[MKPinAnnotationView alloc]initWithAnnotation:annotation
                                                reuseIdentifier:identifier];
        //        result = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    }else{
        result.annotation = annotation;
    }
    result.canShowCallout = true;
    
    //        result.pinColor = MKPinAnnotationColorGreen;
    //        result.pinTintColor = [UIColor brownColor];
    
    UILabel *left = [UILabel new];
    left.text = @"Logo";
    [left sizeToFit];
    result.leftCalloutAccessoryView = left;
    
    UIButton *createMissionBTN = [UIButton buttonWithType:UIButtonTypeSystem];
    [createMissionBTN setTitle:@"打電話" forState:UIControlStateNormal];
    [createMissionBTN sizeToFit];
//    [createMissionBTN addTarget:self
//                         action:@selector(createMission)
//               forControlEvents:UIControlEventTouchUpInside];
    result.rightCalloutAccessoryView = createMissionBTN;
    return result;
    
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
