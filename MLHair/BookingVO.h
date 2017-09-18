//
//  BookingVO.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/14.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DesignerVO.h"

@interface BookingVO : NSObject

@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *bookingTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) DesignerVO *designer;


@end
