//
//  LoginWithPwdViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "LoginWithPwdViewController.h"
#import "RegistViewController.h"
#import "ForgetPwdViewController.h"

@interface LoginWithPwdViewController ()
@property (nonatomic , strong)UITextField *phoneTF;
@property (nonatomic , strong)UITextField *pwdTF;
@property (nonatomic , strong)UIButton *loginBtn;
@property (nonatomic , strong)UIButton *registBtn;
@property (nonatomic , strong)UIButton *forgetPwdBtn;

@end

@implementation LoginWithPwdViewController

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
        make.top.equalTo(phoneView.mas_bottom).offset(KRealValue(20));
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
    //登录按钮
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(pwdView.mas_bottom).offset(KRealValue(20));
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
- (IBAction)registBtnClick:(id)sender{
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
- (IBAction)forgetPwdBtnClick:(id)sender{
    ForgetPwdViewController *forgetVC = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
- (IBAction)loginBtnClick:(id)sender{
    if ([self.phoneTF.text isEmpty]) {
        [MBManager showBriefMessage:@"手机号不能为空" InView:self.view];
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
    //账户密码登录
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c_s"] = C_S;
    params[@"user_tel"] = self.phoneTF.text;
    params[@"user_pwd"] = [self.pwdTF.text md5Str];
    params[@"type"] = [NSString stringWithFormat:@"%ld",(long)KLoginTypePhone];
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
        _phoneTF.placeholder = @"手机号";
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
-(UITextField *)pwdTF{
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.placeholder = @"密码";
        [_pwdTF setSecureTextEntry:YES];
        _pwdTF.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _pwdTF;
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
        [_wxBtn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    }
    return _wxBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
