//
//  DesignerVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/4.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "DesignerVC.h"
#import "DesignerVCell.h"
#import "MLHairDatabase.h"
#import "BookingVC.h"
#import "FindShopPickerDelegate.h"



@interface DesignerVC ()<UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout>
{
    MLHairDatabase *data;
    FindShopPickerDelegate *pickerDelegate;
}
@property (weak, nonatomic) IBOutlet UICollectionView *designerCV;
@property (weak, nonatomic) IBOutlet UIView *findpage;
@property (weak, nonatomic) IBOutlet UIView *bookingPage;
@property (weak, nonatomic) IBOutlet UIStackView *stack;
@property (weak, nonatomic) IBOutlet UIButton *bookingBtn;
@property (weak, nonatomic) IBOutlet UITextField *chooseDay;
@property (weak, nonatomic) IBOutlet UITextField *chooseTime;
@property (weak, nonatomic) IBOutlet UITextField *chooseDesigner;




@end

@implementation DesignerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [MLHairDatabase stand];
    _shopList = data.shopList;
    _bookingPage.hidden = true;
    
    UIPickerView *picker = [UIPickerView new];
    pickerDelegate = [FindShopPickerDelegate new];
    pickerDelegate.data = self;
    picker.delegate = (id)pickerDelegate;
    picker.dataSource = (id)pickerDelegate;
    _findShop.inputView = picker;
    _chooseShop.inputView = picker;
    
    UIDatePicker *dayPicker = [UIDatePicker new];
    dayPicker.datePickerMode = UIDatePickerModeDate;
    [dayPicker
     addTarget:self
     action:@selector(chooseDate:)
     forControlEvents:UIControlEventValueChanged];
    _chooseDay.inputView = dayPicker;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy/MM/dd"];
    _chooseDay.text = [df stringFromDate:dayPicker.date];
    
    UIDatePicker *timePicker = [UIDatePicker new];
    timePicker.datePickerMode = UIDatePickerModeTime;
    timePicker.date = dayPicker.date;
    [timePicker addTarget:self
                   action:@selector(chooseTime:)
         forControlEvents:UIControlEventValueChanged];
    _chooseTime.inputView = timePicker;
    df = [NSDateFormatter new];
    [df setDateFormat:@"HH:mm"];
    _chooseTime.text = [df stringFromDate:timePicker.date];
}

-(void)chooseDate:(UIDatePicker *)datePicker {
    NSDate *date = datePicker.date;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy/MM/dd"];
    _chooseDay.text = [df stringFromDate:date];
    [self.view endEditing:true];
}

-(void)chooseTime:(UIDatePicker*)time {
    NSDate *date = time.date;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"HH:mm"];
    _chooseTime.text = [df stringFromDate:date];
    [self.view endEditing:true];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _stack.spacing = _bookingBtn.frame.size.height;
}

- (IBAction)chooseMode:(id)sender {
    [self.view endEditing:true];
    if ([sender selectedSegmentIndex] == 0) {
        _bookingPage.hidden = true;
        _findpage.hidden = false;
    } else {
        _bookingPage.hidden = false;
        _findpage.hidden = true;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width * .49, self.view.frame.size.height * .4);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _shopList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _shopList[section].designerList.count;
}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DesignerVCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"DesignerVCell"
                                  forIndexPath:indexPath];
    
    NSString *urlString = data.shopList[indexPath.section].designerList[indexPath.row].photoURL;
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.photo loadImageWithURL:url];
    cell.name.text = data.shopList[indexPath.section].designerList[indexPath.item].name;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingVC *booking = [self.storyboard instantiateViewControllerWithIdentifier:@"BookingVC"];
    
    DesignerVO *designer = data.shopList[indexPath.section].designerList[indexPath.row];
    
    booking.data = designer;
    booking.designer.text = designer.name;
    NSURL *url = [NSURL URLWithString:designer.photoURL];
    [booking.photo loadImageWithURL:url];
    booking.shop.text = designer.shopName;
    booking.phoneNumber.text = designer.phone;
    
    
    [self.navigationController pushViewController:booking animated:true];
    
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
