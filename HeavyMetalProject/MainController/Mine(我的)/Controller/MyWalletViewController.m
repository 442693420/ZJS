//
//  MyWalletViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/13.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "MyWalletViewController.h"
#import "LoginViewController.h"
#import "RechargeListViewController.h"
#import "RechargeAndVIPViewController.h"
#import "WalletObject.h"
@interface MyWalletViewController ()
@property (nonatomic , strong)WalletObject *walletObj;


@property (nonatomic , strong)UIImageView *titleImgView;
@property (nonatomic , strong)UILabel *myGoldTitleLab;
@property (nonatomic , strong)UILabel *myGoldInfoLab;
@property (nonatomic , strong)UIButton *rechargeBtn;
@property (nonatomic , strong)UIButton *vipBtn;
@property (nonatomic , strong)UILabel *vipDateLab;
@property (nonatomic , strong)UILabel *vipMoneyLab;


@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的钱包";
    //导航栏按钮
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
    [rightButton setTitle:@"充值记录" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [rightButton addTarget:self action:@selector(presentRightVC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [self creatUI];
    
    [self fetchDetailInfo];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.titleImgView];
    [self.view addSubview:self.myGoldTitleLab];
    [self.view addSubview:self.myGoldInfoLab];
    [self.view addSubview:self.rechargeBtn];
    [self.view addSubview:self.vipBtn];
    [self.view addSubview:self.vipDateLab];
    [self.view addSubview:self.vipMoneyLab];

    [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(KRealValue(100));
        make.height.width.mas_equalTo(KRealValue(100));
    }];
    [self.myGoldTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.titleImgView.mas_bottom).offset(KRealValue(8));
    }];
    [self.myGoldInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.myGoldTitleLab.mas_bottom).offset(KRealValue(8));
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(self.myGoldInfoLab.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(40));
    }];
    [self.vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.top.equalTo(self.rechargeBtn.mas_bottom).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(40));
    }];
    [self.vipDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.vipBtn.mas_bottom).offset(KRealValue(20));
    }];
    [self.vipMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.vipDateLab.mas_bottom).offset(KRealValue(8));
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(IBAction)presentRightVC:(id)sender{
    RechargeListViewController *rechargeListVC = [[RechargeListViewController alloc]init];
    [self.navigationController pushViewController:rechargeListVC animated:YES];
}
//获取详情信息
- (void)fetchDetailInfo{
    UserObject *userObj = [UserManger getUserInfoDefault];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    [HMPAFNetWorkManager POST:API_WalletInfo params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        self.walletObj = [WalletObject mj_objectWithKeyValues:dic[@"msg"]];
        if ([rc isEqualToString:@"0"])
        {
            self.myGoldInfoLab.text = [NSString stringWithFormat:@"%@个",self.walletObj.gold];
            NSString *rechargeBtnStr = [NSString stringWithFormat:@"充值 (%@个金属币=￥1.00元)",self.walletObj.exchange];
            [self.rechargeBtn setTitle:rechargeBtnStr forState:UIControlStateNormal];
            switch ([self.walletObj.viptype integerValue]) {
                case 0://非会员
                    [self.vipBtn setTitle:@"成为年费会员" forState:UIControlStateNormal];
                    self.vipDateLab.text = @"我的年费会员：尚未开通";
                    break;
                case 1://普通会员
                    [self.vipBtn setTitle:@"成为年费会员" forState:UIControlStateNormal];
                    self.vipDateLab.text = @"我的年费会员：尚未开通";
                    break;
                case 2://年费会员
                    [self.vipBtn setTitle:@"续费年费会员" forState:UIControlStateNormal];
                    self.vipDateLab.text = [NSString stringWithFormat:@"我的年费会员：%@",self.walletObj.vipenddate];
                    break;
                default:
                    break;
            }
            self.vipMoneyLab.text = [NSString stringWithFormat:@"￥%.2f元/年 查看报价信息无需使用金属币",[self.walletObj.memberprice floatValue]];
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
-(IBAction)rechargeBtnAction:(id)sender{
    RechargeAndVIPViewController *rechargeVC = [[RechargeAndVIPViewController alloc]init];
    rechargeVC.type = @"0";//充值金币
    rechargeVC.walletObj = self.walletObj;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
-(IBAction)vipBtnAction:(id)sender{
    RechargeAndVIPViewController *rechargeVC = [[RechargeAndVIPViewController alloc]init];
    rechargeVC.type = @"1";//充值年费会员
    rechargeVC.walletObj = self.walletObj;
    [self.navigationController pushViewController:rechargeVC animated:YES];
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
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
        _titleImgView.image = [UIImage imageNamed:@"bigGold"];
    }
    return _titleImgView;
}
-(UILabel *)myGoldTitleLab {
    if (_myGoldTitleLab == nil) {
        _myGoldTitleLab = [[UILabel alloc]init];
        _myGoldTitleLab.font = [UIFont  systemFontOfSize:KRealValue(14)];
        _myGoldTitleLab.textColor = [UIColor whiteColor];
        _myGoldTitleLab.text = @"我的金属币";
    }
    return _myGoldTitleLab;
}
-(UILabel *)myGoldInfoLab {
    if (_myGoldInfoLab == nil) {
        _myGoldInfoLab = [[UILabel alloc]init];
        _myGoldInfoLab.font = [UIFont  systemFontOfSize:KRealValue(30)];
        _myGoldInfoLab.textColor = [UIColor whiteColor];
    }
    return _myGoldInfoLab;
}
-(UIButton *)rechargeBtn{
    if (_rechargeBtn == nil) {
        _rechargeBtn = [[UIButton alloc]init];
        _rechargeBtn.backgroundColor = [UIColor colorWithHexString:@"#1BAC19"];
        _rechargeBtn.layer.masksToBounds = YES;
        _rechargeBtn.layer.cornerRadius = KRealValue(5);
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        [_rechargeBtn addTarget:self action:@selector(rechargeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}
-(UIButton *)vipBtn{
    if (_vipBtn == nil) {
        _vipBtn = [[UIButton alloc]init];
        _vipBtn.backgroundColor = [UIColor whiteColor];
        _vipBtn.layer.masksToBounds = YES;
        _vipBtn.layer.cornerRadius = KRealValue(5);
        [_vipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _vipBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        [_vipBtn addTarget:self action:@selector(vipBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vipBtn;
}
-(UILabel *)vipDateLab{
    if (_vipDateLab == nil) {
        _vipDateLab = [[UILabel alloc]init];
        _vipDateLab.font = [UIFont  systemFontOfSize:KRealValue(14)];
        _vipDateLab.textColor = [UIColor whiteColor];
    }
    return _vipDateLab;
}
-(UILabel *)vipMoneyLab{
    if (_vipMoneyLab == nil) {
        _vipMoneyLab = [[UILabel alloc]init];
        _vipMoneyLab.font = [UIFont  systemFontOfSize:KRealValue(12)];
        _vipMoneyLab.textColor = [UIColor whiteColor];
    }
    return _vipMoneyLab;
}
@end
