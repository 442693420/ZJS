//
//  HMPTabBarButton.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPTabBarButton.h"

@implementation HMPTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#34373C"];

        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.adjustsImageWhenHighlighted = NO;
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self addSubview:self.redUnreadLab];
        self.redUnreadLab.hidden = YES;
        [self.redUnreadLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.mas_centerX).offset(8);
            make.height.equalTo(@16);
            make.width.equalTo(@16);
        }];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.left = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = KRealValue(22);
    self.titleLabel.top = self.height - self.titleLabel.height;
    
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.left = (self.width - self.imageView.width) / 2;
    self.imageView.top = self.titleLabel.top - self.imageView.height-5 ;
}

- (void)setEcount:(NSInteger)ecount{
    _ecount = ecount;
    NSString *countStr = [NSString stringWithFormat:@"%ld",(long)ecount];
    
    self.redUnreadLab.hidden = NO;
    self.redUnreadLab.font= [UIFont systemFontOfSize:11];
    _redUnreadLab.layer.cornerRadius = 7;
    if (ecount == 0) {
        self.redUnreadLab.hidden = YES;
    }else if(ecount>0 &&ecount<=9){
        [self.redUnreadLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_centerX).offset(12);
            make.width.equalTo(@14);
            make.height.equalTo(@14);
        }];
    }
    else if (ecount>9 &&ecount<100){
        [self.redUnreadLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_centerX).offset(10);
            make.width.equalTo(@20);
            make.height.equalTo(@14);
        }];
    }else if (ecount>99) {
        countStr = @"99";
        [self.redUnreadLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_centerX).offset(10);
            make.width.equalTo(@20);
            make.height.equalTo(@14);
        }];
    }
    self.redUnreadLab.text = countStr;
}
- (void)setHighlighted:(BOOL)highlighted {
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)refreshRedUnreadLab{
    self.redUnreadLab.hidden = NO;
    //计算所有未读消息
//    NSInteger count = [SessionDBManager countAllNoReadMessageInAllTable];
    NSInteger count = 99;
    NSString *countStr = [NSString stringWithFormat:@"%ld",(long)count];
    if (count == 0) {
        self.redUnreadLab.hidden = YES;
    }else if (count>9 &&count<100){
        [self.redUnreadLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
        }];
    }else if (count>99) {
        countStr = @"99+";
        [self.redUnreadLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@30);
        }];
    }
    self.redUnreadLab.text = countStr;
}
-(UILabel *)redUnreadLab{
    if (_redUnreadLab == nil) {
        _redUnreadLab = [[UILabel alloc]init];
        _redUnreadLab.textColor = [UIColor whiteColor];
        _redUnreadLab.backgroundColor = [UIColor redColor];
        _redUnreadLab.font = [UIFont systemFontOfSize:14];
        _redUnreadLab.layer.masksToBounds = YES;
        _redUnreadLab.layer.cornerRadius = 8;
        _redUnreadLab.textAlignment = NSTextAlignmentCenter;
    }
    return _redUnreadLab;
}

@end
