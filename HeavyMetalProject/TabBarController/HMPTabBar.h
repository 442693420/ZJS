//
//  HMPTabBar.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMPTabBar;
@protocol HMPTabBarDelegate <NSObject>

- (void)tabBar:(HMPTabBar *)tabBar didClickBtn:(NSInteger)index;

@end
@interface HMPTabBar : UIView
//选中index
@property (nonatomic, assign) NSInteger seletedIndex;

//  (UITabBarItem)
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) id<HMPTabBarDelegate> delegate;
@end
