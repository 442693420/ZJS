//
//  PersonalInfoDetailViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/14.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "PersonalInfoDetailViewController.h"
#import "LoginViewController.h"
#import "WalletObject.h"
#import "TitleTFView.h"
#import "HorizontalChooseView.h"
#import "VerticalChooseView.h"
#import "ChooseBtn.h"
@interface PersonalInfoDetailViewController ()
@property (nonatomic , strong)WalletObject *walletObj;

@property (nonatomic , strong)TitleTFView *nickNameView;
@property (nonatomic , strong)TitleTFView *realNameView;
@property (nonatomic , strong)HorizontalChooseView *companyTypeView;
@property (nonatomic , strong)TitleTFView *companyNameView;
@property (nonatomic , strong)VerticalChooseView *identityTypeView;
@property (nonatomic , strong)TitleTFView *idNumView;
@property (nonatomic , strong)TitleTFView *businessNumView;
@property (nonatomic , strong)TitleTFView *areaView;
@property (nonatomic , strong)TitleTFView *addressView;

@property (nonatomic , copy)NSString *companyType;//0个人 1公司
@property (nonatomic , copy)NSString *identityType;//0用户  1厂家  2批发商

@end
static NSInteger horizontalTag = 50;
static NSInteger verticalTag = 80;

@implementation PersonalInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的信息";
    
    self.view.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
    //导航栏按钮
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [rightButton addTarget:self action:@selector(presentRightVC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    [self fetchDetailInfo];
}
- (void)creatUI{
    [self.view addSubview:self.nickNameView];
    [self.view addSubview:self.realNameView];
    [self.view addSubview:self.companyTypeView];
    [self.view addSubview:self.companyNameView];
    [self.view addSubview:self.identityTypeView];
    [self.view addSubview:self.idNumView];
    [self.view addSubview:self.businessNumView];
    [self.view addSubview:self.areaView];
    [self.view addSubview:self.addressView];
    
    [self.nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(KRealValue(8+64));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.realNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.nickNameView.mas_bottom).offset(KRealValue(1));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.companyTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.realNameView.mas_bottom).offset(KRealValue(1));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.companyNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.companyTypeView.mas_bottom).offset(KRealValue(1));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.idNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.identityTypeView.mas_bottom).offset(KRealValue(1));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.businessNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.identityTypeView.mas_bottom).offset(KRealValue(1));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.identityTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if ([[UserManger getUserInfoDefault].companyname isEqualToString:@""] ||[UserManger getUserInfoDefault].companyname.length == 0) {//个人
            self.idNumView.hidden = NO;
            self.businessNumView.hidden = YES;
            self.companyNameView.hidden = YES;
            ChooseBtn *btn = self.companyTypeView.btnArr[0];
            btn.selected = YES;
            btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
            make.top.equalTo(self.companyTypeView.mas_bottom).offset(KRealValue(1));
        }else{//公司
            self.idNumView.hidden = YES;
            self.businessNumView.hidden = NO;
            self.companyNameView.hidden = NO;
            ChooseBtn *btn = self.companyTypeView.btnArr[1];
            btn.selected = YES;
            btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
            make.top.equalTo(self.companyTypeView.mas_bottom).offset(KRealValue(1+44+1));
        }
        make.height.mas_equalTo(KRealValue(3*30+30));
    }];
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.identityTypeView.mas_bottom).offset(KRealValue(1+44+20));
        make.height.mas_equalTo(KRealValue(44));
    }];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.areaView.mas_bottom).offset(KRealValue(1));
        make.height.mas_equalTo(KRealValue(44));
    }];
    //用户身份
    if ([[UserManger getUserInfoDefault].usertype isEqualToString:@"3"]) {//用户
        ChooseBtn *btn = self.identityTypeView.btnArr[0];
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
    }else if ([[UserManger getUserInfoDefault].usertype isEqualToString:@"1"]) {//厂家
        ChooseBtn *btn = self.identityTypeView.btnArr[1];
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
    }else{//批发商
        ChooseBtn *btn = self.identityTypeView.btnArr[2];
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
    }
}
- (void)refreshUI{
    [self.identityTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
        if ([self.companyType isEqualToString:@"0"]) {//个人
            self.idNumView.hidden = NO;
            self.businessNumView.hidden = YES;
            self.companyNameView.hidden = YES;
            make.top.equalTo(self.companyTypeView.mas_bottom).offset(KRealValue(1));
            self.companyNameView.infoTF.text = @"";//公司名称清除
            self.businessNumView.infoTF.text = @"";//营业执照编号清除
        }else{//公司
            self.idNumView.hidden = YES;
            self.businessNumView.hidden = NO;
            self.companyNameView.hidden = NO;
            make.top.equalTo(self.companyTypeView.mas_bottom).offset(KRealValue(1+44+1));
            self.idNumView.infoTF.text = @"";//身份证号码清除
        }
    }];
    [self.view layoutIfNeeded];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
//保存个人信息
- (IBAction)presentRightVC:(id)sender{
    UserObject *userObj = [UserManger getUserInfoDefault];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    //不管改不改，把所有属性全部上传
    params[@"nickname"] = self.nickNameView.infoTF.text;
    params[@"realname"] = self.realNameView.infoTF.text;
    params[@"companyname"] = self.companyNameView.infoTF.text;
    if ([self.companyType isEqualToString:@"0"]) {//个人
        params[@"zjhm"] = self.idNumView.infoTF.text;
    }else{
        params[@"zjhm"] = self.businessNumView.infoTF.text;
    }
    params[@"zone"] = self.areaView.infoTF.text;
    params[@"address"] = self.addressView.infoTF.text;
    params[@"usertype"] = self.identityType;

    [HMPAFNetWorkManager POST:API_PersonalInfoUpdate params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        if ([rc isEqualToString:@"0"])
        {
            UserObject *userObj = [UserManger getUserInfoDefault];//补充用户信息
            userObj.nickname = self.nickNameView.infoTF.text;
            userObj.realname = self.realNameView.infoTF.text;
            userObj.companyname = self.companyNameView.infoTF.text;
            if ([self.companyType isEqualToString:@"0"]) {//个人
                userObj.zjhm = self.idNumView.infoTF.text;
            }else{
                userObj.zjhm = self.businessNumView.infoTF.text;
            }
            userObj.zone = self.areaView.infoTF.text;
            userObj.address = self.addressView.infoTF.text;
            userObj.usertype = self.identityType;
            [UserManger saveUserInfoDefault:userObj];
            
            [MBManager showBriefAlert:@"保存成功"];
        }
        else if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            [MBManager showBriefMessage:des InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//获取详情信息
- (void)fetchDetailInfo{
    UserObject *userObj = [UserManger getUserInfoDefault];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    [HMPAFNetWorkManager POST:API_PersonalInfo params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSDictionary *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            UserObject *userObj = [UserManger getUserInfoDefault];//补充用户信息
            userObj.realname = msg[@"realname"];
            userObj.companyname = msg[@"companyname"];
            userObj.zjhm = msg[@"zjhm"];
            userObj.zone = msg[@"zone"];
            userObj.address = msg[@"address"];
            userObj.usertype = msg[@"usertype"];
            [UserManger saveUserInfoDefault:userObj];
            
            [self creatUI];
        }
        else if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            [MBManager showBriefMessage:des InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
-(IBAction)companyTypeViewBtnClick:(id)sender{
    ChooseBtn *btn = (ChooseBtn *)sender;
    //单选
    if (!btn.selected) {
        //先把当前选中
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
        if (btn.tag == 0+horizontalTag) {//个人
            self.companyType = @"0";
        }else if(btn.tag == 1+horizontalTag){//公司
            self.companyType = @"1";
        }
        //再把另一个变为未选中
        for (ChooseBtn *oneBtn in self.companyTypeView.btnArr) {
            if (oneBtn.tag != btn.tag) {
                oneBtn.selected = NO;
                oneBtn.imgView.image = [UIImage imageNamed:@"protocol_no"];
            }
        }
        //刷新
        [self refreshUI];
    }
}
-(IBAction)identityTypeViewBtnClick:(id)sender{
    ChooseBtn *btn = (ChooseBtn *)sender;
    //单选
    if (!btn.selected) {
        //先把当前选中
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
        if (btn.tag == 0+verticalTag) {//用户
            self.identityType = @"0";
        }else if(btn.tag == 1+verticalTag){//厂家
            self.identityType = @"1";
        }else if(btn.tag == 1+verticalTag){//批发商
            self.identityType = @"2";
        }
        //再把另一个变为未选中
        for (ChooseBtn *oneBtn in self.identityTypeView.btnArr) {
            if (oneBtn.tag != btn.tag) {
                oneBtn.selected = NO;
                oneBtn.imgView.image = [UIImage imageNamed:@"protocol_no"];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark getter and setter
-(TitleTFView *)nickNameView{
    if (_nickNameView == nil) {
        _nickNameView = [[TitleTFView alloc]init];
        _nickNameView.titleLab.text = @"昵   称:";
        _nickNameView.infoTF.text = [UserManger getUserInfoDefault].nickname;
    }
    return _nickNameView;
}
-(TitleTFView *)realNameView{
    if (_realNameView == nil) {
        _realNameView = [[TitleTFView alloc]init];
        _realNameView.titleLab.text = @"真实姓名:";
        _realNameView.infoTF.text = [UserManger getUserInfoDefault].realname;
    }
    return _realNameView;
}
-(HorizontalChooseView *)companyTypeView{
    if (_companyTypeView == nil) {
        _companyTypeView = [[HorizontalChooseView alloc]initWithTitle:@"所属单位:" chooseBtnArr:@[@"个人",@"公司"]];
        for (ChooseBtn *btn in _companyTypeView.btnArr) {
            [btn addTarget:self action:@selector(companyTypeViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _companyTypeView;
}
-(TitleTFView *)companyNameView{
    if (_companyNameView == nil) {
        _companyNameView = [[TitleTFView alloc]init];
        _companyNameView.titleLab.text = @"公司名称:";
        _companyNameView.infoTF.text = [UserManger getUserInfoDefault].companyname;
    }
    return _companyNameView;
}
-(VerticalChooseView *)identityTypeView{
    if (_identityTypeView == nil) {
        _identityTypeView = [[VerticalChooseView alloc]initWithTitle:@"用户身份:" chooseBtnArr:@[@"金属材料用户",@"金属材料厂家",@"批发商"]];
        for (ChooseBtn *btn in _identityTypeView.btnArr) {
            [btn addTarget:self action:@selector(identityTypeViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    return _identityTypeView;
}
-(TitleTFView *)idNumView{
    if (_idNumView == nil) {
        _idNumView = [[TitleTFView alloc]init];
        _idNumView.titleLab.text = @"身份证号:";
        _idNumView.infoTF.text = [UserManger getUserInfoDefault].zjhm;
    }
    return _idNumView;
}
-(TitleTFView *)businessNumView{
    if (_businessNumView == nil) {
        _businessNumView = [[TitleTFView alloc]init];
        _businessNumView.titleLab.text = @"营业执照编号:";
        _businessNumView.infoTF.text = [UserManger getUserInfoDefault].zjhm;
    }
    return _businessNumView;
}
-(TitleTFView *)areaView{
    if (_areaView == nil) {
        _areaView = [[TitleTFView alloc]init];
        _areaView.titleLab.text = @"所属地区:";
        _areaView.infoTF.text = [UserManger getUserInfoDefault].zone;
    }
    return _areaView;
}
-(TitleTFView *)addressView{
    if (_addressView == nil) {
        _addressView = [[TitleTFView alloc]init];
        _addressView.titleLab.text = @"具体地址:";
        _addressView.infoTF.text = [UserManger getUserInfoDefault].address;
    }
    return _addressView;
}
@end
