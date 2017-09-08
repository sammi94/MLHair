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
#import "StyleViewController.h"
#import "MyViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface ViewController ()<FBSDKLoginButtonDelegate,UISplitViewControllerDelegate>
{
    NSString *userName;//從FB取得
    NSUserDefaults *localUser;
}
//prepare googlesignin
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]
                                     initWithFrame:CGRectMake(100, 400, 200, 50)];
    // Optional: Place the button in the center of your view.
    _loginButton.center = self.view.center;
    
    [self.view addSubview:loginButton];
    
    _loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    _loginButton.delegate = self;
    
    [GIDSignIn sharedInstance].delegate = (id)self;
    [GIDSignIn sharedInstance].uiDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    BOOL signIn = [FBSDKAccessToken currentAccessToken] ||
    [GIDSignIn sharedInstance].shouldFetchBasicProfile;
    
    localUser = [NSUserDefaults standardUserDefaults];
    
    if (signIn) {
        NSLog(@"Welcome uid%@",[localUser objectForKey:@"uid"]);
        [self nextPage];
    }
    
}

-(void)nextPage{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MyViewController * myVC =[self.storyboard
                                  instantiateViewControllerWithIdentifier:@"tabBar"];
        [self presentViewController:myVC animated:YES completion:nil];
        
    });
    [self dismissViewControllerAnimated:true completion:nil];
}

//fb 登入 拿資料
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    //    [self  nextPage];
}

//google 登入 拿資料
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    //    NSString *userId = user.userID;                  // For client-side use only!
    //    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    //        NSString *fullName = user.profile.name;
    //    NSString *givenName = user.profile.givenName;
    //    NSString *familyName = user.profile.familyName;
    //    NSString *email = user.profile.email;
    // ...
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
    // Dispose of any resources that can be recreated.
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
