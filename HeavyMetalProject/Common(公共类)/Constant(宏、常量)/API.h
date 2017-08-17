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
#define MAIN_HOST @"http://118.190.13.62:8080/metal/"  // 测试服务器


//#define MAIN_HOST @"http://118.190.13.62:8080/metal/"  // 正式服务器

#define MAIN_VERSION @"_1_0.do"  // 测试服务器版本号


/**************  报价  *******************/
//栏目列表
#define API_GetClassify  [NSString stringWithFormat:@"%@yh_zq_list%@",MAIN_HOST,MAIN_VERSION]
//详情列表
#define API_GetOfferList  [NSString stringWithFormat:@"%@yh_cllist%@",MAIN_HOST,MAIN_VERSION]
//消费查看价格(单个)
#define API_UPDATEPRICEFORONE  [NSString stringWithFormat:@"%@yh_get_newpriceforone%@",MAIN_HOST,MAIN_VERSION]
//消费查看价格(单个)
#define API_UPDATEPRICEFORALL  [NSString stringWithFormat:@"%@yh_get_newpriceforsome%@",MAIN_HOST,MAIN_VERSION]
//详情的图表数据
#define API_GetChartInfoData  [NSString stringWithFormat:@"%@yh_get_clxq%@",MAIN_HOST,MAIN_VERSION]
//搜索
#define API_Search  [NSString stringWithFormat:@"%@yh_searchmetal%@",MAIN_HOST,MAIN_VERSION]
//热门搜索和热门资讯
#define API_SearchHotInfo  [NSString stringWithFormat:@"%@yh_gethotsearch%@",MAIN_HOST,MAIN_VERSION]
/**************  关注  *******************/
//关注/取消关注栏目
#define API_AttentionOffer  [NSString stringWithFormat:@"%@yh_gz%@",MAIN_HOST,MAIN_VERSION]
//关注栏目列表
#define API_GetAttentionClassify  [NSString stringWithFormat:@"%@yh_gztypelist%@",MAIN_HOST,MAIN_VERSION]
//关注详情列表
#define API_GetAttentionOfferList  [NSString stringWithFormat:@"%@yh_gzlist%@",MAIN_HOST,MAIN_VERSION]

/**************  资讯  *******************/
//资讯分类列表
#define API_GetNewsClassify  [NSString stringWithFormat:@"%@yh_get_newsclassification%@",MAIN_HOST,MAIN_VERSION]
//资讯列表
#define API_GetNewsList  [NSString stringWithFormat:@"%@yh_get_newslst%@",MAIN_HOST,MAIN_VERSION]
#define API_GetNewsDetail  [NSString stringWithFormat:@"%@yh_get_news%@",MAIN_HOST,MAIN_VERSION]
/**************  我的  *******************/
//验证码
#define API_GETVERIFYCODE  [NSString stringWithFormat:@"%@gg_user_getvc%@",MAIN_HOST,MAIN_VERSION]
//注册
#define API_RESGIST  [NSString stringWithFormat:@"%@yh_user_reg_submit%@",MAIN_HOST,MAIN_VERSION]
//登录
#define API_LOGIN  [NSString stringWithFormat:@"%@yh_user_login%@",MAIN_HOST,MAIN_VERSION]
//重置密码
#define API_MODIFYPWD  [NSString stringWithFormat:@"%@yh_user_modifypwd%@",MAIN_HOST,MAIN_VERSION]
//消费明细
#define API_CONSUMELIST  [NSString stringWithFormat:@"%@yh_get_consumelst%@",MAIN_HOST,MAIN_VERSION]
//充值明细
#define API_RechargeList  [NSString stringWithFormat:@"%@yh_get_rechargelst%@",MAIN_HOST,MAIN_VERSION]
//我的钱包信息
#define API_WalletInfo  [NSString stringWithFormat:@"%@yh_get_mywallet%@",MAIN_HOST,MAIN_VERSION]
//用户详情
#define API_PersonalInfo  [NSString stringWithFormat:@"%@yh_get_userdetails%@",MAIN_HOST,MAIN_VERSION]
//用户详情修改
#define API_PersonalInfoUpdate  [NSString stringWithFormat:@"%@yh_upd_nic%@",MAIN_HOST,MAIN_VERSION]
//修改手机号
#define API_ModifyPhone  [NSString stringWithFormat:@"%@yh_modifytel%@",MAIN_HOST,MAIN_VERSION]
/**************  其他  *******************/
//App启动，用于更新登录时间
#define API_APPSTART  [NSString stringWithFormat:@"%@gg_appstart%@",MAIN_HOST,MAIN_VERSION]
#endif


