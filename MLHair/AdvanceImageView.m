//
//  AdvanceImageView.m
//  HelloAdvanceImageView
//
//  Created by Ｍasqurin on 2017/6/13.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "AdvanceImageView.h"

@implementation AdvanceImageView
{
    UIActivityIndicatorView *loadingView;
    NSURLSessionDataTask *existTask;
    
}
-(void)loadImageWithURL:(NSURL*) url{
    
    [self preparIndicatorView];
    
    NSString *hashedFileName = [NSString stringWithFormat:@"Cache_%d",(int)[url hash]];
    //取得路徑 「找到想放的地方的網址」 URLsForDirectory是一個array
    NSURL *cachesURL = [[NSFileManager defaultManager]
                        URLsForDirectory:NSCachesDirectory
                        inDomains:NSUserDomainMask].firstObject;
    
    NSString *fullFilePathname = [cachesURL.path stringByAppendingPathComponent:hashedFileName];
//    NSLog(@"Caches Path:%@",cachesURL.path);
    
    //把電腦圖片放入uiimage 可能失敗 因為沒有載過
    UIImage *cachedImage = [UIImage imageWithContentsOfFile:fullFilePathname];
    //如果找不到檔名=nil 代表沒下載過 跑下面的下載流程
    //如果有檔名 代表下載過 直接把有 直接把檔案放上去後離開
    if(cachedImage != nil){
        self.image = cachedImage;
        return;
    }
    
    // 檢查是否有舊排成 如果有 終止舊排成
    if(existTask != nil){
        [existTask cancel];
        existTask = nil;
    }
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sesstion = [NSURLSession sessionWithConfiguration:config];
    
    //下載開始前動畫開始
    [loadingView startAnimating];
    
    NSURLSessionDataTask *task = [sesstion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 不管前一個下載成功或失敗 都清除暫存
        existTask = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingView stopAnimating];
        });
        
        if(error){
            NSLog(@"Download Fail:%@",error);
            return ;
            //失敗也要顯示某張圖 不要空白
        }
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        // 把資料存到cache file   XXX 寫入OOO atomically y先寫一個備份 檔案寫入正常 更改備份檔名成一般檔名寫入 n不管寫入是否正常都寫入檔案「可能檔存在但是檔案是壞的」
        [data writeToFile:fullFilePathname atomically:true];
        
        //注意cache要設定自動定期清理
    }];
    
    existTask = task;
    [task resume];
}

-(void)preparIndicatorView{
    
    if(loadingView){
        [loadingView removeFromSuperview];
    }
    
    CGRect loadingViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    loadingView = [[UIActivityIndicatorView alloc]
                   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    loadingView.color = [UIColor darkGrayColor];
    loadingView.frame = loadingViewFrame;
    loadingView.hidesWhenStopped = true;
    [self addSubview:loadingView];
}

@end
