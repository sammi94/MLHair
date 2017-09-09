//
//  Location.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void (^GetAddress) (NSString* address);
typedef void (^GetCoordinate) (NSError *error,CLLocationCoordinate2D coordinate);
typedef void (^GetPlacemark) (NSError *error,CLPlacemark *placemark);
typedef void (^GetRoute) (NSError *error,MKRoute *route);

@interface Location : NSObject

@property (nonatomic,strong)CLLocationManager *manager;
@property (nonatomic,strong)CLLocation *userLoction;
@property (nonatomic,strong)CLPlacemark *userPlacemark;

+(instancetype) stand;

-(void)getAddressWithCoordinate:(CLLocationCoordinate2D)coordinate
                        address:(GetAddress)addres;
-(void)getAddressWithLocation:(CLLocation*)location
                      address:(GetAddress)address;
-(NSString*)getAddressWithPlacemark:(CLPlacemark*)placemark;
-(void)getCoordinateWithAddress:(NSString*)address
                     coordinate:(GetCoordinate)done;
-(void)getRouteWithAddress:(NSString*)address
                     route:(GetRoute)done;
-(void)getPlacemarkWithAddress:(NSString*)address
                     placemark:(GetPlacemark)done;
-(CGFloat)getDistanceWithLat:(CGFloat)lat
                      lon:(CGFloat)lon;

@end
