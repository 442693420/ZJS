//
//  QuotePriceChartsDetailViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/4.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceChartsDetailViewController.h"
#import "QuotePriceStyleOneView.h"
#import "QuotePriceStyleTwoView.h"
#import "QuotePriceStyleThreeView.h"
#import "QuotePriceStyleFourView.h"
#import "QuotePriceStyleFiveView.h"
#import "QuotePriceStyleSixView.h"
#import "QuotePriceStyleSevenView.h"
#import "QuotePriceDetailChartView.h"
#import "LoginViewController.h"

#import "ChartInfoDataObject.h"
#import "ChartSegmentScrollView.h"

@interface QuotePriceChartsDetailViewController ()
@property (nonatomic , strong)ChartSegmentScrollView *scView;

@property (nonatomic , assign)NSInteger currentIndex;
@property (nonatomic , strong)NSString *zp;
@property (nonatomic , strong)NSArray *yLabArr;
@end
typedef NS_ENUM(NSInteger , KChartInfoDataZP) {
    KChartInfoDataZPOneWeek = 1,	//一周
    KChartInfoDataZPOneMonth = 2,// 一月
    KChartInfoDataZPThreeMonth = 3,	// 三月
    KChartInfoDataZPHalfYear = 4,	// 半年
    KChartInfoDataZPOneYear = 5,	// 一年
};
static NSInteger kChartViewTag = 800;//chartView TAG值

@implementation QuotePriceChartsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"价格走势图";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.currentIndex = 0;
    [self creatUI];
    
}
- (void)creatUI{
    //top 基本信息展示
    switch ([self.cellObj.styletype integerValue]) {
        case 1:
        {
            self.yLabArr = @[@"昨结",@"最新",@"结算"];
            QuotePriceStyleOneView *oneView = [[QuotePriceStyleOneView alloc]init];
            [self.view addSubview:oneView];
            [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            oneView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            oneView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                oneView.priceBgView.hidden = YES;
                oneView.showPriceBtn.hidden = NO;
            }else{
                oneView.priceBgView.hidden = NO;
                oneView.showPriceBtn.hidden = YES;
                NSString *oldPriceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                NSString *nowPriceLab = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd2,self.cellObj.stylecontent.dw];
                NSString *countPriceLab = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd3,self.cellObj.stylecontent.dw];
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd4 substringWithRange:NSMakeRange(0, 1)];
                oneView.upDownPriceLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    oneView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    oneView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                    oneView.countPriceLab.attributedText = [self cellUpDownAttributedString:countPriceLab colorContent:self.cellObj.stylecontent.zd3 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    oneView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    oneView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                    oneView.countPriceLab.attributedText = [self cellUpDownAttributedString:countPriceLab colorContent:self.cellObj.stylecontent.zd3 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            oneView.attentionBtn.hidden = YES;
        }
            break;
        case 2:
        {
            self.yLabArr = @[@"最新"];
            QuotePriceStyleTwoView *twoView = [[QuotePriceStyleTwoView alloc]init];
            [self.view addSubview:twoView];
            [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            twoView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            twoView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                twoView.priceBgView.hidden = YES;
                twoView.showPriceBtn.hidden = NO;
            }else{
                twoView.priceBgView.hidden = NO;
                twoView.showPriceBtn.hidden = YES;
                NSString *oldPriceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                NSString *nowPriceLab = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd2,self.cellObj.stylecontent.dw];
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                twoView.upDownPriceLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    twoView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    twoView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    twoView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    twoView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            twoView.attentionBtn.hidden = YES;
        }
            break;
        case 3:
        {
            self.yLabArr = @[@"均价"];
            QuotePriceStyleThreeView *threeView = [[QuotePriceStyleThreeView alloc]init];
            [self.view addSubview:threeView];
            [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            threeView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            threeView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                threeView.priceBgView.hidden = YES;
                threeView.showPriceBtn.hidden = NO;
            }else{
                threeView.priceBgView.hidden = NO;
                threeView.showPriceBtn.hidden = YES;
                
                NSString *priceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                NSString *averagePriceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd2,self.cellObj.stylecontent.dw];
                
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                threeView.upDownPriceLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    threeView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    threeView.averagePriceLab.attributedText = [self cellUpDownAttributedString:averagePriceStr colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    threeView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    threeView.averagePriceLab.attributedText = [self cellUpDownAttributedString:averagePriceStr colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            
            threeView.attentionBtn.hidden = YES;
        }
            break;
        case 4:
        {
            self.yLabArr = @[@"价格"];
            QuotePriceStyleFourView *fourView = [[QuotePriceStyleFourView alloc]init];
            [self.view addSubview:fourView];
            [fourView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            fourView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            fourView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                fourView.priceBgView.hidden = YES;
                fourView.showPriceBtn.hidden = NO;
            }else{
                fourView.priceBgView.hidden = NO;
                fourView.showPriceBtn.hidden = YES;
                
                NSString *priceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd2 substringWithRange:NSMakeRange(0, 1)];
                fourView.upDownPriceLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    fourView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    fourView.priceLab.attributedText = [self cellUpDownAttributedString:priceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            
            fourView.attentionBtn.hidden = YES;
        }
            break;
        case 5:
        {
            self.yLabArr = @[@"最低现货价格", @"最高现货价格", @"最低订货价格", @"最高订货价格"];
            QuotePriceStyleFiveView *fiveView = [[QuotePriceStyleFiveView alloc]init];
            [self.view addSubview:fiveView];
            [fiveView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            fiveView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            fiveView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                fiveView.priceBgView.hidden = YES;
                fiveView.showPriceBtn.hidden = NO;
            }else{
                fiveView.priceBgView.hidden = NO;
                fiveView.showPriceBtn.hidden = YES;
                
                NSString *spotPriceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                NSString *orderPriceLab = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd2,self.cellObj.stylecontent.dw];
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                fiveView.upDownPriceLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    fiveView.spotPriceLab.attributedText = [self cellUpDownAttributedString:spotPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    fiveView.orderPriceLab.attributedText = [self cellUpDownAttributedString:orderPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    fiveView.spotPriceLab.attributedText = [self cellUpDownAttributedString:spotPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    fiveView.orderPriceLab.attributedText = [self cellUpDownAttributedString:orderPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            fiveView.attentionBtn.hidden = YES;
        }
            break;
        case 6:
        {
            self.yLabArr = @[@"库存"];
            QuotePriceStyleSixView *sixView = [[QuotePriceStyleSixView alloc]init];
            [self.view addSubview:sixView];
            [sixView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            sixView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            sixView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                sixView.priceBgView.hidden = YES;
                sixView.showPriceBtn.hidden = NO;
            }else{
                sixView.priceBgView.hidden = NO;
                sixView.showPriceBtn.hidden = YES;
                
                NSString *stockStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd2 substringWithRange:NSMakeRange(0, 1)];
                sixView.upDownstockLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    sixView.stockLab.attributedText = [self cellUpDownAttributedString:stockStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    sixView.stockLab.attributedText = [self cellUpDownAttributedString:stockStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            
            sixView.attentionBtn.hidden = YES;
        }
            break;
        case 7:
        {
            self.yLabArr = @[@"最低价",@"最高价"];
            QuotePriceStyleSevenView *sevenView = [[QuotePriceStyleSevenView alloc]init];
            [self.view addSubview:sevenView];
            [sevenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.height.mas_equalTo(KRealValue(144));
            }];
            sevenView.nameLab.text = [NSString stringWithFormat:@"%@|%@|%@", self.cellObj.clname,self.cellObj.clph,self.cellObj.clgg];
            sevenView.timeLab.text = self.cellObj.rq;
            if ([self.cellObj.needupd isEqualToString:@"1"]) {//是否点击更新价格
                sevenView.priceBgView.hidden = YES;
                sevenView.showPriceBtn.hidden = NO;
            }else{
                sevenView.priceBgView.hidden = NO;
                sevenView.showPriceBtn.hidden = YES;
                NSString *oldPriceStr = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd1,self.cellObj.stylecontent.dw];
                NSString *nowPriceLab = [NSString stringWithFormat:@"%@ %@",self.cellObj.stylecontent.zd2,self.cellObj.stylecontent.dw];
                //涨跌值
                NSString *type = [self.cellObj.stylecontent.zd3 substringWithRange:NSMakeRange(0, 1)];
                sevenView.upDownPriceLab.hidden = YES;
                if (![type isEqualToString:@"-"]) {
                    sevenView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                    sevenView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    sevenView.oldPriceLab.attributedText = [self cellUpDownAttributedString:oldPriceStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                    sevenView.nowPriceLab.attributedText = [self cellUpDownAttributedString:nowPriceLab colorContent:self.cellObj.stylecontent.zd2 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }
            sevenView.attentionBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
    
    //chart展示
    NSArray *titleArr = @[@"一周",@"一月",@"三月",@"半年",@"一年"];
    NSMutableArray *array=[NSMutableArray array];
    for (int i =0; i<titleArr.count; i++) {
        QuotePriceDetailChartView *chartView = [[QuotePriceDetailChartView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KRealValue(280))];
        chartView.backgroundColor = [UIColor redColor];
        chartView.tag = i+kChartViewTag;
        [array addObject:chartView];
    }
    self.scView=[[ChartSegmentScrollView alloc] initWithFrame:CGRectMake(0, KRealValue(200), KScreenWidth, KRealValue(280+44+40)) titleArray:titleArr contentViewArray:array yLabArr:self.yLabArr clickBlick:^(NSInteger index) {
        self.currentIndex = index-1;
        [self getChartInfoData];
    }];
    self.scView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.scView];
    
    [self getChartInfoData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)getChartInfoData{
    NSString *zq = @"";
    switch (self.currentIndex) {
        case 0:
            zq = [NSString stringWithFormat:@"%ld",(long)KChartInfoDataZPOneWeek];
            break;
        case 1:
            zq = [NSString stringWithFormat:@"%ld",(long)KChartInfoDataZPOneMonth];
            break;
        case 2:
            zq = [NSString stringWithFormat:@"%ld",(long)KChartInfoDataZPThreeMonth];
            break;
        case 3:
            zq = [NSString stringWithFormat:@"%ld",(long)KChartInfoDataZPHalfYear];
            break;
        case 4:
            zq = [NSString stringWithFormat:@"%ld",(long)KChartInfoDataZPOneYear];
            break;
        default:
            break;
    }
    UserObject *userObj = [UserManger getUserInfoDefault];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    params[@"clid"] = self.cellObj.clid;
    params[@"zq"] = zq;
    
    [HMPAFNetWorkManager POST:API_GetChartInfoData params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        if ([rc isEqualToString:@"0"])
        {
            QuotePriceDetailChartView *chartView = [self.scView viewWithTag:kChartViewTag+self.currentIndex];
            chartView.zq = zq;
            [chartView refreshView:[ChartInfoDataObject mj_objectWithKeyValues:dic[@"msg"]]];
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


- (NSMutableAttributedString *)cellUpDownAttributedString:(NSString *)contentStr colorContent:(NSString *)colorContent color:(UIColor *)fontColor{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //设置：在0-X个单位长度内的内容显示成红色
    NSInteger length = colorContent.length;
    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0,length)];
    return attrStr;
}


@end
