//
//  WDShoppingCarTabBarItem.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDShoppingCarTabBarItem.h"
@interface WDShoppingCarTabBarItem ()
@property (strong, nonatomic) UIImageView *spotImageView;
@property (assign, nonatomic) BOOL tmpFlag;

@end
@implementation WDShoppingCarTabBarItem
- (void)setupItem {
    [super setupItem];
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_car"]];
    [self.titleLabel setText:@"购物车"];
    
//    self.spotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ornament7"]];
//    _spotImageView.alpha = 0;
//    [self addSubview:_spotImageView];
//    [self sendSubviewToBack:_spotImageView];
//    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
//        make.trailing.equalTo(self.mainImageView).offset(-4);
//        make.top.equalTo(self.mainImageView).offset(1);
//    }];
    
    UILabel * numLabel = [[UILabel alloc]init];
    numLabel.font = [UIFont systemFontOfSize:10];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.backgroundColor = [UIColor redColor];
//    numLabel.layer.masksToBounds = YES;
//    numLabel.layer.cornerRadius = 7.5;
//    numLabel.text = @"1";
    numLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainImageView.mas_right).offset(-10);
        make.bottom.equalTo(self.mainImageView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [numLabel layoutIfNeeded];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:numLabel.bounds cornerRadius:7.5];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    numLabel.layer.mask = layer;
    
    self.numLabel = numLabel;
    self.numLabel.hidden = YES;
}
-(void)setBarNum:(NSString *)barNum{
    _barNum = barNum;
    if (_barNum) {
        self.numLabel.text = barNum;
        self.numLabel.hidden = NO;
    }
}
- (void)handleClick {
    [super handleClick];
}

- (void)releaseAnim {
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_car"]];
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
    [self.mainImageView setImage:[UIImage imageNamed:@"shouye_icon_selectCar"]];
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
