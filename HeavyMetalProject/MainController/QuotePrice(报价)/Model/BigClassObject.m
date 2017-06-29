//
//  BigClassObject.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "BigClassObject.h"
#import "MidClassObject.h"
@implementation BigClassObject
+ (NSDictionary *)objectClassInArray{
    return @{
             @"midclasslst" : @"MidClassObject",
             };
}
@end
