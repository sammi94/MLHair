//
//  StyleVO.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/7.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "StyleVO.h"
#import "Define.h"

@implementation StyleVO

-(instancetype) initWithData:(NSDictionary*)data {
    self = [super init];
    _photoList = data[PhotoList];
    _photoURL = _photoList.firstObject;
    _photoDescription = data[PhotoDescription];
    _gender = [data[Gender] intValue];
    _modelId = [data[ModelId] intValue];
    _modelAuthority = [data[ModelAuthority] intValue];
    _designerId = [data[DesignerId] intValue];
    _styleId = [data[StyleId] intValue];
    _collected = [data[Collected] intValue];
    return self;
}


@end
