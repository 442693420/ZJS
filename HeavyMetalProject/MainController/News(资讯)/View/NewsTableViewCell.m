//
//  NewsTableViewCell.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.titleLab];
        [self addSubview:self.infoLab];
        [self addSubview:self.timeLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(20));
            make.top.equalTo(self.mas_top).offset(KRealValue(8));
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
            make.height.mas_equalTo(KRealValue(30));
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLab);
            make.top.equalTo(self.titleLab.mas_bottom);
            make.height.mas_equalTo(KRealValue(30));
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
            make.bottom.equalTo(self.mas_bottom).offset(-KRealValue(8));
            make.height.mas_equalTo(KRealValue(30));
        }];

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark getter and setter
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
-(UILabel *)infoLab{
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.numberOfLines = 0;
        _infoLab.font = [UIFont systemFontOfSize:14];
        _infoLab.textColor = [UIColor lightTextColor];
    }
    return _infoLab;
}
-(UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:12];
        _timeLab.textColor = [UIColor darkGrayColor];
    }
    return _timeLab;
}
@end
