//
//  NewsDetailViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/13.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "LoginViewController.h"
@interface NewsDetailViewController ()
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *infoLab;
@property (nonatomic , strong)UITextView *contentTV;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= @"咨询详情";
    // Do any additional setup after loading the view.
    [self creatUI];
    
    [self fetchDetailInfo];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.infoLab];
    [self.view addSubview:self.contentTV];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(KRealValue(8+64));
        make.height.mas_equalTo(KRealValue(30));
    }];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(8));
        make.top.equalTo(self.titleLab.mas_bottom).offset(KRealValue(8));
    }];
    [self.contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(8));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(8));
        make.top.equalTo(self.infoLab.mas_bottom).offset(KRealValue(20));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
//获取详情信息
- (void)fetchDetailInfo{
    UserObject *userObj = [UserManger getUserInfoDefault];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    params[@"id"] = self.newsId;
    
    [HMPAFNetWorkManager POST:API_GetNewsDetail params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSDictionary *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            self.titleLab.text = msg[@"title"];
            self.infoLab.text = msg[@"synopsis"];
            self.contentTV.text = msg[@"content"];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  getter and setter
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont  systemFontOfSize:KRealValue(16)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
-(UILabel *)infoLab {
    if (_infoLab == nil) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = [UIFont  systemFontOfSize:KRealValue(12)];
        _infoLab.textColor = [UIColor groupTableViewBackgroundColor];
        _infoLab.numberOfLines = 0;
    }
    return _infoLab;
}
-(UITextView *)contentTV{
    if (_contentTV == nil) {
        _contentTV = [[UITextView alloc]init];
        _contentTV.editable = NO;
        _contentTV.textColor = [UIColor whiteColor];
        _contentTV.backgroundColor = [UIColor blackColor];
    }
    return _contentTV;
}
@end
