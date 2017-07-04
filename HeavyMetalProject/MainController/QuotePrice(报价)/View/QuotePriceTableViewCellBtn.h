//
//  QuotePriceTableViewCellBtn.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/4.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotePriceTableViewCellBtn : UIButton
@property (nonatomic , strong)NSIndexPath *cellIndexPath;//当前tableView的indexPath
@property (nonatomic , copy)NSString *clid;//材料id
@property (nonatomic , copy)NSString *isgz;//是否关注  0未关注 1已关注
@end
