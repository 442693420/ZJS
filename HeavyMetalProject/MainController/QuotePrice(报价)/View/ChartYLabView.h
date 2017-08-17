//
//  ChartYLabView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/11.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YLabView : UIView
@property (nonatomic , strong)UIView *titleView;
@property (nonatomic , strong)UILabel *titleLable;

@end

@interface ChartYLabView : UIView
-(id)initWithYLabArr:(NSArray *)yLabArr;
@end
