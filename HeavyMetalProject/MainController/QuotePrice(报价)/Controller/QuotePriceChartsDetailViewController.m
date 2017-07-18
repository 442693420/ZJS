//
//  QuotePriceChartsDetailViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/4.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceChartsDetailViewController.h"
#import "HeavyMetalProject-Bridging-Header.h"
#import "SymbolsValueFormatter.h"
@interface CubicLineSampleFillFormatter : NSObject <IChartFillFormatter>
{
}
@end

@implementation CubicLineSampleFillFormatter

- (CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
    return -10.f;
}
@end

@interface QuotePriceChartsDetailViewController ()<ChartViewDelegate>
@property (nonatomic, strong)LineChartView *chartView;

@end

@implementation QuotePriceChartsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"价格走势图";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *chartsView = [[UIView alloc]init];
    chartsView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:chartsView];
    [chartsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(KRealValue(200));
        make.height.mas_equalTo(KRealValue(280));
    }];
    
    _chartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KRealValue(280))];
    _chartView.delegate = self;
    [_chartView setViewPortOffsetsWithLeft:0.f top:20.f right:0.f bottom:0.f];
    _chartView.backgroundColor = [UIColor colorWithRed:104/255.f green:241/255.f blue:175/255.f alpha:1.f];
    _chartView.chartDescription.enabled = NO;
    _chartView.noDataText = @"暂无数据";
    _chartView.scaleYEnabled = NO;//取消Y轴缩放
    _chartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    _chartView.dragEnabled = YES;////启用拖拽图标
    _chartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    _chartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.maxHighlightDistance = 300.0;
    
    /*
     X轴
     **/
    ChartXAxis *xAxis = _chartView.xAxis;//获取X轴
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelPosition= XAxisLabelPositionBottomInside;//设置x轴数据在底部
    xAxis.gridColor = [UIColor clearColor];
    xAxis.labelTextColor = [UIColor blackColor];//文字颜色
    xAxis.axisLineColor = [UIColor grayColor];
    xAxis.drawGridLinesEnabled = YES;//是否开启网格
    xAxis.gridColor = [UIColor grayColor];//网格线颜色
    xAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    /*
     Y轴
     **/
    ChartYAxis *yAxis = _chartView.leftAxis;//获取左侧Y轴
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    [yAxis setLabelCount:6 force:NO];////Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    // yAxis.axisMinValue = 0;//设置Y轴的最小值
    //yAxis.axisMaxValue = 105;//设置Y轴的最大值
    yAxis.labelTextColor = UIColor.whiteColor;
    yAxis.labelPosition = YAxisLabelPositionInsideChart;//label位置
    yAxis.axisLineColor = UIColor.whiteColor;//Y轴颜色
    yAxis.drawGridLinesEnabled = YES;//是否开启网格
    yAxis.gridColor = [UIColor grayColor];//网格线颜色
    yAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    yAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];//设置y轴的数据格式
    _chartView.rightAxis.enabled = NO;//不需要显示右侧Y轴
    _chartView.legend.enabled = NO;
    
    
    [_chartView animateWithXAxisDuration:2.0 yAxisDuration:2.0];
    [chartsView addSubview:_chartView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self updateChartData];
}
- (void)updateChartData
{
    LineChartData *data = [self dataWithCount:100 range:100];
    _chartView.data = data;
    [_chartView.data notifyDataChanged];
    [_chartView notifyDataSetChanged];
}
- (LineChartData *)dataWithCount:(int)count range:(double)range
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(range)) + 3;
        [yVals addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"DataSet 1"];
    
    set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"DataSet 1"];
    set1.mode = LineChartModeCubicBezier;
    set1.cubicIntensity = 0.2;
    set1.drawCirclesEnabled = NO;
    set1.lineWidth = 1.8;
    set1.circleRadius = 4.0;
    [set1 setCircleColor:UIColor.whiteColor];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    [set1 setColor:UIColor.whiteColor];
    set1.fillColor = UIColor.whiteColor;
    set1.fillAlpha = 1.f;
    set1.drawHorizontalHighlightIndicatorEnabled = NO;
    set1.fillFormatter = [[CubicLineSampleFillFormatter alloc] init];
    return [[LineChartData alloc] initWithDataSet:set1];
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleFilled"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawFilledEnabled = !set.isDrawFilledEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCircles"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawCirclesEnabled = !set.isDrawCirclesEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeLinear : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleStepped"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeStepped ? LineChartModeLinear : LineChartModeStepped;
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHorizontalCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeHorizontalBezier : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}


@end
