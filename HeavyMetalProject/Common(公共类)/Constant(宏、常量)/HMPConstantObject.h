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
    KLoginTypePhone = 0,	//手机号登录
    KLoginTypeWeChat = 1,// 微信登录
    KLoginTypeQQ = 2,	//QQ登录
    KLoginTypeCode = 3, //手机号+验证码登录
};



#pragma mark - 互动
typedef NS_ENUM(NSInteger , KLiveRadioType) {
    KLiveRadioTypeWithNoVideo = 1,	//无视频直播
    KLiveRadioTypeWithDevice = 2,// 自驾宝直播
    KLiveRadioTypeWithPhone = 3,	//手机直播
};
typedef NS_ENUM(NSInteger , KLiveRadioStatusType) {
    KLiveRadioStatusTypeIn = 1,	//进入聊天室
    KLiveRadioStatusTypeOut = 2,//离开聊天室
};
typedef NS_ENUM(NSInteger , KLiveRadioLocationType) {
    KLiveRadioLocationTypeTrue = 0,	//直播真实地址
    KLiveRadioLocationTypeFalse = 1,// 直播自定义地址
};
typedef NS_ENUM(NSInteger , KLiveRadioBeautyType) {
    KLiveRadioBeautyTypeTrue = 0,	//使用美颜
    KLiveRadioBeautyTypeFalse = 1,// 关闭美颜
};
typedef NS_ENUM(NSInteger , KUpdateFileType) {
    KUpdateFileTypeImage = 1,	//上传图片
    KUpdateFileTypeAudio = 2,//上传音频
};
typedef NS_ENUM(NSInteger, KLiveRadioRecordPhase) {
    KLiveRadioRecordPhaseStart,
    KLiveRadioRecordPhaseRecording,
    KLiveRadioRecordPhaseCancelling,
    KLiveRadioRecordPhaseEnd
};
typedef NS_ENUM(NSInteger , KMessageDeliveryStatus) {
    KMessageDeliveryStatusSuccell = 1,//消息发送成功
    KMessageDeliveryStatusFail = 2,//消息发送失败
    KMessageDeliveryStatusDelivering = 3,//消息发送中
};
typedef NS_ENUM(NSInteger , KMessageCellDirection) {
    KMessageCellDirectionRight = 1,//消息显示在右侧
    KMessageCellDirectionLeft = 2,//消息显示在左侧
};
typedef NS_ENUM(NSInteger , KMessagePlayingStatus) {
    KMessagePlayingStatusStart = 1,//消息开始播放
    KMessagePlayingStatusEnd = 2,//消息停止播报
};
typedef NS_ENUM(NSInteger , KMessageType) {
    KMessageTypePhoto = 0,//图片
    KMessageTypeAudio = 1,//语音
    KMessageTypePresent = 2,//礼物
    KMessageTypeText = 3,//文字
    KMessageTypeInsuranceGetCash = 10,//保险收款
    KMessageTypeTime = 99,//时间
};
typedef NS_ENUM(NSInteger , KChatroomManagerType) {
    KChatroomManagerTypeYes = 0,//设为管理员
    KChatroomManagerTypeNo = 1,//取消管理员
};
typedef NS_ENUM(NSInteger , KChatroomSilenceType) {
    KChatroomSilenceTypeYes = 0,//禁言
    KChatroomSilenceTypeNo = 1,//取消禁言
};
typedef NS_ENUM(NSInteger , KCityChatroomVolumeType) {
    KCityChatroomVolumeZero = 0,//静音
    KCityChatroomVolumeOne = 1,//取消静音
};
typedef NS_ENUM(NSInteger , KCityChatroomType) {
    KCityChatroomTypePublic = 1,//公共频道
    KCityChatroomTypeCity = 2,//城市频道
    KCityChatroomTypePersonal = 3,//个人频道
    KCityChatroomTypeBusiness = 4,//商业频道
    KCityChatroomTypeHighWay = 5,//高速频道
};
typedef NS_ENUM(NSInteger , KLoginSuccessToVcType) {
    KLoginSuccessToVcTypeChannel = 1,//登陆成功跳转对讲机
    KLoginSuccessToVcTypeChatroom = 2,//登陆成功跳转直播
    KLoginSuccessToVcTypeH5Web = 3,//登陆成功跳转H5页面
};
typedef NS_ENUM(NSInteger , KVipCenterWebType) {
    KVipCenterWebTypeShop = 1,//积分商城
    KVipCenterWebTypeHjq = 2,//惠加气
    KVipCenterWebTypeCarInsurance = 3,//车险订单
    KVipCenterWebTypeRentCar = 4,//路叔包车
    KVipCenterWebTypeFreeway = 5,//智慧高速
    KVipCenterWebTypeHjqOrderDetail = 6,//惠加气订单详情
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
