//
//  SetValueFormatter.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "SetValueFormatter.h"

@interface SetValueFormatter ()
{
    NSArray * _arr;
    double _AAAdataSetIndex;
}
@end
@implementation SetValueFormatter
-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        NSMutableArray * muArr = [NSMutableArray arrayWithArray:arr];
        [muArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            ChartDataEntry * entry1 =(ChartDataEntry *)obj1;
            ChartDataEntry * entry2 =(ChartDataEntry *)obj2;
            if (entry1.y >= entry2.y){
                return NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }];
        _AAAdataSetIndex =((ChartDataEntry * )muArr[0]).x;
    }
    return self;
}
-(NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler{
    NSLog(@"%@",[NSString stringWithFormat:@"%.2f",(float)entry.y]);
    return [NSString stringWithFormat:@"%.2f",(float)entry.y];
}
//- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler{
//    //    NSLog(@"value:%f----entry:%@------dataSetIndex:%ld-------viewPortHandler:%@",value,[entry modelToJSONString],(long)dataSetIndex,[viewPortHandler modelToJSONString]);
//    if (entry.x==_AAAdataSetIndex) {
//        NSLog(@"%@",[NSString stringWithFormat:@"%.2f",(float)entry.y]);
//        return [NSString stringWithFormat:@"%.2f",(float)entry.y];
//    }else{
//        return @"";
//    }
//}

@end
