//
//  ShowPriceView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowPriceAlertView.h"
typedef void (^ShowPriceViewClickBlock)(NSInteger buttonIndex,NSIndexPath *cellIndexPath,NSString *clid);
@interface ShowPriceView : UIView
@property (nonatomic , strong) ShowPriceAlertView *alertView;
@property (nonatomic , copy)ShowPriceViewClickBlock btnAction;

@property (nonatomic , strong)NSIndexPath *cellIndexPath;//当前tableView的indexPath
@property (nonatomic , copy)NSString *clid;//材料id

@end
