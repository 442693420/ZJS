//
//  HMPTabBarButton.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPTabBarButton : UIButton
@property (nonatomic , strong)UILabel *redUnreadLab;//红色未读消息

@property (nonatomic , assign)NSInteger ecount; //只用于首页下方事件数
- (void)refreshRedUnreadLab;
@end
