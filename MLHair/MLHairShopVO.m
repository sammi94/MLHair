//
//  MLHairShopVO.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MLHairShopVO.h"
#import "Define.h"

@implementation MLHairShopVO

-(instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    
    _shopId = [data[ShopId] intValue];
    _name = data[ShopName];
    _address = data[ShopAddress];
    _phone = data[ShopPhone];
    _designerList = data[ShopDesignerList];
    
    NSMutableArray <DesignerVO*>*designerData = [NSMutableArray new];
    for (NSDictionary *data in _designerList) {
        DesignerVO *designer = [[DesignerVO alloc] initWithData:data];
        [designerData addObject:designer];
    }
    _designerList = designerData;
    
    return self;
}


@end
