//
//  MineTitleView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "MineTitleView.h"

@implementation MineTitleView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self addSubview:self.infoBackView];
        
        [self.infoBackView addSubview:self.titleImgView];
        [self.infoBackView addSubview:self.nickNameLab];
        [self.infoBackView addSubview:self.infoLab];
        [self.infoBackView addSubview:self.messageBtn];
        [self.infoBackView addSubview:self.messageUnreadPointView];
        [self.infoBackView addSubview:self.rightArrowView];
        
        [self.infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(KRealValue(150));
        }];
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.infoBackView.mas_left).offset(20);
            make.width.height.mas_equalTo(KRealValue(64));
            make.top.equalTo(self.infoBackView.mas_top).offset(40+KRealValue(13));
        }];
        [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleImgView.mas_right).offset(8);
            make.top.equalTo(self.titleImgView.mas_top);
            make.height.equalTo(@30);
            make.right.equalTo(self.infoBackView.mas_right).offset(-20);
        }];
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.nickNameLab);
            make.top.equalTo(self.nickNameLab.mas_bottom).offset(8);
            make.height.equalTo(@20);
        }];
        [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.infoBackView.mas_right).offset(-20);
            make.centerY.equalTo(self.titleImgView.mas_centerY);
            make.width.mas_equalTo(KRealValue(6));
            make.height.mas_equalTo(KRealValue(12));
        }];
        [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.infoBackView.mas_right).offset(-20);
            make.top.equalTo(self.infoBackView.mas_top).offset(40);
            make.height.mas_equalTo(KRealValue(13));
            make.width.mas_equalTo(KRealValue(20));
        }];
        [self.messageUnreadPointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@8);
            make.centerY.equalTo(self.messageBtn.mas_top);
            make.left.equalTo(self.messageBtn.mas_right);
        }];
        
    }
    return self;
}


#pragma mark getter and setter
-(UIView *)infoBackView{
    if (_infoBackView == nil) {
        _infoBackView = [[UIView alloc]init];
        _infoBackView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
    }
    return _infoBackView;
}
-(UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]init];
        _titleImgView.layer.cornerRadius = KRealValue(64)/2;
        _titleImgView.layer.masksToBounds = YES;
    }
    return _titleImgView;
}
-(UILabel *)nickNameLab{
    if (_nickNameLab == nil) {
        _nickNameLab = [[UILabel alloc]init];
        _nickNameLab.text = @"昵称";
        _nickNameLab.font = [UIFont systemFontOfSize:KRealValue(18)];
        _nickNameLab.textColor = [UIColor whiteColor];
    }
    return _nickNameLab;
}
-(UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = [UIFont systemFontOfSize:KRealValue(12)];
        _infoLab.textColor = [UIColor whiteColor];
    }
    return _infoLab;
}
-(UIButton *)messageBtn{
    if (_messageBtn == nil) {
        _messageBtn = [[UIButton alloc]init];
        [_messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    }
    return _messageBtn;
}
-(UIView *)messageUnreadPointView{
    if (_messageUnreadPointView == nil) {
        _messageUnreadPointView = [[UIView alloc]init];
        _messageUnreadPointView.backgroundColor = [UIColor redColor];
        _messageUnreadPointView.layer.masksToBounds = YES;
        _messageUnreadPointView.layer.cornerRadius = 4;
    }
    return _messageUnreadPointView;
}
-(UIImageView *)rightArrowView{
    if (_rightArrowView == nil) {
        _rightArrowView = [[UIImageView alloc]init];
        _rightArrowView.image = [UIImage imageNamed:@"rightArrowWhite"];
    }
    return _rightArrowView;
}
- (void)refreshTitleViewUI:(UserObject *)userModel{
    NSLog(@"%@",userModel);
//    [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",j_userModel.head_img]] placeholderImage:[UIImage imageNamed:@"touxiang_moren"]];
//    _nickNameLab.text = [NSString stringWithFormat:@"%@",j_userModel.name];
//    _carImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_zb",j_userModel.car_img]];
//    if (j_userModel.tel.length == 11) {
//        _infoLab.text = j_userModel.tel;
//    }else {
//        _infoLab.text = @"未绑定手机号";
//    }
}
//- (void)titleViewClick {
//    //    BaseNavigationController *nav =(BaseNavigationController *) [UIApplication sharedApplication].delegate.window.rootViewController;
//    //    [[J_HomeLeftVCSliderManager sharedManager] openOrClose];
//
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    LBTabBarController *control = (LBTabBarController*)app.window.rootViewController;
//    BaseNavigationController *nav = [control selectedViewController];
//
//    J_PersonalMsgViewController *viewController = [[J_PersonalMsgViewController alloc]init];
//    [nav pushViewController:viewController animated:NO];
//
//}

@end
