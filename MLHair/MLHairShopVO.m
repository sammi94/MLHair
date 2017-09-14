//
//  MLHairShopVO.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MLHairShopVO.h"
#import "Define.h"
#import "Location.h"

@implementation MLHairShopVO

-(instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    
    _shopId = [data[ShopId] intValue];
    _name = data[ShopName];
    _time = data[ShopTime];
    _address = data[ShopAddress];
    _phone = data[ShopPhone];
    _designerList = data[ShopDesignerList];
    _lat = [data[ShopLat] floatValue];
    _lon = [data[ShopLon] floatValue];
    _distance = [[Location stand] getDistanceWithLat:_lat lon:_lon];
    
    NSMutableArray <DesignerVO*>*designerData = [NSMutableArray new];
    for (NSDictionary *data in _designerList) {
        NSMutableDictionary *data1 = [NSMutableDictionary new];
        [data1 setObject:_name forKey:ShopName];
        [data1 addEntriesFromDictionary:data];
        DesignerVO *designer = [[DesignerVO alloc] initWithData:data1];
        [designerData addObject:designer];
    }
    _designerList = designerData;
    
    return self;
}


@end
