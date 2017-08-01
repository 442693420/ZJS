//
//  ChangePwdViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "LoginViewController.h"
@interface ChangePwdViewController ()
@property (nonatomic , strong)UITextField *oldPwdTF;
@property (nonatomic , strong)UITextField *newPwdTF;
@property (nonatomic , strong)UITextField *newRePwdTF;
@property (nonatomic , strong)UIButton *submitBtn;
@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"EFEFF4"];
    //旧密码
    UIView *oldPwdView = [[UIView alloc]init];
    oldPwdView.backgroundColor = [UIColor whiteColor];
    oldPwdView.layer.masksToBounds = YES;
    oldPwdView.layer.cornerRadius = 5;
    [self.view addSubview:oldPwdView];
    [oldPwdView addSubview:self.oldPwdTF];
    UIImageView *oldPwdImgView = [[UIImageView alloc]init];
    oldPwdImgView.image = [UIImage imageNamed:@"phone"];
    [oldPwdView addSubview:oldPwdImgView];
    [oldPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(self.view.mas_top).offset(KRealValue(30+64));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [oldPwdImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(oldPwdView.mas_centerY);
        make.width.mas_equalTo(KRealValue(11));
        make.height.mas_equalTo(KRealValue(21));
        make.left.equalTo(oldPwdView.mas_left).offset(KRealValue(20));
    }];
    [self.oldPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(oldPwdView.mas_centerY);
        make.height.mas_equalTo(KRealValue(30));
        make.left.equalTo(oldPwdView.mas_left).offset(KRealValue(60));
        make.right.equalTo(oldPwdView.mas_right).offset(-KRealValue(20));
    }];
    //新密码
    UIView *newPwdView = [[UIView alloc]init];
    newPwdView.backgroundColor = [UIColor whiteColor];
    newPwdView.layer.masksToBounds = YES;
    newPwdView.layer.cornerRadius = 5;
    [self.view addSubview:newPwdView];
    [newPwdView addSubview:self.newPwdTF];
    UIImageView *newPwdImgView = [[UIImageView alloc]init];
    newPwdImgView.image = [UIImage imageNamed:@"password"];
    [newPwdView addSubview:newPwdImgView];
    [newPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(oldPwdView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [newPwdImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(newPwdView.mas_centerY);
        make.width.mas_equalTo(KRealValue(16));
        make.height.mas_equalTo(KRealValue(19));
        make.left.equalTo(newPwdView.mas_left).offset(KRealValue(20));
    }];
    [self.newPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(newPwdView.mas_centerY);
        make.height.mas_equalTo(KRealValue(30));
        make.left.equalTo(newPwdView.mas_left).offset(KRealValue(60));
        make.right.equalTo(newPwdView.mas_right).offset(-KRealValue(20));
    }];
    //新密码
    UIView *newPwdReView = [[UIView alloc]init];
    newPwdReView.backgroundColor = [UIColor whiteColor];
    newPwdReView.layer.masksToBounds = YES;
    newPwdReView.layer.cornerRadius = 5;
    [self.view addSubview:newPwdReView];
    [newPwdReView addSubview:self.newRePwdTF];
    UIImageView *newPwdReImgView = [[UIImageView alloc]init];
    newPwdReImgView.image = [UIImage imageNamed:@"password"];
    [newPwdReView addSubview:newPwdReImgView];
    [newPwdReView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(newPwdView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [newPwdReImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(newPwdReView.mas_centerY);
        make.width.mas_equalTo(KRealValue(16));
        make.height.mas_equalTo(KRealValue(19));
        make.left.equalTo(newPwdReView.mas_left).offset(KRealValue(20));
    }];
    [self.newRePwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(newPwdReView.mas_centerY);
        make.height.mas_equalTo(KRealValue(30));
        make.left.equalTo(newPwdReView.mas_left).offset(KRealValue(60));
        make.right.equalTo(newPwdReView.mas_right).offset(-KRealValue(20));
    }];
    //注册按钮
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(newPwdReView.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (IBAction)submitBtnClick:(id)sender{
    if ([self.oldPwdTF.text isEmpty]) {
        [MBManager showBriefMessage:@"旧密码不能为空" InView:self.view];
        return;
    }
    if ([self.newPwdTF.text isEmpty]) {
        [MBManager showBriefMessage:@"新密码不能为空" InView:self.view];
        return;
    }
    if (![self.newRePwdTF.text isEqualToString:self.newPwdTF.text]) {
        [MBManager showBriefMessage:@"新密码确认不一致" InView:self.view];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = [UserManger getUserInfoDefault].sid;
    params[@"oldpwd"] = self.oldPwdTF.text;
    params[@"newpwd"] = self.newPwdTF.text;
    [HMPAFNetWorkManager POST:API_RESGIST params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"]) {
            [MBManager showBriefMessage:@"修改成功" InView:self.view];
            //登录
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }else{
            [MBManager showBriefMessage:responseObject[@"des"] InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark getter and setter
-(UITextField *)oldPwdTF{
    if (_oldPwdTF == nil) {
        _oldPwdTF = [[UITextField alloc]init];
        _oldPwdTF.placeholder = @"旧密码";
        [_oldPwdTF setSecureTextEntry:YES];
        _oldPwdTF.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _oldPwdTF;
}
-(UITextField *)newPwdTF{
    if (_newPwdTF == nil) {
        _newPwdTF = [[UITextField alloc]init];
        _newPwdTF.placeholder = @"新密码，4-16位";
        [_newPwdTF setSecureTextEntry:YES];
        _newPwdTF.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _newPwdTF;
}
-(UITextField *)newRePwdTF{
    if (_newRePwdTF == nil) {
        _newRePwdTF = [[UITextField alloc]init];
        _newRePwdTF.placeholder = @"新密码确认";
        [_newRePwdTF setSecureTextEntry:YES];
        _newRePwdTF.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _newRePwdTF;
}
-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#4C4A48"];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _submitBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
