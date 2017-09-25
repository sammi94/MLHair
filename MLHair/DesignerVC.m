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
#import "ShopInfoCVCell.h"
#import "DesignerPickerDelegate.h"
#import "BookingTableDelegate.h"

@interface DesignerVC ()<UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout>
{
    MLHairDatabase *data;
    FindShopPickerDelegate *pickerDelegate;
    DesignerPickerDelegate *designerDesignerDelegate;
    BookingTableDelegate *bookingTableDelegate;
    UICollectionViewCell *sessionCell;
}
@property (weak, nonatomic) IBOutlet UICollectionView *designerCV;
@property (weak, nonatomic) IBOutlet UIView *findpage;
@property (weak, nonatomic) IBOutlet UIView *bookingPage;
@property (weak, nonatomic) IBOutlet UIStackView *stack;
@property (weak, nonatomic) IBOutlet UIButton *bookingBtn;
@property (weak, nonatomic) IBOutlet UITextField *chooseDay;
@property (weak, nonatomic) IBOutlet UITextField *chooseTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseMode;

@end

@implementation DesignerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [MLHairDatabase stand];
    
    [(NSMutableArray*)data.vcs addObject:self];
    
    _shopList = data.shopList;
    _bookingPage.hidden = true;
    _bookingTable.hidden = true;
    
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
    
    designerDesignerDelegate = [DesignerPickerDelegate new];
    _designerList = _shopList.firstObject.designerList;
    designerDesignerDelegate.data = self;
    UIPickerView *designerPicker = [UIPickerView new];
    designerPicker.delegate = (id)designerDesignerDelegate;
    designerPicker.dataSource = (id)designerDesignerDelegate;
    _chooseDesigner.inputView = designerPicker;
    
    bookingTableDelegate = [BookingTableDelegate new];
    _bookingTable.delegate = (id)bookingTableDelegate;
    _bookingTable.dataSource = (id)bookingTableDelegate;
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

- (IBAction)chooseMode:(UISegmentedControl *)sender {
    [self.view endEditing:true];
    [self setChooseMode:sender];
}

-(void)setChooseMode:(UISegmentedControl *)chooseMode {
    
    _chooseMode = chooseMode;
    
    if ([chooseMode selectedSegmentIndex] == 0) {
        _bookingPage.hidden = true;
        _findpage.hidden = false;
        _bookingTable.hidden = true;
    } else if([chooseMode selectedSegmentIndex] == 1) {
        _bookingPage.hidden = false;
        _findpage.hidden = true;
        _bookingTable.hidden = true;
    }else if ([chooseMode selectedSegmentIndex] == 2) {
        _bookingPage.hidden = true;
        _findpage.hidden = true;
        _bookingTable.hidden = false;
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
    
    if (indexPath.item == 0) {
        return CGSizeMake(_designerCV.frame.size.width, 50);
    }
    
    return CGSizeMake(self.view.frame.size.width * .49, self.view.frame.size.height * .4);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _shopList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _shopList[section].designerList.count +1;
}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        ShopInfoCVCell *shopInfo = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopInfoCVCell" forIndexPath:indexPath];
        shopInfo.shopName.text = data.shopList[indexPath.section].name;
        NSString *number = [NSString stringWithFormat:@"%lu位設計師",(unsigned long)data.shopList[indexPath.section].designerList.count];
        shopInfo.numberOfDesigner.text = number;
        return shopInfo;
    }
    
    
    DesignerVCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"DesignerVCell"
                                  forIndexPath:indexPath];
    
    NSString *urlString = data.shopList[indexPath.section].designerList[indexPath.row-1].photoURL;
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.photo loadImageWithURL:url];
    cell.name.text = data.shopList[indexPath.section].designerList[indexPath.item -1].name;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        return;
    }
    
    BookingVC *booking = [self.storyboard instantiateViewControllerWithIdentifier:@"BookingVC"];
    
    DesignerVO *designer = data.shopList[indexPath.section].designerList[indexPath.row -1];
    
    booking.data = designer;
    
    booking.designer.text = designer.name;
    NSURL *url = [NSURL URLWithString:designer.photoURL];
    [booking.photo loadImageWithURL:url];
    booking.shop.text = designer.shopName;
    booking.phoneNumber.text = designer.phone;
    
    
    [self.navigationController pushViewController:booking animated:true];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (UICollectionViewCell *cell in [_designerCollectionView visibleCells]) {
        
        _findShop.text = _shopList[[_designerCollectionView indexPathForCell:cell].section].name;

        
//        if ([_designerCollectionView indexPathForCell:cell].item == 0) {
//            sessionCell = cell;
//        }
    }
}

- (IBAction)presentBooking:(id)sender {
    BookingVO *booking = [BookingVO new];
//    booking.createTime = [[NSDateFormatter alloc] stringFromDate:[NSDate new]];
    booking.designer = data.shopList[1].designerList[1];
    booking.bookingTime = _chooseTime.text;
    booking.designer.shopName = _chooseShop.text;
    booking.designer.name = _chooseDesigner.text;
    
    NSMutableArray <BookingVO*>*bookingList = [NSMutableArray new];
    [bookingList addObject:booking];
    NSLog(@"\nML=%@\ndata=%@",data.member.bookingList,bookingList);
    data.member.bookingList = [bookingList arrayByAddingObjectsFromArray:data.member.bookingList];
    
    NSLog(@"\nML=%@\ndata=%@",data.member.bookingList,bookingList);
    [_bookingTable reloadData];
    [_chooseMode setSelectedSegmentIndex:2];
    [self setChooseMode:_chooseMode];
    
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
