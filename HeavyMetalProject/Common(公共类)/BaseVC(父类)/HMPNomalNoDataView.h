//
//  HMPNomalNoDataView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPNomalNoDataView : UIView
@property (nonatomic , strong)UILabel *lab;
@property (nonatomic , strong)UIButton *btn;
@property (nonatomic , strong)UIImageView *imgView;
@property (strong, nonatomic) void (^refreshData)(void);

@end
