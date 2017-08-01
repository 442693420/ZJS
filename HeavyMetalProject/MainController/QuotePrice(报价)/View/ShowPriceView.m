//
//  ShowPriceView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ShowPriceView.h"

@implementation ShowPriceView


-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.mas_equalTo(KRealValue(200));
            make.width.mas_equalTo(KRealValue(260));
        }];
    }
    return self;
}
- (IBAction)alertBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    self.btnAction(btn.tag,self.cellIndexPath,self.clid);
}
-(ShowPriceAlertView *)alertView{
    if (_alertView == nil) {
        _alertView = [[ShowPriceAlertView alloc]init];
        [_alertView.cancelBtn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView.submitBtn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alertView;
}
@end
