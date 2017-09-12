//
//  MLHairDatabase.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MLHairDatabase.h"
#import "Http.h"

MLHairDatabase *data = nil;

@implementation MLHairDatabase

+(instancetype)stand {
    if (data == nil) {
        data = [MLHairDatabase new];
        data.shopList = [NSArray new];
        
    }
    return data;
}

-(void)getRemoteData:(Havedata)done {
    if (done) {
        done(false);
    }
}

@end
