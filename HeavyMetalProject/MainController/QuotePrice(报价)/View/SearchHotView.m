//
//  SearchHotView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "SearchHotView.h"
#import "NewsListObject.h"
@implementation SearchHotView
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)creatUIHotView:(NSArray *)searchHot newsHot:(NSArray *)newsHot{
    self.searchBtnArr = [[NSMutableArray alloc]init];
    self.newsBtnArr = [[NSMutableArray alloc]init];
    
    //热门搜索
    UIView *searchView = [[UIView alloc]init];
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(KRealValue(20));
        //bottom
    }];
    UILabel *searchTitleLab = [[UILabel alloc]init];
    searchTitleLab.textColor = [UIColor whiteColor];
    searchTitleLab.font = [UIFont systemFontOfSize:KRealValue(16)];
    [searchView addSubview:searchTitleLab];
    [searchTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left).offset(KRealValue(20));
        make.top.equalTo(searchView.mas_top);
        make.height.mas_equalTo(@30);
    }];
    NSString *searchTitleStr = @"近期热门搜索";
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:searchTitleStr attributes:attribtDic];
    //赋值
    searchTitleLab.attributedText = attribtStr;
    
    //遍历构建
    UIView *lastView;
    for (int i = 0; i < searchHot.count; i++) {
        NSDictionary *dic = searchHot[i];
        int lie = i%4;
        UIButton *button = [UIButton new];
        button.tag = i;
        [button setTitle:dic[@"keyword"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        [searchView addSubview:button];
        [self.searchBtnArr addObject:button];
        if (i != searchHot.count - 1) {//最后一个不加分割线
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor lightTextColor];
            [searchView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(button.mas_centerY);
                make.height.mas_equalTo(KRealValue(20));
                make.width.mas_equalTo(KRealValue(0.5));
                make.left.equalTo(button.mas_right);
            }];
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                if (lie == 0) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(2);
                    make.left.mas_equalTo(0);
                }else{
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).offset(2);
                }
            }else{
                make.top.equalTo(searchTitleLab.mas_bottom).offset(KRealValue(8));
                make.left.mas_equalTo(0);
            }
            make.width.mas_equalTo((KScreenWidth-40)/4);
            make.height.mas_equalTo(KRealValue(30));
        }];
        lastView = button;
    }
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {        make.bottom.equalTo(lastView.mas_bottom).offset(KRealValue(8));
    }];
    
    
    
    //热门资讯
    UIView *newsView = [[UIView alloc]init];
    [self addSubview:newsView];
    [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(searchView.mas_bottom).offset(KRealValue(20));
        //bottom
    }];
    UILabel *newsTitleLab = [[UILabel alloc]init];
    newsTitleLab.textColor = [UIColor whiteColor];
    newsTitleLab.font = [UIFont systemFontOfSize:KRealValue(16)];
    [newsView addSubview:newsTitleLab];
    [newsTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newsView.mas_left).offset(KRealValue(20));
        make.top.equalTo(newsView.mas_top);
        make.height.mas_equalTo(@30);
    }];
    NSString *newsTitleStr = @"相关资讯";
    // 下划线
    NSMutableAttributedString *newsAttribtStr = [[NSMutableAttributedString alloc]initWithString:newsTitleStr attributes:attribtDic];
    //赋值
    newsTitleLab.attributedText = newsAttribtStr;
    //遍历构建
    UIView *lastNewsView;
    for (int i = 0; i < newsHot.count; i++) {
        NewsListObject *newObj = newsHot[i];
        UIButton *button = [UIButton new];
        button.tag = i;
        [button setTitle:newObj.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [newsView addSubview:button];
        [self.newsBtnArr addObject:button];
        if (i != newsHot.count - 1) {//最后一个不加分割线
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor lightTextColor];
            [newsView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.mas_bottom);
                make.height.mas_equalTo(KRealValue(0.5));
                make.left.right.equalTo(button);
            }];
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastNewsView) {
                make.top.mas_equalTo(lastNewsView.mas_bottom);
            }else{
                make.top.equalTo(newsTitleLab.mas_bottom).offset(KRealValue(8));
            }
            make.left.equalTo(newsView.mas_left).offset(KRealValue(20));
            make.right.equalTo(newsView.mas_right).offset(-KRealValue(20));
            make.height.mas_equalTo(KRealValue(40));
        }];
        lastNewsView = button;
    }
    [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastNewsView.mas_bottom).offset(KRealValue(8));
    }];
    
}

@end
