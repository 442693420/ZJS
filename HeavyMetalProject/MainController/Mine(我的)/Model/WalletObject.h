//
//  WalletObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/13.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletObject : NSObject
//exchange = 50;//1元可兑换的金币数
//gold = 197;//用户剩余金币数
//memberprice = "598.00";//年费会员价格
//vipenddate = "";//年费vip到期日
//viptype = 1;//vip类型0-非vip 1-普通vip 2-年费vip
@property (nonatomic , copy)NSString *exchange;
@property (nonatomic , copy)NSString *gold;
@property (nonatomic , copy)NSString *memberprice;
@property (nonatomic , copy)NSString *vipenddate;
@property (nonatomic , copy)NSString *viptype;

@end
