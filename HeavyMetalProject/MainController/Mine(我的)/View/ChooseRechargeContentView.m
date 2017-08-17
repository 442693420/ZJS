//
//  ChooseRechargeContentView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "ChooseRechargeContentView.h"
#import "ChooseBtn.h"
@interface ChooseRechargeContentView()
@property (nonatomic , strong)UILabel *titleLab;
@end
static NSInteger chooseRechargeContentViewTag = 100;
@implementation ChooseRechargeContentView

-(id)initWithTitle:(NSString *)title chooseBtnArr:(NSArray *)btnArr{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.btnArr = [[NSMutableArray alloc]init];
        
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(8));
            make.top.equalTo(self.mas_top).offset(KRealValue(5));
            make.height.mas_equalTo(KRealValue(30));
            make.width.mas_equalTo(KRealValue(100));
        }];
        self.titleLab.text = title;
        UIView *btnView = [[UIView alloc]init];
        [self addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right);
            make.right.equalTo(self.mas_right).offset(-KRealValue(8));
            make.bottom.equalTo(self.mas_bottom);
            make.top.equalTo(self.mas_top);
        }];
        UIView *lastView;
        for (int i = 0; i < btnArr.count; i++) {
            ChooseBtn *button = [[ChooseBtn alloc]init];
            button.tag = i+chooseRechargeContentViewTag;
            button.titleLab.text = btnArr[i];
            button.titleLab.textColor = [UIColor blackColor];
            [btnView addSubview:button];
            [self.btnArr addObject:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.left.right.equalTo(btnView);
                    make.top.equalTo(btnView.mas_top);
                }else{
                    if (i == btnArr.count-1) {
                        make.left.right.equalTo(btnView);
                        make.top.equalTo(lastView.mas_bottom);
                        make.height.equalTo(lastView.mas_height);
                        make.bottom.equalTo(btnView.mas_bottom);
                    }else{
                        make.left.right.equalTo(btnView);
                        make.top.equalTo(lastView.mas_bottom);
                        make.height.equalTo(lastView.mas_height);
                    }
                }
            }];
            lastView = button;
        }
    }
    return self;
}
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _titleLab;
}
@end
