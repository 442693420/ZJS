//
//  TitleTFView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/14.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "TitleTFView.h"

@implementation TitleTFView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.titleLab];
        [self addSubview:self.infoTF];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(30));
            make.width.mas_equalTo(KRealValue(100));
        }];
        [self.infoTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.titleLab.mas_right).offset(KRealValue(8));
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
            make.height.mas_equalTo(KRealValue(30));
        }];
    }
    return self;
}
#pragma mark getter and setter
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(14)];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}
-(UITextField *)infoTF{
    if (_infoTF == nil) {
        _infoTF = [[UITextField alloc]init];
        _infoTF.font = [UIFont systemFontOfSize:KRealValue(14)];
        _infoTF.textColor = [UIColor whiteColor];
    }
    return _infoTF;
}
@end
