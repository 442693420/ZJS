//
//  QuotePriceStyleFiveTableViewCell.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceStyleFiveTableViewCell.h"

@implementation QuotePriceStyleFiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        //名称
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        titleLab.textColor = [UIColor colorWithHexString:kMainWordColorGray];
        titleLab.text = @"名称|牌号|规格";
        [self addSubview:titleLab];
        //昨结/最新/结算/涨跌
        UILabel *infoLab = [[UILabel alloc]init];
        infoLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        infoLab.textColor = [UIColor colorWithHexString:kMainWordColorGray];
        infoLab.text = @"现货价格/订货价格/涨跌";
        [self addSubview:infoLab];
        
        [self addSubview:self.timeLab];
        [self addSubview:self.nameLab];
        [self addSubview:self.priceBgView];
        [self.priceBgView addSubview:self.spotPriceLab];
        [self.priceBgView addSubview:self.orderPriceLab];
        [self.priceBgView addSubview:self.upDownPriceLab];
        [self addSubview:self.showPriceBtn];
        [self addSubview:self.attentionBtn];
        
        //第一行  8+20
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(8));
            make.top.equalTo(self.mas_top).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(20));
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab.mas_right).offset(KRealValue(20));
            make.centerY.equalTo(titleLab.mas_centerY);
            make.height.mas_equalTo(KRealValue(20));
        }];
        //第二行 8+40
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab.mas_left);
            make.top.equalTo(titleLab.mas_bottom).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(40));
            make.right.equalTo(self.mas_right).offset(KRealValue(16+30));
        }];
        [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
            make.width.height.mas_equalTo(KRealValue(30));
            make.centerY.equalTo(self.nameLab.mas_centerY);
        }];
        //第三行 8+20
        [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab.mas_left);
            make.top.equalTo(self.nameLab.mas_bottom).offset(KRealValue(8));
            make.height.mas_equalTo(KRealValue(20));
        }];
        //第四行 30
        [self.priceBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(infoLab.mas_bottom);
            make.height.equalTo(@30);
        }];
        [self.spotPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceBgView.mas_left).offset(KRealValue(8));
            make.centerY.equalTo(self.priceBgView.mas_centerY);
            make.height.mas_equalTo(KRealValue(20));
        }];
        [self.orderPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.spotPriceLab.mas_right).offset(KRealValue(8));
            make.centerY.equalTo(self.priceBgView.mas_centerY);
            make.height.mas_equalTo(KRealValue(20));
            make.width.equalTo(self.spotPriceLab.mas_width);
            make.right.mas_equalTo(self.mas_right).offset(KRealValue(16+60));
        }];
        [self.upDownPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(KRealValue(8));
            make.centerY.equalTo(self.priceBgView.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
            make.width.mas_equalTo(KRealValue(60));
        }];
        [self.showPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceBgView.mas_left).offset(KRealValue(8));
            make.centerY.equalTo(self.priceBgView.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark getter and setter
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _timeLab.textColor = [UIColor colorWithHexString:kMainWordColorGray];
    }
    return _timeLab;
}
-(UILabel *)nameLab{
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = [UIFont boldSystemFontOfSize:KRealValue(14)];
        _nameLab.textColor = [UIColor whiteColor];
        _nameLab.numberOfLines = 0;
    }
    return _nameLab;
}
-(UIView *)priceBgView{
    if (_priceBgView == nil) {
        _priceBgView = [[UIView alloc]init];
        _priceBgView.backgroundColor = [UIColor blackColor];
    }
    return _priceBgView;
}
-(UILabel *)spotPriceLab{
    if (_spotPriceLab == nil) {
        _spotPriceLab = [[UILabel alloc]init];
    }
    return _spotPriceLab;
}
-(UILabel *)orderPriceLab{
    if (_orderPriceLab == nil) {
        _orderPriceLab = [[UILabel alloc]init];
    }
    return _orderPriceLab;
}
-(UILabel *)upDownPriceLab{
    if (_upDownPriceLab == nil) {
        _upDownPriceLab = [[UILabel alloc]init];
        _upDownPriceLab.layer.masksToBounds = YES;
        _upDownPriceLab.layer.cornerRadius = KRealValue(5);
    }
    return _upDownPriceLab;
}
-(UIButton *)showPriceBtn{
    if (_showPriceBtn == nil) {
        _showPriceBtn = [[UIButton alloc]init];
        _showPriceBtn.backgroundColor = [UIColor blackColor];
        [_showPriceBtn setTitle:@"点击查看实时报价" forState:UIControlStateNormal];
        [_showPriceBtn setTitleColor:[UIColor colorWithHexString:kMainColorOrange] forState:UIControlStateNormal];
    }
    return _showPriceBtn;
}
-(UIButton *)attentionBtn{
    if (_attentionBtn == nil) {
        _attentionBtn = [[UIButton alloc]init];
        [_attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
    }
    return _attentionBtn;
}

@end
