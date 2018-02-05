//
//  TopCategoryCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/18.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "TopCategoryCell.h"
#import "LeftCategoryItem.h"
@interface TopCategoryCell ()
@property (nonatomic,strong) UILabel * titleLabel;
@end
@implementation TopCategoryCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor =[UIColor whiteColor];
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius = 5;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor getColor:@"bfbfbf"];
    [self addSubview:self.titleLabel];
}
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}
-(void)setModel:(LeftCategoryItem *)model{
    self.titleLabel.text = model.title;
}
-(void)setTitleColor:(NSString *)titleColor{
    _titleColor = titleColor;
    if (_titleColor) {
                self.titleLabel.backgroundColor = [UIColor getColor:titleColor];
    }
}
-(void)setSelected:(BOOL)selected{
    if (selected) {
        
        self.titleLabel.backgroundColor = [UIColor getColor:@"8dc445"];
    }else{
        self.titleLabel.backgroundColor = [UIColor getColor:@"bfbfbf"];
    }
}
@end
