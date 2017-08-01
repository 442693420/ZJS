//
//  NewsListObject.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListObject : NSObject
//id = 10fa97bb4fbe47b49db7d2ad1357b591;
//synopsis = 1121;
//time = "2017-07-27 17:40:36";
//title = "\U6d4b\U8bd5";
@property (nonnull , copy)NSString *ID;
@property (nonnull , copy)NSString *synopsis;
@property (nonnull , copy)NSString *time;
@property (nonnull , copy)NSString *title;
@end
