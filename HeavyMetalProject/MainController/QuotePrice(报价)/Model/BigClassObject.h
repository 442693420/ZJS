//
//  BigClassObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

//bigclassid = 1;
//bigclassname = "\U539f\U6599\U62a5\U4ef7";
//midclasslst ={}
@interface BigClassObject : NSObject
@property (nonatomic , copy)NSString *bigclassid;
@property (nonatomic , copy)NSString *bigclassname;
@property (nonatomic , strong)NSArray *midclasslst;
@end
