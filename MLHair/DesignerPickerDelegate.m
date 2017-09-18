//
//  DesignerPickerDelegate.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/16.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "DesignerPickerDelegate.h"

@interface DesignerPickerDelegate ()<UIPickerViewDelegate,
                                    UIPickerViewDataSource>

@end

@implementation DesignerPickerDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    return _data.designerList.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    return _data.designerList[row].name;
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
    _data.chooseDesigner.text = _data.designerList[row].name;
    [_data.view endEditing:true];
}

@end
