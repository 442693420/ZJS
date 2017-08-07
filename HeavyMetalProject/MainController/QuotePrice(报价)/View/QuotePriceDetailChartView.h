//
//  QuotePriceDetailChartView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartInfoDataObject.h"
@interface QuotePriceDetailChartView : UIView
@property (nonatomic , strong)NSString *zp;
//外部调用，刷新数据
- (void)refreshView:(ChartInfoDataObject *)data;
@end
