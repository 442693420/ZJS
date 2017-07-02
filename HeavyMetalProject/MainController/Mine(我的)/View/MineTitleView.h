//
//  MineTitleView.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MineTitleView : UIView
@property (nonatomic , strong)UIView *infoBackView;
@property (nonatomic , strong)UIImageView *titleImgView;
@property (nonatomic , strong)UILabel *nickNameLab;
@property (nonatomic , strong)UILabel *infoLab;
@property (nonatomic , strong)UIButton *messageBtn;
@property (nonatomic , strong)UIView *messageUnreadPointView;
@property (nonatomic , strong)UIImageView *rightArrowView;

- (void)refreshTitleViewUI:(UserObject *)userModel;

@end
