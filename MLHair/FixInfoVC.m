//
//  FixInfoVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "FixInfoVC.h"
#import "AdvanceImageView.h"
#import "MLHairDatabase.h"
#import "ModelCamara.h"

@interface FixInfoVC ()

@property (weak, nonatomic) IBOutlet AdvanceImageView *avator;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *mail;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation FixInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MemberVO *member = [MLHairDatabase stand].member;
    [_avator loadImageWithURL:[NSURL URLWithString:member.avatorURL]];
    _nickName.text = member.nickName;
    _birthday.text = @"";
    _gender.text = @"";
    _mail.text = member.mail;
    _phone.text = @"";
    _password.secureTextEntry = true;
    _password.text = member.password;
    if (member.signType == 1 || member.signType == 2) {
        _password.secureTextEntry = false;
        _password.text = @"第三方登入，密碼由第三方修改";
        _password.enabled = false;
    }
    
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _avator.layer.cornerRadius = _avator.frame.size.height/2;
}

- (IBAction)chooseAvator:(id)sender {
    [ModelCamara takephotoWithUIViewController:self
                                         image:^(UIImage *img) {
                                             [_avator setImage:img];
                                         }];
//    [ModelCamara shard].ib = ^(UIImage *img) {
//        [_avator setImage:img];
//    };
}

- (IBAction)saveexit:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
