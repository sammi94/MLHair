//
//  Location.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^GetAddress) (NSString* address);
typedef void (^GetCoordinate) (NSError *error,CLLocationCoordinate2D coordinate);

@interface Location : NSObject

@property (nonatomic,strong)CLLocationManager *manager;

+(instancetype) stand;

-(void)getAddressWithCoordinate:(CLLocationCoordinate2D)coordinate
                        address:(GetAddress)addres;
-(void)getAddressWithLocation:(CLLocation*)location
                      address:(GetAddress)address;
-(NSString*)getAddressWithPlacemark:(CLPlacemark*)placemark;
-(void)getCoordinateWithAddress:(NSString*)address
                     coordinate:(GetCoordinate)done;

@end
