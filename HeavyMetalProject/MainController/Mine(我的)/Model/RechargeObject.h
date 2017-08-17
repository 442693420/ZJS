//
//  RechargeObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeObject : NSObject
//czfs = "\U540e\U53f0\U5145\U503c";
//czje = "20.00";
//cznr = "\U8d2d\U4e70\U91d1\U5c5e\U5e011000\U4e2a";
//czsj = "2017-07-31 16:41:18";
@property (nonatomic , copy)NSString *czfs;//充值方式
@property (nonatomic , copy)NSString *czje;//充值金额
@property (nonatomic , copy)NSString *cznr;//充值内容
@property (nonatomic , copy)NSString *czsj;//充值时间

@end
