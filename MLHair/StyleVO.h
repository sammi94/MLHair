//
//  StyleVO.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/7.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StyleVO : NSObject

@property (nonatomic,strong) NSString *photoURL;
@property (nonatomic,strong) NSString *photoDescription;
@property (nonatomic,assign) int modelId;
@property (nonatomic,assign) int designerId;

-(instancetype) initWithData:(NSDictionary*)data;

@end
