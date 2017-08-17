//
//  UserObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject
//登录返回
@property (nonatomic , copy)NSString *sid;
@property (nonatomic , copy)NSString *userid;
@property (nonatomic , copy)NSString *nickname;
@property (nonatomic , copy)NSString *tel;
@property (nonatomic , copy)NSString *head_Img;
@property (nonatomic , copy)NSString *gold;//金币数
@property (nonatomic , copy)NSString *viptype;//Vip类型 0-非vip 1-普通vip 2-年费vip
//获取用户信息返回
@property (nonatomic , copy)NSString *realname;//真实姓名
@property (nonatomic , copy)NSString *companyname;//公司名称//如果是空就是个人，否则是公司
@property (nonatomic , copy)NSString *zjhm;//证件号码
@property (nonatomic , copy)NSString *zone;//所属地区
@property (nonatomic , copy)NSString *address;//具体地址
@property (nonatomic , copy)NSString *usertype;//用户类型 1-金属材料厂家 2-批发商 3-金属材料用户
@end
