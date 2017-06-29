//
//  MidClassObject.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "MidClassObject.h"
#import "SmallClassObject.h"

@implementation MidClassObject
+ (NSDictionary *)objectClassInArray{
    return @{
             @"smlclasslst" : @"SmallClassObject",
             };
}
@end
