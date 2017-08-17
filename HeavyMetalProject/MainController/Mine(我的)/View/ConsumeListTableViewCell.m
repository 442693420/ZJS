//
//  ConsumeListTableViewCell.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ConsumeListTableViewCell.h"
@interface ConsumeListTableViewCell()
@property (nonatomic , strong)UILabel *infoTitleLab;
@end
@implementation ConsumeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        [self.topView addSubview:self.timeLab];
        [self.topView addSubview:self.moneyLab];
        [self.topView addSubview:self.goldImgView];
        [self.topView addSubview:self.arrowImgView];
        
        [self.bottomView addSubview:self.infoTitleLab];
        [self.bottomView addSubview:self.infoLab];

        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(@40);
        }];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.topView.mas_bottom);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView.mas_left).offset(KRealValue(20));
            make.centerY.equalTo(self.topView.mas_centerY);
            make.right.equalTo(self.topView.mas_centerX);
        }];
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLab.mas_right).offset(KRealValue(8));
            make.centerY.equalTo(self.topView.mas_centerY);
        }];
        [self.goldImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLab.mas_right).offset(KRealValue(3));
            make.centerY.equalTo(self.topView.mas_centerY);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.topView.mas_right).offset(-KRealValue(20));
            make.centerY.equalTo(self.topView.mas_centerY);
        }];
        
        [self.infoTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(KRealValue(20));
            make.top.equalTo(self.bottomView.mas_top).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(20));
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(KRealValue(20));
            make.right.equalTo(self.bottomView.mas_right).offset(-KRealValue(20));
            make.top.equalTo(self.infoTitleLab.mas_bottom).offset(KRealValue(8));
        }];

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark getter and setter
-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
    }
    return _topView;
}
-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
    }
    return _bottomView;
}
-(UILabel *)moneyLab{
    if (_moneyLab == nil) {
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.textColor = [UIColor whiteColor];
        _moneyLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _moneyLab;
}
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.textColor = [UIColor whiteColor];
        _infoLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _infoLab.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLab;
}
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.font = [UIFont systemFontOfSize:KRealValue(12)];
    }
    return _timeLab;
}
-(UIImageView *)goldImgView{
    if (_goldImgView == nil) {
        _goldImgView = [[UIImageView alloc]init];
        _goldImgView.image = [UIImage imageNamed:@"smallGold"];
    }
    return _goldImgView;
}
-(UIImageView *)arrowImgView{
    if (_arrowImgView == nil) {
        _arrowImgView = [[UIImageView alloc]init];
        _arrowImgView.image = [UIImage imageNamed:@"downArrowWhite"];
    }
    return _arrowImgView;
}
-(UILabel *)infoTitleLab{
    if (_infoTitleLab == nil) {
        _infoTitleLab = [[UILabel alloc]init];
        _infoTitleLab.text = @"消费记录：";
        _infoTitleLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _infoTitleLab.textColor = [UIColor colorWithHexString:@"#1BAC19"];
    }
    return _infoTitleLab;
}
@end
