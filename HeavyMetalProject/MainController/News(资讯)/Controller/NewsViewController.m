//
//  NewsViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "NewsViewController.h"
#import "HMPSegmentScrollView.h"
#import "LoginViewController.h"
#import "NewsDetailViewController.h"
#import "BigClassObject.h"
#import "MJRefresh.h"
#import "NewsTableViewCell.h"
#import "NewsListObject.h"
#import "MidClassObject.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int start_id;
    int sum;
}
@property (nonatomic , strong)HMPSegmentScrollView *scView;
@property (nonatomic , strong)NSMutableArray *segmentsArr;//所有的二级标题
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , assign)NSInteger currentIndex;
@end
static NSInteger kTableViewTag = 800;//tableView TAG值
static NSString *cellIdentifier = @"NewsTableViewCell";

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"有色金属资讯";
    // Do any additional setup after loading the view.
    self.segmentsArr = [[NSMutableArray alloc]init];
    self.currentIndex = 0;
    start_id = 0;
    sum = 10;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.leftBarButtonItem = nil;//隐藏返回
    
    [self creatSegmentsUI];
}
- (void)creatSegmentsUI{
    UserObject *userObj = [UserManger getUserInfoDefault];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    
    [HMPAFNetWorkManager POST:API_GetNewsClassify params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSArray *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
           NSMutableArray *bigArr = [BigClassObject mj_objectArrayWithKeyValuesArray:msg];
            //1.取出所有二级obj
            self.segmentsArr = [[NSMutableArray alloc]init];
            for (BigClassObject *bigObj in bigArr) {
                for (MidClassObject *midObj in bigObj.midclasslst) {
                    [self.segmentsArr addObject:midObj];
                }
            }
            NSLog(@"%@",self.segmentsArr);
            NSMutableArray *midTitleArr = [[NSMutableArray alloc]init];
            NSMutableArray *array=[NSMutableArray array];
            for (int i =0; i<self.segmentsArr.count; i++) {
                //标题
                MidClassObject *midObj = self.segmentsArr[i];
                [midTitleArr addObject:midObj.midclassname];
                //tableview
                UITableView *table=[[UITableView alloc] init];
                table.delegate = self;
                table.tag = i+kTableViewTag;
                table.dataSource=self;
                table.rowHeight = KRealValue(130);
                table.backgroundColor = [UIColor blackColor];
                table.separatorColor = [UIColor colorWithHexString:kMainWordColorGray];
                table.tableFooterView = [[UIView alloc]init];
                table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self headerRereshing];
                }];
                table.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
                    [self footerRereshing];
                }];
                //cell加入缓存池
                [table registerClass:[NewsTableViewCell class] forCellReuseIdentifier:cellIdentifier];
                [array addObject:table];
            }
            self.scView=[[HMPSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-HMPTabbarHeight) titleArray:midTitleArr maxTitleNumInWindow:3 contentViewArray:array clickBlick:^(NSInteger index) {
                self.currentIndex = index-1;
                [self loadListData];
            }];
            self.scView.segmentToolView.bgScrollViewColor = [UIColor blackColor];
            self.scView.segmentToolView.titleSelectColor = [UIColor colorWithHexString:@"#FF5E3A"];
            
            [self.view addSubview:self.scView];
            
            //默认请求
            [self loadListData];
        }
        else if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            [MBManager showBriefAlert:des];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)loadListData{
    UserObject *userObj = [UserManger getUserInfoDefault];
    MidClassObject *midObj = self.segmentsArr[self.currentIndex];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    params[@"classid"] = midObj.midclassid;
    params[@"start_id"] = [NSString stringWithFormat:@"%d",start_id];
    params[@"sum"] = [NSString stringWithFormat:@"%d",sum];
    
    [HMPAFNetWorkManager POST:API_GetNewsList params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSArray *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            if (start_id == 0)
            {
                self.dataArr = [NewsListObject mj_objectArrayWithKeyValuesArray:msg];
            }
            else
            {
                [self.dataArr addObjectsFromArray:[NewsListObject mj_objectArrayWithKeyValuesArray:msg]];
            }
            [self delayMethod];
        }
        else if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
//            [MBManager showBriefMessage:des InView:self.view];
            [self delayMethod];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self delayMethod];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsListObject *obj = self.dataArr[indexPath.row];

    cell.titleLab.text = obj.title;
    cell.infoLab.text = obj.synopsis;
    cell.timeLab.text = [[obj.time componentsSeparatedByString:@" "] firstObject];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListObject *obj = self.dataArr[indexPath.row];
    NewsDetailViewController *detailVC = [[NewsDetailViewController alloc]init];
    detailVC.newsId = obj.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)headerRereshing
{
    start_id = 0;
    
    [self loadListData];
    
}
-(void)footerRereshing
{
    start_id = start_id +sum;
    
    [self loadListData];
    
}
-(void)delayMethod
{
    UITableView *tabelView = [self.scView viewWithTag:kTableViewTag+self.currentIndex];
    [tabelView.header endRefreshing];
    [tabelView.footer endRefreshing];
    
    [tabelView reloadData];
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
