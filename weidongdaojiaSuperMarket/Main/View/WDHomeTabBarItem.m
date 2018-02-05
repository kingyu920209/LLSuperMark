//
//  WDHomeTabBarItem.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDHomeTabBarItem.h"
#define SPOTIMAGEVIEW_CENTERY_OFFSET 2
NSString * const NOTIFICATION_NAME_HOME_PAGE_DID_LOAD_DATA = @"NOTIFICATION_NAME_HOME_PAGE_DID_LOAD_DATA";

@interface WDHomeTabBarItem ()
@property (strong, nonatomic) UIImageView *subImageView;
@property (strong, nonatomic) UIImageView *spotImageView;
@property (assign, nonatomic) BOOL tmpFlag;
@property (assign, nonatomic) CGFloat spotImageViewCurrentScale;
@end
@implementation WDHomeTabBarItem
- (void)setupItem {
    [super setupItem];
//    [self registerNotification];
    self.itemStatus = HomeTabBarItemStatusWeather;
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_selectHome"]];
    
    //    [self.mainImageView setHighlightedImage:[UIImage imageNamed:@"icon_subscribe"]];
    //    [self.mainButton setImage:[UIImage imageNamed:@"icon_subscribe"] forState:(UIControlStateSelected)];
    [self.titleLabel setText:@"首页"];
    self.titleLabel.textColor=[UIColor getColor:@"8dc445"];

    self.subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh"]];
    _subImageView.alpha = 0;
    [self addSubview:_subImageView];
    [_subImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainImageView);
    }];
    
//    self.spotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ornament7"]];
//    _spotImageViewCurrentScale = 1.f;
//    [self addSubview:_spotImageView];
//    [self sendSubviewToBack:_spotImageView];
//    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
//        make.centerX.equalTo(self.mainImageView);
//        make.centerY.equalTo(self.mainImageView).offset(SPOTIMAGEVIEW_CENTERY_OFFSET);
//    }];
}
- (void)handleClick {
    [super handleClick];
    
}
- (void)releaseAnim {
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_home"]];
    self.titleLabel.textColor=[UIColor getColor:@"9e9e9e"];
    

//    CABasicAnimation *spotImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    spotImageViewScaleAnim.fromValue = @(1);
//    spotImageViewScaleAnim.toValue = @(0);
//    spotImageViewScaleAnim.duration = 0.3f;
//    [_spotImageView.layer addAnimation:spotImageViewScaleAnim forKey:@"mainImageView"];
//
//    [CATransaction begin];
//    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//    [_spotImageView.layer setTransform:CATransform3DMakeScale(0, 0, 0)];
//    [CATransaction commit];
}

- (void)selectedAnim {
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_selectHome"]];
self.titleLabel.textColor=[UIColor getColor:@"8dc445"];
//    _spotImageView.alpha = 1;
//    CABasicAnimation *spotImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    spotImageViewScaleAnim.fromValue = @(0);
//    spotImageViewScaleAnim.toValue = @(1);
//    spotImageViewScaleAnim.duration = 0.3f;
//    [_spotImageView.layer addAnimation:spotImageViewScaleAnim forKey:@"mainImageView"];
//
//    [CATransaction begin];
//    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//    [_spotImageView.layer setTransform:CATransform3DMakeScale(1, 1, 1)];
//    [CATransaction commit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
