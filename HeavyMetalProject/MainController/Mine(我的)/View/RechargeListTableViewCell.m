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
        [self addSubview:self.timeLab];
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(20));
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-KRealValue(30));
            make.centerY.equalTo(self.mas_centerY);
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
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor darkGrayColor];
        _timeLab.font = [UIFont systemFontOfSize:KRealValue(12)];
    }
    return _timeLab;
}

@end
