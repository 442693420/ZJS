//
//  DateValueFormatter.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "DateValueFormatter.h"

@interface DateValueFormatter()
{
    NSArray * _arr;
}
@end
@implementation DateValueFormatter
-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    if (value > 0 && value < _arr.count) {
        return _arr[(NSInteger)value];
    }else{
        return _arr[0];
    }
//    return _arr[(NSInteger)value];

}

@end
