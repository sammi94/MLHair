//
//  Location.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic,strong)CLLocationManager *manager;

+(instancetype) stand;

@end
