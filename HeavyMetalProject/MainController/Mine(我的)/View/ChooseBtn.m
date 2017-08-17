//
//  ChooseBtn.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/14.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChooseBtn.h"

@implementation ChooseBtn

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLab];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(KRealValue(20));
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(KRealValue(8));
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
#pragma mark getter and setter
-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"protocol_no"];
    }
    return _imgView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _titleLab.textColor = [UIColor colorWithHexString:kMainWordColorGray];
    }
    return _titleLab;
}

@end
