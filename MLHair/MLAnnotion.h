//
//  MLAnnotion.h
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/9.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MLHairDatabase.h"

@interface MLAnnotion : MKPointAnnotation

@property (nonatomic,weak) MLHairShopVO *shop;

@end
