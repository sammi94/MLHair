//
//  DetailViewController.h
//  HelloMyRSSReader
//
//  Created by sammi on 2017/6/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NewsItem *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

