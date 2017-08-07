//
//  ChartInfoDataObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/7.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartValueObject.h"
#import "CellModelPriceObject.h"

@interface ChartInfoDataObject : NSObject
//clgg = "S6-S42 ";
//clid = 559d490fe5db4293b5a8c9f00e81a6db;
//clname = "\U516d\U89d2\U94dd\U68d2";
//clph = 2A12T4;
//isgz = 0;
//lst1 =         (
//                {
//                    price = "22.00";
//                    rq = 20170713;
//                },
//                {
//                    price = "22.00";
//                    rq = 20170712;
//                },
//                {
//                    price = "22.00";
//                    rq = 20170711;
//                },
//                {
//                    price = "22.00";
//                    rq = 20170707;
//                }
//                );
//lst2 =         (
//                {
//                    price = "27.50";
//                    rq = 20170713;
//                },
//                {
//                    price = "27.50";
//                    rq = 20170712;
//                },
//                {
//                    price = "27.50";
//                    rq = 20170711;
//                },
//                {
//                    price = "26.00 ";
//                    rq = 20170707;
//                }
//                );
//lst3 =         (
//                {
//                    price = "21.50";
//                    rq = 20170713;
//                },
//                {
//                    price = "21.50";
//                    rq = 20170712;
//                },
//                {
//                    price = "21.50";
//                    rq = 20170711;
//                },
//                {
//                    price = "21.50";
//                    rq = 20170707;
//                }
//                );
//lst4 =         (
//                {
//                    price = "27.00";
//                    rq = 20170713;
//                },
//                {
//                    price = "27.00";
//                    rq = 20170712;
//                },
//                {
//                    price = "27.00";
//                    rq = 20170711;
//                },
//                {
//                    price = "25.50";
//                    rq = 20170707;
//                }
//                );
//lst5 =         (
//);
//needupd = 0;
//rq = 20170713;
//stylecontent =         {
//    dw = "\U5143/\U338f";
//    zd1 = "22.00-27.50";
//    zd2 = "21.50-27.00";
//    zd3 = 52;
//    zd4 = "";
//    zd5 = "";
//};
//styletype = 5;
@property(nonatomic , copy)NSString *clgg;
@property(nonatomic , copy)NSString *clid;
@property(nonatomic , copy)NSString *clname;
@property(nonatomic , copy)NSString *clph;
@property(nonatomic , copy)NSString *isgz;
@property(nonatomic , strong)NSArray *lst1;
@property(nonatomic , strong)NSArray *lst2;
@property(nonatomic , strong)NSArray *lst3;
@property(nonatomic , strong)NSArray *lst4;
@property(nonatomic , strong)NSArray *lst5;
@property(nonatomic , copy)NSString *needupd;
@property(nonatomic , copy)NSString *rq;
@property(nonatomic , strong)CellModelPriceObject *stylecontent;
@property(nonatomic , copy)NSString *styletype;

@end
