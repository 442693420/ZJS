//
//  QuotePriceStyleSixTableViewCell.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/27.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "QuotePriceStyleSixTableViewCell.h"

@implementation QuotePriceStyleSixTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.cellView];
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark getter and setter
-(QuotePriceStyleSixView *)cellView{
    if (_cellView == nil) {
        _cellView = [[QuotePriceStyleSixView alloc]init];
    }
    return _cellView;
}
@end
