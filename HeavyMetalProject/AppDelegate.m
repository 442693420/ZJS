//
//  AppDelegate.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "AppDelegate.h"
#import "HMPTabBarController.h"
#import "LoginViewController.h"

//ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"
@interface AppDelegate ()<WXApiDelegate>

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
    
    //ShareSDK配置
    [self sharrSDKConfig];
    [WXApi registerApp:kWeChatAppKey];//微信注册
    
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
- (void)sharrSDKConfig
{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerActivePlatforms:@[
                                        // 不要使用微信总平台进行初始化
                                        //@(SSDKPlatformTypeWechat),
                                        // 使用微信子平台进行初始化，即可
                                        @(SSDKPlatformSubTypeWechatSession),
                                        @(SSDKPlatformSubTypeWechatTimeline),
                                        ] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeWechat:
                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                    break;
                                                    
                                                default:
                                                    break;
                                            }
                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                            switch (platformType)
                                            {
                                                    
                                                case SSDKPlatformTypeWechat:
                                                    [appInfo SSDKSetupWeChatByAppId:kWeChatAppKey
                                                                          appSecret:kWeChatAppSecret];
                                                    break;
                                                    
                                                    
                                                default:
                                                    break;
                                            }
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
#pragma mark wxapi-delegate
//第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面
//微信
-(void)onResp:(BaseResp *)resp{
//    switch (resp.errCode) {
//        case 0://用户同意
//        {
//            SendAuthResp *aresp = (SendAuthResp *)resp;
//        }
//            break;
//        case -4://用户拒绝授权
//            //do ...
//            break;
//        case -2://用户取消
//            //do ...
//            break;
//        default:
//            break;
//    }
//    NSDictionary *dicha;
//    if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *status = [NSString stringWithFormat:@"%d",resp.errCode];
//        dicha = @{@"status":status};
//        [[NSNotificationCenter defaultCenter] postNotificationName:kWechatPayResultNotification //广播名称
//                                                            object:dicha
//                                                          userInfo:nil];
//    }
}

@end
