//
//  SearchViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/2.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "SearchViewController.h"
#import "LoginViewController.h"
#import "QuotePriceChartsDetailViewController.h"
#import "NewsDetailViewController.h"
#import "ShowPriceView.h"
#import "SearchHotView.h"
#import "MJRefresh.h"
#import "CellModelObject.h"
#import "NewsListObject.h"
#import "QuotePriceStyleOneTableViewCell.h"
#import "QuotePriceStyleTwoTableViewCell.h"
#import "QuotePriceStyleThreeTableViewCell.h"
#import "QuotePriceStyleFourTableViewCell.h"
#import "QuotePriceStyleFiveTableViewCell.h"
#import "QuotePriceStyleSixTableViewCell.h"
#import "QuotePriceStyleSevenTableViewCell.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int start_id;
    int sum;
    
    UITextField *searchField;//输入搜索的内容
    UITableView *tableview;//显示搜索提示
}
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)NSArray *searchHotArr;
@property (nonatomic , strong)NSArray *newsHotArr;
@property (nonatomic , strong)ShowPriceView *showPriceView;//查看价格的询问View
@property (nonatomic , strong)SearchHotView *hotView;//热门搜索和热门资讯

@end
static NSString *cellIdentifier1 = @"QuotePriceStyleOneTableViewCell";
static NSString *cellIdentifier2 = @"QuotePriceStyleTwoTableViewCell";
static NSString *cellIdentifier3 = @"QuotePriceStyleThreeTableViewCell";
static NSString *cellIdentifier4 = @"QuotePriceStyleFourTableViewCell";
static NSString *cellIdentifier5 = @"QuotePriceStyleFiveTableViewCell";
static NSString *cellIdentifier6 = @"QuotePriceStyleSixTableViewCell";
static NSString *cellIdentifier7 = @"QuotePriceStyleSevenTableViewCell";

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *searchTFBackView=[[UIView alloc] init];
    searchTFBackView.backgroundColor=[UIColor colorWithHexString:@"#4C4A48"];
    searchTFBackView.userInteractionEnabled=YES;
    searchTFBackView.layer.masksToBounds = YES;
    searchTFBackView.layer.cornerRadius = KRealValue(5);
    [self.view addSubview:searchTFBackView];
    [searchTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRealValue(20));
        make.right.equalTo(self.view.mas_right).offset(-KRealValue(20));
        make.height.mas_equalTo(KRealValue(40));
        make.top.equalTo(self.view.mas_top).offset(64+20);
    }];
    
    //放大镜按钮
    UIButton *searchBtn=[[UIButton alloc]init];
    [searchBtn setImage:[UIImage imageNamed:@"searchBigMirror"] forState:UIControlStateNormal];
    [searchTFBackView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searchTFBackView.mas_right).offset(-KRealValue(20));
        make.width.height.mas_equalTo(KRealValue(20));
        make.centerY.equalTo(searchTFBackView.mas_centerY);
    }];
    
    searchField =[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 285, 40)];
    searchField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    searchField.returnKeyType=UIReturnKeySearch;
    searchField.textAlignment=NSTextAlignmentLeft;
    searchField.font = [UIFont systemFontOfSize:16];
    searchField.textColor=[UIColor whiteColor];
    searchField.placeholder=@"输入名称";
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchField.delegate=self;
    [searchField becomeFirstResponder];
    [searchField addTarget:self action:@selector(textFieldChanded:) forControlEvents:UIControlEventEditingChanged];
    [searchTFBackView addSubview:searchField];
    
    //提示信息的tableView
    tableview=[[UITableView alloc]init];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.rowHeight = KRealValue(144);
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor=[UIColor colorWithHexString:@"#0xf0f0f0"];
    tableview.hidden=YES;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(searchTFBackView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        start_id = 0;
        [self searchAction];
    }];
    tableview.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (start_id >= sum) {
            [MBManager showBriefAlert:@"已经是最后一页了"];
            [tableview.footer endRefreshing];
        }else{
            start_id = start_id + 10;
            [self searchAction];
        }
    }];
    //cell加入缓存池
    [tableview registerClass:[QuotePriceStyleOneTableViewCell class] forCellReuseIdentifier:cellIdentifier1];
    [tableview registerClass:[QuotePriceStyleTwoTableViewCell class] forCellReuseIdentifier:cellIdentifier2];
    [tableview registerClass:[QuotePriceStyleThreeTableViewCell class] forCellReuseIdentifier:cellIdentifier3];
    [tableview registerClass:[QuotePriceStyleFourTableViewCell class] forCellReuseIdentifier:cellIdentifier4];
    [tableview registerClass:[QuotePriceStyleFiveTableViewCell class] forCellReuseIdentifier:cellIdentifier5];
    [tableview registerClass:[QuotePriceStyleSixTableViewCell class] forCellReuseIdentifier:cellIdentifier6];
    [tableview registerClass:[QuotePriceStyleSevenTableViewCell class] forCellReuseIdentifier:cellIdentifier7];

    //热门资讯和热门搜索
    [self.view addSubview:self.hotView];
    [self.hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(searchTFBackView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.dataArr = [[NSMutableArray alloc]init];
    start_id = 0;
    sum = 10;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadHotData];
}
- (IBAction)searchBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSDictionary *dic = self.searchHotArr[btn.tag];
    searchField.text = dic[@"keyword"];
    tableview.hidden=NO;
    self.hotView.hidden=YES;
    [self searchAction];
}
- (IBAction)newsBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NewsListObject *obj = self.newsHotArr[btn.tag];
    NewsDetailViewController *detailVC = [[NewsDetailViewController alloc]init];
    detailVC.newsId = obj.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}
//获取热门数据
- (void)loadHotData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = [UserManger getUserInfoDefault].sid;
    [HMPAFNetWorkManager POST:API_SearchHotInfo params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"])
        {
            self.searchHotArr = [[NSArray alloc]initWithArray:responseObject[@"hotlst"]];
            self.newsHotArr = [NewsListObject mj_objectArrayWithKeyValuesArray:responseObject[@"informationlst"]];
            [self.hotView creatUIHotView:self.searchHotArr newsHot:self.newsHotArr];
            for (UIButton *searchBtn in self.hotView.searchBtnArr) {
                [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            for (UIButton *newsBtn in self.hotView.newsBtnArr) {
                [newsBtn addTarget:self action:@selector(newsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            }
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
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error)
     {

     }];
}
- (void)searchAction{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = [UserManger getUserInfoDefault].sid;
    params[@"keyword"] = searchField.text;
    params[@"start_id"] = [NSString stringWithFormat:@"%d",start_id];
    params[@"sum"] = [NSString stringWithFormat:@"%d",sum];
    [HMPAFNetWorkManager POST:API_Search params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rc"] isEqualToString:@"0"])
        {
            NSArray *array = responseObject[@"msg"];
            if (start_id == 0)
            {
                self.dataArr = [CellModelObject mj_objectArrayWithKeyValuesArray:array];
            }
            else
            {
                [self.dataArr addObjectsFromArray:[CellModelObject mj_objectArrayWithKeyValuesArray:array]];
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
         [tableview reloadData];
         [self delayMethod];
     }];
}
- (void)hidekeyboard{
    [searchField resignFirstResponder];
}

#pragma mark ----UITextFieldDelegate------
- (void)textFieldChanded:(UITextField *)textField{
    tableview.hidden=NO;
    self.hotView.hidden=YES;
    [self searchAction];
    if (searchField.text.length==0) {
        tableview.hidden=YES;
        self.hotView.hidden=NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self performSelector:@selector(searchAction) withObject:nil afterDelay:0];
    return YES;
}

#pragma mark ----tableview----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [searchField resignFirstResponder];
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
    
    [self searchAction];
    
}
-(void)footerRereshing
{
    start_id = start_id +sum;
    
    [self searchAction];
    
}
-(void)delayMethod
{
    [tableview.header endRefreshing];
    [tableview.footer endRefreshing];
    
    [tableview reloadData];
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
        if ([rc isEqualToString:@"0"])
        {
            CellModelObject *obj = self.dataArr[btn.cellIndexPath.row];
            if ([type isEqualToString:@"1"]) {
                obj.isgz = @"1";
            }else{
                obj.isgz = @"0";
            }
            //刷新
            [tableview reloadRowsAtIndexPaths:@[btn.cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
-(IBAction)showPriceBtnClick:(id)sender{
    QuotePriceTableViewCellBtn *btn = (QuotePriceTableViewCellBtn *)sender;
    self.showPriceView.hidden = NO;
    self.showPriceView.clid = btn.clid;
    self.showPriceView.cellIndexPath = btn.cellIndexPath;
    
    [self.view bringSubviewToFront:self.showPriceView];
}
- (void)showPriceAlertBtnAction:(NSInteger)btnTag indexPath:(NSIndexPath *)indexPath clid:(NSString *)clid{
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
                [tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
- (NSMutableAttributedString *)cellUpDownAttributedString:(NSString *)contentStr colorContent:(NSString *)colorContent color:(UIColor *)fontColor{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //设置：在0-X个单位长度内的内容显示成红色
    NSInteger length = colorContent.length;
    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0,length)];
    return attrStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(SearchHotView *)hotView{
    if (_hotView == nil) {
        _hotView = [[SearchHotView alloc]init];
    }
    return _hotView;
}
@end
