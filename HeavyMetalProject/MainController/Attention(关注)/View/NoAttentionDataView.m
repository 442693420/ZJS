//
//  NoAttentionDataView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/17.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "NoAttentionDataView.h"

@implementation NoAttentionDataView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.lab];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(KRealValue(300));
            make.height.mas_equalTo(KRealValue(250));
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.imgView.mas_bottom).offset(10);
        }];
    }
    return self;
}

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"attentionNodataImg"]];
        _imgView.contentMode=UIViewContentModeCenter;
    }
    return _imgView;
}
-(UILabel *)lab{
    if (_lab == nil) {
        _lab = [[UILabel alloc]init];
        _lab.textColor = [UIColor lightGrayColor];
        _lab.font = [UIFont systemFontOfSize:14];
        _lab.numberOfLines = 0;
        //富文本
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"您还没有添加关注产品\n报价页点击“"];
        // 创建图片图片附件
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"attention_no"];
        attach.bounds = CGRectMake(0, 0, 15, 15);
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        [string appendAttributedString:attachString];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"”可添加至关注页"]];
        _lab.attributedText = string;
    }
    return _lab;
}
@end
