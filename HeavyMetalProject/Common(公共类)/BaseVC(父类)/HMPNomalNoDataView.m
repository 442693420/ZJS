//
//  HMPNomalNoDataView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPNomalNoDataView.h"

@interface HMPNomalNoDataView ()

@end

@implementation HMPNomalNoDataView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.lab];
        [self addSubview:self.btn];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(KRealValue(200));
            make.height.mas_equalTo(KRealValue(150));
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.imgView.mas_bottom).offset(10);
        }];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.lab.mas_bottom).offset(8);
            make.width.mas_equalTo(KRealValue(80));
            make.height.mas_equalTo(KRealValue(30));
        }];
        self.btn.hidden = YES;
    }
    return self;
}
-(IBAction)noDataBtnAction:(id)sender{
    self.refreshData();//block回调
}

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SNNormal_noData"]];
        _imgView.contentMode=UIViewContentModeCenter;
    }
    return _imgView;
}
-(UILabel *)lab{
    if (_lab == nil) {
        _lab = [[UILabel alloc]init];
        _lab.textColor = [UIColor lightGrayColor];
        _lab.font = [UIFont systemFontOfSize:14];
        _lab.text = @"暂无数据";
        _lab.numberOfLines = 0;
    }
    return _lab;
}
-(UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc]init];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitleColor:[UIColor colorWithHexString:kMainGreenColor] forState:UIControlStateNormal];
        [_btn setTitle:@"重新加载" forState:UIControlStateNormal];
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
        [_btn addTarget:self action:@selector(noDataBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.borderColor = [UIColor colorWithHexString:kMainGreenColor].CGColor;
        _btn.layer.borderWidth = 1;
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
    }
    return _btn;
}

@end
