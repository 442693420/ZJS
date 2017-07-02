//
//  UserObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject
@property (nonatomic , copy)NSString *sid;
@property (nonatomic , copy)NSString *userid;
@property (nonatomic , copy)NSString *nickname;
@property (nonatomic , copy)NSString *tel;
@property (nonatomic , copy)NSString *head_Img;
@property (nonatomic , copy)NSString *gold;//金币数
@property (nonatomic , copy)NSString *viptype;//Vip类型 0-非vip 1-普通vip 2-年费vip

@end
