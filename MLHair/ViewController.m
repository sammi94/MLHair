//
//  ViewController.m
//  MLHair
//
//  Created by sammi on 2017/7/24.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "ViewController.h"
#import "MLHairDatabase.h"

@interface ViewController ()
{
    Location *loc;
    
    NSMutableArray <NSDictionary*>*ls;//林森
    NSMutableArray <NSDictionary*>*mc;//民權
    NSMutableArray <NSDictionary*>*my;//民楊
    
    NSMutableArray <NSDictionary*>*boyWorks;
    NSMutableArray <NSDictionary*>*girlWorks;
    
    NSMutableArray <NSDictionary*>*boyDesigner;
    NSMutableArray <NSDictionary*>*gilrDesdigner;
    
    
    int worknumber;
    int alldesignerNumber;
    int avgDesignerWorks;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layout];
    loc = [Location stand];
    
    ls = [NSMutableArray new];
    mc = [NSMutableArray new];
    my = [NSMutableArray new];
    
    boyWorks = [NSMutableArray new];
    girlWorks = [NSMutableArray new];
    
    NSDictionary *girl = [self fackGirlWorks];
    NSLog(@"%@",girl);
    NSDictionary * boy = [self fackBoyWorks];
    NSLog(@"%@",boy);
    
    worknumber = (int)boyWorks.count + (int)girlWorks.count;
    
    boyDesigner = [NSMutableArray new];
    gilrDesdigner = [NSMutableArray new];
    
    
    NSDictionary *fab = [self fackBoyDesigner];
    NSDictionary *fag = [self fackGirlDesigner];
    NSLog(@"%@",fab);
    NSLog(@"%@",fag);
    
    alldesignerNumber = (int)ls.count + (int)mc.count + (int)my.count;
    
    avgDesignerWorks = worknumber / alldesignerNumber;
    
    NSLog(@"\n男作品%lu\n女作品%lu\n林森%lu\n民權%lu\n民楊%lu\n平均%d",(unsigned long)boyWorks.count,(unsigned long)girlWorks.count,(unsigned long)ls.count,(unsigned long)mc.count,(unsigned long)my.count,avgDesignerWorks);
    
}

-(void)layout {
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self nextPage];
}

-(void)nextPage{
    [[MLHairDatabase stand] getRemoteData:^(bool havedat) {
        
        if (!havedat) {
        
            [self setDummyData];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController * myVC =[self.storyboard
                                      instantiateViewControllerWithIdentifier:@"tabBar"];
            [self presentViewController:myVC animated:YES completion:nil];
            
        });
        [self dismissViewControllerAnimated:true completion:nil];
        
    }];
    
}

-(void)setDummyData {
    int number = arc4random_uniform(100);
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
    
    NSArray *photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/247989.jpg",
                           @"https://cdn.urstylemap.com/post/photo/normal/247988.jpg"
                           ];
    NSDictionary *works = @{PhotoList : photoList,
                            PhotoDescription : @"奶茶色☕️ 日系復古捲"};
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/233286.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"歐美感燙型不燙捲"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/257067.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/257068.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/257071.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/257069.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"💯網美微卷中長髮😍➕日韓當紅楓糖斑比色💕"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/256195.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/256196.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"😈 有型小捲 隨便綁都帥 😎"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];

    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/222301.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"漂髮也能燙系列"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/261936.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"秋冬流行色系 霧感焦糖色🤞🏻"};
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/270057.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/270058.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"害怕老氣嗎？那一定要來試試波紋捲度"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/238461.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/238462.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"小鹿班比霧棕色🐹"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/269053.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/269052.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"喬妹瀏海Long BOB～就該這麼自然美好❤️自然吹乾不用梳子喔 輕柔低層次長鮑伯頭➕質感霧亞麻棕色✨✨✨"};
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/270248.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"💯時髦微卷大波浪😍➕歐美質感冷霧棕💕"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    //  新增造型
    //放照片表 記得最後一個不要逗號
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/269035.jpg"
                  ];
    //放描述
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"💯韓系微卷溫朔燙😍➕楓糖奶茶斑比色💕"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    //新增造型 完成
    

    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/270279.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/270282.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/270281.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/270283.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/270280.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"自然柔美中長髮氧氣瀏海❤️"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
//    -----------------------------------------------------------------------
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/267655.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"雲朵彎彎燙❤️霧感特調染"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/267021.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/267022.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"🔥質感的冷棕色🔥"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/265326.jpg"
                  ];
    
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"挑染晶鑽藍，底色黑髮早就整頭低調神秘的藍寶石。"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/267106.jpg"
                  ];
    
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"微醺燙髮🍷"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/267086.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/267087.jpg"
                  ];
    
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"唯美的捲度😉女人味ᵁᴾ"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/267773.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/267774.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/267775.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/267776.jpg"
                  ];
    
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"韓系梨花C字鬆軟燙訂製款✂️"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/261456.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/261457.jpg"
                  ];
    
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"短髮內彎 染完霧感髮色 超仙超美🌹🌹🌹"
              };
    [fackGirlWorks addObject:works];
    [girlWorks addObject:works];
    
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/13624.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/13627.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/13626.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/13625.jpg"
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"經典包伯+眉上劉海"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/14036.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/14037.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/14039.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/14038.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/14040.jpg"
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#鮑伯頭 #剪短會上癮 #正妹就是要剪短"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/57705.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/57706.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/57707.jpg",
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"可帥氣 可俏麗 當女神"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/58616.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/58617.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/58628.jpg",
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"夏天到了就是要換個清爽舒服的不敗款髮型"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/42782.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/42783.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/42784.jpg"
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"深色首選適合不喜歡褪色醜醜的妳們"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/61003.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/61004.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/61005.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/61006.jpg"
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"美人魚染~~~"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/70915.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70918.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70919.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70917.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70920.jpg"
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"眉上瀏海+霧感髮色"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/1860.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/1861.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/1862.jpg"
//                  ];
//
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"棉花糖霜雞蛋刨冰外加甜甜的島國女孩"};
//    [fackGirlWorks addObject:works];
//    [girlWorks addObject:works];
    
    

    
    
    
    return fackGirlWorks[arc4random_uniform((int)fackGirlWorks.count)];
    
}

-(NSDictionary*) fackBoyWorks {
    
    NSMutableArray <NSDictionary*>*fackGirlWorks = [NSMutableArray new];
    
    NSArray *photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/25718.jpg",
                           @"https://cdn.urstylemap.com/post/photo/normal/25719.jpg",
                           @"https://cdn.urstylemap.com/post/photo/normal/25720.jpg"
                           ];
    NSDictionary *works = @{PhotoList : photoList,
                            PhotoDescription : @"🥇Undercut - 變化油頭🥇"
                            };
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
    
    //  新增造型
    //放照片表 記得最後一個不要逗號
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/131911.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/131912.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/131913.jpg"
                  ];
    //放描述
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"男士質感空氣燙～簡單俐落有型😎"
              };
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
    //新增造型 完成
    
    //    ------------------------------------------------------------------------
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/127546.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/127549.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/127548.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/127547.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"微捲S型空氣燙"
              };
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
//    ------------------------------------------------------------------------
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/253629.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/253630.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"🔥秋冬個性男髮設計🔥"};
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
//    ------------------------------------------------------------------------
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/111404.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/111405.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/111407.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/111406.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"韓系髮型還有個重點就在於後腦勺的處理💁🏼‍♂️"
              };
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
//    ------------------------------------------------------------------------
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/255846.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/255847.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/255848.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"雅痞風格"
              };
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
//    ------------------------------------------------------------------------
    
    photoList = @[@"https://cdn.urstylemap.com/post/photo/normal/230284.jpg",
                  @"https://cdn.urstylemap.com/post/photo/normal/230285.jpg",
                  @"https://cdn.hair-map.com/post/photo/normal/13961.jpg"
                  ];
    works = @{PhotoList : photoList,
              PhotoDescription :
                  @"型男必備，漸層推剪。"
              };
    [fackGirlWorks addObject:works];
    [boyWorks addObject:works];
    
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/5630.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/5631.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#頹廢感#搖滾感#英倫紳士風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/80852.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/80853.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/80854.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#歐美油頭款#男生短髮#英倫紳士風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/91533.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/91534.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#蓬鬆感#男生剪裁"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/90847.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/90848.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/90849.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#蓬鬆感#型男必備#質感"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/69171.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/69169.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/69170.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#空氣感層次#清晰輪廓線條#二分區式剪裁"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/77510.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/77511.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#蓬鬆感#男生捲髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/71029.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/71030.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/71031.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#冷色調#男生短髮#孔劉髮型"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/86971.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/86972.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/86973.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#極短髮#蓬鬆感#男生捲髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/79851.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/79852.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/79853.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#燙髮#韓式髮根燙#隨性撥乾"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/78515.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78517.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78516.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#韓系文青捲#超好整理吹乾就有型#蓬度100%"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/44040.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/44041.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#個人剪裁#蓬鬆感#男生捲髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/72196.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/72195.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/72197.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#男仕油頭#男仕燙髮#鬆亂感微捲髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/4143.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/4144.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/4145.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#微燙#微染#綠棕色"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/83444.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/83445.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/83443.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#微染#時尚運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/70342.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70344.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70343.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#霧面#超好整理"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/83883.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/83884.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/83885.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#歐美感#特殊色"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/4797.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/4798.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/4799.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#男生短髮#運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/4797.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/4798.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/4799.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#型男必備#男生短髮#運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/9341.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/9340.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/9339.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#剪髮造型#層次款油頭#油頭"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/70664.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70665.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#韓系低層次#蓬鬆感#線條感"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/86597.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/86600.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/86598.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#超級好整理#男生短髮#清爽"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/58882.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/58883.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/58884.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#霧灰棕#微線條剪裁#帥到掉渣"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/74958.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/74959.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/74961.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#男生短髮#微線條剪裁#韓系歐巴頭"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/84597.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/84598.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/84599.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#運動風#漸層推#割線"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/70139.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/70140.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#韓系髮#空氣瀏海微捲頭#線條感"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/14263.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/14264.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#乾淨利落#藍色挑染#男生短髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/9777.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/9778.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/9779.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#油頭#英倫紳士風#型男短髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/83058.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/83057.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/83059.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#手撥成型#英倫紳士風#短瀏海"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/54816.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/54818.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/54817.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#乾淨俐落#運動風#小鮮肉"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/89530.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/89532.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#v特條#運動風#男生短髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/74997.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/74998.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/75000.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#夏天陽光男孩#奶茶霧冷色特調#漸層推"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/82506.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82507.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#歐美感#運動風#男生短髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/89924.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/89926.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/89923.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#不連接裁剪#線條感#運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/78731.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78730.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78732.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#刻線#漸層推#運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/77616.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78448.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78447.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#運動系#俐落#型男必備"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/82830.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82831.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#運動系短髮#歐美感#男生短髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/82503.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82505.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82504.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#漸層推#質感#型男必備"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/82593.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82594.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#極短油頭款#髮參角#男生短髮"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/78871.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78872.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/78873.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#油頭#質感#時尚運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/85088.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/85089.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#韓系#多層次剪裁#夏日輕爽感"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/89259.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/89262.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/89264.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#油頭#粗硬髮#時尚運動風"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/87648.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/87650.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/87649.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#短髮微捲#燙捲#蓬鬆感"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/88096.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/88097.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/88098.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#霧灰#燙捲#蓬鬆感"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
////    ------------------------------------------------------------------------
//
//    photoList = @[@"https://cdn.hair-map.com/post/photo/normal/82772.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82774.jpg",
//                  @"https://cdn.hair-map.com/post/photo/normal/82773.jpg"
//                  ];
//    works = @{PhotoList : photoList,
//              PhotoDescription :
//                  @"#俐落感#運動風#油頭"};
//    [fackGirlWorks addObject:works];
//    [boyWorks addObject:works];
    
    return fackGirlWorks[arc4random_uniform((int)fackGirlWorks.count)];
    
}

-(NSDictionary*) fackGirlDesigner {
    NSMutableArray *designerList = [NSMutableArray new];
    
    NSDictionary *designer = @{DesignerName : @"愛紗",
                               DesignerPhone : @"0927977966",
                               DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/22736_12.jpg",
                               DesignerLine : @"sexyvivi124",
                               DesignerFB : @"https://www.facebook.com/sonHairBoutique/",
                               @"shopName" : @"森 Hair Boutique 板橋四川店 "};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    
    
    designer = @{DesignerName : @"Jen",
                 DesignerPhone : @"0930757009",
                 DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/24932_4.jpg",
                 DesignerLine : @"j820419",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    
    
    designer = @{DesignerName : @"Hedy Lee",
                 DesignerPhone : @"0923803231",
                 DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/13543_0.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    
    designer = @{DesignerName : @"Amber安柏",
                 DesignerPhone : @"0922290635",
                 DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/8984_3.jpg",
                 DesignerLine : @"abc",
                 DesignerFB: @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"米妮",
                 DesignerPhone: @"0926893841",
                 DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/9814_2.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"蔡安伯",
                 DesignerPhone : @"0937006052",
                 DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/9743_2.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"阿毛",
                 DesignerPhone : @"0932502930",
                 DesignerPhotoURL : @"https://cdn.urstylemap.com/user/head/small/9930_3.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
//    designer = @{DesignerName : @"16號A-Ki設計師",
//                 DesignerPhone : @"0989413869",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%84%8F%E5%A6%821.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"林森"};
//    [designerList addObject:designer];
//    [ls addObject:designer];
//    
//    designer = @{DesignerName : @"B號月月設計師",
//                 DesignerPhone : @"0989135639",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9C%88%E6%9C%881.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"林森"};
//    [designerList addObject:designer];
//    [ls addObject:designer];
//    
//    designer = @{DesignerName : @"10號歐麥設計師",
//                 DesignerPhone : @"0967025878",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%AD%90%E9%BA%A51.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"林森"};
//    [designerList addObject:designer];
//    [ls addObject:designer];
//    
//    designer = @{DesignerName : @"2號Apple設計師",
//                 DesignerPhone : @"0981570203",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/apple.JPG",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"林森"};
//    [designerList addObject:designer];
//    [ls addObject:designer];
//    
//    designer = @{DesignerName : @"4號貴珍設計師",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E8%B2%B4%E7%8F%8D1.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"林森"};
//    [designerList addObject:designer];
//    [ls addObject:designer];
//    
//    
//    //名揚
//    designer = @{DesignerName : @"Vicky",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.57.01.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"名揚"};
//    [designerList addObject:designer];
//    [my addObject:designer];
//    
//    designer = @{DesignerName : @"黃于庭",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.42.48.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"名揚"};
//    [designerList addObject:designer];
//    [my addObject:designer];
//    
//    designer = @{DesignerName : @"joanna",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.44.12.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"名揚"};
//    [designerList addObject:designer];
//    [my addObject:designer];
//    
//    designer = @{DesignerName : @"Miko",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.46.30.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"名揚"};
//    [designerList addObject:designer];
//    [my addObject:designer];
//    
//    //民權
//    designer = @{DesignerName : @"5號湘妮",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E4%B8%AD(2).jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"民權"};
//    
//    [designerList addObject:designer];
//    [mc addObject:designer];
//    
//    designer = @{DesignerName : @"10號琳雅",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%BF%81%E7%BF%81%E7%BF%81(2).jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"民權"};
//    
//    [designerList addObject:designer];
//    [mc addObject:designer];
//    
//    designer = @{DesignerName : @"3號琪琪",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%90%AA%E7%90%AA.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"民權"};
//    
//    [designerList addObject:designer];
//    [mc addObject:designer];
//    
//    designer = @{DesignerName : @"8號雯雯",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%9B%85%E9%9B%AF.JPG",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"民權"};
//    
//    [designerList addObject:designer];
//    [mc addObject:designer];
//    
//    designer = @{DesignerName : @"6號婷婷",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%83%81%E5%A9%B7.png",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"民權"};
//    
//    [designerList addObject:designer];
//    [mc addObject:designer];
//    
//    
//    designer = @{DesignerName : @"7號阿水",
//                 DesignerPhone : @"0937010319",
//                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9E%97%E6%98%A5%E6%B0%B4.jpg",
//                 DesignerLine : @"abc",
//                 DesignerFB : @"URL",
//                 @"shopName" : @"民權"};
//    
//    [designerList addObject:designer];
//    [mc addObject:designer];
    
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
    [ls addObject:designer];
    
    designer = @{DesignerName : @"9號于瑄設計師",
                 DesignerPhone : @"0930757009",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/IMG_2589_%E5%89%AF%E6%9C%AC.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    
    designer = @{DesignerName : @"6號阿龔設計師",
                 DesignerPhone : @"0923803231",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%98%BF%E9%BE%941.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"12佳穎號設計師",
                 DesignerPhone : @"0922290635",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%8F%B0%EF%BC%A11.jpg",
                 DesignerLine : @"abc",
                 DesignerFB: @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"7號妹妹設計師",
                 DesignerPhone: @"0926893841",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%A6%B9%E5%A6%B9.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"1號Joyce設計師",
                 DesignerPhone : @"0937006052",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%8E%89%E4%BD%A91.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"15號妙妙設計師",
                 DesignerPhone : @"0932502930",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E5%A6%99%E5%A6%991.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"16號A-Ki設計師",
                 DesignerPhone : @"0989413869",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%84%8F%E5%A6%821.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"B號月月設計師",
                 DesignerPhone : @"0989135639",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9C%88%E6%9C%881.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"10號歐麥設計師",
                 DesignerPhone : @"0967025878",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%AD%90%E9%BA%A51.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"2號Apple設計師",
                 DesignerPhone : @"0981570203",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/apple.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    designer = @{DesignerName : @"4號貴珍設計師",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E8%B2%B4%E7%8F%8D1.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"林森"};
    [designerList addObject:designer];
    [ls addObject:designer];
    
    
    
    //名揚
    designer = @{DesignerName : @"Vicky",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.57.01.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    [my addObject:designer];
    
    designer = @{DesignerName : @"黃于庭",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.42.48.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    [my addObject:designer];
    
    designer = @{DesignerName : @"joanna",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.44.12.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    [my addObject:designer];
    
    designer = @{DesignerName : @"Miko",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/2013-07-09%2015.46.30.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"名揚"};
    [designerList addObject:designer];
    [my addObject:designer];
    
    //民權
    designer = @{DesignerName : @"5號湘妮",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E4%B8%AD(2).jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    [mc addObject:designer];
    
    designer = @{DesignerName : @"10號琳雅",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%BF%81%E7%BF%81%E7%BF%81(2).jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    [mc addObject:designer];
    
    designer = @{DesignerName : @"3號琪琪",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E7%90%AA%E7%90%AA.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    [mc addObject:designer];
    
    designer = @{DesignerName : @"8號雯雯",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%9B%85%E9%9B%AF.JPG",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    [mc addObject:designer];
    
    designer = @{DesignerName : @"6號婷婷",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E9%83%81%E5%A9%B7.png",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    
    [designerList addObject:designer];
    [mc addObject:designer];
    
    designer = @{DesignerName : @"7號阿水",
                 DesignerPhone : @"0937010319",
                 DesignerPhotoURL : @"http://www.ml-hair.com.tw/upload/designer/%E6%9E%97%E6%98%A5%E6%B0%B4.jpg",
                 DesignerLine : @"abc",
                 DesignerFB : @"URL",
                 @"shopName" : @"民權"};
    [designerList addObject:designer];
    [mc addObject:designer];
    
    return designerList[arc4random_uniform((int)designerList.count)];
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
