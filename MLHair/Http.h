//
//  Http.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishMessage)(NSError *error,id result);

@interface Http : NSObject

-(void) doPostWithURLString:(NSString*)     urlString
                 parameters:(NSDictionary*) parameters
                       data:(NSData* )      data
                     finish:(FinishMessage) finish;

@end
