//
//  MLHairDatabase.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MLHairDatabase.h"
#import "Http.h"
#import "Define.h"

MLHairDatabase *data = nil;

@implementation MLHairDatabase

+(instancetype)stand {
    if (data == nil) {
        data = [MLHairDatabase new];
        data.shopList = [NSArray new];
        data.vcs = [NSMutableArray new];
        data.connection = [SignInController new];
        NSData *member = [[NSUserDefaults
                             standardUserDefaults] objectForKey:Member];
        if (member) {
            //archiver儲存服務 檔案
            data.member = [NSKeyedUnarchiver unarchiveObjectWithData:member];
        } else {
            data.member = [MemberVO new];
        }
        
    }
    return data;
}

-(void)setMember:(MemberVO *)member {
    _member = member;
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSKeyedArchiver
                archivedDataWithRootObject:member]
     forKey:Member];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)getRemoteData:(Havedata)done {
    if (done) {
        done(false);
    }
}

@end
