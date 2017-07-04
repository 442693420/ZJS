//
//  QuotePriceChartsDetailViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/4.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceChartsDetailViewController.h"

@interface QuotePriceChartsDetailViewController ()

@end

@implementation QuotePriceChartsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"价格走势图";
    
    UIView *chartsView = [[UIView alloc]init];
    chartsView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:chartsView];
    [chartsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(KRealValue(200));
        make.height.mas_equalTo(KRealValue(280));
    }];
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

@end
