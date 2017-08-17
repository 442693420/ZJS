//
//  RechargeListViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "RechargeListViewController.h"
#import "MJRefresh.h"
#import "RechargeListTableViewCell.h"
#import "RechargeObject.h"
#import "LoginViewController.h"
@interface RechargeListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int start_id;
    int sum;
}
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)HMPNomalNoDataView *noDataView;

@end
static NSString *cellIdentifier = @"RechargeListTableViewCell";
static NSString *kRedColor = @"18888E";
static NSString *kGreenColor = @"FC4667";
@implementation RechargeListViewController

-(void)dealloc{
    //移除KVO
    [self removeObserver:self forKeyPath:@"dataArr"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值记录";
    //KVO
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    //tabelView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.rowHeight = KRealValue(74);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.noDataView.hidden = YES;
        start_id = 0;
        [self loadListData];
    }];
    self.tableView.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (start_id >= sum) {
            [MBManager showBriefAlert:@"已经是最后一页了"];
            [self.tableView.footer endRefreshing];
        }else{
            start_id = start_id + 10;
            [self loadListData];
        }
    }];
    [self.view addSubview:self.tableView];
    //cell加入缓存池
    [self.tableView registerClass:[RechargeListTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.dataArr = [[NSMutableArray alloc]init];
    start_id = 0;
    sum = 10;
    [self.view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@150);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.header beginRefreshing];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)loadListData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = [UserManger getUserInfoDefault].sid;
    params[@"month"] = @"";
    params[@"start_id"] = [NSString stringWithFormat:@"%d",start_id];
    params[@"sum"] = [NSString stringWithFormat:@"%d",sum];
    [HMPAFNetWorkManager POST:API_RechargeList params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"])
        {
            sum = [responseObject[@"count"] intValue];
            NSArray *array = responseObject[@"msg"];
            if (start_id == 0)
            {
                self.dataArr = [RechargeObject mj_objectArrayWithKeyValuesArray:array];
            }
            else
            {
                [self.dataArr addObjectsFromArray:[RechargeObject mj_objectArrayWithKeyValuesArray:array]];
            }
            [self delayMethod];
        }
        else
        {
            if ([responseObject[@"rc"] isEqualToString:@"100"])
            {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC
                                                     animated:YES];
            }else{
                [MBManager showBriefAlert:responseObject[@"des"]];
            }
            [self delayMethod];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error)
     {
         //清空数据
         [self.dataArr removeAllObjects];
         [self.tableView reloadData];
         self.noDataView.hidden = NO;
         self.noDataView.btn.hidden = NO;
         self.noDataView.lab.text = @"网络连接错误";
         [self delayMethod];
     }];
}
#pragma tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RechargeObject *obj = [self.dataArr objectAtIndex:indexPath.row];
    //价格富文本  充值
    NSString *money = [NSString stringWithFormat:@"+%@",obj.czje];
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元",money]];
    NSDictionary *attrDict = @{NSForegroundColorAttributeName: [UIColor colorWithHexString:kRedColor],
                               NSFontAttributeName: [UIFont systemFontOfSize:KRealValue(20)]};
    [attri addAttributes:attrDict range:NSMakeRange(0, money.length)];
    cell.moneyLab.attributedText = attri;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.contentLab.text = obj.cznr;
    cell.typeLab.text = obj.czfs;
    cell.timeLab.text = obj.czsj;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RechargeObject *obj = [self.dataArr objectAtIndex:indexPath.row];
    //    //价格富文本  1充值 2消费
    //    if ([obj.type isEqualToString:@"2"]) {
    //        WXWebViewController *webVC = [[WXWebViewController alloc]init];
    //        J_UserModel *userObj = [J_BaseObject getUserInfoDefault];
    //        NSString *urlStr = [NSString stringWithFormat:@"%@&userid=%@&phoneno=%@&unionid=%@",obj.details_page_url,userObj.ID,userObj.tel,userObj.wx_id];
    //        webVC.urlStr = urlStr;
    //        webVC.webYype = KVipCenterWebTypeHjqOrderDetail;
    //        [self.navigationController pushViewController:webVC animated:YES];
    //    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delayMethod
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [self.tableView reloadData];
    
}
#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        self.noDataView.hidden = NO;
        return;
    }
    //有数据
    self.noDataView.hidden = YES;
    //
}
#pragma mark getter and setter
-(HMPNomalNoDataView *)noDataView{
    if (_noDataView == nil) {
        _noDataView = [[HMPNomalNoDataView alloc]init];
        __weak __typeof(self)weakSelf = self;
        _noDataView.refreshData = ^{
            [weakSelf.tableView.header beginRefreshing];
        };
    }
    return _noDataView;
}
@end
