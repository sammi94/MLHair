//
//  MemberVO.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MemberVO.h"
#import "Define.h"
#import "MLHairDatabase.h"

@implementation MemberVO

-(instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    
    _signType = [data[SignInType] intValue];
    _memberId = [data[MemberId] intValue];
    _account = data[Account];
    _password = data[Password];
    _nickName = data[Nickname];
    _mail = data[Mail];
    _avatorURL = data[AvatorURL];
    _styleImageURL = data[StyleImageURL];
    
//    NSArray *collection = data[CollectionStyle];
//    NSMutableArray <StyleVO*>*styles = [NSMutableArray new];
//    for (StyleVO *style in [MLHairDatabase stand].styleList) {
//        for (NSString *i in collection) {
//            if (style.styleId == [i intValue]) {
//                [styles addObject:style];
//            }
//        }
//    }
//    _collectionStyle = styles;
//    
//    NSArray *like = data[LikeDesigner];
//    NSMutableArray <DesignerVO*>*designers = [NSMutableArray new];
//    for (DesignerVO *designer in [MLHairDatabase stand].designerList) {
//        for (NSString *i in like) {
//            if (designer.designerId == [i intValue]) {
//                [designers addObject:designer];
//            }
//        }
//    }
//    _likeDesigner = designers;
    
    return self;
}

@end
