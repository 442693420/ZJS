//
//  RechargeAndVIPViewController.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//充值和购买vip

#import <UIKit/UIKit.h>
#import "WalletObject.h"

@interface RechargeAndVIPViewController : UIViewController
@property (nonatomic , copy)NSString *type;//0:充值  1购买年费会员
@property (nonatomic , strong)WalletObject *walletObj;

@end
