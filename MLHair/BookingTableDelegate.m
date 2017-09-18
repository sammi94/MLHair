//
//  BookingTableDelegate.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/17.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "BookingTableDelegate.h"
#import "MLHairDatabase.h"
#import "BookingTVCell.h"

@interface BookingTableDelegate ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BookingTableDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [MLHairDatabase stand].member.bookingList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingTVCell" forIndexPath:indexPath];
    
    BookingVO *booking = [MLHairDatabase stand].member.bookingList[indexPath.row];
    cell.createTime.text = booking.createTime;
    [cell.designerPhoto loadImageWithURL:[NSURL URLWithString:booking.designer.photoURL]];
    cell.shop.text = booking.designer.shopName;
    cell.bookingDay.text = booking.bookingTime;
    cell.bookingTime.text = booking.bookingTime;
    cell.designerName.text = booking.designer.name;
    cell.doneBtn.indexPath = indexPath;
    
    
    
    
    
    
    cell.doneBtn.indexPath = indexPath;
    return cell;
}

@end
