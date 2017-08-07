//
//  ChartValueObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/7.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartValueObject : NSObject
//price = "27.50";
//rq = 20170713;
@property(nonatomic , copy)NSString *price;
@property(nonatomic , copy)NSString *rq;

@end
