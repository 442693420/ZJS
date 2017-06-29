//
//  HMPSegmentScrollView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMPSegmentView.h"

typedef void(^btnClickBlock)(NSInteger index);
@interface HMPSegmentScrollView : UIView
-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray
                  clickBlick:(btnClickBlock)block;
@property (strong,nonatomic)UIScrollView *bgScrollView;
@property (strong,nonatomic)HMPSegmentView *segmentToolView;
/**
 *  点击后的block
 */
@property (nonatomic,copy)btnClickBlock block;
@end
