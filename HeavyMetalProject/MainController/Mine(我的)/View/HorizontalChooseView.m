//
//  HorizontalChooseView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/14.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HorizontalChooseView.h"
#import "ChooseBtn.h"
@interface HorizontalChooseView()
@property (nonatomic , strong)UILabel *titleLab;
@end
static NSInteger horizontalTag = 50;
@implementation HorizontalChooseView

-(id)initWithTitle:(NSString *)title chooseBtnArr:(NSArray *)btnArr{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.btnArr = [[NSMutableArray alloc]init];
        
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRealValue(8));
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(KRealValue(30));
            make.width.mas_equalTo(KRealValue(100));
        }];
        self.titleLab.text = title;
        UIView *btnView = [[UIView alloc]init];
        [self addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right).offset(KRealValue(8));
            make.right.top.bottom.equalTo(self);
        }];
        UIView *lastView;
        for (int i = 0; i < btnArr.count; i++) {
            ChooseBtn *button = [[ChooseBtn alloc]init];
            button.tag = i+horizontalTag;
            button.titleLab.text = btnArr[i];
            [btnView addSubview:button];
            [self.btnArr addObject:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.left.equalTo(btnView.mas_left);
                    make.height.mas_equalTo(KRealValue(30));
                    make.centerY.equalTo(btnView.mas_centerY);
                }else{
                    if (i == btnArr.count-1) {
                        make.left.equalTo(lastView.mas_right);
                        make.height.mas_equalTo(KRealValue(30));
                        make.centerY.equalTo(btnView.mas_centerY);
                        make.width.equalTo(lastView.mas_width);
                        make.right.equalTo(btnView.mas_right);
                    }else{
                        make.left.equalTo(lastView.mas_right);
                        make.height.mas_equalTo(KRealValue(30));
                        make.centerY.equalTo(btnView.mas_centerY);
                        make.width.equalTo(lastView.mas_width);
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
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    }
    return _titleLab;
}

@end
