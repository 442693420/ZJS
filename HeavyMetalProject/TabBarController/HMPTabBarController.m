//
//  HMPTabBarController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPTabBarController.h"
#import "QuotePriceViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "AttentionViewController.h"
#import "BaseNavigationController.h"

#import "HMPTabBar.h"
@interface HMPTabBarController ()<UINavigationControllerDelegate,HMPTabBarDelegate>{
    NSString *updateStr;//版本更新提示语
}
/** 保存所有控制器对应按钮的内容（UITabBarItem）*/
@property (nonatomic, strong) NSMutableArray *items;
@end
@implementation HMPTabBarController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //去掉系统tabbar
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview];
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[HMPTabBar class]]) {
            [childView removeFromSuperview];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self addChildViewController];
    [self setUpTabBar];
    
    // Do any additional setup after loading the view.
}
- (void)addChildViewController{
    QuotePriceViewController *quotePriceVC = [[QuotePriceViewController alloc]init];
    AttentionViewController *attentionVC = [[AttentionViewController alloc] init];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self addOneChildVC:quotePriceVC title:@"报价" imageName:@"tab_quotePrice_yes" selectedImageName:@"tab_quotePrice_no"];
    [self addOneChildVC:attentionVC title:@"关注" imageName:@"tab_attention_yes" selectedImageName:@"tab_attention_no"];
    [self addOneChildVC:newsVC title:@"资讯" imageName:@"tab_news_yes" selectedImageName:@"tab_news_no"];
    [self addOneChildVC:mineVC title:@"我的" imageName:@"tab_mine_yes" selectedImageName:@"tab_mine_no"];
}

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    [self.items addObject:childVc.tabBarItem];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    nav.delegate=self;
    nav.navigationBarHidden=YES;
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self addChildViewController:nav];
}
- (void)setUpTabBar{
    HMPTabBar *LBar = [[HMPTabBar alloc]init];
    LBar.items = self.items;
    LBar.delegate = self;
    LBar.backgroundColor=[UIColor whiteColor];
    LBar.frame=CGRectMake(0, self.view.frame.size.height-HMPTabbarHeight,KRealValue(375), HMPTabbarHeight);
    [self.view addSubview:LBar];
    self.mytabbar=LBar;
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, self.view.frame.size.width, 1)];
    grayView.backgroundColor = [UIColor grayColor];
    grayView.alpha=0.3;
    [LBar addSubview:grayView];
}
#pragma mark --cctabbar delegate方法--
- (void)tabBar:(HMPTabBar *)tabBar didClickBtn:(NSInteger)index{
        [super setSelectedIndex:index];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    self.mytabbar.seletedIndex = selectedIndex;
}
#pragma mark navVC代理  次级页不显示tabbar
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    self.tabBar.hidden = YES;
    if (viewController != root) {
        //从HomeViewController移除
        [self.mytabbar removeFromSuperview];
        // 调整tabbar的Y值
        CGRect dockFrame = self.mytabbar.frame;
        
        dockFrame.origin.y = root.view.frame.size.height - HMPTabbarHeight;
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是能滚动
            UIScrollView *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y += scrollview.contentOffset.y;
        }
        self.mytabbar.frame = dockFrame;
        // 添加dock到根控制器界面
        [root.view addSubview:self.mytabbar];
    }
}

// 完全展示完调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    BaseNavigationController *nav = (BaseNavigationController *)navigationController;
    if (viewController == root) {
        
        navigationController.interactivePopGestureRecognizer.delegate = nav.popDelegate;
        // 让Dock从root上移除
        [_mytabbar removeFromSuperview];
        
        //_mytabbar添加dock到HomeViewController
        _mytabbar.frame = CGRectMake(0, self.view.frame.size.height-HMPTabbarHeight, KRealValue(375), HMPTabbarHeight);
        [self.view addSubview:_mytabbar];
    }
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
