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

#import <GoogleSignIn/GoogleSignIn.h>
#import "MLHairDatabase.h"

@interface ViewController ()<FBSDKLoginButtonDelegate,UISplitViewControllerDelegate,GIDSignInUIDelegate>
{
    FBSDKLoginButton *loginButton;
    NSString *userName;//從FB取得
    Location *loc;
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
    loc = [Location stand];
    
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
            UIViewController * myVC =[self.storyboard
                                      instantiateViewControllerWithIdentifier:@"tabBar"];
            [self presentViewController:myVC animated:YES completion:nil];
            
        });
        [self dismissViewControllerAnimated:true completion:nil];
        
    }];
    
}

-(void)setDummyData {
    NSLog(@"\n準備假資料");
    
    for (int i = 0; i < 30; i++) {
        StyleVO * style = [StyleVO new];
        style.photoURL = [self fackGirlImg];
    }
    
    NSDictionary *data = @{ShopId : @(1),
                           ShopName : @"林森店",
                           ShopTime : @"AM 10:30 - PM 20：30",
                           ShopAddress : @"台北市中山區林森北路105號2樓",
                           ShopPhone : @"02-25513680",
                           ShopLat : @"25.050210",
                           ShopLon : @"121.524996",
                           ShopDesignerList : [self fackDesignerWithShopId:1]};
    
    NSMutableArray <MLHairShopVO*>*shopList = [NSMutableArray new];
    MLHairShopVO *shop = [[MLHairShopVO alloc] initWithData:data];
    
    [shopList addObject:shop];
    [MLHairDatabase stand].shopList = shopList;
}

-(NSArray*)fackDesignerWithShopId:(int)shopId {
    int designerNumber = arc4random_uniform(20) + 5;
    NSMutableArray *designerList = [NSMutableArray new];
    for (int i = 0; i < designerNumber; i++) {
        NSMutableDictionary *designer = [NSMutableDictionary new];
        [designer setObject:@(i) forKey:DesignerId];
        [designer setObject:@(shopId) forKey:ShopId];
        [designer setObject:@(arc4random_uniform(10000)) forKey:DesignerFollowed];
        int sex = arc4random_uniform(2);
        if (sex == 0) {
            [designer setObject:[self fackGirlImg] forKey:DesignerPhotoURL];
            [designer setObject:[self fackGirlName] forKey:DesignerName];
        } else {
            
            [designer setObject:[self fackBoyImg] forKey:DesignerPhotoURL];
            [designer setObject:[self fackBoyName] forKey:DesignerName];
        }
        [designer setObject:@"https://www.facebook.com/hairdesignerlean/" forKey:DesignerFB];
        [designer setObject:@"Masqurin" forKey:DesignerLine];
        [designer setObject:[self fackWorksWith:i] forKey:DesignerWorksList];
        [designerList addObject:designer];
    }
    return designerList;
}

-(NSArray*)fackWorksWith:(int)designerId {
    int worksNumber = arc4random_uniform(100);
    NSMutableArray *worksList = [NSMutableArray new];
    for (int i = 0 ; i < worksNumber; i++) {
        NSMutableDictionary *works = [NSMutableDictionary new];
        int sex = arc4random_uniform(2);
        [works setObject:@(sex) forKey:Gender];
        NSMutableArray <NSString*>*photoList = [NSMutableArray new];
        int photoNumber = arc4random_uniform(100) + 1;
        if (sex == 0) {
            for (int i = 0; i < photoNumber; i++) {
                [photoList addObject:[self fackBoyImg]];
            }
            [works setObject:[self fackGirlImg] forKey:PhotoURL];
            [works setObject:[self fackGirlName] forKey:PhotoDescription];
        } else {
            for (int i = 0; i < photoNumber; i++) {
                [photoList addObject:[self fackGirlImg]];
            }
            [works setObject:[self fackBoyImg] forKey:PhotoURL];
            [works setObject:[self fackBoyName] forKey:PhotoDescription];
        }
        [works setObject:photoList forKey:PhotoList];
        [works setObject:@(arc4random_uniform(10000)) forKey:ModelId];
        [works setObject:@(1) forKey:ModelAuthority];
        [works setObject:@(designerId) forKey:DesignerId];
        [works setObject:@(arc4random_uniform(10)) forKey:StyleId];
        [works setObject:@(arc4random_uniform(100000)) forKey:Collected];
        [worksList addObject:works];
    }
    return worksList;
}

-(NSString*)fackBoyName {
    NSString *name;
    int i = arc4random_uniform(3);
    switch (i) {
        case 0:
            name = @"山下智久";
            break;
        case 1:
            name = @"木村拓哉";
            break;
        default:
            name = @"金城武";
            break;
    }
    return name;
}

-(NSString*)fackBoyImg {
    NSString *img;
    int i = arc4random_uniform(2);
    switch (i) {
        case 0:
            img = @"https://cdn2-mf-techbang.pixfs.net/system/images/57274/medium/5c1b06608a94101a057c75aae42e527e.jpg?1491895286";
            break;
            
        default:
            img = @"https://cdn1-mf-techbang.pixfs.net/system/images/57277/medium/b943444919635a41cdc95525bb746f2f.jpg?1491895288";
            break;
    }
    return img;
}

-(NSString*)fackGirlName {
    NSString *name;
    int i = arc4random_uniform(3);
    switch (i) {
        case 0:
            name = @"田馥甄";
            break;
        case 1:
            name = @"楊冪";
            break;
        default:
            name = @"周子榆";
            break;
    }
    return name;
}

-(NSString*)fackGirlImg {
    NSString *img;
    int i = arc4random_uniform(20);
    switch (i) {
        case 0:
            img = @"https://img.momoco.me/web_upload/20160731212451_10.jpg";
            break;
        case 1:
            img = @"https://img.momoco.me/web_upload/20160731212455_18.jpg";
            break;
        case 2:
            img = @"https://img.momoco.me/web_upload/20160731212459_51.jpg";
            break;
        case 3:
            img = @"https://img.momoco.me/web_upload/20160731212501_49.jpg";
            break;
        case 4:
            img = @"https://img.momoco.me/web_upload/20160731212504_69.jpg";
            break;
        case 5:
            img = @"https://img.momoco.me/web_upload/20160731212508_58.jpg";
            break;
        case 6:
            img = @"https://img.momoco.me/web_upload/20160731212512_47.jpg";
            break;
        case 7:
            img = @"https://img.momoco.me/web_upload/20160731212514_45.jpg";
            break;
        case 8:
            img = @"https://img.momoco.me/web_upload/20160731212516_7.jpg";
            break;
        case 9:
            img = @"https://img.momoco.me/web_upload/20160731212520_36.jpg";
            break;
        case 10:
            img = @"https://img.momoco.me/web_upload/20160731212525_100.jpg";
            break;
        case 11:
            img = @"https://img.momoco.me/web_upload/20160731212527_98.jpg";
            break;
        case 12:
            img = @"https://img.momoco.me/web_upload/20160731212531_81.jpg";
            break;
        case 13:
            img = @"https://img.momoco.me/web_upload/20160731212540_43.jpg";
            break;
        case 14:
            img = @"https://img.momoco.me/web_upload/20160731212543_85.jpg";
            break;
        case 15:
            img = @"https://img.momoco.me/web_upload/20160731212546_71.jpg";
            break;
        case 16:
            img = @"https://img.momoco.me/web_upload/20160731212550_73.jpg";
            break;
        case 17:
            img = @"https://img.momoco.me/web_upload/20160731212553_86.jpg";
            break;
        case 18:
            img = @"https://img.momoco.me/web_upload/20160731212556_96.jpg";
            break;
        case 19:
            img = @"https://img.momoco.me/web_upload/20160731212558_32.jpg";
            break;
        default:
            img = @"https://img.momoco.me/web_upload/20160731212601_69.jpg";
            break;
    }
    return img;
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
