//
//  MLHairDatabase.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MemberVO.h"
#import "StyleVO.h"

typedef void (^Havedata)(bool havedat);

@interface MLHairDatabase : NSObject

@property (nonatomic,strong) NSArray <DesignerVO*>*designerList;
@property (nonatomic,strong) NSArray <StyleVO*>*styleList;
@property (nonatomic,strong) MemberVO *member;

+(instancetype)stand;

-(void)getRemoteData:(Havedata)done;

@end
