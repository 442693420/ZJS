//
//  HMPTabBar.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPTabBar.h"
#import "HMPTabBarButton.h"
@interface HMPTabBar ()
@property (nonatomic, weak) UIButton *selButton;
/** 需要选中第几个 */
@property (nonatomic, assign) NSUInteger currentSelectedIndex;

//@property (nonatomic, strong) UIView *selectView;//滑块
@end
@implementation HMPTabBar
static NSInteger const CCTabBarTag = 10000;

- (void)setItems:(NSMutableArray *)items{
    _items = items;
    for (int i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        //        if (i==2) {//中间大按钮
        //            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //            btn.tag = self.subviews.count + CCTabBarTag;
        //            [btn setImage:item.image forState:UIControlStateNormal];
        //            [btn setImage:item.selectedImage forState:UIControlStateSelected];
        //            btn.adjustsImageWhenHighlighted = NO;
        //            // 设置文字
        //            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //            [self addSubview:btn];
        //
        //        }else{
        //        其他按键
        HMPTabBarButton *btn = [HMPTabBarButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = self.subviews.count + CCTabBarTag;
        
        // 设置图片
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = NO;
        // 设置文字
        [btn setTitle:item.title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"0x716d68"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x424242"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //我的需要未读小红点,其他按钮直接隐藏
        if (i!=2) {
            btn.redUnreadLab.hidden = YES;
        }else{
            [btn refreshRedUnreadLab];
        }
        [self addSubview:btn];
        // 子控件的个数
        NSInteger subViewsCount = 1;
        if (self.seletedIndex) {
            subViewsCount = self.seletedIndex + 1;
        }
        if (self.subviews.count == subViewsCount) {
            self.currentSelectedIndex = self.subviews.count - 1;
            // 默认选中第一个
            [self btnClick:btn];
        }
    }
    //    }
//    _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, [UIScreen mainScreen].bounds.size.width /  items.count, 2)];
//    _selectView.backgroundColor = [UIColor colorWithHexString:kMainGreenColor];
//    [self addSubview:_selectView];
}
- (void)setDelegate:(id<HMPTabBarDelegate>)delegate{
    _delegate = delegate;
    [self btnClick:(HMPTabBarButton *)[self viewWithTag:self.currentSelectedIndex +CCTabBarTag]];
}

- (void)btnClick:(UIButton *)button{
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        _selectView.left = [UIScreen mainScreen].bounds.size.width / self.items.count *(button.tag-CCTabBarTag);
//    }];
    _selButton.selected = NO;
    _selButton.backgroundColor = [UIColor colorWithHexString:@"#34373C"];
    button.selected = YES;
    button.backgroundColor = [UIColor colorWithHexString:@"#4C5155"];
    _selButton = button;
    
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [_delegate tabBar:self didClickBtn:button.tag - CCTabBarTag];
    }
    
}



/**
 *  外界设置索引页跟着跳转
 */
- (void)setSeletedIndex:(NSInteger)seletedIndex {
    _seletedIndex = seletedIndex;
    UIButton *button = [self viewWithTag:(CCTabBarTag + seletedIndex)];
    [self btnClick:button];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.items.count;
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    
    CGFloat h = self.frame.size.height;
    // 在这里修改位置
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        
        //        if (i == 2) {
        //            y = -12;
        //            h = self.frame.size.height + 12;
        //        } else {
        y = 0;
        h = self.frame.size.height;
        //        }
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
