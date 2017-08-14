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



@interface ViewController ()
{
    NSUserDefaults *localUser;


}




@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
- (IBAction)singInBtn:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Welcome");
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    //FB login
    
   
    localUser = [NSUserDefaults standardUserDefaults];
    {
    NSLog(@"Welcome");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self nextPage];
        });
    }
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
    StyleViewController * styleVC =[mainstorybord instantiateViewControllerWithIdentifier:@"tabBar"];
    
    NSMutableArray *viewcontrollers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
    
    [viewcontrollers removeLastObject];
    [viewcontrollers addObject:styleVC];
    [self presentViewController:[viewcontrollers firstObject] animated:YES completion:nil];
    

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
