//
//  WDSpeciesTabBarItem.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDSpeciesTabBarItem.h"
@interface WDSpeciesTabBarItem ()
@property (strong, nonatomic) UIImageView *spotImageView;
@property (assign, nonatomic) BOOL tmpFlag;
@end
@implementation WDSpeciesTabBarItem

- (void)setupItem {
    [super setupItem];
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_species"]];
    [self.titleLabel setText:@"分类"];
    
//    self.spotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ornament7"]];
//    _spotImageView.alpha = 0;
//    [self addSubview:_spotImageView];
//    [self sendSubviewToBack:_spotImageView];
//    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
//        make.trailing.equalTo(self.mainImageView).offset(-4);
//        make.top.equalTo(self.mainImageView).offset(1);
//    }];
}

- (void)handleClick {
    [super handleClick];
}

- (void)releaseAnim {
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_species"]];
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
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_selectSpecies"]];
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

@end
