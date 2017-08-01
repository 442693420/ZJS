//
//  ShowPriceAlertView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ShowPriceAlertView.h"
@interface ShowPriceAlertView()
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *requireLab;
@property (nonatomic , strong)UIButton *requireBtn;
@end
static NSString *kGrayColor = @"#4C4A48";
static NSString *kWhiteColor = @"#E4E4E4";
@implementation ShowPriceAlertView

-(instancetype)init{
    self = [super init];
    if (self) {
        UIView *infoBackView = [[UIView alloc]init];
        infoBackView.backgroundColor = [UIColor colorWithHexString:kWhiteColor];
        infoBackView.layer.masksToBounds = YES;
        infoBackView.layer.cornerRadius = 5;
        [self addSubview:infoBackView];
        [infoBackView addSubview:self.titleLab];
        [infoBackView addSubview:self.infoLab];
        [infoBackView addSubview:self.requireLab];
        [infoBackView addSubview:self.requireBtn];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.submitBtn];
        
        [infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.cancelBtn.mas_top).offset(-KRealValue(20));
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(infoBackView);
            make.height.mas_equalTo(KRealValue(40));
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(infoBackView.mas_right).offset(-KRealValue(8));
            make.left.equalTo(infoBackView.mas_left).offset(KRealValue(8));
            make.top.equalTo(self.titleLab.mas_bottom).offset(KRealValue(8));
        }];
        [self.requireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(infoBackView.mas_bottom).offset(-KRealValue(10));
            make.width.height.mas_equalTo(KRealValue(20));
            make.right.equalTo(infoBackView.mas_right).offset(-KRealValue(8));
        }];
        [self.requireLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.requireBtn.mas_left).offset(-KRealValue(8));
            make.centerY.equalTo(self.requireBtn.mas_centerY);
            make.height.mas_equalTo(KRealValue(20));
        }];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(KRealValue(80));
            make.height.mas_equalTo(KRealValue(40));
        }];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(KRealValue(80));
            make.height.mas_equalTo(KRealValue(40));
        }];
    }
    return self;
}
-(IBAction)requireBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.requireBtn setImage:[UIImage imageNamed:@
                                   "protocol_yes"] forState:UIControlStateSelected];
    }else{
        [self.requireBtn setImage:[UIImage imageNamed:@
                                   "protocol_no"] forState:UIControlStateNormal];
    }
}
#pragma mark getter and setter
- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @" 查看实时报价";
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(14)];
        _titleLab.backgroundColor = [UIColor colorWithHexString:kGrayColor];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.numberOfLines = 0;
        _infoLab.textColor = [UIColor colorWithHexString:kGrayColor];
        _infoLab.backgroundColor = [UIColor colorWithHexString:kWhiteColor];
        _infoLab.text = @"本次查看将扣除1金币";
        _infoLab.font = [UIFont systemFontOfSize:14];
    }
    return _infoLab;
}
-(UILabel *)requireLab{
    if (_requireLab == nil) {
        _requireLab = [[UILabel alloc]init];
        _requireLab.textColor = [UIColor colorWithHexString:kGrayColor];
        _requireLab.backgroundColor = [UIColor colorWithHexString:kWhiteColor];
        _requireLab.text = @"以后自动扣费不再询问";
        _requireLab.font = [UIFont systemFontOfSize:12];
    }
    return _requireLab;
}
-(UIButton *)requireBtn{
    if (_requireBtn == nil) {
        _requireBtn = [[UIButton alloc]init];
        [_requireBtn setImage:[UIImage imageNamed:@
                               "protocol_no"] forState:UIControlStateNormal];
        [_requireBtn addTarget:self action:@selector(requireBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _requireBtn;
}
-(UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.textColor = [UIColor whiteColor];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        _cancelBtn.backgroundColor = [UIColor colorWithHexString:kGrayColor];
        _cancelBtn.layer.cornerRadius = 5;
        _cancelBtn.tag = 0;
    }
    return _cancelBtn;
}
-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        _submitBtn.titleLabel.textColor = [UIColor whiteColor];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:kGrayColor];
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.tag = 1;
    }
    return _submitBtn;
}
@end
