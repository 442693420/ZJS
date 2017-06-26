//
//  QuotePriceViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceViewController.h"
#import "QuotePriceOddViewController.h"
#import "QuotePriceEvenViewController.h"
#import "HMPSegmentScrollView.h"
#import "HMPSegmentView.h"
#import "HMPNaviSegmentView.h"

@interface QuotePriceViewController ()<UITableViewDataSource,UITableViewDelegate>


@end
static NSInteger kSegmentUITag = 999;//二级分段器的tag
@implementation QuotePriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blackColor];
    //iOS7新增属性
    self.automaticallyAdjustsScrollViewInsets=NO;

    //搜索按钮
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(KRealValue(10), 20+(KRealValue(44-25))/2, KRealValue(25), KRealValue(25))];
    searchBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:searchBtn];
    
    //筛选按钮
    UIButton *filterBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-KRealValue(10)-KRealValue(25), 20+(KRealValue(44-25))/2, KRealValue(25), KRealValue(25))];
    filterBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:filterBtn];

    //导航栏分段
    NSArray *naviArr = @[@"标题一",@"标题二",@"标题三",@"标题四",@"标题五",@"标题六"];
    HMPNaviSegmentView *segmentToolView=[[HMPNaviSegmentView alloc] initWithFrame:CGRectMake(searchBtn.frame.origin.x+searchBtn.frame.size.width+KRealValue(10), 20, KScreenWidth-KRealValue(40+50), KRealValue(44)) titles:naviArr clickBlick:^void(NSInteger index) {
        NSLog(@"-----%ld",index);
        NSArray *titleArr = @[@"黄铜管",@"黄铜棒",@"黄铜板",@"黄铜箔",@"黄铜线",@"黄铜圈"];
        [self creatSegmentUI:titleArr];
    }];
    segmentToolView.bgScrollViewColor = [UIColor blackColor];//背景色
    [self.view addSubview:segmentToolView];
    //构建默认分段选择器
    NSArray *titleArr = @[@"黄铜管",@"黄铜棒",@"黄铜板",@"黄铜箔",@"黄铜线"];
    [self creatSegmentUI:titleArr];
   
}
- (void)creatSegmentUI:(NSArray *)titleArr{
    UIView *segmentView = [self.view viewWithTag:kSegmentUITag];
    if (segmentView) {
        [segmentView removeFromSuperview];
    }
    NSMutableArray *array=[NSMutableArray array];
    for (int i =0; i<2; i++) {
        UIView *view=[[UIView alloc] init];
        if (i==0) {
            view.backgroundColor=[UIColor brownColor];
        }if (i==1) {
            view.backgroundColor=[UIColor greenColor];
        }
        [array addObject:view];
    }
    UITableView *tbale=[[UITableView alloc] init];
    tbale.delegate=self;
    tbale.dataSource=self;
    tbale.rowHeight=100;
    [array addObject:tbale];
    
    HMPSegmentScrollView *scView=[[HMPSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) titleArray:titleArr contentViewArray:array];
    scView.tag = kSegmentUITag;
    [self.view addSubview:scView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text=@"dkdk";
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
