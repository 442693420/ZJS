//
//  HMPNaviSegmentView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPNaviSegmentView.h"

#define MAX_TitleNumInWindow 4
#define ButtonMargin 3 //按钮上下左右空隙

@interface HMPNaviSegmentView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,assign) CGFloat btn_w;
@end
@implementation HMPNaviSegmentView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.layer.shadowColor=[UIColor blackColor].CGColor;
        //        self.layer.shadowOffset=CGSizeMake(2, 2);
        //        self.layer.shadowRadius=2;
        //        self.layer.shadowOpacity=.2;
        
        _btn_w=0.0;
        if (titleArray.count<MAX_TitleNumInWindow+1) {
            _btn_w=frame.size.width/titleArray.count;
        }else{
            _btn_w=frame.size.width/MAX_TitleNumInWindow;
        }
        _titles=titleArray;
        _defaultIndex=1;
        _titleFont=[UIFont systemFontOfSize:15];
        _btns=[[NSMutableArray alloc] initWithCapacity:0];
        _titleNomalColor=[UIColor whiteColor];
        _titleSelectColor=[UIColor whiteColor];
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, self.frame.size.height)];
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, self.frame.size.height);
        [self addSubview:_bgScrollView];
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(_btn_w*i+ButtonMargin, ButtonMargin*2, _btn_w-ButtonMargin*2, self.frame.size.height-ButtonMargin*4);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            btn.titleLabel.font=_titleFont;
            btn.backgroundColor = [UIColor blackColor];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = (self.frame.size.height-ButtonMargin*4)/2;
            btn.layer.borderColor = [UIColor colorWithHexString:@"#D6D6D6"].CGColor;
            btn.layer.borderWidth = 1;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i==0) {
                _titleBtn=btn;
                btn.selected=YES;
                btn.backgroundColor = [UIColor colorWithHexString:@"#D6D6D6"];
            }
            self.block=block;
            
        }
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn.backgroundColor = [UIColor blackColor];
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _titleBtn.backgroundColor = [UIColor colorWithHexString:@"#D6D6D6"];
        _defaultIndex=btn.tag;
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-self.frame.size.width;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setBgScrollViewColor:(UIColor *)bgScrollViewColor{
    _bgScrollViewColor=bgScrollViewColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}

-(void)updateView{
    _bgScrollView.backgroundColor=_bgScrollViewColor;
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
    }
}

@end
