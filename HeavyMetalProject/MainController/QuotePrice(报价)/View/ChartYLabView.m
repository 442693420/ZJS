//
//  ChartYLabView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/11.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChartYLabView.h"
@implementation YLabView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.titleView];
        [self addSubview:self.titleLable];
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.width.mas_equalTo(KRealValue(15));
            make.height.mas_equalTo(KRealValue(5));
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleView.mas_right).offset(KRealValue(3));
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(KRealValue(20));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
-(UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
    }
    return _titleView;
}
-(UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:KRealValue(9)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor whiteColor];
    }
    return _titleLable;
}
@end
@implementation ChartYLabView
-(id)initWithYLabArr:(NSArray *)yLabArr{
    self = [super init];
    if (self) {
        NSArray *yLabColorArr = @[@"#00BCD4",@"#8BC34A",@"#FF5722",@"#FFEB3B"];

        UIView *lastView;
        for (int i = 0; i < yLabArr.count; i++) {
            YLabView *labView = [[YLabView alloc]init];
            labView.titleView.backgroundColor = [UIColor colorWithHexString:yLabColorArr[i]];
            labView.titleLable.text = yLabArr[i];
            [self addSubview:labView];
            
            [labView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.left.mas_equalTo(self.mas_left);
                }else if (i == yLabArr.count-1){
                    make.left.mas_equalTo(lastView.mas_right).offset(KRealValue(8));
                    make.right.equalTo(self.mas_right);
                    make.width.equalTo(lastView.mas_width);
                }else{
                    make.left.mas_equalTo(lastView.mas_right).offset(KRealValue(8));
                    make.width.equalTo(lastView.mas_width);
                }
                make.centerY.mas_equalTo(self.mas_centerY);
                make.height.mas_equalTo(KRealValue(30));
            }];
            lastView = labView;
        }
    }
    return self;
}
@end
