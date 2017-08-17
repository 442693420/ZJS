//
//  AttentionViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "AttentionViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "FilterViewController.h"
#import "QuotePriceChartsDetailViewController.h"
#import "HMPSegmentScrollView.h"
#import "HMPNaviSegmentView.h"
#import "MJRefresh.h"
#import "ShowPriceView.h"
#import "ShowAllPriceView.h"

#import "QuotePriceStyleOneTableViewCell.h"
#import "QuotePriceStyleTwoTableViewCell.h"
#import "QuotePriceStyleThreeTableViewCell.h"
#import "QuotePriceStyleFourTableViewCell.h"
#import "QuotePriceStyleFiveTableViewCell.h"
#import "QuotePriceStyleSixTableViewCell.h"
#import "QuotePriceStyleSevenTableViewCell.h"

#import "SmallClassObject.h"
#import "CellModelObject.h"

#import "LoginViewController.h"
@interface AttentionViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int start_id;
    int sum;
}
typedef NS_ENUM(NSInteger , KShowPriceViewType) {
    KShowPriceViewTypeForOne = 0,//针对单个商品的刷新
    KShowPriceViewTypeForAll = 1,//针对当前三级分类的刷新
};
@property (nonatomic , strong)ShowPriceView *showPriceView;//查看价格的询问View
@property (nonatomic , strong)ShowAllPriceView *showAllPriceView;//底部一次性支付并显示价格信息的View

@property (nonatomic , strong)NSMutableArray *smallArr;//所有三级对象
@property (nonatomic , assign)NSInteger currentSmallIndex;//三级标题的索引
@property (nonatomic , strong)NSMutableArray *dataArr;//三级目录下的详情列表
@property (nonatomic , strong)NSMutableArray *refreshArr;//三级目录下的详情列表(未显示价格的部分)

@end
static NSInteger kSegmentUITag = 900;//分段器的tag
static NSInteger kTableViewTag = 800;//tableView TAG值

static NSString *cellIdentifier1 = @"QuotePriceStyleOneTableViewCell";
static NSString *cellIdentifier2 = @"QuotePriceStyleTwoTableViewCell";
static NSString *cellIdentifier3 = @"QuotePriceStyleThreeTableViewCell";
static NSString *cellIdentifier4 = @"QuotePriceStyleFourTableViewCell";
static NSString *cellIdentifier5 = @"QuotePriceStyleFiveTableViewCell";
static NSString *cellIdentifier6 = @"QuotePriceStyleSixTableViewCell";
static NSString *cellIdentifier7 = @"QuotePriceStyleSevenTableViewCell";

@implementation AttentionViewController

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"refreshArr"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.title = @"关注";
    
    //注册消息通知
    [self installMovieNotificationObservers];
    //分页
    start_id = 0;
    sum = 10;
    self.smallArr = [[NSMutableArray alloc]init];
    //判断登录状态
    if (![UserManger getUserInfoDefault]) {
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
    }
    self.currentSmallIndex = 0;
    [self.view addSubview:self.showPriceView];
    [self.showPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.showPriceView.hidden = YES;
    [self.view addSubview:self.showAllPriceView];
    [self.showAllPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KRealValue(HMPTabbarHeight));
        make.height.mas_equalTo(KRealValue(40));
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.leftBarButtonItem = nil;//隐藏返回
    //获取栏目返分组
    [self getSegmentArr];
}
- (void)getSegmentArr{
    UserObject *userObj = [UserManger getUserInfoDefault];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    
    [HMPAFNetWorkManager POST:API_GetAttentionClassify params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        NSArray *msg = dic[@"msg"];
        if ([rc isEqualToString:@"0"])
        {
            self.smallArr = [SmallClassObject mj_objectArrayWithKeyValuesArray:msg];
            //增加默认的 全部
            SmallClassObject *smallObj = [[SmallClassObject alloc]init];
            smallObj.smlclassid = @"";
            smallObj.smlclassname = @"全部";
            [self.smallArr insertObject:smallObj atIndex:0];
            [self creatSegmentUI:self.smallArr];
        }
        else if ([rc isEqualToString:@"100"])//会话超时
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            //                        [MBManager showBriefMessage:des InView:self.view];
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
        table.rowHeight = KRealValue(144);
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
        [table registerClass:[QuotePriceStyleSevenTableViewCell class] forCellReuseIdentifier:cellIdentifier7];

        [array addObject:table];
    }
    NSMutableArray *smallTitleArr = [[NSMutableArray alloc]init];
    for (SmallClassObject *smallObj in smallArr) {
        [smallTitleArr addObject:smallObj.smlclassname];
    }
    HMPSegmentScrollView *scView=[[HMPSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-HMPTabbarHeight) titleArray:smallTitleArr maxTitleNumInWindow:4 contentViewArray:array clickBlick:^(NSInteger index) {
        self.currentSmallIndex = index-1;
        [self loadListData];
    }];
    scView.tag = kSegmentUITag;
    [self.view addSubview:scView];
    //加载默认数据
    [self loadListData];
}
- (void)loadListData{
    UserObject *userObj = [UserManger getUserInfoDefault];
    SmallClassObject *smallObj = self.smallArr[self.currentSmallIndex];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    params[@"smlclassid"] = smallObj.smlclassid;
    params[@"start_id"] = [NSString stringWithFormat:@"%d",start_id];
    params[@"sum"] = [NSString stringWithFormat:@"%d",sum];
    
    [HMPAFNetWorkManager POST:API_GetAttentionOfferList params:params success:^(NSURLSessionDataTask *task, id responseObject) {
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
            self.refreshArr = [[NSMutableArray alloc]init];
            for (CellModelObject *obj in self.dataArr) {
                if ([obj.needupd isEqualToString:@"1"]) {
                    [[self mutableArrayValueForKeyPath:@"refreshArr"] addObject:obj];
                }
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
            //                        [MBManager showBriefMessage:des InView:self.view];
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
    QuotePriceStyleSevenTableViewCell *cell7 = (QuotePriceStyleSevenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier7];
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;
    cell5.selectionStyle = UITableViewCellSelectionStyleNone;
    cell6.selectionStyle = UITableViewCellSelectionStyleNone;
    cell7.selectionStyle = UITableViewCellSelectionStyleNone;

    CellModelObject *obj = self.dataArr[indexPath.row];
    switch ([obj.styletype integerValue]) {
        case 1:
        {
            cell1.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell1.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell1.cellView.priceBgView.hidden = YES;
                cell1.cellView.showPriceBtn.hidden = NO;
                [cell1.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell1.cellView.priceBgView.hidden = NO;
                cell1.cellView.showPriceBtn.hidden = YES;
                NSString *oldPriceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                NSString *nowPriceLab = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                NSString *countPriceLab = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd3,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd4 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell1.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell1.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd4 floatValue]];
                    
                    cell1.cellView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    cell1.cellView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                    cell1.cellView.countPriceLab.attributedText = [self cellUpDownAttributedString:countPriceLab colorContent:obj.stylecontent.zd3 color:[UIColor colorWithHexString:kMainColorRed]];
                }
                else{
                    cell1.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell1.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd4 substringFromIndex:1] floatValue]];
                    
                    cell1.cellView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    cell1.cellView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                    cell1.cellView.countPriceLab.attributedText = [self cellUpDownAttributedString:countPriceLab colorContent:obj.stylecontent.zd3 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell1.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell1.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell1.cellView.attentionBtn.cellIndexPath = indexPath;
            cell1.cellView.attentionBtn.clid = obj.clid;
            cell1.cellView.attentionBtn.isgz = obj.isgz;
            cell1.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell1.cellView.showPriceBtn.clid = obj.clid;
            [cell1.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell1;
        }
            break;
        case 2:
        {
            cell2.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell2.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell2.cellView.priceBgView.hidden = YES;
                cell2.cellView.showPriceBtn.hidden = NO;
                [cell2.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell2.cellView.priceBgView.hidden = NO;
                cell2.cellView.showPriceBtn.hidden = YES;
                NSString *oldPriceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                NSString *nowPriceLab = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell2.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell2.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd3 floatValue]];
                    
                    cell2.cellView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    cell2.cellView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    cell2.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell2.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd3 substringFromIndex:1] floatValue]];
                    
                    cell2.cellView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    cell2.cellView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell2.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell2.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell2.cellView.attentionBtn.cellIndexPath = indexPath;
            cell2.cellView.attentionBtn.clid = obj.clid;
            cell2.cellView.attentionBtn.isgz = obj.isgz;
            cell2.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell2.cellView.showPriceBtn.clid = obj.clid;
            [ cell2.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell2;
        }
            break;
        case 3:
        {
            cell3.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell3.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell3.cellView.priceBgView.hidden = YES;
                cell3.cellView.showPriceBtn.hidden = NO;
                [cell3.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell3.cellView.priceBgView.hidden = NO;
                cell3.cellView.showPriceBtn.hidden = YES;
                
                NSString *priceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                NSString *averagePriceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell3.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell3.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd3 floatValue]];
                    
                    cell3.cellView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    cell3.cellView.averagePriceLab.attributedText = [self cellUpDownAttributedString:averagePriceStr colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    cell3.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell3.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd3 substringFromIndex:1] floatValue]];
                    
                    cell3.cellView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    cell3.cellView.averagePriceLab.attributedText = [self cellUpDownAttributedString:averagePriceStr colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell3.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell3.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell3.cellView.attentionBtn.cellIndexPath = indexPath;
            cell3.cellView.attentionBtn.clid = obj.clid;
            cell3.cellView.attentionBtn.isgz = obj.isgz;
            cell3.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell3.cellView.showPriceBtn.clid = obj.clid;
            [ cell3.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell3;
        }
            break;
        case 4:
        {
            cell4.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell4.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell4.cellView.priceBgView.hidden = YES;
                cell4.cellView.showPriceBtn.hidden = NO;
                [cell4.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell4.cellView.priceBgView.hidden = NO;
                cell4.cellView.showPriceBtn.hidden = YES;
                
                NSString *priceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                
                //涨跌值
                NSString *type = [obj.stylecontent.zd2 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell4.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell4.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd2 floatValue]];
                    
                    cell4.cellView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    cell4.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell4.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd2 substringFromIndex:1] floatValue]];
                    
                    cell4.cellView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell4.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell4.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell4.cellView.attentionBtn.cellIndexPath = indexPath;
            cell4.cellView.attentionBtn.clid = obj.clid;
            cell4.cellView.attentionBtn.isgz = obj.isgz;
            cell4.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell4.cellView.showPriceBtn.clid = obj.clid;
            [ cell4.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell4;
        }
            break;
        case 5:
        {
            cell5.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell5.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell5.cellView.priceBgView.hidden = YES;
                cell5.cellView.showPriceBtn.hidden = NO;
                [cell5.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell5.cellView.priceBgView.hidden = NO;
                cell5.cellView.showPriceBtn.hidden = YES;
                
                NSString *spotPriceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                NSString *orderPriceLab = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell5.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell5.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd3 floatValue]];
                    
                    cell5.cellView.spotPriceLab.attributedText = [self cellUpDownAttributedString:spotPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    cell5.cellView.orderPriceLab.attributedText = [self cellUpDownAttributedString:orderPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    cell5.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell5.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd3 substringFromIndex:1] floatValue]];
                    
                    cell5.cellView.spotPriceLab.attributedText = [self cellUpDownAttributedString:spotPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    cell5.cellView.orderPriceLab.attributedText = [self cellUpDownAttributedString:orderPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell5.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell5.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell5.cellView.attentionBtn.cellIndexPath = indexPath;
            cell5.cellView.attentionBtn.clid = obj.clid;
            cell5.cellView.attentionBtn.isgz = obj.isgz;
            cell5.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell5.cellView.showPriceBtn.clid = obj.clid;
            [ cell5.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell5;
        }
            break;
        case 6:
        {
            cell6.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell6.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell6.cellView.priceBgView.hidden = YES;
                cell6.cellView.showPriceBtn.hidden = NO;
                [cell6.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell6.cellView.priceBgView.hidden = NO;
                cell6.cellView.showPriceBtn.hidden = YES;
                
                NSString *stockStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                //涨跌值
                NSString *type = [obj.stylecontent.zd2 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell6.cellView.upDownstockLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell6.cellView.upDownstockLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd2 floatValue]];
                    
                    cell6.cellView.stockLab.attributedText = [self cellUpDownAttributedString:stockStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    cell6.cellView.upDownstockLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell6.cellView.upDownstockLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd2 substringFromIndex:1] floatValue]];
                    
                    cell6.cellView.stockLab.attributedText = [self cellUpDownAttributedString:stockStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell6.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell6.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell6.cellView.attentionBtn.cellIndexPath = indexPath;
            cell6.cellView.attentionBtn.clid = obj.clid;
            cell6.cellView.attentionBtn.isgz = obj.isgz;
            cell6.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell6.cellView.showPriceBtn.clid = obj.clid;
            [ cell6.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell6;
        }
            break;
        case 7:
        {
            cell7.cellView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", obj.clname,obj.clph,obj.clgg];
            cell7.cellView.timeLab.text = obj.rq;
            if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                cell7.cellView.priceBgView.hidden = YES;
                cell7.cellView.showPriceBtn.hidden = NO;
                [cell7.cellView.showPriceBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell7.cellView.priceBgView.hidden = NO;
                cell7.cellView.showPriceBtn.hidden = YES;
                
                NSString *oldPriceStr = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd1,obj.stylecontent.dw];
                NSString *nowPriceLab = [NSString stringWithFormat:@"%@ %@",obj.stylecontent.zd2,obj.stylecontent.dw];
                
                //涨跌值
                NSString *type = [obj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                if (![type isEqualToString:@"-"]) {
                    cell7.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorRed];
                    cell7.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↑%.2f",[obj.stylecontent.zd3 floatValue]];
                    
                    cell7.cellView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    cell7.cellView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    cell7.cellView.upDownPriceLab.backgroundColor = [UIColor colorWithHexString:kMainColorGreen];
                    cell7.cellView.upDownPriceLab.text = [NSString stringWithFormat:@"↓%.2f",[[obj.stylecontent.zd3 substringFromIndex:1] floatValue]];
                    
                    cell7.cellView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:obj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    cell7.cellView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:obj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            if ([obj.isgz isEqualToString:@"0"]) {
                [ cell7.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_no"] forState:UIControlStateNormal];
            }else{
                [ cell7.cellView.attentionBtn setImage:[UIImage imageNamed:@"attention_yes"] forState:UIControlStateNormal];
            }
            cell7.cellView.attentionBtn.cellIndexPath = indexPath;
            cell7.cellView.attentionBtn.clid = obj.clid;
            cell7.cellView.attentionBtn.isgz = obj.isgz;
            cell7.cellView.showPriceBtn.cellIndexPath = indexPath;
            cell7.cellView.showPriceBtn.clid = obj.clid;
            [ cell7.cellView.attentionBtn addTarget:self action:@selector(attentionBntClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell7;
        }
            break;
        default:
            break;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModelObject *obj = self.dataArr[indexPath.row];
    if ([obj.needupd isEqualToString:@"1"]) {//是否点击更新价格
        switch ([obj.styletype integerValue]) {
            case 1:
            {
                QuotePriceStyleOneTableViewCell *cell1 = (QuotePriceStyleOneTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell1.cellView.showPriceBtn];
            }
                break;
            case 2:
            {
                QuotePriceStyleTwoTableViewCell *cell2 = (QuotePriceStyleTwoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell2.cellView.showPriceBtn];
            }
                break;
            case 3:
            {
                QuotePriceStyleThreeTableViewCell *cell3 = (QuotePriceStyleThreeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell3.cellView.showPriceBtn];
            }
                break;
            case 4:
            {
                QuotePriceStyleFourTableViewCell *cell4 = (QuotePriceStyleFourTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell4.cellView.showPriceBtn];
            }
                break;
            case 5:
            {
                QuotePriceStyleFiveTableViewCell *cell5 = (QuotePriceStyleFiveTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell5.cellView.showPriceBtn];
            }
                break;
            case 6:
            {
                QuotePriceStyleSixTableViewCell *cell6 = (QuotePriceStyleSixTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell6.cellView.showPriceBtn];
            }
                break;
            case 7:
            {
                QuotePriceStyleSevenTableViewCell *cell7 = (QuotePriceStyleSevenTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self showPriceBtnClick:cell7.cellView.showPriceBtn];
            }
                break;
            default:
                break;
        }
        
    }else{
        QuotePriceChartsDetailViewController *detailVC = [[QuotePriceChartsDetailViewController alloc]init];
        detailVC.cellObj = obj;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
-(void)headerRereshing
{
    start_id = 0;
    if (self.dataArr.count == 0 || self.dataArr == nil) {
        [self getSegmentArr];
    }else{
        [self loadListData];
    }
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
-(IBAction)attentionBntClick:(id)sender{
    QuotePriceTableViewCellBtn *btn = (QuotePriceTableViewCellBtn *)sender;
    NSString *type = @"2";//
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
            //重新获取栏目返分组
            [self getSegmentArr];
            
//            [self.dataArr removeObjectAtIndex:btn.cellIndexPath.row];
//            //刷新
//            UIView *segmentView = [self.view viewWithTag:kSegmentUITag];
//            UITableView *tabelView = [segmentView viewWithTag:kTableViewTag+self.currentSmallIndex];
//            [tabelView reloadData];
        }
        else if ([rc isEqualToString:@"100"])//会话超时
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
-(IBAction)showPriceBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([btn isKindOfClass:[QuotePriceTableViewCellBtn class]]) {//单个刷新
        QuotePriceTableViewCellBtn *btn = (QuotePriceTableViewCellBtn *)sender;
        self.showPriceView.hidden = NO;
        self.showPriceView.clid = btn.clid;
        self.showPriceView.cellIndexPath = btn.cellIndexPath;
        self.showPriceView.tag = KShowPriceViewTypeForOne;
    }else{//整体刷新
        self.showPriceView.hidden = NO;
        self.showPriceView.tag = KShowPriceViewTypeForAll;
        self.showPriceView.alertView.infoLab.text = [NSString stringWithFormat:@"本次查看将扣除%lu金币",(unsigned long)self.refreshArr.count];
    }
    [self.view bringSubviewToFront:self.showPriceView];
}
- (void)showPriceAlertBtnAction:(NSInteger)btnTag indexPath:(NSIndexPath *)indexPath clid:(NSString *)clid{
    if (self.showPriceView.tag == KShowPriceViewTypeForOne) {
        if (btnTag == 0) {//取消
            self.showPriceView.hidden = YES;
        }else{//确定
            UserObject *userObj = [UserManger getUserInfoDefault];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"sid"] = userObj.sid;
            params[@"clid"] = clid;
            params[@"c_s"] = C_S;
            [HMPAFNetWorkManager POST:API_UPDATEPRICEFORONE params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSString *rc = dic[@"rc"];
                if ([rc isEqualToString:@"0"])
                {
                    self.showPriceView.hidden = YES;
                    CellModelPriceObject *stylecontent = [CellModelPriceObject mj_objectWithKeyValues:responseObject[@"stylecontent"]];
                    CellModelObject *obj = self.dataArr[indexPath.row];
                    obj.needupd = @"0";
                    obj.stylecontent = stylecontent;
                    //刷新
                    UIView *segmentView = [self.view viewWithTag:kSegmentUITag];
                    UITableView *tabelView = [segmentView viewWithTag:kTableViewTag+self.currentSmallIndex];
                    [tabelView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
                else if ([rc isEqualToString:@"100"])//会话超时
                {
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    [self.navigationController pushViewController:loginVC animated:YES];
                }
                else
                {
                    //                            [MBManager showBriefMessage:des InView:self.view];
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
    }else if (self.showPriceView.tag == KShowPriceViewTypeForAll){
        if (btnTag == 0) {//取消
            self.showPriceView.hidden = YES;
        }
        else{//确定
            UserObject *userObj = [UserManger getUserInfoDefault];
            SmallClassObject *smallObj = self.smallArr[self.currentSmallIndex];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"sid"] = userObj.sid;
            if (self.currentSmallIndex == 0) {//全部
                params[@"smlclassid"] = @"";
            }else{
                params[@"smlclassid"] = smallObj.smlclassid;
            }
            params[@"c_s"] = C_S;
            [HMPAFNetWorkManager POST:API_UPDATEPRICEFORALL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSString *rc = dic[@"rc"];
                if ([rc isEqualToString:@"0"])
                {
                    self.showPriceView.hidden = YES;
                    //重新获取并刷新数据
                    [self loadListData];
                }
                else if ([rc isEqualToString:@"100"])//会话超时
                {
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    [self.navigationController pushViewController:loginVC animated:YES];
                }
                else
                {
                    //                            [MBManager showBriefMessage:des InView:self.view];
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
    }
}
#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    //KVO
    [self addObserver:self forKeyPath:@"refreshArr" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableAttributedString *)cellUpDownAttributedString:(NSString *)contentStr colorContent:(NSString *)colorContent color:(UIColor *)fontColor{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //设置：在0-X个单位长度内的内容显示成红色
    NSInteger length = colorContent.length;
    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0,length)];
    return attrStr;
}
#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"refreshArr"]) {
        return;
    }
    if ([self.refreshArr count]==0) {//没有需要刷新数据
        self.showAllPriceView.hidden = YES;
        return;
    }
    //有数据
    self.showAllPriceView.hidden = NO;
    [self.view bringSubviewToFront:self.showAllPriceView];
    //刷新
    self.showAllPriceView.numLab.text = [NSString stringWithFormat:@"(%lu项)",(unsigned long)self.refreshArr.count];
}
#pragma mark getter and setter
-(ShowPriceView *)showPriceView
{
    if(_showPriceView == nil){
        _showPriceView = [[ShowPriceView alloc]init];
        __weak __typeof(self)weakSelf = self;
        _showPriceView.btnAction = ^(NSInteger buttonIndex, NSIndexPath *cellIndexPath, NSString *clid) {
            [weakSelf showPriceAlertBtnAction:buttonIndex indexPath:cellIndexPath clid:clid];
        };
    }
    return _showPriceView;
}
-(ShowAllPriceView *)showAllPriceView{
    if (_showAllPriceView == nil) {
        _showAllPriceView = [[ShowAllPriceView alloc]init];
        [_showAllPriceView.refreshBtn addTarget:self action:@selector(showPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showAllPriceView;
}
@end
