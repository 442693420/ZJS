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
#import "QuotePriceDetailChartView.h"
#import "LoginViewController.h"

#import "ChartInfoDataObject.h"

@interface QuotePriceChartsDetailViewController ()
@property (nonatomic, strong)QuotePriceDetailChartView *chartView;

@property (nonatomic , strong)NSString *zp;
@end
typedef NS_ENUM(NSInteger , KChartInfoDataZP) {
    KChartInfoDataZPOneWeek = 1,	//一周
    KChartInfoDataZPOneMonth = 2,// 一月
    KChartInfoDataZPThreeMonth = 3,	// 三月
    KChartInfoDataZPHalfYear = 4,	// 半年
    KChartInfoDataZPOneYear = 5,	// 一年
};
@implementation QuotePriceChartsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"价格走势图";
    self.view.backgroundColor = [UIColor blackColor];
    //top 基本信息展示
    switch ([self.cellObj.styletype integerValue]) {
        case 1:
        {
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
                if ([type isEqualToString:@"-"]) {
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
                if ([type isEqualToString:@"-"]) {
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
                if ([type isEqualToString:@"-"]) {
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
                if ([type isEqualToString:@"-"]) {
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
                if ([type isEqualToString:@"-"]) {
                    sixView.stockLab.attributedText = [self cellUpDownAttributedString:stockStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorRed]];
                }else{
                    sixView.stockLab.attributedText = [self cellUpDownAttributedString:stockStr colorContent:self.cellObj.stylecontent.zd1 color:[UIColor colorWithHexString:kMainColorGreen]];
                }
            }

            sixView.attentionBtn.hidden = YES;
        }
            break;
        default:
            break;
    }

    //获取图表信息
    self.zp = [NSString stringWithFormat:@"%ld",(long)KChartInfoDataZPThreeMonth];
    [self getChartInfoData];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)getChartInfoData{
    
    UserObject *userObj = [UserManger getUserInfoDefault];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = userObj.sid;
    params[@"c_s"] = C_S;
    params[@"clid"] = self.cellObj.clid;
    params[@"zq"] = self.zp;

    [HMPAFNetWorkManager POST:API_GetChartInfoData params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *rc = dic[@"rc"];
        NSString *des = dic[@"des"];
        if ([rc isEqualToString:@"0"])
        {
            self.chartView.zp = self.zp;
            [self.chartView refreshView:[ChartInfoDataObject mj_objectWithKeyValues:dic[@"msg"]]];
        }
        if ([rc isEqualToString:@"100"])//会话超时
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
    
    UIView *chartsView = [[UIView alloc]init];
    chartsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chartsView];
    [chartsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(KRealValue(200));
        make.height.mas_equalTo(KRealValue(280));
    }];
    self.chartView = [[QuotePriceDetailChartView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KRealValue(280))];
    [chartsView addSubview:_chartView];
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
