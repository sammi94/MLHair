//
//  DetailViewController.m
//  HelloMyRSSReader
//
//  Created by sammi on 2017/6/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()
{
    WKWebView *mainWebView;
}

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem && mainWebView) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
        
        //Show news title
        self.title = _detailItem.title;
        
        //Load HTML Content from link.
        NSURL *url = [NSURL URLWithString:_detailItem.link];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [mainWebView loadRequest:request];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Prepare mainWebView
    CGSize viewSize = self.view.frame.size;
    CGRect webViewFrame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    mainWebView = [[WKWebView alloc] initWithFrame:webViewFrame];
    
    mainWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:mainWebView];
    mainWebView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:mainWebView
                              attribute:NSLayoutAttributeLeading
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                              constant:.0]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:mainWebView
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                              constant:.0]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:mainWebView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                              constant:.0]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:mainWebView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.topLayoutGuide
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                              constant:.0]];
    
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NewsItem *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
