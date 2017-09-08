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

@end
