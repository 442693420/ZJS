//
//  HMPConstantObject.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPConstantObject.h"

@implementation HMPConstantObject
#pragma mark - IM服务器地址
NSString *const kIMConnectURL = @"ws://imluba.auto.soooner.com";//IM地址



#pragma mark - 用户
NSString *const kUserInfoDefault = @"userDefault";//用户信息
NSString *const kPdInfo = @"pdInfo";//频道信息
NSInteger const kSNAssistivesViewTag = 777;//悬浮按钮tag
NSInteger const kSNAssistivesViewWidthHeight = 40;//悬浮按钮宽高
NSInteger const kUserNameMaxLength = 15;//昵称最长字数限制



#pragma mark - 其他 kFirstGoTocarInfo
NSString *const kFirstSetupApp = @"firstSetupApp";//判断引导页
NSString *const kAppUpdateType = @"appUpdateType";//判断是建议更新还是强制更新
NSString *const kFirstGpsAlert = @"kFirstGpsAlert"; //判断弹没弹过提示
NSString *const kFirstGoTocarInfo = @"kFirstGoTocarInfo";
NSString *const kKeychainWithUUID = @"keychainWithUUID";//uuid
NSString *const kCAGSaveInfoDefault = @"CAGSaveInfoDefault";//上下班模块用户选择信息的保存(家、公司地址，出行方式)



#pragma mark - 通知管理
NSString *const kQuotePriceSmallSegmentScrollNotifiCation = @"QuotePriceSmallSegmentScrollNotifiCation";//报价首页检测到收尾页
NSString *const kFilterChangeSegmentNotifiCation = @"FilterChangeSegmentNotifiCation";//筛选-选择目类



#pragma mark - 第三方key管理
NSString *const kShareSDKAppKey = @"1ff2324cd6f16";//shareSDK
NSString *const kWeChatAppKey = @"wx5fcbd2e6fdd6c14e";//微信appKey
NSString *const kWeChatAppSecret = @"e70407b02b6e55f67adb139cd1618c8d";//微信appSecret
NSString *const kAppleId = @"";//苹果appid
NSString *const kAppName = @"路网";//



#pragma mark - 其他信息管理
NSString *const kMainGreenColor = @"#00A99D";//主色调中的  绿色
NSString *const kMainWordColorGray = @"#95989A";//字体颜色  灰色(报价cell中灰色字体颜色)
NSString *const kMainColorRed = @"#FF463C";//红色  (报价cell中涨)
NSString *const kMainColorGreen = @"#4CDA64";//绿色  (报价cell中跌)
NSString *const kMainColorOrange = @"#FF8C00";//橙黄色  (报价cell中报价的橙黄色)
NSString *const kChatFillColor = @"#D06121";//橙黄色  (chat填充色)
NSString *const kMainColorDark = @"#1C1C1C";//深灰色  (个人中心深灰色背景)


#pragma mark - 微信支付
NSString *const kWXAPP_ID = @"";//苹果appid
NSString *const kWXMCH_ID = @"";//商户号，填写商户对应参数

@end
