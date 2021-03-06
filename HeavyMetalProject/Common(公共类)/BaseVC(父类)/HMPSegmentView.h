//
//  HMPSegmentView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnClickBlock)(NSInteger index);


@interface HMPSegmentView : UIView
/**
 *  未选中时的文字颜色,默认黑色
 */
@property (nonatomic,strong) UIColor *titleNomalColor;

/**
 *  选中时的文字颜色,默认红色
 */
@property (nonatomic,strong) UIColor *titleSelectColor;

/**
 *  背景色,默认白色
 */
@property (nonatomic,strong) UIColor *bgScrollViewColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont  *titleFont;

/**
 *  默认选中的index=1，即第一个
 */
@property (nonatomic,assign) NSInteger defaultIndex;


/**
 *  点击后的block
 */
@property (nonatomic,copy)btnClickBlock block;



/**
 *  初始化方法
 *
 *  @param frame      frame
 *  @param titleArray 传入数组
 *  @param maxTitleNumInWindow      屏幕中最多展示多少个
 *  @param canScroll      是不是可滑动，不可滑动就在width固定的情况下均分
 *  @param block      点击后的回调
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray  maxTitleNumInWindow:(NSInteger)maxTitleNumInWindow canScroll:(BOOL)canScroll clickBlick:(btnClickBlock)block;


//外部调用
- (void)bgScrollWithIndex:(NSInteger)index;

@end
