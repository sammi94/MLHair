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
//    manager.allowsBackgroundLocationUpdates = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
