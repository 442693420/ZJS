//
//  MidClassObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
//midclassid = 100011;
//midclassname = "\U6709\U8272\U539f\U6599";
//smlclasslst =
@interface MidClassObject : NSObject
@property (nonatomic , copy)NSString *midclassid;
@property (nonatomic , copy)NSString *midclassname;
@property (nonatomic , strong)NSArray *smlclasslst;
@end
