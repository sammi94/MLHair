//
//  SignInVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/10.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "SignInVC.h"
#import "SignUpVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface SignInVC ()
{
    
}
@property (weak, nonatomic) IBOutlet UITextField *mail;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *botton;
@property (weak, nonatomic) IBOutlet GIDSignInButton *googleSignInView;
@property (weak, nonatomic) IBOutlet UIView *background;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbb;


@end

@implementation SignInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = true;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _botton.transform = CGAffineTransformMakeRotation(M_PI);
    _googleSignInView.layer.cornerRadius = _googleSignInView.frame.size.height/2;
    [[_googleSignInView.heightAnchor constraintEqualToConstant:_mail.frame.size.height*.8] setActive:true];
    _fbb.translatesAutoresizingMaskIntoConstraints = false;
    [[_fbb.widthAnchor constraintEqualToConstant:_mail.frame.size.width*.9] setActive:true];
    [[_fbb.heightAnchor constraintEqualToConstant:_mail.frame.size.height*.9] setActive:true];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}


- (IBAction)signUp:(id)sender {
    SignUpVC *signUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    [self.navigationController pushViewController:signUpVC animated:true];
}


- (IBAction)google:(id)sender {
}




- (IBAction)signIn:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
