//
//  SetValueFormatter.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Charts;
@interface SetValueFormatter : NSObject<IChartValueFormatter>
-(id)initWithArr:(NSArray *)arr;
@end
