//
//  ChartInfoDataObject.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/7.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChartInfoDataObject.h"

@implementation ChartInfoDataObject
+ (NSDictionary *)objectClassInArray{
    return @{
             @"lst1" : @"ChartValueObject",
             @"lst2" : @"ChartValueObject",
             @"lst3" : @"ChartValueObject",
             @"lst4" : @"ChartValueObject",
             @"lst5" : @"ChartValueObject",
             };
}
@end
