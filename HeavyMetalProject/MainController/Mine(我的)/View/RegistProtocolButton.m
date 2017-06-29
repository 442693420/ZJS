//
//  RegistProtocolButton.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RegistProtocolButton.h"

@implementation RegistProtocolButton

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.firstLab];
        [self addSubview:self.lastLab];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(KRealValue(20));
        }];
        [self.firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(KRealValue(8));
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.lastLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.firstLab.mas_right).offset(KRealValue(8));
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
-(UILabel *)firstLab{
    if (_firstLab == nil) {
        _firstLab = [[UILabel alloc]init];
        _firstLab.text = @"我同意遵守";
        _firstLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _firstLab.textColor = [UIColor colorWithHexString:kMainWordColorGray];
    }
    return _firstLab;
}
-(UILabel *)lastLab{
    if (_lastLab == nil) {
        _lastLab = [[UILabel alloc]init];
        _lastLab.text = @"《山东有色金属会员服务条款》";
        _lastLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _lastLab.textColor = [UIColor blackColor];
    }
    return _lastLab;
}

@end
