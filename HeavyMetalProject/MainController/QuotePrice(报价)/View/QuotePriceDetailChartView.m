//
//  QuotePriceDetailChartView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/29.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceDetailChartView.h"
#import "ChartSeletView.h"
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"

#import "ChartInfoDataObject.h"
#import "ChartValueObject.h"
@import Charts;
@interface QuotePriceDetailChartView ()<ChartViewDelegate>
@property (nonatomic,strong) LineChartView * lineView;
@property (nonatomic,strong) ChartSeletView * markY;

@property (nonatomic,strong) ChartInfoDataObject *obj;//整个图表的信息对象
@property (nonatomic,assign) NSInteger xLabCount;//x轴显示的最大
@end
static NSString *kLst1LineColor = @"#00BCD4";
static NSString *kLst2LineColor = @"#8BC34A";
static NSString *kLst3LineColor = @"#FF5722";
static NSString *kLst4LineColor = @"#FFEB3B";
static const float markYViewWidth = 80;
static const float markYViewHeight = 70;

@implementation QuotePriceDetailChartView
- (ChartSeletView *)markY{//点击后显示当前选中的值
    if (!_markY) {
        _markY = [[ChartSeletView alloc]initWithFrame:CGRectMake(0, 0, KRealValue(markYViewWidth), KRealValue(markYViewHeight))];
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
        _lineView.extraTopOffset = 40;//距离top的偏移量，为了让marker可以展示全
        _lineView.extraRightOffset = 20;//距离right的偏移量，为了让marker可以展示全
        _lineView.extraLeftOffset = 20;//距离left的偏移量，为了让marker可以展示全
        
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]
                                    init];
        markerY.offset = CGPointMake(-KRealValue(markYViewWidth/2), -KRealValue(40+15));//
        markerY.chartView = _lineView;
        _lineView.marker = markerY;
        [markerY addSubview:self.markY];
        
        
        _lineView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        // leftAxis.axisMinValue = 0;//设置Y轴的最小值
        //leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor whiteColor];//Y轴颜色
        leftAxis.axisLineWidth = 2;//Y轴线的宽度
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor whiteColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor groupTableViewBackgroundColor];//网格线颜色
        leftAxis.gridLineWidth = 0.3;//网格线宽度
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.forceLabelsEnabled = YES;//强制绘制指定数量的label
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor groupTableViewBackgroundColor];
        xAxis.gridLineWidth = 0.3;//网格线宽度
        xAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        xAxis.labelTextColor = [UIColor whiteColor];//文字颜色
        xAxis.axisLineColor = [UIColor whiteColor];
        xAxis.axisLineWidth = 2;//X轴线的宽度
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
    }
    return self;
}
//外部调用，刷新数据
- (void)refreshView:(ChartInfoDataObject *)data{
    NSLog(@"%@",data);
    self.obj = data;
    self.lineView.data = [self setData];
}
- (LineChartData *)setData{
    if (self.obj.lst1 && self.obj.lst1.count != 0) {//如果有数据
        //数据反转，保证日期早的在前边
        NSArray *newLst1 = [[self.obj.lst1 reverseObjectEnumerator] allObjects];
        NSArray *newLst2 = [[self.obj.lst2 reverseObjectEnumerator] allObjects];
        NSArray *newLst3 = [[self.obj.lst3 reverseObjectEnumerator] allObjects];
        NSArray *newLst4 = [[self.obj.lst4 reverseObjectEnumerator] allObjects];
        
        //因为lst1、2、3、4、5都一样，所以任意取一个即可,用来确定X轴和Y轴的数据
        //X轴上面需要显示的数据
        //1.确定X轴显示点的数量
        ChartValueObject *lastObj = [newLst1 lastObject];
        ChartValueObject *firstObj = [newLst1 firstObject];
        NSInteger xNum = [lastObj.rq integerValue]-[firstObj.rq integerValue]+1;
        
        NSMutableArray *xVals = [[NSMutableArray alloc] init];
        NSMutableArray *xValsSet = [[NSMutableArray alloc] init];//获取对应Y轴数据，取值用
        for (int i = 0; i < xNum; i++) {
            NSInteger result = [firstObj.rq integerValue]+i;
            [xVals addObject:[[NSString stringWithFormat:@"%ld",(long)result] substringWithRange:NSMakeRange(4, 4)]];
            [xValsSet addObject:[NSString stringWithFormat:@"%ld",[firstObj.rq integerValue]+i]];
        }
        _lineView.xAxis.labelCount = [self xLabCount:(NSInteger)xNum];//重新设置X轴显示的lable数量
        _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
        
        //Y轴上数据
        NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
        for (int i = 0; i < newLst1.count; i++) {
            ChartValueObject *valueObj = newLst1[i];
            NSInteger j=[xValsSet indexOfObject:[NSString stringWithFormat:@"%ld",[valueObj.rq integerValue]]];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:j y:[valueObj.price doubleValue]];
            [yVals1 addObject:entry];
        }
        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        for (int i = 0; i < newLst2.count; i++) {
            ChartValueObject *valueObj = newLst2[i];
            NSInteger j=[xValsSet indexOfObject:[NSString stringWithFormat:@"%ld",[valueObj.rq integerValue]]];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:j y:[valueObj.price doubleValue]];
            [yVals2 addObject:entry];
        }
        NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
        for (int i = 0; i < newLst3.count; i++) {
            ChartValueObject *valueObj = newLst3[i];
            NSInteger j=[xValsSet indexOfObject:[NSString stringWithFormat:@"%ld",[valueObj.rq integerValue]]];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:j y:[valueObj.price doubleValue]];
            [yVals3 addObject:entry];
        }
        NSMutableArray *yVals4 = [[NSMutableArray alloc] init];
        for (int i = 0; i < newLst4.count; i++) {
            ChartValueObject *valueObj = newLst4[i];
            NSInteger j=[xValsSet indexOfObject:[NSString stringWithFormat:@"%ld",[valueObj.rq integerValue]]];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:j y:[valueObj.price doubleValue]];
            [yVals4 addObject:entry];
        }
        LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@""]; //对于线的各种设置
        set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals1];
        set1.lineWidth = 1.0;//折线宽度
        set1.drawValuesEnabled = NO;//是否在拐点处显示数据
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        set1.valueColors = @[[UIColor colorWithHexString:kMainColorOrange]];//折线拐点处显示数据的颜色
        set1.highlightColor = [UIColor colorWithHexString:kLst1LineColor];// 十字线颜色
        set1.highlightLineWidth = 2;//
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        set1.cubicIntensity = 0.2;// 曲线弧度
        set1.circleRadius = 5.0f;//拐点半径
        set1.drawCircleHoleEnabled = NO;//是否绘制中间的空心
        set1.circleHoleRadius = 4.0f;//空心的半径
        set1.circleHoleColor = [UIColor whiteColor];//空心的颜色
        set1.circleColors = @[[UIColor whiteColor]];
        set1.mode = LineChartModeCubicBezier;// 模式为曲线模式
        set1.drawFilledEnabled = NO;//是否填充颜色
        // 设置渐变效果
        [set1 setColor:[UIColor colorWithHexString:kLst1LineColor]];//折线颜色
        
        // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //添加第二个LineChartDataSet对象
        LineChartDataSet *set2 = [set1 copy];
        set2.values = yVals2;
        set2.drawValuesEnabled = NO;
        [set2 setColor:[UIColor colorWithHexString:kLst2LineColor]];
        set2.highlightColor = [UIColor colorWithHexString:kLst2LineColor];// 十字线颜色
        [dataSets addObject:set2];
        
        //添加第三个LineChartDataSet对象
        LineChartDataSet *set3 = [set1 copy];
        set3.values = yVals3;
        set3.drawValuesEnabled = NO;
        [set3 setColor:[UIColor colorWithHexString:kLst3LineColor]];
        set3.highlightColor = [UIColor colorWithHexString:kLst3LineColor];// 十字线颜色
        [dataSets addObject:set3];
        
        //添加第四个LineChartDataSet对象
        LineChartDataSet *set4 = [set1 copy];
        set4.values = yVals4;
        set4.drawValuesEnabled = NO;
        [set4 setColor:[UIColor colorWithHexString:kLst4LineColor]];
        set4.highlightColor = [UIColor colorWithHexString:kLst4LineColor];// 十字线颜色
        [dataSets addObject:set4];
        
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        return data;
    }else{
        LineChartData *data = [[LineChartData alloc]initWithDataSets:nil];
        return data;
    }
}
//点击选中时的代理
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    _markY.lab.text = [NSString stringWithFormat:@"%.2f",(float)entry.y];
    
    //将点击的数据滑动到中间
    [_lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
}
//没有选中时的代理
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
}
//捏合放大或缩小
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
}
//拖拽图表时的代理方法
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
}

#pragma mark private
- (NSInteger)xLabCount:(NSInteger)xNum{
    switch ([self.zq intValue]) {
        case 1:
            if (xNum > 5)
                xNum = 5;
            break;
        case 2:
            if (xNum > 5)
                xNum = 5;
            break;
        case 3:
            if (xNum > 7)
                xNum = 7;
            break;
        case 4:
            if (xNum > 9)
                xNum = 9;
            break;
        case 5:
            if (xNum > 9)
                xNum = 9;
            break;
    }
    return xNum;
}
@end
