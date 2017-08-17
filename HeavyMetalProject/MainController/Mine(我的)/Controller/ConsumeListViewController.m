//
//  ConsumeListViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ConsumeListViewController.h"
#import "MJRefresh.h"
#import "ConsumeListTableViewCell.h"
#import "ConsumeObject.h"
#import "LoginViewController.h"
#import "PickDateView.h"
@interface ConsumeListViewController ()<UITableViewDelegate,UITableViewDataSource,PickDateViewDelegate>{
    int start_id;
    int sum;
}
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)HMPNomalNoDataView *noDataView;
@property (nonatomic , strong)UIButton *chooseDateBtn;

//pickView
@property(nonatomic,strong)PickDateView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)NSString *year;//查询的年
@property (nonatomic,strong)NSString *month;//查询的月
@end
static NSString *cellIdentifier = @"ConsumeListTableViewCell";
static NSString *kRedColor = @"18888E";
static NSString *kGreenColor = @"FC4667";
@implementation ConsumeListViewController
-(void)dealloc{
    //移除KVO
    [self removeObserver:self forKeyPath:@"dataArr"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消费明细";
    self.view.backgroundColor = [UIColor blackColor];
    //KVO
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    
    [self getDefaultYearMonth];//必须在chooseDateBtn初始化之前加
    [self.view addSubview:self.chooseDateBtn];
    [self.chooseDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.mas_equalTo(KRealValue(60));
    }];
    //tabelView
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.chooseDateBtn.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.tableView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
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
    //cell加入缓存池
    [self.tableView registerClass:[ConsumeListTableViewCell class] forCellReuseIdentifier:cellIdentifier];
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
- (void)getDefaultYearMonth{
    //获取当前年月
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents *comp = [gregorian components: unitFlags
                                          fromDate:dt];
    self.year = [NSString stringWithFormat:@"%ld",(long)comp.year];
    self.month = [NSString stringWithFormat:@"%ld",(long)comp.month];
}
- (void)loadListData {
    NSString *month = @"";//格式是201701
    if (self.month.length == 1) {
        month = [NSString stringWithFormat:@"%@0%@",self.year,self.month];
    }else{
        month = [NSString stringWithFormat:@"%@%@",self.year,self.month];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = [UserManger getUserInfoDefault].sid;
    params[@"month"] = month;
    params[@"start_id"] = [NSString stringWithFormat:@"%d",start_id];
    params[@"sum"] = [NSString stringWithFormat:@"%d",sum];
    [HMPAFNetWorkManager POST:API_CONSUMELIST params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"])
        {
            NSArray *array = responseObject[@"msg"];
            if (start_id == 0)
            {
                self.dataArr = [ConsumeObject mj_objectArrayWithKeyValuesArray:array];
            }
            else
            {
                [self.dataArr addObjectsFromArray:[ConsumeObject mj_objectArrayWithKeyValuesArray:array]];
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
-(IBAction)chooseDateAction:(id)sender{
    [_pickview remove];
    NSMutableArray *yearArr = [[NSMutableArray alloc]init];
    int temp = 2017; //App上线年份;
    for (int i = temp; i<temp+1; i++) {
        NSString *year = [NSString stringWithFormat:@"%d年",i];
        [yearArr addObject:year];
    }
    NSLog(@"%@",yearArr);
    NSArray *array=@[yearArr,@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"]];
    _pickview=[[PickDateView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.delegate=self;
    NSString *dateStr = [NSString stringWithFormat:@"%@年%@月",self.year,self.month];
    _pickview.resultString = dateStr;
    [_pickview.pickerView selectRow:0 inComponent:0 animated:NO];//年
    [_pickview.pickerView selectRow:[self.month integerValue]-1 inComponent:1 animated:NO];//月
    [_pickview show];
}
#pragma pickView delegate
-(void)toobarDonBtnHaveClick:(PickDateView *)pickView resultString:(NSString *)resultString{
    NSLog(@"%@",resultString);
    [self.chooseDateBtn setTitle:resultString forState:UIControlStateNormal];
    self.year = @"2017";
    //取出月份
    NSArray *arr = [resultString componentsSeparatedByString:@"年"];
    NSArray *temp = [[arr lastObject] componentsSeparatedByString:@"月"];
    self.month = [temp firstObject];
    [self.tableView.header beginRefreshing];
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
    
    ConsumeListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ConsumeObject *obj = [self.dataArr objectAtIndex:indexPath.row];
    cell.open = obj.open;
    
    if (obj.open) {
        cell.arrowImgView.image = [UIImage imageNamed:@"upArrowWhite"];
        cell.bottomView.hidden = NO;
    }else{
        cell.arrowImgView.image = [UIImage imageNamed:@"downArrowWhite"];
        cell.bottomView.hidden = YES;
    }
    
    if ([obj.count integerValue] == 0) {//年费会员
        cell.moneyLab.text = @"消费总计：年费会员";
        cell.goldImgView.image = [UIImage imageNamed:@"yearVip"];
    }else{
        cell.moneyLab.text = [NSString stringWithFormat:@"消费总计：%@",obj.count];
        cell.goldImgView.image = [UIImage imageNamed:@"smallGold"];
    }
    cell.timeLab.text = [NSString stringWithFormat:@"日期:%@",obj.xfsj];
    cell.infoLab.text = obj.xfnr;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsumeObject *obj = [self.dataArr objectAtIndex:indexPath.row];
    obj.open = !obj.open;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsumeObject *obj = [self.dataArr objectAtIndex:indexPath.row];
    CGSize labelSize = [obj.xfnr sizeWithFont:[UIFont systemFontOfSize:KRealValue(12)] constrainedToSize:CGSizeMake(KScreenWidth-KRealValue(40), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];// 不限制高度
    if (obj.open) {
        return 40+8+20+8+labelSize.height+8;
    }else{
        return KRealValue(40);
    }
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
-(UIButton *)chooseDateBtn{
    if (_chooseDateBtn == nil) {
        _chooseDateBtn = [[UIButton alloc]init];
        
        NSString *dateStr = [NSString stringWithFormat:@"%@年%@月",self.year,self.month];
        [_chooseDateBtn setTitle:dateStr forState:UIControlStateNormal];
        [_chooseDateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chooseDateBtn.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
        _chooseDateBtn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(18)];
        [_chooseDateBtn setImage:[UIImage imageNamed:@"downArrowWhite"] forState:UIControlStateNormal];
        _chooseDateBtn.imageEdgeInsets = UIEdgeInsetsMake(0,KScreenWidth/2+60,0,0);//top,left,bottom,right
        [_chooseDateBtn addTarget:self action:@selector(chooseDateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseDateBtn;
}

@end
