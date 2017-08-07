//
//  ChartSeletView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/7.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChartSeletView.h"
@interface ChartSeletView()
@property (nonatomic , strong)UIImageView *labBgImgView;
@property (nonatomic , strong)UIImageView *pointView;
@end
@implementation ChartSeletView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labBgImgView];
        [self addSubview:self.pointView];
        [self addSubview:self.lab];
    }
    return self;
}
#pragma mark getter and setter
-(UIImageView *)labBgImgView{
    if (_labBgImgView == nil) {
        _labBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, KRealValue(40))];
        _labBgImgView.image = [UIImage imageNamed:@"chartSelectBg"];
    }
    return _labBgImgView;
}
-(UIImageView *)pointView{
    if (_pointView == nil) {
        _pointView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-KRealValue(15), KRealValue(40), KRealValue(30), KRealValue(30))];
        _pointView.image = [UIImage imageNamed:@"chartSelectPoint"];
    }
    return _pointView;
}
-(UILabel *)lab{
    if (_lab == nil) {
        _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, KRealValue(30))];
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.font = [UIFont systemFontOfSize:14.0];
        _lab.textColor = [UIColor colorWithHexString:kMainColorOrange];
    }
    return _lab;
}
@end
