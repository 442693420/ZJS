//
//  CellModelObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModelPriceObject.h"
//clgg = "";
//clid = dbf6b1d6728c4c049aa98ef30b4e98a0;
//clname = "\U6709\U8272\U91d1\U5c5e1";
//clph = "";
//isgz = 0;
//needupd = 0;
//rq = 20170626;
//stylecontent =             {
//    dw = "\U5143/\U5428";
//    zd1 = "100.00";
//    zd2 = "101.00";
//    zd3 = "100.00";
//    zd4 = 10;
//    zd5 = "";
//};
//styletype = 1;
@interface CellModelObject : NSObject
@property (nonatomic , copy)NSString *clgg;
@property (nonatomic , copy)NSString *clid;
@property (nonatomic , copy)NSString *clname;
@property (nonatomic , copy)NSString *clph;
@property (nonatomic , copy)NSString *isgz;
@property (nonatomic , copy)NSString *needupd;
@property (nonatomic , copy)NSString *rq;
@property (nonatomic , strong)CellModelPriceObject *stylecontent;
@property (nonatomic , copy)NSString *styletype;

@end
