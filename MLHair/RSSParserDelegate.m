//
//  RSSParserDelegate.m
//  HelloMyRSSReader
//
//  Created by sammi on 2017/6/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "RSSParserDelegate.h"

#define ITEM_TAG  @"item"
#define TITLE_TAG @"title"
#define LINK_TAG  @"link"
#define PUBDATE_TAG @"pubDate"

@implementation RSSParserDelegate

{
    NewsItem *currentItem;
    NSMutableArray *resultItems;
    NSMutableString *valueBufferString;
}

-(instancetype)init{
    self = [super init];
    resultItems = [NSMutableArray new];
    return self;
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    if([elementName isEqualToString:ITEM_TAG]){
        currentItem = [NewsItem new];
    }else if([elementName isEqualToString:TITLE_TAG] ||
             [elementName isEqualToString:LINK_TAG] ||
             [elementName isEqualToString:PUBDATE_TAG]){
        
        valueBufferString = nil;
        
    }

}


-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    //如果value是nil就把NSMutableString裡面的資料放進去
    if(valueBufferString == nil){
        valueBufferString = [[NSMutableString alloc] initWithString:string];
    }else{
        [valueBufferString appendString:string];//若暫存區有資料就分區放上
    }

}


-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:ITEM_TAG]){
        
        [resultItems addObject:currentItem];
        currentItem = nil;
        
    }else if ([elementName isEqualToString:TITLE_TAG]){
        
        currentItem.title = valueBufferString;
    
    }else if ([elementName isEqualToString:LINK_TAG]){
    
        currentItem.link = valueBufferString;
        
    }else if ([elementName isEqualToString:PUBDATE_TAG]){
        
        currentItem.pubDate = valueBufferString;
    
    }
    valueBufferString = nil;//Important!
}

-(NSArray*) getResults{
    return resultItems;
}


@end
