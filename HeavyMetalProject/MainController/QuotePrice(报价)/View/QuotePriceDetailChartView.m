//
//  QuotePriceDetailChartView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceDetailChartView.h"
#import "SymbolsValueFormatter.h"
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"
@import Charts;
@interface QuotePriceDetailChartView ()<ChartViewDelegate>
@property (nonatomic,strong) LineChartView * lineView;
@property (nonatomic,strong) UILabel * markY;
@end
@implementation QuotePriceDetailChartView
- (UILabel *)markY{//点击后显示当前选中的值
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 25)];
        _markY.font = [UIFont systemFontOfSize:15.0];
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"";
        _markY.textColor = [UIColor whiteColor];
        _markY.backgroundColor = [UIColor grayColor];
    }
    return _markY;
}

- (LineChartView *)lineView {
    if (!_lineView) {
        _lineView = [[LineChartView alloc] initWithFrame:self.frame];
        _lineView.delegate = self;//设置代理
        _lineView.backgroundColor =  [UIColor blackColor];
        _lineView.noDataText = @"暂无数据";
        _lineView.chartDescription.enabled = YES;
        _lineView.scaleYEnabled = NO;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView.dragEnabled = YES;//启用拖拽图标
        _lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]
                                    init];
//        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = _lineView;
        _lineView.marker = markerY;
        [markerY addSubview:self.markY];
        
        
        
        _lineView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        // leftAxis.axisMinValue = 0;//设置Y轴的最小值
        //leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor whiteColor];//Y轴颜色
        leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor whiteColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor whiteColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor whiteColor];
        xAxis.labelTextColor = [UIColor whiteColor];//文字颜色
        xAxis.axisLineColor = [UIColor whiteColor];
        _lineView.maxVisibleCount = 999;//
        //描述及图例样式
        [_lineView setDescriptionText:@""];
        _lineView.legend.enabled = NO;
        
        [_lineView animateWithXAxisDuration:1.0f];
    }
    return _lineView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineView];
        self.lineView.data = [self setData];
    }
    return self;
}
- (LineChartData *)setData{
    NSInteger xVals_count = 50;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= xVals_count; i++) {
        if (i<30) {
            [xVals addObject: [NSString stringWithFormat:@"02-%d",i]];
        }else{
            [xVals addObject: [NSString stringWithFormat:@"03-%d",i-29]];
        }
    }
    _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        int a = arc4random() % 100;
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
        [yVals addObject:entry];
    }
    
    LineChartDataSet *set1 = nil;
    if (_lineView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1.values = yVals;
        set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        return data;
    }else{
        LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:yVals label:@""]; //对于线的各种设置
        set.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        set.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        set.drawValuesEnabled = YES;//是否在拐点处显示数据
        set.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        set.valueColors = @[[UIColor colorWithHexString:kMainColorOrange]];//折线拐点处显示数据的颜色
        set.highlightColor = [UIColor whiteColor];// 十字线颜色
        set.drawCirclesEnabled = NO;//是否绘制拐点
        set.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        set.cubicIntensity = 0.2;// 曲线弧度
        set.circleRadius = 5.0f;//拐点半径
        set.drawCircleHoleEnabled = NO;//是否绘制中间的空心
        set.circleHoleRadius = 4.0f;//空心的半径
        set.circleHoleColor = [UIColor whiteColor];//空心的颜色
        set.circleColors = @[[UIColor whiteColor]];
        set.mode = LineChartModeCubicBezier;// 模式为曲线模式
        set.drawFilledEnabled = YES;//是否填充颜色
        // 设置渐变效果
        [set setColor:[UIColor darkGrayColor]];//折线颜色
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#F7630C"].CGColor, (id)[ChartColorTemplates colorFromString:@"#FF8C00"].CGColor]; CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set.fillAlpha = 0.8f;//透明度
        set.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        return data;
    }
    
}

- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    
    _markY.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];
    //将点击的数据滑动到中间
    [_lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    
    
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    
    
}@end
