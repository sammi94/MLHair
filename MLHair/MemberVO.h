//
//  MemberVO.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StyleVO.h"
#import "DesignerVO.h"
#import "BookingVO.h"

@interface MemberVO : NSObject

@property (nonatomic,assign) int signType;
@property (nonatomic,assign) int memberId;
@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *mail;
@property (nonatomic,strong) NSString *avatorURL;
@property (nonatomic,strong) NSString *styleImageURL;
@property (nonatomic,strong) NSArray <BookingVO*>*bookingList;

@property (nonatomic,strong) NSArray <StyleVO*>*collectionStyle;
@property (nonatomic,strong) NSArray <DesignerVO*>*likeDesigner;

-(instancetype) initWithData:(NSDictionary*)data;

@end
