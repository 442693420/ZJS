//
//  AppDelegate.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "AppDelegate.h"
#import "HMPTabBarController.h"
@interface AppDelegate ()

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HMPTabBarController *homeVC = [[HMPTabBarController alloc] init];
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    //导航栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //更新登录时间
    UserObject *userObj = [UserManger getUserInfoDefault];
    if (userObj) {
        [self updateUserLoginTime:userObj.sid];
    }
    return YES;
}
- (void)updateUserLoginTime:(NSString *)sid{
    //账户密码登录
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c_s"] = C_S;
    params[@"sid"] = sid;
    [HMPAFNetWorkManager POST:API_APPSTART params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
