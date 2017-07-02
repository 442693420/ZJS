//
//  HMPConstantObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HMPConstantObject : NSObject
#pragma mark - IM服务器地址
UIKIT_EXTERN NSString *const kIMConnectURL;//IM地址

#pragma mark - 用户
UIKIT_EXTERN NSString *const kUserInfoDefault;//用户信息
UIKIT_EXTERN NSString *const kPdInfo;//频道信息
UIKIT_EXTERN NSInteger const kSNAssistivesViewTag;//悬浮按钮tag
UIKIT_EXTERN NSInteger const kSNAssistivesViewWidthHeight;//悬浮按钮宽高
UIKIT_EXTERN NSInteger const kUserNameMaxLength;//昵称最长字数限制



typedef NS_ENUM(NSInteger , KIMConnectionStstus) {
    KIMConnectionStstusSuccess = 0,	//连接成功
    KIMConnectionStstusFail = 1,// 连接失败
    KIMConnectionStstusLoading = 2,	// 连接中
};

typedef NS_ENUM(NSInteger , KLoginType) {
    KLoginTypePhone = 0,	//账号密码登录
    KLoginTypeWeChat = 1,// 微信登录
    KLoginTypeQQ = 2,	//QQ登录
    KLoginTypeCode = 3, //手机号+验证码登录
};
typedef NS_ENUM(NSInteger , KVerifyType) {
    KVerifyTypeRegister = 10,	//注册验证码
    KVerifyTypeChangePwd = 11,//修改密码或重置验证码
    KVerifyTypeLogin = 13,	//登录验证码
};




#pragma mark - 其他
UIKIT_EXTERN NSString *const kFirstSetupApp;//判断引导页
UIKIT_EXTERN NSString *const kAppUpdateType;//判断是建议更新还是强制更新
UIKIT_EXTERN NSString *const kFirstGpsAlert;
UIKIT_EXTERN NSString *const kFirstGoTocarInfo;//第一次看车友卡片
UIKIT_EXTERN NSString *const kKeychainWithUUID;//uuid
UIKIT_EXTERN NSString *const kCAGSaveInfoDefault;//上下班模块用户选择信息的保存(家、公司地址，出行方式)



#pragma mark - 通知管理
UIKIT_EXTERN NSString *const kQuotePriceSmallSegmentScrollNotifiCation;//报价首页检测到收尾页
UIKIT_EXTERN NSString *const kFilterChangeSegmentNotifiCation;//筛选-选择目类


#pragma mark - 第三方key管理
UIKIT_EXTERN NSString *const kShareSDKAppKey;//shareSDK
UIKIT_EXTERN NSString *const kWeChatAppKey;//微信appKey
UIKIT_EXTERN NSString *const kWeChatAppSecret;//微信appSecret
UIKIT_EXTERN NSString *const kAppleId;//应用id
UIKIT_EXTERN NSString *const kAppName;//应用名称


#pragma mark - 其他信息管理
UIKIT_EXTERN NSString *const kMainGreenColor;//主色调中的  绿色
UIKIT_EXTERN NSString *const kMainWordColorGray;//字体颜色  灰色(报价cell中灰色字体颜色)
UIKIT_EXTERN NSString *const kMainColorRed;//红色  (报价cell中涨)
UIKIT_EXTERN NSString *const kMainColorGreen;//绿色  （报价cell中跌)
UIKIT_EXTERN NSString *const kMainColorOrange;//橙黄色  (报价cell中报价的橙黄色)



#pragma mark - 微信支付
UIKIT_EXTERN NSString *const kWXAPP_ID;//微信支付appid
UIKIT_EXTERN NSString *const kWXMCH_ID;//商户号，填写商户对应参数



#pragma mark - define
//tabar高度
#define HMPTabbarHeight 48
/* 屏幕尺寸等比计算 */
#define KRealValue(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
@end
