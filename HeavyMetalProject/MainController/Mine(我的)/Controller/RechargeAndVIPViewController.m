//
//  RechargeAndVIPViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RechargeAndVIPViewController.h"
#import "ChooseRechargeContentView.h"
#import "RechargeMoneyView.h"
#import "ChooseBtn.h"
@interface RechargeAndVIPViewController ()
@property (nonatomic , strong)ChooseRechargeContentView *chooseContentView;
@property (nonatomic , strong)RechargeMoneyView *moneyTFView;
@property (nonatomic , strong)UIButton *submitBtn;
@end
static NSInteger chooseRechargeContentViewTag = 100;

@implementation RechargeAndVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值";
    
    [self creatUI];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor blackColor];
    //选择充值方式
    UIView *typeView = [[UIView alloc]init];
    typeView.backgroundColor = [UIColor whiteColor];
    typeView.layer.masksToBounds = YES;
    typeView.layer.cornerRadius = KRealValue(5);
    [self.view addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.height.mas_equalTo(KRealValue(60));
        make.top.equalTo(self.view.mas_top).offset(64+20);
    }];
    
    UILabel *typeLab = [[UILabel alloc]init];
    typeLab.text = @"选择充值方式：";
    typeLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    typeLab.textColor = [UIColor blackColor];
    [typeView addSubview:typeLab];
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeView.mas_left).offset(KRealValue(8));
        make.centerY.equalTo(typeView.mas_centerY);
        make.width.mas_equalTo(KRealValue(100));
    }];
    UILabel *wxLab = [[UILabel alloc]init];
    wxLab.text = @"微信支付";
    wxLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    wxLab.textColor = [UIColor blackColor];
    [typeView addSubview:wxLab];
    [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeLab.mas_right);
        make.centerY.equalTo(typeView.mas_centerY);
    }];
    
    UIImageView *typeImgView = [[UIImageView alloc]init];
    typeImgView.image = [UIImage imageNamed:@"smallWXLogo"];
    [typeView addSubview:typeImgView];
    [typeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxLab.mas_right).offset(KRealValue(8));
        make.centerY.equalTo(typeView.mas_centerY);
        make.height.width.mas_equalTo(KRealValue(20));
    }];
    
    //选择充值内容
    [self.view addSubview:self.chooseContentView];
    [self.chooseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.height.mas_equalTo(KRealValue(2*30+30));
        make.top.equalTo(typeView.mas_bottom).offset(KRealValue(20));
    }];
    if ([self.type isEqualToString:@"0"]) {//充值金属币
        ChooseBtn *btn = self.chooseContentView.btnArr[0];
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
        self.moneyTFView.moneyTF.text = @"";
        self.moneyTFView.moneyTF.enabled = YES;
    }else{//充值年费会员
        ChooseBtn *btn = self.chooseContentView.btnArr[1];
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
        //充值年费会员，金额默认填充，不能修改
        self.moneyTFView.moneyTF.text = self.walletObj.memberprice;
        self.moneyTFView.moneyTF.enabled = NO;
    }
    
    //输入充值金额
    UIView *moneyView = [[UIView alloc]init];
    moneyView.backgroundColor = [UIColor whiteColor];
    moneyView.layer.masksToBounds = YES;
    moneyView.layer.cornerRadius = KRealValue(5);
    [self.view addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.height.mas_equalTo(KRealValue(60));
        make.top.equalTo(self.chooseContentView.mas_bottom).offset(KRealValue(20));
    }];
    
    UILabel *moneyTitleLab = [[UILabel alloc]init];
    moneyTitleLab.text = @"输入充值金额：";
    moneyTitleLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    moneyTitleLab.textColor = [UIColor blackColor];
    [moneyView addSubview:moneyTitleLab];
    [moneyTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyView.mas_left).offset(KRealValue(8));
        make.centerY.equalTo(moneyView.mas_centerY);
        make.width.mas_equalTo(KRealValue(100));
    }];
    [moneyView addSubview:self.moneyTFView];
    [self.moneyTFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyTitleLab.mas_right);
        make.width.mas_equalTo(@200);
        make.centerY.equalTo(moneyView.mas_centerY);
        make.height.mas_equalTo(KRealValue(40));
    }];
    
    //提交
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.height.mas_equalTo(KRealValue(44));
        make.top.equalTo(moneyView.mas_bottom).offset(KRealValue(40));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseContentViewClick:(id)sender{
    ChooseBtn *btn = (ChooseBtn *)sender;
    //单选
    if (!btn.selected) {
        //先把当前选中
        btn.selected = YES;
        btn.imgView.image = [UIImage imageNamed:@"protocol_yes"];
        if (btn.tag == 0+chooseRechargeContentViewTag) {//充值金属币
            self.type = @"0";
        }else if(btn.tag == 1+chooseRechargeContentViewTag){//购买年费会员
            self.type = @"1";
        }
        //再把另一个变为未选中
        for (ChooseBtn *oneBtn in self.chooseContentView.btnArr) {
            if (oneBtn.tag != btn.tag) {
                oneBtn.selected = NO;
                oneBtn.imgView.image = [UIImage imageNamed:@"protocol_no"];
            }
        }
    }
    [self refreshUI];
}
-(void)refreshUI{
    if ([self.type isEqualToString:@"0"]) {//充值金属币
        self.moneyTFView.moneyTF.text = @"";
        self.moneyTFView.moneyTF.enabled = YES;
    }else{//充值年费会员
        //充值年费会员，金额默认填充，不能修改
        self.moneyTFView.moneyTF.text = self.walletObj.memberprice;
        self.moneyTFView.moneyTF.enabled = NO;
    }
}
-(IBAction)submitBtnAction:(id)sender{
//提交
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
-(ChooseRechargeContentView *)chooseContentView{
    if (_chooseContentView == nil) {
        NSString *gold = [NSString stringWithFormat:@"充值 (%@个金属币=￥1.00元)",self.walletObj.exchange];
        NSString *vip = [NSString stringWithFormat:@"购买年费会员（￥%@元/年）",self.walletObj.memberprice];
        _chooseContentView = [[ChooseRechargeContentView alloc]initWithTitle:@"选择充值内容：" chooseBtnArr:@[gold,vip]];
        for (ChooseBtn *btn in _chooseContentView.btnArr) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(chooseContentViewClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        _chooseContentView.backgroundColor = [UIColor whiteColor];
        _chooseContentView.layer.masksToBounds = YES;
        _chooseContentView.layer.cornerRadius = KRealValue(5);
    }
    return _chooseContentView;
}
-(RechargeMoneyView *)moneyTFView{
    if (_moneyTFView == nil) {
        _moneyTFView = [[RechargeMoneyView alloc]init];
    }
    return _moneyTFView;
}
-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#1BAC19"];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = KRealValue(5);
    }
    return _submitBtn;
}
@end
