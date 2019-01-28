//
//  Location.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "Location.h"

static Location *location = nil;

@interface Location ()<CLLocationManagerDelegate>

@end

@implementation Location

+(instancetype)stand {
    
    if (location != nil) {
        return location;
    }
    location = [Location new];
    location.manager = [CLLocationManager new];
    location.manager.delegate = (id)location;
    //[location.manager requestAlwaysAuthorization];
    [location.manager requestWhenInUseAuthorization];
    [location.manager startUpdatingLocation];
    
    return location;
}

-(void)getAddressWithCoordinate:(CLLocationCoordinate2D)coordinate
                        address:(GetAddress)addres {
    
    CLLocation *location = [[CLLocation alloc]
                            initWithLatitude:coordinate.latitude
                            longitude:coordinate.longitude];
    
    [self getAddressWithLocation:location address:^(NSString *address) {
        
        if (addres) {
            addres(address);
        }
    }];
}

-(void)getAddressWithLocation:(CLLocation *)location
                      address:(GetAddress)address {
    
    [[CLGeocoder new]
     reverseGeocodeLocation:location
     completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         
         if (error) {
             if (address) {
                 address([NSString stringWithFormat:@"訊號異常"]);
             }
             NSLog(@"error.description");
             return ;
         }
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         if (address) {
             address([self getAddressWithPlacemark:placemark]);
         }
     }];
    
}

-(NSString *)getAddressWithPlacemark:(CLPlacemark *)placemark {
    
    NSString *locatedAt = [[placemark.addressDictionary
                            valueForKey:@"FormattedAddressLines"]
                           componentsJoinedByString:@", "];
    
    return locatedAt;
    //        NSLog(@"\n資訊placemark\n %@",placemark);
    //String to hold address
    //        NSLog(@"\n字典addressDictionary \n%@", placemark.addressDictionary);
    //        NSLog(@"placemark\n範圍 %@",placemark.region);
    //        NSLog(@"placemark\n國家 %@",placemark.country);
    //        // Give Country Name
    //        NSLog(@"placemark\n鄉鎮市區 %@",placemark.locality);
    //        // Extract the city name
    //        NSLog(@"location \n地標名字 %@",placemark.name);
    //        NSLog(@"location \n我是%@",placemark.ocean);
    //        NSLog(@"location \n我是2%@",placemark.postalCode);
    //        NSLog(@"location \n我是3%@",placemark.subLocality);
    //        NSLog(@"location \n位置資訊，緯經度，精確範圍，秒速，時間%@",placemark.location);
    //Print the location to console
    //        NSLog(@"I am currently at %@",locatedAt);
}

-(void)getCoordinateWithAddress:(NSString*)address
                     coordinate:(GetCoordinate)done{
    [[CLGeocoder new] geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (done) {
            if (error) {
                done(error,CLLocationCoordinate2DMake(0, 0));
            }
            if (placemarks[0]) {
                done(nil,placemarks[0].location.coordinate);
            }else {
                done(nil,CLLocationCoordinate2DMake(0, 0));
            }
        }
        
    }];
}

-(void)getPlacemarkWithAddress:(NSString *)address
                     placemark:(GetPlacemark)done {
    
    [[CLGeocoder new] geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (done) {
            if (error) {
                done(error,placemarks.lastObject);
            }
            if (placemarks.lastObject) {
                done(nil,placemarks.lastObject);
            }else {
                done(nil,placemarks.lastObject);
            }
        }
        
    }];
}

-(MKMapItem*)getMapItemWithClPlacemark:(CLPlacemark*)placemark{
    return [[MKMapItem alloc]
            initWithPlacemark:[[MKPlacemark alloc]
                               initWithPlacemark:placemark]];
}

-(void)getRouteWithAddress:(NSString *)address
                     route:(GetRoute)done {
    [self getPlacemarkWithAddress:address placemark:^(NSError *error, CLPlacemark *placemark) {
        MKMapItem *start = [self getMapItemWithClPlacemark:self->_userPlacemark];
        MKMapItem *end = [self getMapItemWithClPlacemark:placemark];
        MKDirectionsRequest *request = [MKDirectionsRequest new];
        request.source = start;
        request.destination = end;
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                for (MKRoute *route in response.routes) {
                    if (done) {
                        done(nil,route);
                    }
//                    NSLog(@"里程:%f公里; 預計時間:%f小時",route.distance/1000, route.expectedTravelTime/3600);
                    //steps
//                    for (MKRouteStep *step in route.steps) {
//                        NSLog(@"每個step描述:%@; step距離:%f", step.instructions, step.distance);

//                    }
                }
            }
        }];
    }];
    
    
}

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray<CLLocation *> *)locations {
    _userLoction = locations.lastObject;
    
    [[CLGeocoder new]
     reverseGeocodeLocation:locations.lastObject
     completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         
         if (error) {
             return ;
         }
         if (!placemarks) {
             return;
         }
         self->_userPlacemark = placemarks.lastObject;
         
     }];
}

-(CGFloat)getDistanceWithLat:(CGFloat)lat
                         lon:(CGFloat)lon {
    CLLocation *loc = [[CLLocation alloc]
                       initWithLatitude:lat
                       longitude:lon];
    CGFloat distance = [loc distanceFromLocation:_userLoction];
    return distance;
}


@end
