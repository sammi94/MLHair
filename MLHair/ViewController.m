//
//  ViewController.m
//  MLHair
//
//  Created by sammi on 2017/7/24.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MyViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "MLHairDatabase.h"

@interface ViewController ()<FBSDKLoginButtonDelegate,UISplitViewControllerDelegate,GIDSignInUIDelegate>
{
    FBSDKLoginButton *loginButton;
    NSString *userName;//從FB取得
}
//prepare googlesignin
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layout];
    [self googleSetting];
    [self facebooksetting];
    
}

-(void)layout {
    // Do any additional setup after loading the view, typically from a nib.
    loginButton = [[FBSDKLoginButton alloc]
                                     initWithFrame:CGRectMake(100, 400, 200, 50)];
    
    // Optional: Place the button in the center of your view.
    [self.view addSubview:loginButton];
}

-(void)facebooksetting {
    loginButton.readPermissions =
    @[@"public_profile",
      @"email",
      @"user_friends"
      ];
    loginButton.delegate = self;
}

-(void)googleSetting {
    [GIDSignIn sharedInstance].delegate = (id)self;
    [GIDSignIn sharedInstance].uiDelegate = self;
}


-(void)viewWillAppear:(BOOL)animated{
    [self checkSignIn];
}

-(void)checkSignIn {
    BOOL signIn = [FBSDKAccessToken currentAccessToken] ||
    [[GIDSignIn sharedInstance] hasAuthInKeychain];
    
    if (signIn) {
        [self nextPage];
    }
}

-(void)nextPage{
    [[MLHairDatabase stand] getRemoteData:^(bool havedat) {
        
        if (!havedat) {
        #warning test only
            [self setDummyData];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MyViewController * myVC =[self.storyboard
                                      instantiateViewControllerWithIdentifier:@"tabBar"];
            [self presentViewController:myVC animated:YES completion:nil];
            
        });
        [self dismissViewControllerAnimated:true completion:nil];
        
    }];
    
}

-(void)setDummyData {
    NSLog(@"\n準備設架資料");
}

//fb 登入 拿資料
-(void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
             error:(NSError *)error{
    
    [self checkSignIn];
}

//google 登入 拿資料
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    //    NSString *userId = user.userID;                  // For client-side use only!
    //    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    //        NSString *fullName = user.profile.name;
    //    NSString *givenName = user.profile.givenName;
    //    NSString *familyName = user.profile.familyName;
    //    NSString *email = user.profile.email;
    // ...
    [self checkSignIn];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (BOOL)validateAccount:(NSString *)account{
    NSString *regex = @"[A-Z0-9a-z]{1,18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:account];
}

- (BOOL)validatePassword:(NSString *)password{
    NSString *regex = @"[A-Z0-9a-z]{6,18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:password];
}




@end
