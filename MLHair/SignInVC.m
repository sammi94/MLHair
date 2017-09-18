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
#import "MLHairDatabase.h"

@interface SignInVC ()<FBSDKLoginButtonDelegate,GIDSignInUIDelegate>
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
    [GIDSignIn sharedInstance].uiDelegate = (id)self;
    [self facebooksetting];
    [self googleSetting];
}

-(void)googleSetting {
    [GIDSignIn sharedInstance].delegate = (id)self;
    
}

-(void)facebooksetting {
    _fbb.readPermissions =
    @[@"public_profile",
      @"email",
      @"user_friends"
      ];
    _fbb.delegate = (id)self;
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

//fb 登入 拿資料
-(void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
             error:(NSError *)error{
    
    if ([FBSDKAccessToken currentAccessToken] == false) {
        
        return;
    }
    
    loginButton.readPermissions =@[@"public_profile",
                                   @"email",
                                   @"user_friends"];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"me"
                                  parameters:@{@"fields" : @"gender,picture,email, name, first_name, last_name"}
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        NSDictionary *fbMemo = (NSDictionary*)result;
        MemberVO *member = [MLHairDatabase stand].member;
        member.account = fbMemo[@"id"];
        member.password = @"none";
        member.nickName = fbMemo[@"name"];
        member.avatorURL = fbMemo[@"picture"][@"data"][@"url"];
        member.mail = fbMemo[@"email"];
        member.signType = 1;
    }];
    
    [self.navigationController popViewControllerAnimated:true];
}

//google 登入 拿資料
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    if (user == nil) {
        
        return;
    }
    
    MemberVO *member = [MLHairDatabase stand].member;
    member.account = user.userID;
    member.password = user.authentication.idToken;
    member.nickName = user.profile.name;
    member.mail= user.profile.email;
    member.signType = 2;
    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage) {
        member.avatorURL = [[user.profile imageURLWithDimension:100] absoluteString];
    }
    //    NSString *givenName = user.profile.givenName;
    //    NSString *familyName = user.profile.familyName;
    
    
    [self.navigationController popViewControllerAnimated:true];
}

//fb登出
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

//google 登出
- (IBAction)signOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

//自定登出
- (IBAction)singInBtn:(id)sender {
    
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
