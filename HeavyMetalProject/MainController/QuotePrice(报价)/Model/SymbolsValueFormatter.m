//
//  SymbolsValueFormatter.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/4.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "SymbolsValueFormatter.h"

@implementation SymbolsValueFormatter
-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}
-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return [NSString stringWithFormat:@"%ld%%",(NSInteger)value];
}//IChartAxisValueFormatter的代理方法
@end
