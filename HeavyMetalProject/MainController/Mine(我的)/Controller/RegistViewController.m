//
//  RegistViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistProtocolButton.h"
#import "UserObject.h"
#import "UserManger.h"
#import "UIButton+countDown.h"
#import "NSString+Common.h"
@interface RegistViewController ()
@property (nonatomic , strong)UITextField *phoneTF;
@property (nonatomic , strong)UITextField *verifyCodeTF;
@property (nonatomic , strong)UIButton *verifyCodeBtn;
@property (nonatomic , strong)UITextField *pwdTF;
@property (nonatomic , strong)UIButton *registBtn;
@property (nonatomic , strong)RegistProtocolButton *protocolBtn;

@end
@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"EFEFF4"];
    //手机号
    UIView *phoneView = [[UIView alloc]init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.masksToBounds = YES;
    phoneView.layer.cornerRadius = 5;
    [self.view addSubview:phoneView];
    [phoneView addSubview:self.phoneTF];
    UIImageView *phoneImgView = [[UIImageView alloc]init];
    phoneImgView.image = [UIImage imageNamed:@"phone"];
    [phoneView addSubview:phoneImgView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(self.view.mas_top).offset(KRealValue(30+64));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [phoneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView.mas_centerY);
        make.width.mas_equalTo(KRealValue(11));
        make.height.mas_equalTo(KRealValue(21));
        make.left.equalTo(phoneView.mas_left).offset(KRealValue(20));
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView.mas_centerY);
        make.height.mas_equalTo(KRealValue(30));
        make.left.equalTo(phoneView.mas_left).offset(KRealValue(60));
        make.right.equalTo(phoneView.mas_right).offset(-KRealValue(20));
    }];
    //验证码
    UIView *verifyCodeView = [[UIView alloc]init];
    verifyCodeView.backgroundColor = [UIColor whiteColor];
    verifyCodeView.layer.masksToBounds = YES;
    verifyCodeView.layer.cornerRadius = 5;
    [self.view addSubview:verifyCodeView];
    [verifyCodeView addSubview:self.verifyCodeTF];
    [self.view addSubview:self.verifyCodeBtn];
    UIImageView *verifyCodeImgView = [[UIImageView alloc]init];
    verifyCodeImgView.image = [UIImage imageNamed:@"verifyCode"];
    [verifyCodeView addSubview:verifyCodeImgView];
    [verifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.verifyCodeBtn.mas_left).offset(-KRealValue(20));
        make.top.equalTo(phoneView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [verifyCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verifyCodeView.mas_centerY);
        make.width.mas_equalTo(KRealValue(16));
        make.height.mas_equalTo(KRealValue(19));
        make.left.equalTo(verifyCodeView.mas_left).offset(KRealValue(20));
    }];
    [self.verifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verifyCodeView.mas_centerY);
        make.height.mas_equalTo(KRealValue(30));
        make.left.equalTo(verifyCodeView.mas_left).offset(KRealValue(60));
        make.right.equalTo(self.verifyCodeBtn.mas_left).offset(-KRealValue(20));
    }];
    [self.verifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verifyCodeView.mas_centerY);
        make.height.mas_equalTo(KRealValue(44));
        make.width.mas_equalTo(KRealValue(80));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
    }];
    //密码
    UIView *pwdView = [[UIView alloc]init];
    pwdView.backgroundColor = [UIColor whiteColor];
    pwdView.layer.masksToBounds = YES;
    pwdView.layer.cornerRadius = 5;
    [self.view addSubview:pwdView];
    [pwdView addSubview:self.pwdTF];
    UIImageView *pwdImgView = [[UIImageView alloc]init];
    pwdImgView.image = [UIImage imageNamed:@"password"];
    [pwdView addSubview:pwdImgView];
    [pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(verifyCodeView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [pwdImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pwdView.mas_centerY);
        make.width.mas_equalTo(KRealValue(16));
        make.height.mas_equalTo(KRealValue(19));
        make.left.equalTo(pwdView.mas_left).offset(KRealValue(20));
    }];
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pwdView.mas_centerY);
        make.height.mas_equalTo(KRealValue(30));
        make.left.equalTo(pwdView.mas_left).offset(KRealValue(60));
        make.right.equalTo(pwdView.mas_right).offset(-KRealValue(20));
    }];
    //注册按钮
    [self.view addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(pwdView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    //协议按钮
    [self.view addSubview:self.protocolBtn];
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.protocolBtn.lastLab.mas_right);
        make.top.equalTo(self.registBtn.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(30));
    }];
}
- (void)countTextLength:(UITextField *)textField {
    if (textField.text.length >11) {
        [MBManager showBriefAlert:@"手机号长度超出"];
        textField.text = [textField.text substringToIndex:11];
    }
}
- (void)verifyCodeButtonClick:(UIButton *)button {
    if (![self.phoneTF.text isMobile]) {
        [MBManager showBriefAlert:@"请输入正确的手机号"];
        return;
    }
    [self loadverifyCodeData];
}
- (void)loadverifyCodeData {
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"imei"] = [UUID getUUID];
    //    params[@"tel"] = _phoneFirstTextField.text;
    //    params[@"c_s"] = C_S;
    //    params[@"type"] = LOGININCODE;
    //
    //    [HMPAFNetWorkManager POST:API_GETVERIFYCODE params:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //
    //        J_RegistModel *model = [J_RegistModel mj_objectWithKeyValues:responseObject];
    //
    //        if ([model.rc isEqual:@"0"]) {
    //            [self.verifyCodeBtn startWithTime:50 title:@"获取验证码" countDownTitle:@"s后重试" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    //            [MBManager showBriefAlert:@"验证码获取成功"];
    //
    //        }else{
    //            [MBManager showBriefAlert:model.des];
    //
    //        }
    //    } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //
    //    }];
}

- (IBAction)protocolBtnClick:(id)sender{
    RegistProtocolButton *btn = (RegistProtocolButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
    }else{
        btn.imgView.image = [UIImage imageNamed:@"protocol_no"];
    }
}
#pragma mark getter and setter
-(UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
        _phoneTF.placeholder = @"请输入手机号码";
        UserObject *userObj = [UserManger getUserInfoDefault];
        //        if(userObj != nil && userObj.tel != nil)
        //        {
        //            _phoneFirstTextField.text = userObj.tel;
        //        }
        [_phoneTF addTarget:self action:@selector(countTextLength:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTF;
}
-(UITextField *)verifyCodeTF{
    if (_verifyCodeTF == nil) {
        _verifyCodeTF = [[UITextField alloc]init];
        _verifyCodeTF.keyboardType = UIKeyboardTypePhonePad;
        _verifyCodeTF.placeholder = @"请输入验证码";
        [_verifyCodeTF addTarget:self action:@selector(countTextLength:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verifyCodeTF;
}
-(UIButton *)verifyCodeBtn{
    if (_verifyCodeBtn == nil) {
        _verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _verifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _verifyCodeBtn.layer.cornerRadius = 5;
        _verifyCodeBtn.layer.masksToBounds = YES;
        _verifyCodeBtn.layer.borderWidth = 1.0;
        _verifyCodeBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _verifyCodeBtn.backgroundColor = [UIColor whiteColor];
        [_verifyCodeBtn addTarget:self action:@selector(verifyCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyCodeBtn;
}
-(UITextField *)pwdTF{
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.placeholder = @"请输入密码";
        [_pwdTF setSecureTextEntry:YES];
    }
    return _pwdTF;
}
-(UIButton *)registBtn{
    if (_registBtn == nil) {
        _registBtn = [[UIButton alloc]init];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registBtn.layer.masksToBounds = YES;
        _registBtn.layer.cornerRadius = 5;
        _registBtn.backgroundColor = [UIColor colorWithHexString:@"#4C4A48"];
    }
    return _registBtn;
}
-(RegistProtocolButton *)protocolBtn{
    if (_protocolBtn == nil) {
        _protocolBtn = [[RegistProtocolButton alloc]init];
        [_protocolBtn addTarget:self action:@selector(protocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
