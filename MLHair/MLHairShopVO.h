//
//  MLHairShopVO.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerVO.h"

@interface MLHairShopVO : NSObject

@property (nonatomic,assign) int shopId;
@property (nonatomic,assign) CGFloat lat;
@property (nonatomic,assign) CGFloat lon;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSArray <DesignerVO*>*designerList;

-(instancetype)initWithData:(NSDictionary*)data;

@end
