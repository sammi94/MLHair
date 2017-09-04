//
//  MLHairDatabase.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MLHairDatabase.h"

MLHairDatabase *data = nil;

@implementation MLHairDatabase

+(instancetype)stand {
    if (data == nil) {
        data = [MLHairDatabase new];
        data.designerList = [NSArray new];
    }
    return data;
}

@end
