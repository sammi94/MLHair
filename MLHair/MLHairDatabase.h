//
//  MLHairDatabase.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MemberVO.h"
#import "MLHairShopVO.h"
#import "SignInController.h"
#import "Define.h"
#import "Location.h"

typedef void (^Havedata)(bool havedat);

@interface MLHairDatabase : NSObject

@property (nonatomic,strong) NSArray <MLHairShopVO*>*shopList;
@property (nonatomic,strong) MemberVO *member;
@property (nonatomic,strong) SignInController *connection;
@property (nonatomic,strong) NSArray <UIViewController*>*vcs;

+(instancetype)stand;

-(void)getRemoteData:(Havedata)done;

@end
