//
//  WDOtherHeadView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/15.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDOtherHeadView.h"

@implementation WDOtherHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    _likeImageView = [[UIImageView alloc] init];
//    _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:_likeImageView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);

    }];
}
@end
