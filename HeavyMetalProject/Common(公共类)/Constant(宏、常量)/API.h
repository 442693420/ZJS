//
//  API.h
//  NutzCommunity
//
//  Created by chen on 15/12/25.
//  Copyright (c) 2015年 CL. All rights reserved.
//
#ifndef API_h
#define API_h

#define C_S @4 // 服务器版本号

/**************  服务器地址  *******************/
#define MAIN_HOST @"http://main.rooodad.com/rooodad/"  // 测试服务器
#define MAIN_HOSTWEB @"http://main.rooodad.com/"  // 测试服务器
#define WX_MAIN_HOST @"https://test.carwindows.net/rooodad/"  // 测试地址微信公众号接口  post请求接口
#define WX_HOSTWEB @"https://test.carwindows.net/rooodad/"  // 测试地址微信公众号功能(个人中心-会员中心-积分商城、惠加气、我的车险) get请求页面
#define KEFUID @"6227d863f3594b2c96e9b6c6745b1058"  // 测试地址客服ID
#define KEFUIMG @"http://t2.auto.soooner.com/group2/M00/8A/CF/jNIEkljc2tuELdEWAAAAAP0woL4575.jpg"  // 测试地址客服头像
#define CARKEFUID @"6227d863f3594b2c96e9b6c6745b1058"  // 测试地址车险客服ID
#define CARKEFUIMG @"http://t2.auto.soooner.com/group2/M00/8A/CF/jNIEkljc2tuELdEWAAAAAP0woL4575.jpg"  // 测试地址车险客服头像

//#define MAIN_HOST @"https://sdsw.rooodad.com/rooodad/"  // 正式服务器
//#define MAIN_HOSTWEB @"https://sdsw.rooodad.com/"  // 正式服务器
//#define WX_MAIN_HOST @"https://www.carwindows.net/rooodad/"  // 正式地址微信公众号接口 post请求接口
//#define WX_HOSTWEB @"https://www.carwindows.net/rooodad/"  // 正式地址微信公众号(个人中心-会员中心-积分商城、惠加气、我的车险) get请求页面
//#define KEFUID @"b352456791b24579809c5641d110bc15"  // 正式地址客服ID
//#define KEFUIMG @"http://t2.auto.soooner.com/group3/M00/71/E7/jNIElVjc3dyEcdqhAAAAAP0woL4146.jpg"  // 正式地址客服头像
//#define CARKEFUID @"b1e6990fba7342b6b2c6788745021430"  // 正式地址车险客服ID
//#define CARKEFUIMG @"http://t2.auto.soooner.com/group1/M00/61/26/jNIEkFkVU_WES1-OAAAAABDy8cY123.jpg"  // 正式地址车险客服头像

#define MAIN_VERSION @"_1_0.do"  // 测试服务器版本号

/*  北京服务器 */
#define PROTOCOL_URL  @"http://if.auto.soooner.com/"   //正式
#define PROTOCOL_URL_TEST @"http://117.122.220.82:8802/"      //测试
/**************  接口地址  *******************/
#define REGISTVERIFYCODE @"10"//注册验证吗
#define CHANGEVERIFYCODE @"11"//修改验证码
#define BANGDVERIFYCODE @"12"//绑定账号验证码
#define LOGININCODE @"13"//验证码登录

/**************  是否允许视频直播功能  *******************/
#define API_ALLOWVEDIO  [NSString stringWithFormat:@"%@yh_cy_checklts%@",MAIN_HOST,MAIN_VERSION]
/**************  控制车友互动页面,隐私弹窗  *******************/
#define API_SHOWPRIVACYALLTHETIME  [NSString stringWithFormat:@"%@yh_cy_checkys%@",MAIN_HOST,MAIN_VERSION]



/**************  登录注册  *******************/
// 注册接口---获取手机验证码
#define API_GETVERIFYCODE  [NSString stringWithFormat:@"%@gg_user_getvc%@",MAIN_HOST,MAIN_VERSION]
//注册
#define API_RESGIST  [NSString stringWithFormat:@"%@yh_user_reg_submit%@",MAIN_HOST,MAIN_VERSION]
//找回密码
#define API_RETRIEVE  [NSString stringWithFormat:@"%@yh_user_retrieve_pwd%@",MAIN_HOST,MAIN_VERSION]
//xiugaimima
#define API_CHANGEPWD  [NSString stringWithFormat:@"%@yh_user_modifypwd%@",MAIN_HOST,MAIN_VERSION]

// 登录接口
#define API_LOGIN  [NSString stringWithFormat:@"%@yh_user_login%@",MAIN_HOST,MAIN_VERSION]
//获取个人基本信息
#define API_GETJIBENINFO  [NSString stringWithFormat:@"%@yh_user_pointinfo%@",MAIN_HOST,MAIN_VERSION]

//注销
#define API_LOGINOUT  [NSString stringWithFormat:@"%@yh_user_logout%@",MAIN_HOST,MAIN_VERSION]
/**************   车友互动 *******************/
#define API_GETCARFRENDSLIST  [NSString stringWithFormat:@"%@yh_cy_list%@",MAIN_HOST,MAIN_VERSION]

/**************  互动  *******************/
// 创建聊天室接口
#define API_CREATCHATROOM  [NSString stringWithFormat:@"%@yh_cy_lts_pub%@",MAIN_HOST,MAIN_VERSION]
//上传背景图片和开场白语音
#define API_CREATCHATROOMUPDATEFILE  [NSString stringWithFormat:@"%@yh_cy_imgmic_upload%@",MAIN_HOST,MAIN_VERSION]
//关闭聊天室
#define API_CLOSECHATROOM  [NSString stringWithFormat:@"%@yh_cy_ltszb_close%@",MAIN_HOST,MAIN_VERSION]
//加入、离开聊天室
#define API_INORLEAVECHATROOM  [NSString stringWithFormat:@"%@yh_cy_ltsuser_op%@",MAIN_HOST,MAIN_VERSION]
//聊天室用户信息获取
#define API_CHATROOMUSERINFO  [NSString stringWithFormat:@"%@yh_cy_user_info%@",MAIN_HOST,MAIN_VERSION]
//礼物积分扣除
#define API_CHATROOMGIFTTAKEOFFPOINT  [NSString stringWithFormat:@"%@yh_user_pointout%@",MAIN_HOST,MAIN_VERSION]
//频道列表
#define API_CHANNELLIST [NSString stringWithFormat:@"%@hd_cspd_pdlst%@",MAIN_HOST,MAIN_VERSION]
//创建频道
#define API_CHREATECHANNEL [NSString stringWithFormat:@"%@hd_cspd_creatpd%@",MAIN_HOST,MAIN_VERSION]
//搜索频道
#define API_SEARCHCHANNEL [NSString stringWithFormat:@"%@hd_cspd_searchpd%@",MAIN_HOST,MAIN_VERSION]
//删除频道
#define API_DELETECHANNEL [NSString stringWithFormat:@"%@hd_cspd_pddelete%@",MAIN_HOST,MAIN_VERSION]
//进入、离开频道
#define API_INORLEAVECHREATECHANNEL [NSString stringWithFormat:@"%@yh_cy_pduser_op%@",MAIN_HOST,MAIN_VERSION]
//私人消息(图片)上传
#define API_PRIVATEPHOTOUPLOAD [NSString stringWithFormat:@"%@talkimg_upload%@",MAIN_HOST,MAIN_VERSION]

/**************  固定摄像头  *******************/
//3.1.1 发表评论协议
#define API_SENDCAMERACOMMENT [NSString stringWithFormat:@"%@hd_live_pl_op%@",MAIN_HOST,MAIN_VERSION]
//3.1.2 获取评论列表
#define API_GETCAMERACOMMENT [NSString stringWithFormat:@"%@hd_live_getpllist%@",MAIN_HOST,MAIN_VERSION]
//3.1.3 点赞协议_PL_003
#define API_CAMERALIKED [NSString stringWithFormat:@"%@hd_live_upvote%@",MAIN_HOST,MAIN_VERSION]
/**************  留言板  *******************/

// 留言列表接口
#define API_NOTELIST  [NSString stringWithFormat:@"%@yh_cy_msglist%@",MAIN_HOST,MAIN_VERSION]
// 留言删除
#define API_NOTEDELETE  [NSString stringWithFormat:@"%@yh_cy_msgdelete%@",MAIN_HOST,MAIN_VERSION]
// 留言回复
#define API_NOTEREPLYORADD  [NSString stringWithFormat:@"%@yh_cy_reply%@",MAIN_HOST,MAIN_VERSION]

/**************  我的关注  *******************/

// 我的关注列表接口
#define API_ATTENTIONLIST  [NSString stringWithFormat:@"%@yh_cy_gzlist%@",MAIN_HOST,MAIN_VERSION]
// 黑名单列表
#define API_BLACKACCOUNTLIST  [NSString stringWithFormat:@"%@yh_cy_hmdlist%@",MAIN_HOST,MAIN_VERSION]

// 车友操作 1关注  2取消关注  3，设置黑名单4 取消黑名单
#define API_CHEYOUOP  [NSString stringWithFormat:@"%@yh_cy_gz%@",MAIN_HOST,MAIN_VERSION]
#define API_CARLIVEINFO  [NSString stringWithFormat:@"%@yh_cy_getinfo%@",MAIN_HOST,MAIN_VERSION]

/**************  位置上传  *******************/

// 我的位置实时上传
#define API_UPDATELOCATION  [NSString stringWithFormat:@"%@yh_user_posup%@",MAIN_HOST,MAIN_VERSION]

// 版本更新
#define API_UPDATEVERSION  [NSString stringWithFormat:@"%@gg_upgrade%@",MAIN_HOST,MAIN_VERSION]

/**************  个人资料  *******************/
//修改昵称、性别、品牌、生日等信息
#define API_PERSONALMSG  [NSString stringWithFormat:@"%@yh_user_modifynamesex%@",MAIN_HOST,MAIN_VERSION]
//头像
#define API_POSTHEADIMAGE  [NSString stringWithFormat:@"%@yh_user_modifyhead%@",MAIN_HOST,MAIN_VERSION]
//用户相册 shuangchuan
#define API_POSTALBUM  [NSString stringWithFormat:@"%@yh_user_img_up%@",MAIN_HOST,MAIN_VERSION]
//用户相册 huoqu
#define API_GETALBUM  [NSString stringWithFormat:@"%@yh_user_img_list%@",MAIN_HOST,MAIN_VERSION]
//实名认证信息获取
#define API_GETSHIMING  [NSString stringWithFormat:@"%@yh_user_shimin_xinxi%@",MAIN_HOST,MAIN_VERSION]
//实名认证提交
#define API_SHIMING  [NSString stringWithFormat:@"%@yh_user_shiminxinxi_tj%@",MAIN_HOST,MAIN_VERSION]
//实名照片
#define API_SHIMINGIMAGE  [NSString stringWithFormat:@"%@yh_user_shimin_upimage%@",MAIN_HOST,MAIN_VERSION]
//绑定
#define API_BANGDING  [NSString stringWithFormat:@"%@yh_user_bindtel%@",MAIN_HOST,MAIN_VERSION]
//合并
#define API_HEBING  [NSString stringWithFormat:@"%@yh_user_combinetel%@",MAIN_HOST,MAIN_VERSION]
//安全和隐私
#define API_GETSAFESTATUS [NSString stringWithFormat:@"%@yh_user_setpolicy%@",MAIN_HOST,MAIN_VERSION]

/**************  惠加气  *******************/
//加气站列表
#define API_GETGASLIST  [NSString stringWithFormat:@"%@hjq_applbs",WX_MAIN_HOST]
//获取惠加气二维码
#define API_GETQRCODE  [NSString stringWithFormat:@"%@hjq_getCode",WX_MAIN_HOST]
//车牌信息绑定
#define API_CARINFOBINDING  [NSString stringWithFormat:@"%@zlbc",WX_MAIN_HOST]
//惠加气订单列表
#define API_GETHJQORDERLIST  [NSString stringWithFormat:@"%@ddlb_search",WX_MAIN_HOST]
//保单生成前获取默认数据(两次使用，一个在个人中心-会员中心-我的车险；另一个在保险客服点收款的时候)
#define API_GETCARINFOBEFORECREATORDER  [NSString stringWithFormat:@"%@payment_projectQueryForSend",WX_MAIN_HOST]
//车险保单生成
#define API_CREATINSURANCEGETCASHORDER  [NSString stringWithFormat:@"%@gatheringForAppTalk",WX_MAIN_HOST]
//车险发起询价
#define API_CARINSURANCEINQUIRY  [NSString stringWithFormat:@"%@payment_request",WX_MAIN_HOST]

/**************  公众号接口地址  *******************/
//订单列表
#define API_GETORDERLIST  [NSString stringWithFormat:@"%@ddlb",WX_MAIN_HOST]


#endif


