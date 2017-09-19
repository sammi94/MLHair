//
//  ModelCamara.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "ModelCamara.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

static ModelCamara *camara = nil;

@interface ModelCamara () <UINavigationControllerDelegate,
                            UIImagePickerControllerDelegate>
@end

@implementation ModelCamara

+(instancetype)shard {
    if (camara == nil) {
        camara = [ModelCamara new];
    }
    return camara;
}

+(void)takephotoWithUIViewController:(UIViewController*)vc
                               image:(Img)done {
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:@"請選擇來源"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *camera = [UIAlertAction
                             actionWithTitle:@"相機"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * _Nonnull action) {
                                 
                                 [[ModelCamara shard] lanuchImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera
                                                      UIViewController:vc];
                                 
                                 camara.ib = ^(UIImage *img) {
                                     if (done) {
                                         done(img);
                                     }
                                 };
                             }];
    UIAlertAction *album = [UIAlertAction
                            actionWithTitle:@"相簿"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action) {
                                
                                [[ModelCamara shard] lanuchImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary
                                                     UIViewController:vc];
                                
                                camara.ib = ^(UIImage *img) {
                                    if (done) {
                                        done(img);
                                    }
                                };
                            }];
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"取消"
                             style:UIAlertActionStyleDefault
                             handler:nil];
    [alert addAction:cancel];
    [alert addAction:camera];
    [alert addAction:album];
    [vc presentViewController:alert animated:true completion:nil];
    
}


-(void)lanuchImagePickerWithSourceType:(UIImagePickerControllerSourceType)souceType
                      UIViewController:(UIViewController*)vc{
    
    if ([UIImagePickerController isSourceTypeAvailable:souceType]==false) {
        
        return;
    }
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = souceType;
    //最上方定義 小修改成蘋果定義方法 kucc是c語言的string 要轉型才能包近array
//    picker.mediaTypes = @[@"public.image",@"publiic.movie"];
//    picker.mediaTypes = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie];
    picker.mediaTypes = @[(NSString*)kUTTypeImage];
    picker.delegate = self;
    picker.allowsEditing = true;
    
    [vc presentViewController:picker animated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"Info:%@",info);
    NSString *type = info[UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        UIImage *inputImage = editedImage != nil ? editedImage : originalImage;
        NSLog(@"originalImage:%fx%f",originalImage.size.width,originalImage.size.height);
        UIImage *resizeImage = [self resizeFromImage:inputImage];
        NSLog(@"resizeImage:%fx%f",resizeImage.size.width,resizeImage.size.height);
        _ib(resizeImage);
        
        PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
        [library performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:resizeImage];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"Save Image OK.");
            }else{
                NSLog(@"Save Image Fail:%@",error);
            }
        }];
        
        NSData *jpgData = UIImageJPEGRepresentation(resizeImage, .8);
        NSData *pngData = UIImagePNGRepresentation(resizeImage);
        NSLog(@"JPG%lu",(unsigned long)jpgData.length);
        NSLog(@"png%lu",(unsigned long)pngData.length);
    }else if ([type isEqualToString:(NSString*)kUTTypeMovie]){
        NSURL *fileURL = info[UIImagePickerControllerMediaURL];
        NSLog(@"Movie is placed at:%@",fileURL);
        [[NSFileManager defaultManager] removeItemAtURL:fileURL error:nil];
    }
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(UIImage*)resizeFromImage:(UIImage*)input{
    
    CGFloat maxLength = 1024.0;
    CGSize targetSize;
    UIImage *finalImage;
    if (input.size.width<=maxLength&&input.size.height<=maxLength) {
        finalImage = input;
        targetSize = input.size;
    }else{
        if (input.size.width>=input.size.height) {
            CGFloat ratio = input.size.width / maxLength;
            targetSize = CGSizeMake(maxLength, input.size.height*ratio);
        }else{
            CGFloat ratio = input.size.height / maxLength;
            targetSize = CGSizeMake(input.size.width / ratio, maxLength);
        }
    }
    UIGraphicsBeginImageContext(targetSize);
    [input drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}



@end
