//
//  HMPSegmentView.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPSegmentView.h"

#define MAX_TitleNumInWindow 4
#define LineHeight 1

@interface HMPSegmentView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;
@property (nonatomic,assign) CGFloat btn_w;
@end
@implementation HMPSegmentView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        
        _btn_w=frame.size.width/MAX_TitleNumInWindow;
        
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
        
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-LineHeight, _btn_w, LineHeight)];
        _selectLine.backgroundColor=[UIColor colorWithHexString:@"#D6D6D6"];
        [_bgScrollView addSubview:_selectLine];
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height-2);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            btn.titleLabel.font=_titleFont;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i==0) {
                btn.selected=YES;
                _titleBtn=btn;
            }
            //左右分割线
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#D6D6D6"];
            lineView.size = CGSizeMake(1, btn.frame.size.height/2);
            lineView.center = CGPointMake(btn.frame.origin.x+btn.frame.size.width-1,btn.frame.size.height/2);
            [_bgScrollView addSubview:lineView];
            self.block=block;
        }
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    
    NSLog(@"%ld",(long)btn.tag);
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        if (btn.tag-1 == 0) {
            NSLog(@"已经是第一页了");
            [[NSNotificationCenter defaultCenter] postNotificationName:kQuotePriceSmallSegmentScrollNotifiCation object:@"first"];
        }else if (btn.tag == _titles.count){
            NSLog(@"已经是最后一页了");
            [[NSNotificationCenter defaultCenter] postNotificationName:kQuotePriceSmallSegmentScrollNotifiCation object:@"last"];
        }else{
            return;
        }
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
    }
    
    if (_titles.count >= MAX_TitleNumInWindow) {
        //计算偏移量
        CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
        if (offsetX<0) {
            offsetX=0;
        }
        CGFloat maxOffsetX= _bgScrollView.contentSize.width-self.frame.size.width;
        if (offsetX>maxOffsetX) {
            offsetX=maxOffsetX;
        }
        [UIView animateWithDuration:0.1 animations:^{
            
            [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-LineHeight, btn.frame.size.width, LineHeight);
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-LineHeight, btn.frame.size.width, LineHeight);
    }
}

//下方内容切换，刷新分段器
- (void)bgScrollWithIndex:(NSInteger)index{
    UIButton *btn = [_bgScrollView viewWithTag:index+1];
    [self btnClick:btn];
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
    _bgScrollView.backgroundColor=_bgScrollViewColor;
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
    for (UIButton *btn in _btns) {
        NSLog(@"%ld",(long)btn.tag);
        NSLog(@"%ld",(long)_defaultIndex);
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-LineHeight, btn.frame.size.width, LineHeight);
        }else{
            btn.selected=NO;
        }
    }
}
@end
