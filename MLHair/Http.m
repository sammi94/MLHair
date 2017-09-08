//
//  Http.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/8.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "Http.h"
#import <AFNetworking.h>
#import "Define.h"

@implementation Http


-(void) doPostWithURLString:(NSString*)     urlString
                 parameters:(NSDictionary*) parameters
                       data:(NSData* )      data
                     finish:(FinishMessage) finish{
    
    NSError *error = nil;
    NSMutableDictionary *par = [NSMutableDictionary new];
    [par addEntriesFromDictionary:parameters];
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:parameters
                        options:NSJSONWritingPrettyPrinted
                        error:&error];
    
    if (error) {
        NSLog(@"NSJSONSeroalization Error:%@",error.description);
        finish(error,nil);
        return;
    }
    
    NSString *jsonString = [[NSString alloc]
                            initWithData:jsonData
                            encoding:NSUTF8StringEncoding];
    NSLog(@"doPost Parameters:%@",jsonString);
    
    NSDictionary *finalParameters = @{HttpExchange:jsonString};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *url = [@"" stringByAppendingString:urlString];
    [manager POST:url
       parameters:finalParameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    if (data != nil) {
        [formData appendPartWithFileData:data
                                    name:@"fileToUpload"
                                fileName:@"image.jpg"
                                mimeType:@"image/jpg"];
    }
}
         progress:^(NSProgress * _Nonnull uploadProgress) {
             //回報進度
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"doPOST OK:%@",responseObject);
              if (finish) {
                  finish(nil,responseObject);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              NSLog(@"doPOST Fail:%@",error);
              if (finish) {
                  finish(error,nil);
              }
          }];
}



@end
