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

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.signType)
                  forKey:SignInType];
    [aCoder encodeObject:@(self.memberId)
                  forKey:MemberId];
    [aCoder encodeObject:self.account
                  forKey:Account];
    [aCoder encodeObject:self.password
                  forKey:Password];
    [aCoder encodeObject:self.nickName
                  forKey:Nickname];
    [aCoder encodeObject:self.mail
                  forKey:Mail];
    [aCoder encodeObject:self.avatorURL
                  forKey:AvatorURL];
    [aCoder encodeObject:self.styleImageURL
                  forKey:StyleImageURL];
//    [aCoder encodeObject:self.bookingList
//                  forKey:BookingList];
//    [aCoder encodeObject:self.collectionStyle
//                  forKey:CollectionStyle];
//    [aCoder encodeObject:self.likeDesigner
//                  forKey:LikeDesigner];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.signType = [[coder
                          decodeObjectForKey:SignInType] intValue];
        self.memberId = [[coder
                          decodeObjectForKey:MemberId] intValue];
        self.account = [coder decodeObjectForKey:Account];
        self.password = [coder decodeObjectForKey:Password];
        self.nickName = [coder decodeObjectForKey:Nickname];
        self.mail = [coder decodeObjectForKey:Mail];
        self.avatorURL = [coder decodeObjectForKey:AvatorURL];
        self.styleImageURL = [coder decodeObjectForKey:StyleImageURL];
        self.bookingList = [coder decodeObjectForKey:BookingList];
        self.collectionStyle = [coder decodeObjectForKey:CollectionStyle];
        self.likeDesigner = [coder decodeObjectForKey:LikeDesigner];
    }
    return self;
}

-(instancetype)init {
    self = [super init];
//    self.bookingList = [NSMutableArray new];
//    self.collectionStyle = [NSMutableArray new];
//    self.likeDesigner = [NSMutableArray new];
    return self;
}

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

-(void)setSignType:(int)signType {
    _signType = signType;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setMemberId:(int)memberId {
    _memberId = memberId;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setAccount:(NSString *)account {
    _account = account;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setPassword:(NSString *)password {
    _password = password;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setMail:(NSString *)mail {
    _mail = mail;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setAvatorURL:(NSString *)avatorURL {
    _avatorURL = avatorURL;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setBookingList:(NSArray<BookingVO *> *)bookingList {
    _bookingList = bookingList;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setCollectionStyle:(NSArray<StyleVO *> *)collectionStyle {
    _collectionStyle = collectionStyle;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setLikeDesigner:(NSArray<DesignerVO *> *)likeDesigner {
    _likeDesigner = likeDesigner;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:self]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
