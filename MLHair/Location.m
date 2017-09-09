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
    if (location == nil) {
        location = [Location new];
        location.manager = [CLLocationManager new];
        location.manager.delegate = (id)location;
        [location.manager requestAlwaysAuthorization];
        
    }
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

@end
