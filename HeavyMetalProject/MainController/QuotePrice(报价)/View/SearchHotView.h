//
//  SearchHotView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//搜索页面热门搜索和咨询

#import <UIKit/UIKit.h>

@interface SearchHotView : UIView
@property (nonatomic , strong)NSMutableArray *searchBtnArr;
@property (nonatomic , strong)NSMutableArray *newsBtnArr;

- (void)creatUIHotView:(NSArray *)searchHot newsHot:(NSArray *)newsHot;
@end
