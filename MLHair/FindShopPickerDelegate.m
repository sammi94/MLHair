//
//  FindShopPickerDelegate.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/13.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "FindShopPickerDelegate.h"

@interface FindShopPickerDelegate ()<UIPickerViewDelegate,
                                    UIPickerViewDataSource>

@end

@implementation FindShopPickerDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _data.shopList.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _data.shopList[row].name;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _data.findShop.text = _data.shopList[row].name;
    _data.chooseShop.text = _data.shopList[row].name;
    #warning 待實作更換店家設計師
    [_data.designerCollectionView reloadData];
    [_data.view endEditing:true];
    
}

@end
