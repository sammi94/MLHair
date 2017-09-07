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
    _photoURL = data[PhotoURL];
    _photoDescription = data[PhotoDescription];
    _modelId = [data[ModelId] intValue];
    _designerId = [data[DesignerId] intValue];
    return self;
}


@end
