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
@property (nonatomic,strong) NSArray <NSString*>*photoList;
@property (nonatomic,strong) NSString *photoDescription;
@property (nonatomic,assign) int gender;
@property (nonatomic,assign) int modelId;
@property (nonatomic,assign) int modelAuthority;
@property (nonatomic,assign) int designerId;
@property (nonatomic,strong) NSString *designerName;
@property (nonatomic,assign) int styleId;
@property (nonatomic,assign) int collected;

-(instancetype) initWithData:(NSDictionary*)data;

@end
