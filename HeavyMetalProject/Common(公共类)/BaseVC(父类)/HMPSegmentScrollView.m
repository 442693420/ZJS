//
//  HMPSegmentScrollView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPSegmentScrollView.h"
#define MainScreen_W [UIScreen mainScreen].bounds.size.width

@interface HMPSegmentScrollView()<UIScrollViewDelegate>
@property (assign,nonatomic)NSInteger allIndex;
@end
@implementation HMPSegmentScrollView

-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray
                  clickBlick:(btnClickBlock)block{
    if (self = [super initWithFrame:frame]) {
        
        _allIndex = titleArray.count;
        [self addSubview:self.bgScrollView];
        
        _segmentToolView = [[HMPSegmentView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_W, KRealValue(44)) titles:titleArray clickBlick:^void(NSInteger index) {
        NSLog(@"-----%ld",index);
            if (self.block) {
                self.block(index);
            }
            [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(index-1), 0)];
        }];
        _segmentToolView.bgScrollViewColor = [UIColor colorWithHexString:@"#4C4A48"];
        [self addSubview:_segmentToolView];
        
        
        for (int i=0;i<contentViewArray.count; i++ ) {
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame=CGRectMake(MainScreen_W * i, _segmentToolView.bounds.size.height, MainScreen_W, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
        }
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
