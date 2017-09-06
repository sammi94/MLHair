//
//  NewsItem.h
//  HelloMyRSSReader
//
//  Created by sammi on 2017/6/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *pubDate;

@end
