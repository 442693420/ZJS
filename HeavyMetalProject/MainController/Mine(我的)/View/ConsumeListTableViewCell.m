//
//  ConsumeListTableViewCell.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ConsumeListTableViewCell.h"

@implementation ConsumeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.moneyLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.infoLab];
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(20));
            make.width.mas_equalTo(KRealValue(80));
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLab.mas_right).offset(KRealValue(20));
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.timeLab.mas_left).offset(-KRealValue(8));
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
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
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.textColor = [UIColor blackColor];
        _infoLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _infoLab.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLab;
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
