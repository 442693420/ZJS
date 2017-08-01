//
//  SearchDetailViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/2.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchDetailViewController ()

@end

@implementation SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor blackColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
