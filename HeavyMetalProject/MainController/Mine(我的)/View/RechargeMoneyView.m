//
//  RechargeMoneyView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RechargeMoneyView.h"
#import "HMPToolManager.h"

@interface RechargeMoneyView()<UITextFieldDelegate>
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *unitLab;
@end
@implementation RechargeMoneyView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.moneyTF];
        [self addSubview:self.unitLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.titleLab.mas_right);
            make.height.mas_equalTo(KRealValue(30));
            make.width.mas_equalTo(KRealValue(150));
        }];
        [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyTF.mas_right).offset(KRealValue(5));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 实际付款金额位数限制，小数点前是 8为整数，小数点后2位
    return [HMPToolManager limitPayMoneyDot:textField shouldChangeCharactersInRange:range replacementString:string dotPreBits:8 dotAfterBits:2];
}
#pragma mark getter and setter
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"￥";
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(20)];
        _titleLab.textColor = [UIColor lightGrayColor];
    }
    return _titleLab;
}
-(UITextField *)moneyTF{
    if (_moneyTF == nil) {
        _moneyTF = [[UITextField alloc]init];
        _moneyTF.textColor = [UIColor blackColor];
        _moneyTF.font = [UIFont systemFontOfSize:KRealValue(14)];
        _moneyTF.layer.masksToBounds = YES;
        _moneyTF.layer.cornerRadius = KRealValue(5);
        _moneyTF.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _moneyTF.layer.borderWidth = 1;
        _moneyTF.delegate = self;
        _moneyTF.keyboardType = UIKeyboardTypeDecimalPad;//纯数字+小数点
        _moneyTF.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyTF;
}
-(UILabel *)unitLab{
    if (_unitLab == nil) {
        _unitLab = [[UILabel alloc]init];
        _unitLab.text = @"元";
        _unitLab.textColor = [UIColor blackColor];
        _unitLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _unitLab;
}
@end
