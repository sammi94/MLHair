//
//  DesignerVO.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StyleVO.h"

@interface DesignerVO : NSObject

@property (nonatomic,assign) int designerId;
@property (nonatomic,assign) int shopId;
@property (nonatomic,assign) int followed;
@property (nonatomic,assign) NSString *photoURL;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *facebook;
@property (nonatomic,strong) NSString *line;
@property (nonatomic,strong) NSArray <StyleVO*>*worksList;

-(instancetype)initWithData:(NSDictionary*)data;

@end
