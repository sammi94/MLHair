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
    int number = arc4random_uniform(100) + 1;
    [self fackShopWithShopNumber:number];
}

-(void)fackShopWithShopNumber:(int)shopNumber {
    
    NSMutableArray <MLHairShopVO*>*shopList = [NSMutableArray new];
    
    NSDictionary *data = @{ShopId : @(1),
                           ShopName : @"名留林森",
                           ShopTime : @"AM 10:30 - PM 20：30",
                           ShopAddress : @"台北市中山區林森北路105號2樓",
                           ShopPhone : @"02-25513680",
                           ShopLat : @"25.050210",
                           ShopLon : @"121.524996",
                           ShopDesignerList : [self fackDesignerWithShopId:1]};
    MLHairShopVO *shop = [[MLHairShopVO alloc] initWithData:data];
    [shopList addObject:shop];
    
    data = @{ShopId : @(2),
                           ShopName : @"名留民權",
                           ShopTime : @" AM10:00 - PM8:30",
                           ShopAddress : @"台北市中山區天祥路70號2樓",
                           ShopPhone : @"02-25223535",
                           ShopLat : @"25.0624011",
                           ShopLon : @"121.5186504",
                           ShopDesignerList : [self fackDesignerWithShopId:2]};
    shop = [[MLHairShopVO alloc] initWithData:data];
    [shopList addObject:shop];
    
    data = @{ShopId : @(3),
                           ShopName : @"名留名揚",
                           ShopTime : @"AM10:00～ PM10:00",
                           ShopAddress : @"台北市中山區農安街261號1樓",
                           ShopPhone : @"02-25513680",
                           ShopLat : @"25.0648654",
                           ShopLon : @"121.5334365",
                           ShopDesignerList : [self fackDesignerWithShopId:3]};
    shop = [[MLHairShopVO alloc] initWithData:data];
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
        [designer setObject:@"https://www.facebook.com/hairdesignerlean/" forKey:DesignerFB];
        [designer setObject:@"Masqurin" forKey:DesignerLine];
        [designer setObject:[self fackWorksWith:i] forKey:DesignerWorksList];
        [designer setObject:@(arc4random_uniform(10000)) forKey:DesignerFollowed];
        int sex = arc4random_uniform(2);
        if (sex == 0) {
            [designer setObject:[self fackGirlImg] forKey:DesignerPhotoURL];
            [designer setObject:[self fackGirlName] forKey:DesignerName];
        } else {
            
            [designer setObject:[self fackBoyImg] forKey:DesignerPhotoURL];
            [designer setObject:[self fackBoyName] forKey:DesignerName];
        }
        [designer addEntriesFromDictionary:[self fackGirlDesigner]];
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
//        NSMutableArray <NSString*>*photoList = [NSMutableArray new];
//        int photoNumber = arc4random_uniform(100) + 1;
        if (sex == 0) {
            [works addEntriesFromDictionary:[self fackGirlWorks]];

//            for (int i = 0; i < photoNumber; i++) {
//                [photoList addObject:[self fackGirlImg]];
//            }
//            [works setObject:[self fackGirlName] forKey:PhotoDescription];
        } else {
            [works addEntriesFromDictionary:[self fackBoyWorks]];
//            for (int i = 0; i < photoNumber; i++) {
//                [photoList addObject:[self fackBoyImg]];
//            }
//            [works setObject:[self fackBoyName] forKey:PhotoDescription];
//            [works setObject:photoList forKey:PhotoList];
        }
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

-(NSDictionary*) fackGirlWorks {
    
    NSMutableArray <NSDictionary*>*fackGirlWorks = [NSMutableArray new];
    
    NSArray *photoList = @[@"https://cdn.hair-map.com/post/photo/normal/86051.jpg",
                           @"https://cdn.hair-map.com/post/photo/normal/86054.jpg",
                           @"https://cdn.hair-map.com/post/photo/normal/86052.jpg"];
    NSDictionary *works = @{PhotoList : photoList,
                        PhotoDescription : @"蓬鬆捲度+霧面薰衣草紫灰"};
    [fackGirlWorks addObject:works];
    
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/77937.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/77938.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/77940.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/77939.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"中長髮燙"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/4399.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/6055.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/6056.jpg"];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"深棕挑染灰！"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/59557.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"超好整理的浪漫燙髮、冷霧棕色"};
    [fackGirlWorks addObject:works];

    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/28689.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/28690.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"粉紫漸層灰藍x戀愛指數爆表的顏色"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/16641.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/16642.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/16644.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/16643.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"個性短瀏海搭配霧霧的可可色"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/57682.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/57683.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/57684.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/57686.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"韓式微卷髮"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/81073.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/81075.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/81074.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"歐美系挑染"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/90330.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/90331.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/90332.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"灰棕摩卡手刷紫灰 藍灰"};
    [fackGirlWorks addObject:works];
    
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/73562.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/73563.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"霧灰咖啡 加點不一樣的葡萄紫"};
    [fackGirlWorks addObject:works];
    
    //  新增造型
    //放照片表 記得最後一個不要逗號
    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/83761.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/83762.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/83763.jpg"
                  ];
    //放描述
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"#韓式燙髮#手繞撥乾#電棒感覺"};
    [fackGirlWorks addObject:works];
    //新增造型 完成
    
    
    
    return fackGirlWorks[arc4random_uniform((int)fackGirlWorks.count)];
    
}

-(NSDictionary*) fackBoyWorks {
    
    NSMutableArray <NSDictionary*>*fackGirlWorks = [NSMutableArray new];
    
    NSArray *photoList = @[@"https://cdn2-mf-techbang.pixfs.net/system/images/57274/medium/5c1b06608a94101a057c75aae42e527e.jpg?1491895286"
                           ];
    NSDictionary *works = @{PhotoList : photoList,
                            PhotoDescription : @"清爽男"};
    [fackGirlWorks addObject:works];
    
    //  新增造型
    //放照片表 記得最後一個不要逗號
    photoList = @[@"https://cdn1-mf-techbang.pixfs.net/system/images/57277/medium/b943444919635a41cdc95525bb746f2f.jpg?1491895288"
                  ];
    //放描述
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"簡單男"};
    [fackGirlWorks addObject:works];
    //新增造型 完成
    
    
    
    return fackGirlWorks[arc4random_uniform((int)fackGirlWorks.count)];
    
}

-(NSDictionary*) fackGirlDesigner {
    NSMutableArray *designerList = [NSMutableArray new];
    
    NSDictionary *designer = @{DesignerName : @"Q號妤韓設計師",
                               DesignerPhone : @"0927977966",
                               DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%EF%BC%B1%E8%99%9F1.jpg",
                               DesignerLine : @"abc",
                               DesignerFB : @"URL",
                               @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"9號于瑄設計師",
                 DesignerPhone : @"0930757009",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/IMG_2589_%E5%89%AF%E6%9C%AC.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    
    designer = @{DesignerName : @"6號阿龔設計師",
                 DesignerPhone : @"0923803231",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%98%BF%E9%BE%941.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"12佳穎號設計師",
                 DesignerPhone : @"0922290635",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%8F%B0%EF%BC%A11.jpg",
                 DesignerLine : @"abc",
                 DesignerFB: @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"7號妹妹設計師",
                 DesignerPhone: @"0926893841",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%A6%B9%E5%A6%B9.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"1號Joyce設計師",
                 DesignerPhone : @"0937006052",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%8E%89%E4%BD%A91.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"15號妙妙設計師",
                 DesignerPhone : @"0932502930",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%A6%99%E5%A6%991.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"16號A-Ki設計師",
                 DesignerPhone : @"0989413869",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%84%8F%E5%A6%821.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"B號月月設計師",
                 DesignerPhone : @"0989135639",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9C%88%E6%9C%881.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"10號歐麥設計師",
                 DesignerPhone : @"0967025878",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%AD%90%E9%BA%A51.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"2號Apple設計師",
                 DesignerPhone : @"0981570203",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/apple.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"4號貴珍設計師",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E8%B2%B4%E7%8F%8D1.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    
    //名揚
    designer = @{DesignerName : @"Vicky",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.57.01.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"黃于庭",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.42.48.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"joanna",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.44.12.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"Miko",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.46.30.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    //民權
    designer = @{DesignerName : @"5號湘妮",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E4%B8%AD(2).jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"10號琳雅",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%BF%81%E7%BF%81%E7%BF%81(2).jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"3號琪琪",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%90%AA%E7%90%AA.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"8號雯雯",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%9B%85%E9%9B%AF.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"6號婷婷",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%83%81%E5%A9%B7.png",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    
    designer = @{DesignerName : @"7號阿水",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9E%97%E6%98%A5%E6%B0%B4.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    return designerList[arc4random_uniform((int)designerList.count)];
}

-(NSDictionary*) fackBoyDesigner {
    
    NSMutableArray *designerList = [NSMutableArray new];
    NSDictionary *designer = @{DesignerName : @"Q號妤韓設計師",
                               DesignerPhone : @"0927977966",
                               DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%EF%BC%B1%E8%99%9F1.jpg",
                               DesignerLine : @"abc",
                               DesignerFB : @"URL",
                                @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"9號于瑄設計師",
                 DesignerPhone : @"0930757009",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/IMG_2589_%E5%89%AF%E6%9C%AC.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    
    designer = @{DesignerName : @"6號阿龔設計師",
                 DesignerPhone : @"0923803231",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%98%BF%E9%BE%941.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"12佳穎號設計師",
                 DesignerPhone : @"0922290635",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%8F%B0%EF%BC%A11.jpg",
                 DesignerLine : @"abc",
                 DesignerFB: @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"7號妹妹設計師",
                 DesignerPhone: @"0926893841",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%A6%B9%E5%A6%B9.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"1號Joyce設計師",
                 DesignerPhone : @"0937006052",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%8E%89%E4%BD%A91.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"15號妙妙設計師",
                 DesignerPhone : @"0932502930",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%A6%99%E5%A6%991.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"16號A-Ki設計師",
                 DesignerPhone : @"0989413869",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%84%8F%E5%A6%821.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"B號月月設計師",
                 DesignerPhone : @"0989135639",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9C%88%E6%9C%881.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"10號歐麥設計師",
                 DesignerPhone : @"0967025878",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%AD%90%E9%BA%A51.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"2號Apple設計師",
                 DesignerPhone : @"0981570203",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/apple.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"4號貴珍設計師",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E8%B2%B4%E7%8F%8D1.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    
    
    
    //名揚
    designer = @{DesignerName : @"Vicky",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.57.01.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"黃于庭",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.42.48.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"joanna",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.44.12.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"Miko",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.46.30.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    
    //民權
    designer = @{DesignerName : @"5號湘妮",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E4%B8%AD(2).jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"10號琳雅",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%BF%81%E7%BF%81%E7%BF%81(2).jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"3號琪琪",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%90%AA%E7%90%AA.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"8號雯雯",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%9B%85%E9%9B%AF.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    designer = @{DesignerName : @"6號婷婷",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%83%81%E5%A9%B7.png",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    
    
    designer = @{DesignerName : @"7號阿水",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9E%97%E6%98%A5%E6%B0%B4.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    return designerList[arc4random_uniform((int)designerList.count)];
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
