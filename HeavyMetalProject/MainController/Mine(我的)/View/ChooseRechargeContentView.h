//
//  ChooseRechargeContentView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//选择充值内容View

#import <UIKit/UIKit.h>

@interface ChooseRechargeContentView : UIView
@property (nonatomic , strong)NSMutableArray *btnArr;//存放按钮对象

-(id)initWithTitle:(NSString *)title chooseBtnArr:(NSArray *)btnArr;

@end
