//
//  BaseNavigationController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    [self.view setTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 默认带返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //
    //[super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fuanhuil"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        
    }
    
    if ([self.topViewController isMemberOfClass:[viewController class]]) {
        return;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)backAction {
    [self popViewControllerAnimated:YES];
}


@end
