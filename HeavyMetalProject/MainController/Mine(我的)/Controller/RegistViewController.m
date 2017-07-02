//
//  RegistViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistProtocolButton.h"
#import "UIButton+countDown.h"
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
        [MBManager showBriefMessage:@"手机号长度超出" InView:self.view];
        textField.text = [textField.text substringToIndex:11];
    }
}
- (void)verifyCodeButtonClick:(UIButton *)button {
    if ([self.phoneTF.text isEmpty]) {
        [MBManager showBriefMessage:@"手机号不能为空" InView:self.view];
        return;
    }
    if (![self.phoneTF.text isMobile]) {
        [MBManager showBriefMessage:@"请输入正确的手机号" InView:self.view];
        return;
    }
    [self loadVerifyCodeData];
}
- (void)loadVerifyCodeData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tel"] = self.phoneTF.text;
    params[@"type"] = [NSNumber numberWithInteger:KVerifyTypeRegister];
    [HMPAFNetWorkManager POST:API_GETVERIFYCODE params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqual:@"0"]) {
            [self.verifyCodeBtn startWithTime:50 title:@"获取验证码" countDownTitle:@"s后重试" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
            [MBManager showBriefMessage:@"验证码获取成功" InView:self.view];
        }else{
            [MBManager showBriefMessage:responseObject[@"des"] InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
    }];
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
- (IBAction)registBtnClick:(id)sender{
    if ([self.verifyCodeTF.text isEmpty]) {
        [MBManager showBriefMessage:@"验证码不能为空" InView:self.view];
        return;
    }
    if ([self.pwdTF.text isEmpty]) {
        [MBManager showBriefMessage:@"密码不能为空" InView:self.view];
        return;
    }
    if (self.pwdTF.text.length < 4 || self.pwdTF.text.length >16) {
        [MBManager showBriefMessage:@"密码,4-16位" InView:self.view];
        return;
    }
    if (!self.protocolBtn.selected) {
        [MBManager showBriefMessage:@"请先阅读服务协议" InView:self.view];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_tel"] = self.phoneTF.text;
    params[@"vccode"] = self.verifyCodeTF.text;
    params[@"user_pwd"] = self.pwdTF.text;
    [HMPAFNetWorkManager POST:API_RESGIST params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"]) {
            [MBManager showBriefMessage:@"注册成功" InView:self.view];
            //自动登录
            [self loadLoginData];
        }else{
            [MBManager showBriefMessage:responseObject[@"des"] InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)loadLoginData {
    //账户密码登录
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c_s"] = C_S;
    params[@"user_tel"] = self.phoneTF.text;
    params[@"user_pwd"] = [self.pwdTF.text md5Str];
    params[@"type"] = [NSString stringWithFormat:@"%ld",(long)KLoginTypePhone];
    [HMPAFNetWorkManager POST:API_LOGIN params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"]) {
            UserObject *model = [UserObject mj_objectWithKeyValues:responseObject[@"msg"]];
            [UserManger saveUserInfoDefault:model];
            //跳转
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [MBManager showBriefMessage:responseObject[@"des"] InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark getter and setter
-(UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
        _phoneTF.placeholder = @"手机号";
        _phoneTF.font = [UIFont systemFontOfSize:KRealValue(14)];
        UserObject *userObj = [UserManger getUserInfoDefault];
        if(userObj != nil && userObj.tel != nil)
        {
        _phoneTF.text = userObj.tel;
        }
        [_phoneTF addTarget:self action:@selector(countTextLength:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTF;
}
-(UITextField *)verifyCodeTF{
    if (_verifyCodeTF == nil) {
        _verifyCodeTF = [[UITextField alloc]init];
        _verifyCodeTF.keyboardType = UIKeyboardTypePhonePad;
        _verifyCodeTF.placeholder = @"验证码";
        _verifyCodeTF.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _verifyCodeTF;
}
-(UIButton *)verifyCodeBtn{
    if (_verifyCodeBtn == nil) {
        _verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _verifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(12)];
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
        _pwdTF.placeholder = @"密码，4-16位";
        [_pwdTF setSecureTextEntry:YES];
        _pwdTF.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _pwdTF;
}
-(UIButton *)registBtn{
    if (_registBtn == nil) {
        _registBtn = [[UIButton alloc]init];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _registBtn.layer.masksToBounds = YES;
        _registBtn.layer.cornerRadius = 5;
        _registBtn.backgroundColor = [UIColor colorWithHexString:@"#4C4A48"];
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
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
