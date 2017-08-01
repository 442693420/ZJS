//
//  ShowAllPriceView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/1.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ShowAllPriceView.h"
@interface ShowAllPriceView()
@property (nonatomic , strong)UIImageView *titleImgView;
@property (nonatomic , strong)UILabel *titleLab;

@end
static NSString *kGrayColor = @"#4C4A48";
@implementation ShowAllPriceView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kGrayColor];
        [self addSubview:self.titleImgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.numLab];
        [self addSubview:self.refreshBtn];
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(KRealValue(20));
            make.left.equalTo(self.mas_left).offset(KRealValue(20));
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
            make.left.equalTo(self.titleImgView.mas_right).offset(KRealValue(20));
        }];
        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
            make.left.equalTo(self.titleLab.mas_right).offset(KRealValue(8));
        }];
        [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(KRealValue(20));
            make.right.equalTo(self.mas_right).offset(-KRealValue(20));
        }];
    }
    return self;
}


#pragma mark getter and setter
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
        _titleImgView.image = [UIImage imageNamed:@"fullScreen"];
    }
    return _titleImgView;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = @"显示全部价格更新";
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _titleLab;
}
-(UILabel *)numLab{
    if (_numLab == nil) {
        _numLab = [[UILabel alloc]init];
        _numLab.textColor = [UIColor whiteColor];
        _numLab.font = [UIFont systemFontOfSize:KRealValue(12)];
    }
    return _numLab;
}
-(UIButton *)refreshBtn{
    if (_refreshBtn == nil) {
        _refreshBtn = [[UIButton alloc]init];
        [_refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    }
    return _refreshBtn;
}
@end
