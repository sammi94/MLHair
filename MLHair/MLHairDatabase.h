//
//  MLHairDatabase.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DesignerVO.h"

@interface MLHairDatabase : NSObject

@property (nonatomic,strong) NSArray <DesignerVO*>*designerList;

+(instancetype)stand;

@end
