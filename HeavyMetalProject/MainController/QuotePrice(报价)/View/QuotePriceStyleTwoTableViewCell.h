//
//  QuotePriceStyleTwoTableViewCell.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuotePriceTableViewCellBtn.h"

@interface QuotePriceStyleTwoTableViewCell : UITableViewCell
@property (nonatomic , strong)UILabel *timeLab;
@property (nonatomic , strong)UILabel *nameLab;

@property (nonatomic , strong)UIView *priceBgView;//下方显示价格和涨跌的View，此处可能隐藏此View，显示点击查看报价的button
@property (nonatomic , strong)UILabel *oldPriceLab;//
@property (nonatomic , strong)UILabel *nowPriceLab;
@property (nonatomic , strong)UILabel *upDownPriceLab;

@property (nonatomic , strong)UIButton *showPriceBtn;//查看实时报价
@property (nonatomic , strong)QuotePriceTableViewCellBtn *attentionBtn;//关注
@end
