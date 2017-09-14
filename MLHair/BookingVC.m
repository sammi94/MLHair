//
//  BookingVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "BookingVC.h"
#import "WorksVC.h"


@interface BookingVC ()
{
    
}


@end

@implementation BookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _designer.text = _data.name;
    _shop.text = _data.shopName;
    _phoneNumber.text = _data.phone;
    
    [_photo loadImageWithURL:[NSURL URLWithString:_data.photoURL]];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)works:(id)sender {
    WorksVC *works = [self.storyboard instantiateViewControllerWithIdentifier:@"WorksVC"];
    
    works.worksList = _data.worksList;
    [self.navigationController pushViewController:works animated:true];
    
}

- (IBAction)schemeLine:(id)sender {
    
//    NSURL *appURL = [NSURL URLWithString:@"line://msg/text/IamHappyMan:)"];
//    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"line://ti/p/%@",_data.line]];
//    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"line://ti/p/zCG2juYsvX"]];
    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"line://ti/p/adIBjrBLwR"]];
    if ([[UIApplication sharedApplication] canOpenURL: appURL]) {
        [[UIApplication sharedApplication]
         openURL:appURL
         options:@{}
         completionHandler:^(BOOL success) {
             
         }];
        
    }
    else { //如果使用者沒有安裝，連結到App Store
        NSURL *itunesURL = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id443904275"];
        [[UIApplication sharedApplication]
         openURL:itunesURL
         options:@{}
         completionHandler:^(BOOL success) {
             
         }];
    }
}

- (IBAction)callDesigner:(id)sender {
    NSURL *phoneURL = [NSURL
                       URLWithString:[NSString
                                      stringWithFormat:@"tel:%@",_data.phone]];
    
    [[UIApplication sharedApplication]
     openURL:phoneURL
     options:@{}
     completionHandler:^(BOOL success) {
         
     }];
}

- (IBAction)fbscheme:(id)sender {

//    NSURL *url = [NSURL
//                  URLWithString:[NSString
//                                 stringWithFormat:@"fb://profile/%@",_data.facebook]];
    NSURL *url = [NSURL
                  URLWithString:[NSString
                                 stringWithFormat:@"fb://profile/206570056024414"]];
    
    [[UIApplication sharedApplication]
     openURL:url
     options:@{}
     completionHandler:^(BOOL success) {
         
     }];
}

- (IBAction)booking:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
