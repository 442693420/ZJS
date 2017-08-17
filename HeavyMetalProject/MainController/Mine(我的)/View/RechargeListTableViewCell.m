//
//  RechargeListTableViewCell.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RechargeListTableViewCell.h"

@implementation RechargeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.moneyLab];
        [self addSubview:self.contentLab];
        [self addSubview:self.typeLab];
        [self addSubview:self.timeLab];
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(20));
            make.top.equalTo(self.mas_top).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(30));
        }];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLab.mas_right).offset(KRealValue(20));
            make.centerY.equalTo(self.moneyLab.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
        }];
        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-KRealValue(30));
            make.centerY.equalTo(self.moneyLab.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-KRealValue(30));
            make.top.equalTo(self.typeLab.mas_bottom).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(20));
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark getter and setter
-(UILabel *)moneyLab{
    if (_moneyLab == nil) {
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.textColor = [UIColor blackColor];
        _moneyLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _moneyLab;
}
-(UILabel *)contentLab{
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = [UIColor blackColor];
        _contentLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _contentLab;
}
-(UILabel *)typeLab{
    if (_typeLab == nil) {
        _typeLab = [[UILabel alloc]init];
        _typeLab.textColor = [UIColor darkGrayColor];
        _typeLab.font = [UIFont systemFontOfSize:KRealValue(12)];
    }
    return _typeLab;
}
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor darkGrayColor];
        _timeLab.font = [UIFont systemFontOfSize:KRealValue(12)];
    }
    return _timeLab;
}

@end
