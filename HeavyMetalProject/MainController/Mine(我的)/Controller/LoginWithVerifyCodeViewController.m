//
//  LoginWithVerifyCodeViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "LoginWithVerifyCodeViewController.h"
#import "RegistViewController.h"
#import "ForgetPwdViewController.h"
#import "UIButton+countDown.h"
#import "NSString+Common.h"
@interface LoginWithVerifyCodeViewController ()
@property (nonatomic , strong)UITextField *phoneTF;
@property (nonatomic , strong)UITextField *verifyCodeTF;
@property (nonatomic , strong)UIButton *verifyCodeBtn;
@property (nonatomic , strong)UIButton *loginBtn;
@property (nonatomic , strong)UIButton *registBtn;
@property (nonatomic , strong)UIButton *forgetPwdBtn;

@end
@implementation LoginWithVerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        make.top.equalTo(self.view.mas_top).offset(KRealValue(30));
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
    //登录按钮
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(verifyCodeView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    //注册
    [self.view addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn.mas_left);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
        make.width.mas_equalTo(KRealValue(100));
    }];
    //忘记密码
    [self.view addSubview:self.forgetPwdBtn];
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginBtn.mas_right);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
        make.width.mas_equalTo(KRealValue(100));
    }];
    //三方登录
    UILabel *otherLoginLab = [[UILabel alloc]init];
    otherLoginLab.text = @"使用第三方账号登录";
    otherLoginLab.font = [UIFont systemFontOfSize:KRealValue(12)];
    otherLoginLab.textColor = [UIColor blackColor];
    [self.view addSubview:otherLoginLab];
    [self.view addSubview:self.wxBtn];
    [otherLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.wxBtn.mas_top).offset(-KRealValue(30));
        make.height.mas_equalTo(KRealValue(30));
    }];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KRealValue(40));
        make.width.height.mas_equalTo(KRealValue(40));
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
    params[@"type"] = [NSNumber numberWithInteger:KVerifyTypeLogin];
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
- (IBAction)registBtnClick:(id)sender{
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
- (IBAction)forgetPwdBtnClick:(id)sender{
    ForgetPwdViewController *forgetVC = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
- (IBAction)loginBtnClick:(id)sender{
    if ([self.verifyCodeTF.text isEmpty]) {
        [MBManager showBriefMessage:@"验证码不能为空" InView:self.view];
        return;
    }
    //账户密码登录
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c_s"] = C_S;
    params[@"user_tel"] = self.phoneTF.text;
    params[@"user_code"] = [self.verifyCodeTF.text md5Str];
    params[@"type"] = [NSString stringWithFormat:@"%ld",(long)KLoginTypeCode];
    [HMPAFNetWorkManager POST:API_LOGIN params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [MBManager hideAlert];
        if ([responseObject[@"rc"] isEqualToString:@"0"]) {
            UserObject *model = [UserObject mj_objectWithKeyValues:responseObject[@"msg"]];
            [UserManger saveUserInfoDefault:model];
            //跳转
            [self.navigationController popViewControllerAnimated:YES];
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
        _phoneTF.placeholder = @"请输入手机号码";
        UserObject *userObj = [UserManger getUserInfoDefault];
        if(userObj != nil && userObj.tel != nil)
        {
            _phoneTF.text = userObj.tel;
        }
        _phoneTF.font = [UIFont systemFontOfSize:KRealValue(14)];
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
        [_verifyCodeTF addTarget:self action:@selector(countTextLength:) forControlEvents:UIControlEventEditingChanged];
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
-(UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#4C4A48"];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
-(UIButton *)registBtn{
    if (_registBtn == nil) {
        _registBtn = [[UIButton alloc]init];
        [_registBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor colorWithHexString:@"#5A99E0"] forState:UIControlStateNormal];
        _registBtn.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        [_registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}
-(UIButton *)forgetPwdBtn{
    if (_forgetPwdBtn == nil) {
        _forgetPwdBtn = [[UIButton alloc]init];
        [_forgetPwdBtn setTitle:@"重置密码" forState:UIControlStateNormal];
        [_forgetPwdBtn setTitleColor:[UIColor colorWithHexString:@"#5A99E0"] forState:UIControlStateNormal];
        _forgetPwdBtn.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
        _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        [_forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdBtn;
}
-(UIButton *)wxBtn{
    if (_wxBtn == nil) {
        _wxBtn = [[UIButton alloc]init];
        [_wxBtn setImage:[UIImage imageNamed:@"bigWXLogo"] forState:UIControlStateNormal];
    }
    return _wxBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
