//
//  QuotePriceViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "FilterViewController.h"
#import "QuotePriceChartsDetailViewController.h"
#import "HMPSegmentScrollView.h"
#import "HMPNaviSegmentView.h"
#import "MJRefresh.h"

#import "QuotePriceStyleOneTableViewCell.h"
#import "QuotePriceStyleTwoTableViewCell.h"
#import "QuotePriceStyleThreeTableViewCell.h"
#import "QuotePriceStyleFourTableViewCell.h"
#import "QuotePriceStyleFiveTableViewCell.h"
#import "QuotePriceStyleSixTableViewCell.h"
#import "QuotePriceTableViewCellBtn.h"

#import "BigClassObject.h"
#import "MidClassObject.h"
#import "SmallClassObject.h"
#import "CellModelObject.h"


#import "LoginViewController.h"
@interface QuotePriceViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int start_id;
    int sum;
}
@property (nonatomic , strong)HMPNaviSegmentView *segmentToolView;//二级标题


@property (nonatomic , strong)NSMutableArray *bigArr;//所有一级对象
@property (nonatomic , strong)NSMutableArray *midArr;//所有二级对象
@property (nonatomic , assign)NSInteger currentMidIndex;//二级标题的索引
@property (nonatomic , assign)NSInteger currentSmallIndex;//三级标题的索引
@property (nonatomic , strong)NSMutableArray *dataArr;//三级目录下的详情列表
@end
static NSInteger kSegmentUITag = 900;//二级分段器的tag
static NSInteger kTableViewTag = 800;//tableView TAG值

static NSString *cellIdentifier1 = @"QuotePriceStyleOneTableViewCell";
static NSString *cellIdentifier2 = @"QuotePriceStyleTwoTableViewCell";
static NSString *cellIdentifier3 = @"QuotePriceStyleThreeTableViewCell";
static NSString *cellIdentifier4 = @"QuotePriceStyleFourTableViewCell";
static NSString *cellIdentifier5 = @"QuotePriceStyleFiveTableViewCell";
static NSString *cellIdentifier6 = @"QuotePriceStyleSixTableViewCell";

@implementation QuotePriceViewController
- (void)dealloc{
    [self removeMovieNotificationObservers];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blackColor];
    //iOS7新增属性
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //搜索按钮
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(KRealValue(10), 20+(KRealValue(44-24))/2, KRealValue(24), KRealValue(24))];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    //筛选按钮
    UIButton *filterBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-KRealValue(10)-KRealValue(24), 20+(KRealValue(44-24))/2, KRealValue(24), KRealValue(24))];
    [filterBtn setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
    [filterBtn addTarget:self action:@selector(filterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterBtn];
    
    //注册消息通知
    [self installMovieNotificationObservers];
    //分页
    start_id = 0;
    sum = 10;
    self.dataArr = [[NSMutableArray alloc]init];
    //判断登录状态
    if (![UserManger getUserInfoDefault]) {
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
    }
    self.currentMidIndex = 0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //获取栏目返分组
    [self creatNaviSegmentUI];
}
- (void)creatNaviSegmentUI{
    UserObject *userObj = [UserManger getUserInfoDefault];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    
    [HMPAFNetWorkManager POST:API_GetClassify params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSArray *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            self.bigArr = [BigClassObject mj_objectArrayWithKeyValuesArray:msg];
            NSLog(@"%@",self.bigArr);
            //1.取出所有二级obj
            self.midArr = [[NSMutableArray alloc]init];
            for (BigClassObject *bigObj in self.bigArr) {
                for (MidClassObject *midObj in bigObj.midclasslst) {
                    [self.midArr addObject:midObj];
                }
            }
            //导航栏分段,构建二级标题
            NSMutableArray *midTitleArr = [[NSMutableArray alloc]init];
            for (MidClassObject *midObj in self.midArr) {
                [midTitleArr addObject:midObj.midclassname];
            }
            self.segmentToolView=[[HMPNaviSegmentView alloc] initWithFrame:CGRectMake(KRealValue(20+24), 20, KScreenWidth-KRealValue(40+48), KRealValue(44)) titles:midTitleArr clickBlick:^void(NSInteger index) {
                NSLog(@"-----%ld",index);
                self.currentMidIndex = index-1;
                self.currentSmallIndex = 0;//每次点击二级标题，一级标题的index要从0开始
                [self loadListData];
                //构建三级分段选择器
                MidClassObject *indexMidObj = self.midArr[index-1];
                [self creatSegmentUI:indexMidObj.smlclasslst];
            }];
            self.segmentToolView.defaultIndex = self.currentMidIndex+1;//默认选中第一个;//defaultIndex从1开始   currentMidIndex从0开始
            self.segmentToolView.bgScrollViewColor = [UIColor blackColor];//背景色
            [self.view addSubview:self.segmentToolView];
            //构建默认三级分段选择器
            if (self.midArr) {
                MidClassObject *firstMidObj = self.midArr[self.currentMidIndex];
                [self creatSegmentUI:firstMidObj.smlclasslst];
            }
            self.currentSmallIndex = 0;
            [self loadListData];
        }
        if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            //            [MBManager showBriefMessage:des InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)creatSegmentUI:(NSArray *)smallArr{
    UIView *segmentView = [self.view viewWithTag:kSegmentUITag];
    if (segmentView) {
        [segmentView removeFromSuperview];
    }
    NSMutableArray *array=[NSMutableArray array];
    for (int i =0; i<smallArr.count; i++) {
        UITableView *table=[[UITableView alloc] init];
        table.delegate=self;
        table.tag = i+kTableViewTag;
        table.dataSource=self;
        table.rowHeight=134;
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
        [table registerClass:[QuotePriceStyleOneTableViewCell class] forCellReuseIdentifier:cellIdentifier1];
        [table registerClass:[QuotePriceStyleTwoTableViewCell class] forCellReuseIdentifier:cellIdentifier2];
        [table registerClass:[QuotePriceStyleThreeTableViewCell class] forCellReuseIdentifier:cellIdentifier3];
        [table registerClass:[QuotePriceStyleFourTableViewCell class] forCellReuseIdentifier:cellIdentifier4];
        [table registerClass:[QuotePriceStyleFiveTableViewCell class] forCellReuseIdentifier:cellIdentifier5];
        [table registerClass:[QuotePriceStyleSixTableViewCell class] forCellReuseIdentifier:cellIdentifier6];
        [array addObject:table];
    }
    NSMutableArray *smallTitleArr = [[NSMutableArray alloc]init];
    for (SmallClassObject *smallObj in smallArr) {
        [smallTitleArr addObject:smallObj.smlclassname];
    }
    HMPSegmentScrollView *scView=[[HMPSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-HMPTabbarHeight) titleArray:smallTitleArr contentViewArray:array clickBlick:^(NSInteger index) {
        self.currentSmallIndex = index-1;
        [self loadListData];
    }];
    scView.tag = kSegmentUITag;
    [self.view addSubview:scView];
}
- (void)loadListData{
    UserObject *userObj = [UserManger getUserInfoDefault];
    MidClassObject *midObj = self.midArr[self.currentMidIndex];
    NSArray *smallArr = midObj.smlclasslst;
    SmallClassObject *smallObj = smallArr[self.currentSmallIndex];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    params[@"smlclassid"] = smallObj.smlclassid;
    params[@"start_id"] = [NSString stringWithFormat:@"%d",start_id];
    params[@"sum"] = [NSString stringWithFormat:@"%d",sum];
    
    [HMPAFNetWorkManager POST:API_GetOfferList params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSArray *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            if (start_id == 0)
            {
                self.dataArr = [CellModelObject mj_objectArrayWithKeyValuesArray:msg];
            }
            else
            {
                [self.dataArr addObjectsFromArray:[CellModelObject mj_objectArrayWithKeyValuesArray:msg]];
            }
            [self delayMethod];
        }if ([rc isEqualToString:@"100"])//会话超时
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
    QuotePriceStyleOneTableViewCell *cell1 = (QuotePriceStyleOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    QuotePriceStyleTwoTableViewCell *cell2 = (QuotePriceStyleTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    QuotePriceStyleThreeTableViewCell *cell3 = (QuotePriceStyleThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
    QuotePriceStyleFourTableViewCell *cell4 = (QuotePriceStyleFourTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
    QuotePriceStyleFiveTableViewCell *cell5 = (QuotePriceStyleFiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
    QuotePriceStyleSixTableViewCell *cell6 = (QuotePriceStyleSixTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier6];
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;
    cell5.selectionStyle = UITableViewCellSelectionStyleNone;
    cell6.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CellModelObject *obj = self.dataArr[indexPath.row];
    switch ([obj.styletype integerValue]) {
        case 1:
        {
            cell1.nameLab.text = obj.clname;
            cell1.timeLab.text = obj.rq;
            if (obj.needupd) {//是否点击更新价格
                cell1.priceBgView.hidden = YES;
                cell1.showPriceBtn.hidden = NO;
            }else{
                cell1.priceBgView.hidden = NO;
                cell1.showPriceBtn.hidden = YES;
                cell1.oldPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                cell1.nowPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                cell1.countPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd3,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd4 substringWithRange:NSMakeRange(0, 1)];
                if ([type isEqualToString:@"-"]) {
                    cell1.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell1.upDownPriceLab.text = [NSString stringWithFormat:@"↓%@",obj.stylecontent.zd4];
                }else{
                    cell1.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell1.upDownPriceLab.text = [NSString stringWithFormat:@"↑%@",obj.stylecontent.zd4];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [cell1.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [cell1.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell1.attentionBtn.cellIndexPath = indexPath;
            cell1.attentionBtn.clid = obj.clid;
            cell1.attentionBtn.isgz = obj.isgz;
            [cell1.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell1;
        }
            break;
        case 2:
        {
            cell2.nameLab.text = obj.clname;
            cell2.timeLab.text = obj.rq;
            if (obj.needupd) {//是否点击更新价格
                cell2.priceBgView.hidden = YES;
                cell2.showPriceBtn.hidden = NO;
            }else{
                cell2.priceBgView.hidden = NO;
                cell2.showPriceBtn.hidden = YES;
                cell2.oldPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                cell2.nowPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if ([type isEqualToString:@"-"]) {
                    cell2.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell2.upDownPriceLab.text = [NSString stringWithFormat:@"↓%@",obj.stylecontent.zd3];
                }else{
                    cell2.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell2.upDownPriceLab.text = [NSString stringWithFormat:@"↑%@",obj.stylecontent.zd3];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [cell2.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [cell2.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell2.attentionBtn.cellIndexPath = indexPath;
            cell2.attentionBtn.clid = obj.clid;
            cell2.attentionBtn.isgz = obj.isgz;
            [cell2.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell2;
        }
            break;
        case 3:
        {
            cell3.nameLab.text = obj.clname;
            cell3.timeLab.text = obj.rq;
            if (obj.needupd) {//是否点击更新价格
                cell3.priceBgView.hidden = YES;
                cell3.showPriceBtn.hidden = NO;
            }else{
                cell3.priceBgView.hidden = NO;
                cell3.showPriceBtn.hidden = YES;
                cell3.priceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                cell3.averagePriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if ([type isEqualToString:@"-"]) {
                    cell3.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell3.upDownPriceLab.text = [NSString stringWithFormat:@"↓%@",obj.stylecontent.zd3];
                }else{
                    cell3.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell3.upDownPriceLab.text = [NSString stringWithFormat:@"↑%@",obj.stylecontent.zd3];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [cell3.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [cell3.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell3.attentionBtn.cellIndexPath = indexPath;
            cell3.attentionBtn.clid = obj.clid;
            cell3.attentionBtn.isgz = obj.isgz;
            [cell3.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell3;
        }
            break;
        case 4:
        {
            cell4.nameLab.text = obj.clname;
            cell4.timeLab.text = obj.rq;
            if (obj.needupd) {//是否点击更新价格
                cell4.priceBgView.hidden = YES;
                cell4.showPriceBtn.hidden = NO;
            }else{
                cell4.priceBgView.hidden = NO;
                cell4.showPriceBtn.hidden = YES;
                cell4.priceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd2 substringWithRange:NSMakeRange(0, 1)];
                if ([type isEqualToString:@"-"]) {
                    cell4.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell4.upDownPriceLab.text = [NSString stringWithFormat:@"↓%@",obj.stylecontent.zd2];
                }else{
                    cell4.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell4.upDownPriceLab.text = [NSString stringWithFormat:@"↑%@",obj.stylecontent.zd2];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [cell4.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [cell4.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell4.attentionBtn.cellIndexPath = indexPath;
            cell4.attentionBtn.clid = obj.clid;
            cell4.attentionBtn.isgz = obj.isgz;
            [cell4.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell4;
        }
            break;
        case 5:
        {
            cell5.nameLab.text = obj.clname;
            cell5.timeLab.text = obj.rq;
            if (obj.needupd) {//是否点击更新价格
                cell5.priceBgView.hidden = YES;
                cell5.showPriceBtn.hidden = NO;
            }else{
                cell5.priceBgView.hidden = NO;
                cell5.showPriceBtn.hidden = YES;
                cell5.spotPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                cell5.orderPriceLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if ([type isEqualToString:@"-"]) {
                    cell5.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell5.upDownPriceLab.text = [NSString stringWithFormat:@"↓%@",obj.stylecontent.zd3];
                }else{
                    cell5.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell5.upDownPriceLab.text = [NSString stringWithFormat:@"↑%@",obj.stylecontent.zd3];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [cell5.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [cell5.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell5.attentionBtn.cellIndexPath = indexPath;
            cell5.attentionBtn.clid = obj.clid;
            cell5.attentionBtn.isgz = obj.isgz;
            [cell5.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell5;
        }
            break;
        case 6:
        {
            cell6.nameLab.text = obj.clname;
            cell6.timeLab.text = obj.rq;
            if (obj.needupd) {//是否点击更新价格
                cell6.priceBgView.hidden = YES;
                cell6.showPriceBtn.hidden = NO;
            }else{
                cell6.priceBgView.hidden = NO;
                cell6.showPriceBtn.hidden = YES;
                cell6.stockLab.text = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd2 substringWithRange:NSMakeRange(0, 1)];
                if ([type isEqualToString:@"-"]) {
                    cell6.upDownstockLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell6.upDownstockLab.text = [NSString stringWithFormat:@"↓%@",obj.stylecontent.zd2];
                }else{
                    cell6.upDownstockLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell6.upDownstockLab.text = [NSString stringWithFormat:@"↑%@",obj.stylecontent.zd2];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [cell6.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [cell6.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell6.attentionBtn.cellIndexPath = indexPath;
            cell6.attentionBtn.clid = obj.clid;
            cell6.attentionBtn.isgz = obj.isgz;
            [cell6.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell6;
        }
            break;
        default:
            break;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuotePriceChartsDetailViewController *detailVC = [[QuotePriceChartsDetailViewController alloc]init];
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
    UIView *segmentView = [self.view viewWithTag:kSegmentUITag];
    UITableView *tabelView = [segmentView viewWithTag:kTableViewTag+self.currentSmallIndex];
    [tabelView.header endRefreshing];
    [tabelView.footer endRefreshing];
    
    [tabelView reloadData];
}
#pragma mark pricate
-(IBAction)searchBtnClick:(id)sender{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(IBAction)filterBtnClick:(id)sender{
    FilterViewController *filterVC = [[FilterViewController alloc]init];
    filterVC.dataArr = [[NSMutableArray alloc]initWithArray:self.bigArr];
    MidClassObject *midObj = self.midArr[self.currentMidIndex];
    filterVC.currentMidTitle = midObj.midclassname;
    [self.navigationController pushViewController:filterVC animated:YES];
}
-(IBAction)attentionBntClick:(id)sender{
    QuotePriceTableViewCellBtn *btn = (QuotePriceTableViewCellBtn *)sender;
    NSString *type;
    if ([btn.isgz isEqualToString:@"0"]) {
        type = @"1";
    }else{
        type = @"2";
    }
    UserObject *userObj = [UserManger getUserInfoDefault];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"clid"] = btn.clid;
    params[@"type"] = type;
    params[@"c_s"] = C_S;
    
    [HMPAFNetWorkManager POST:API_AttentionOffer params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSArray *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            CellModelObject *obj = self.dataArr[btn.cellIndexPath.row];
            if ([type isEqualToString:@"1"]) {
                obj.isgz = @"1";
            }else{
                obj.isgz = @"0";
            }
            //刷新
            UIView *segmentView = [self.view viewWithTag:kSegmentUITag];
            UITableView *tabelView = [segmentView viewWithTag:kTableViewTag+self.currentSmallIndex];
            [tabelView reloadRowsAtIndexPaths:@[btn.cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            //            [MBManager showBriefMessage:des InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma Notifiacation action
- (void)quotePriceSmallSegmentScrollNotifiCation:(NSNotification *)notification {
    NSString *str = notification.object;
    if ([str isEqualToString:@"first"]) {
        if (self.currentMidIndex != 0) {
            [self.segmentToolView bgScrollWithIndex:self.currentMidIndex-1];
        }
    }else if([str isEqualToString:@"last"]){
        if (self.currentMidIndex != self.midArr.count) {
            [self.segmentToolView bgScrollWithIndex:self.currentMidIndex+1];
        }
    }
}
- (void)filterChangeSegmentNotifiCation:(NSNotification *)notification {
    NSString *str = notification.object;
    for (int i = 0; i < self.midArr.count; i++) {
        MidClassObject *midObj = self.midArr[i];
        if ([midObj.midclassname isEqualToString:str]) {
            self.currentMidIndex = i;
            break;
        }
    }
}

#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(quotePriceSmallSegmentScrollNotifiCation:)
                                                 name:kQuotePriceSmallSegmentScrollNotifiCation
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(filterChangeSegmentNotifiCation:)
                                                 name:kFilterChangeSegmentNotifiCation
                                               object:nil];
}

- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kQuotePriceSmallSegmentScrollNotifiCation
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kFilterChangeSegmentNotifiCation
                                                  object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
