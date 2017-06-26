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
NSString *const kAppUpdateNotifiCation = @"appUpdateNotifiCation";//版本更新通知
NSString *const kCarFInNotifiCation = @"carFNotifiCation";//车友通知
NSString *const kCarStatusNotifiCation = @"carStatusNotifiCation";//车友--附近直播--附近互动
NSString *const kGetMessageRefreshMineViewNotifiCation = @"getMessageRefreshMineViewNotifiCation";//收到消息，刷新个人中心的未读消息数量显示
NSString *const kUseUserLocationNotifiCation = @"useUserLocationNotifiCation";//上下班-使用当前位置
NSString *const kUseMapChooseLocationNotifiCation = @"useMapChooseLocationNotifiCation";//上下班-使用地图位置
NSString *const kUseKeySearchLocationNotifiCation = @"useMapChooseLocationNotifiCation";//上下班-使用关键字搜索位置
NSString *const kSNHomeVCIntercomMsgNotifiCation = @"SNHomeVCIntercomMsgNotifiCation";//首页点击频道消息跳转
NSString *const kSNHomeReceiveAppDelegateRegisteSuccellNotifiCation = @"SNHomeReceiveAppDelegateRegisteSuccellNotifiCation";//homeVC收到appdelegate中注册成功的消息




NSString *const kCarFAttenNotifiCation = @"carFAttenNotifiCation";//关注通知
NSString *const kCarButtonClickNotifiCation = @"carButtonClickNotifiCation";//关注通知 区分关注按钮和下滑关注

NSString *const kChatroomUserInfoShowNotifiCation = @"chatroomUserInfoShowNotifiCation";//聊天室用户信息展示
NSString *const kChatroomUserInfoHidenNotifiCation = @"chatroomUserInfoHidenNotifiCation";//聊天室用户信息隐藏

NSString *const kChatroomPointGuideShowNotifiCation = @"chatroomPointGuideShowNotifiCation";//聊天室积分赚取指引信息展示
NSString *const kChatroomPointGuideHidenNotifiCation = @"chatroomPointGuideHidenNotifiCation";//聊天室积分赚取指引信息隐藏

NSString *const kChatroomLeaveMessageNotifiCation = @"chatroomLeaveMessageNotifiCation";//聊天室留言
NSString *const kChatroomPresentSendNotifiCation = @"chatroomPresentSendNotifiCation";//积分兑换礼物

NSString *const kChatroomAnchorChangeLiveBackImageNotifiCation = @"chatroomAnchorChangeLiveBackImageNotifiCation";//主播直播过程中更换背景图片

NSString *const kUserOvertimeNotifiCation = @"userOvertimeNotifiCation";//观看或者进行直播的时候被顶掉(sid超时),发通知关闭当前页面

NSString *const kChangeCityChatroomNotifiCation = @"changeCityChatroomNotifiCation";//城市对讲机模式下切换城市频道

NSString *const kChangeFriendsNaviCurrentVC = @"changeFriendsNaviCurrentVCNotifiCation";//互动导航VC下切换不同字VC

NSString *const kLoginSuccessNotifiCation = @"loginSuccessNotifiCation";//登陆成功
NSString *const kBindingPhoneSuccessNotifiCation = @"bindingPhoneSuccessNotifiCation";//绑定手机号

NSString *const kWechatPayResultNotification = @"wechatPayResultNotification";//微信支付回调



//im部分
NSString *const kSooonerSocketManagerConnectedCallbackNotifiCation = @"sooonerSocketManagerConnectedCallbackNotifiCation";//连接成功通知
NSString *const kSooonerSocketManagerReconnectCallbackNotifiCation = @"sooonerSocketManagerReconnectCallbackNotifiCation";//自动重连中通知
NSString *const kSooonerSocketManagerConnectErrorCallbackNotifiCation = @"sooonerSocketManagerConnectErrorCallbackNotifiCation";//连接错误通知
NSString *const kSooonerSocketManagerJoinCallbackNotifiCation = @"sooonerSocketManagerJoinCallbackNotifiCation";//接收进入房间通知
NSString *const kSooonerSocketManagerLeaveCallbackNotifiCation = @"sooonerSocketManagerLeaveCallbackNotifiCation";//接收离开房间通知
NSString *const kSooonerSocketManagerRoomMessageCallbackNotifiCation = @"sooonerSocketManagerRoomMessageCallbackNotifiCation";//接收房间消息通知
NSString *const kSooonerSocketManagerPrivateMessageCallbackNotifiCation = @"sooonerSocketManagerPrivateMessageCallbackNotifiCation";//接收私聊消息通知
NSString *const kSooonerSocketManagerOfflineMessageCallbackNotifiCation = @"sooonerSocketManagerOfflineMessageCallbackNotifiCation";//接收离线消息通知
NSString *const kSooonerSocketManagerSystemMessageCallbackNotifiCation = @"sooonerSocketManagerSystemMessageCallbackNotifiCation";//接收系统消息通知



#pragma mark - 第三方key管理
NSString *const kShareSDKAppKey = @"19f16e96a6d40";//shareSDK
NSString *const kWeChatAppKey = @"wxe8ed4dd0247c603c";//微信appKey
NSString *const kWeChatAppSecret = @"b765b6941b7a1ee2e833a2613df5ffcb";//微信appSecret
NSString *const kAppleId = @"1190009170";//苹果appid
NSString *const kAppName = @"路网";//微信appSecret



#pragma mark - 其他信息管理
NSString *const kMainGreenColor = @"#00A99D";//主色调中的  绿色

#pragma mark - 微信支付
NSString *const kWXAPP_ID = @"wxe8ed4dd0247c603c";//苹果appid
NSString *const kWXMCH_ID = @"1440649002";//商户号，填写商户对应参数

@end
