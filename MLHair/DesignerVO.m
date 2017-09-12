//
//  DesignerVO.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "DesignerVO.h"
#import "Define.h"

@implementation DesignerVO

-(instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    
    _shopId = [data[ShopId] intValue];
    _designerId = [data[DesignerId] intValue];
    _followed = [data[DesignerFollowed] intValue];
    _photoURL = data[DesignerPhotoURL];
    _name = data[DesignerName];
    _phone = data[DesignerPhone];
    _facebook = data[DesignerFB];
    _line = data[DesignerLine];
    
    NSArray *worksList = data[DesignerWorksList];
    NSMutableArray <StyleVO*>*scapegoat = [NSMutableArray new];
    for (NSDictionary *styleData in worksList) {
        StyleVO *style = [[StyleVO alloc] initWithData:styleData];
        style.designerName = _name;
        [scapegoat addObject:style];
    }
    
    _worksList = scapegoat;
    
    return self;
}


@end
