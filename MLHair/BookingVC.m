//
//  BookingVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "BookingVC.h"
#import "WorksVC.h"


@interface BookingVC ()
{
    
}









@end

@implementation BookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)works:(id)sender {
    WorksVC *works = [self.storyboard instantiateViewControllerWithIdentifier:@"WorksVC"];
    
    [self.navigationController pushViewController:works animated:true];
    
}

- (IBAction)booking:(id)sender {
    
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
