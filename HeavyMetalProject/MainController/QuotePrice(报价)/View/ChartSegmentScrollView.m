//
//  ChartSegmentScrollView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/11.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChartSegmentScrollView.h"
#import "ChartYLabView.h"

#define MainScreen_W [UIScreen mainScreen].bounds.size.width

@interface ChartSegmentScrollView()<UIScrollViewDelegate>
@property (assign,nonatomic)NSInteger allIndex;
@end
@implementation ChartSegmentScrollView
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray contentViewArray:(NSArray *)contentViewArray yLabArr:(NSArray *)yLabArr clickBlick:(btnClickBlock)block{
    if (self = [super initWithFrame:frame]) {
        _allIndex = titleArray.count;
        [self addSubview:self.bgScrollView];
        
        _segmentToolView =
        [[HMPSegmentView alloc] initWithFrame:CGRectMake(KRealValue(40), 0, MainScreen_W-KRealValue(80), KRealValue(44)) titles:titleArray maxTitleNumInWindow:4 canScroll:NO clickBlick:^void(NSInteger index) {
            NSLog(@"-----%ld",index);
            if (self.block) {
                self.block(index);
            }
            [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(index-1), 0)];
        }];
        _segmentToolView.bgScrollViewColor = [UIColor blackColor];
        [self addSubview:_segmentToolView];
        
        for (int i=0;i<contentViewArray.count; i++ ) {
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame=CGRectMake(MainScreen_W * i, _segmentToolView.bounds.size.height, MainScreen_W, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height-KRealValue(40));
            [_bgScrollView addSubview:contentView];
        }
        
        ChartYLabView *yLabView = [[ChartYLabView alloc]initWithYLabArr:yLabArr];
        [self addSubview:yLabView];
        [yLabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(20));
            make.right.equalTo(self.mas_right).offset(-KRealValue(20));
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(KRealValue(40));
        }];
        self.block=block;
        
    }
    
    return self;
}

-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, MainScreen_W, self.bounds.size.height-_segmentToolView.bounds.size.height)];
        _bgScrollView.contentSize=CGSizeMake(MainScreen_W*_allIndex, self.bounds.size.height-_segmentToolView.bounds.size.height);
        _bgScrollView.backgroundColor=[UIColor blackColor];
        _bgScrollView.showsVerticalScrollIndicator=NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.delegate=self;
        _bgScrollView.bounces=NO;
        _bgScrollView.pagingEnabled=YES;
    }
    return _bgScrollView;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_bgScrollView)
    {
        NSInteger p=_bgScrollView.contentOffset.x/MainScreen_W;
        [_segmentToolView bgScrollWithIndex:p];
        _segmentToolView.defaultIndex=p+1;
    }
}

@end
