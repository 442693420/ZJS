//
//  UserManger.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "UserManger.h"
@implementation UserManger
//存储用户信息
+ (void)saveUserInfoDefault:(UserObject *)user{
    NSLog(@"%@",user);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = user.mj_keyValues;
    [defaults setObject:userDic forKey:kUserInfoDefault];
    [defaults synchronize];
}
//获取用户信息
+(UserObject *)getUserInfoDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:kUserInfoDefault];
    UserObject *user;
    if(userDic == nil)
    {
        return nil;
    }
    else{
        user = [UserObject mj_objectWithKeyValues:userDic];
        return user;
    }
}
+ (void)removeUserInfoDefault {
    [[NSUserDefaults
      standardUserDefaults] removeObjectForKey:kUserInfoDefault];
    
    [[NSUserDefaults
      standardUserDefaults] synchronize];
}
//+ (NSString *)getCurrentDeviceModel
//{
//    int mib[2];
//    size_t len;
//    char *machine;
//    
//    mib[0] = CTL_HW;
//    mib[1] = HW_MACHINE;
//    sysctl(mib, 2, NULL, &len, NULL, 0);
//    machine = malloc(len);
//    sysctl(mib, 2, machine, &len, NULL, 0);
//    
//    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
//    free(machine);
//    
//    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
//    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
//    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
//    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
//    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
//    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
//    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
//    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
//    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
//    
//    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
//    
//    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
//    
//    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
//    
//    
//    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
//    
//    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
//    
//    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
//    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
//    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
//    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
//    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
//    
//    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
//    
//    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
//    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
//    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
//    
//    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
//    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
//    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
//    
//    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
//    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
//    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
//    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
//    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
//    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
//    
//    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
//    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
//    return @"iPhone";
//}
@end
