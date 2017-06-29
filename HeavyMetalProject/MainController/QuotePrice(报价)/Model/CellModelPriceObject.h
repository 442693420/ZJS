//
//  CellModelPriceObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
//    dw = "\U5143/\U5428";
//    zd1 = "100.00";
//    zd2 = "101.00";
//    zd3 = "100.00";
//    zd4 = 10;
//    zd5 = "";
@interface CellModelPriceObject : NSObject
@property (nonatomic , copy)NSString *dw;
@property (nonatomic , copy)NSString *zd1;
@property (nonatomic , copy)NSString *zd2;
@property (nonatomic , copy)NSString *zd3;
@property (nonatomic , copy)NSString *zd4;
@property (nonatomic , copy)NSString *zd5;
@end
