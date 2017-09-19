//
//  ModelCamara.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Img)(UIImage*img);

@interface ModelCamara : NSObject

@property (nonatomic,strong) Img ib;
+(instancetype) shard;
+(void)takephotoWithUIViewController:(UIViewController*)vc
                               image:(Img)done;

@end
