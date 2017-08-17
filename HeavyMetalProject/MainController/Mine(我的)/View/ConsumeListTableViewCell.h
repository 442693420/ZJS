//
//  ConsumeListTableViewCell.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/31.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsumeListTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL open;

@property (nonatomic , strong)UIView *topView;
@property (nonatomic , strong)UIView *bottomView;

@property (nonatomic , strong)UILabel *timeLab;
@property (nonatomic , strong)UILabel *moneyLab;
@property (nonatomic , strong)UIImageView *goldImgView;
@property (nonatomic , strong)UIImageView *arrowImgView;
@property (nonatomic , strong)UILabel *infoLab;
@end
