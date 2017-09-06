//
//  ViewController.m
//  MLHair
//
//  Created by sammi on 2017/7/24.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "ViewController.h"



// Add this to the header of your file, e.g. in ViewController.m
// after #import "ViewController.h"
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
- (IBAction)singInBtn:(id)sender;


@end

@implementation ViewController

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
    [self nextPage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [GIDSignIn sharedInstance].delegate = self;
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Welcome");
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(100, 400, 200, 50)];
    // Optional: Place the button in the center of your view.
    _loginButton.center = self.view.center;
    
    [self.view addSubview:loginButton];
    
    _loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    _loginButton.delegate = self;
    
    [GIDSignIn sharedInstance].uiDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    //FB login
    
    if ([GIDSignIn sharedInstance].shouldFetchBasicProfile) {
        NSLog(@"\n現在呢");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self nextPage];
        });
        return;
    }
       
    
    
    localUser = [NSUserDefaults standardUserDefaults];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self nextPage];
        });

        NSLog(@"Welcome uid%@",[localUser objectForKey:@"uid"]);
    }
    
    NSLog(@"not login");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

-(void)nextPage{
    UIStoryboard * mainstorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyViewController * myVC =[mainstorybord instantiateViewControllerWithIdentifier:@"tabBar"];
    
    NSMutableArray *viewcontrollers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
    
    [viewcontrollers removeLastObject];
    [viewcontrollers addObject:myVC];
    [self presentViewController:[viewcontrollers firstObject] animated:YES completion:nil];
    

}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    
    NSLog(@"----------- test");
    [self  nextPage];

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
- (IBAction)singInBtn:(id)sender {
    
    
}
@end
