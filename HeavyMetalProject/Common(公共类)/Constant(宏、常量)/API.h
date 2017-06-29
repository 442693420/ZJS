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
#define MAIN_HOST @"http://main.rooodad.com/metal/"  // 测试服务器


//#define MAIN_HOST @"https://sdsw.rooodad.com/metal/"  // 正式服务器

#define MAIN_VERSION @"_1_0.do"  // 测试服务器版本号


/**************  报价  *******************/
//栏目列表
#define API_GetClassify  [NSString stringWithFormat:@"%@yh_zq_list%@",MAIN_HOST,MAIN_VERSION]
//详情列表
#define API_GetOfferList  [NSString stringWithFormat:@"%@yh_cllist%@",MAIN_HOST,MAIN_VERSION]


#endif


