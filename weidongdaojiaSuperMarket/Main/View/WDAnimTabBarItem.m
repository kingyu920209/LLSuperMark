//
//  WDAnimTabBarItem.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDAnimTabBarItem.h"
#define TITLE_LABEL_FONT [UIFont systemFontOfSize:12.f]
#define TITLE_LABEL_TEXT_COLOR [UIColor getColor:@"9e9e9e"]
#define TABBAR_ITEM_WIDTH 60.f
@implementation WDAnimTabBarItem
- (instancetype)initWithTabBarController:(UITabBarController *)tabBarController index:(NSUInteger)index {
    self = [super init];
    if (self) {
        _index = index;
        _tabBarController = tabBarController;
        [self setupItem];
    }
    return self;
}
- (void)setupItem {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TABBAR_ITEM_WIDTH));
    }];
    
    self.mainButton = [[UIButton alloc] init];
    [_mainButton addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mainButton];
    
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"Anim"];
    [_titleLabel setFont:TITLE_LABEL_FONT];
    [_titleLabel setTextColor:TITLE_LABEL_TEXT_COLOR];
    [self addSubview:_titleLabel];
    
    self.mainImageView = [[UIImageView alloc] init];
    [self addSubview:_mainImageView];
    
    [_mainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-3);
    }];
    
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.leading.greaterThanOrEqualTo(self);
        make.bottom.equalTo(_titleLabel.mas_top);
        make.width.and.height.equalTo(@25);
    }];
}
- (void)handleClick {
    _tabBarController.selectedIndex = _index;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
