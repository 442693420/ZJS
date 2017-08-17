//
//  VerticalChooseView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/14.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalChooseView : UIView
@property (nonatomic , strong)NSMutableArray *btnArr;//存放按钮对象

-(id)initWithTitle:(NSString *)title chooseBtnArr:(NSArray *)btnArr;

@end
