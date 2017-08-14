//
//  RSSParserDelegate.h
//  HelloMyRSSReader
//
//  Created by sammi on 2017/6/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"

@interface RSSParserDelegate : NSObject <NSXMLParserDelegate>

-(NSArray*) getResults;

@end
