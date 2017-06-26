//
//  UserManger.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserObject;
@interface UserManger : NSObject
+ (void)saveUserInfoDefault:(UserObject *)user;//保存个人信息
+ (UserObject *)getUserInfoDefault;
+ (void)removeUserInfoDefault;
//+ (NSString *)getCurrentDeviceModel;


@end
