//
//  WDAnimTabBarItem.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDAnimTabBarItem : UIView
@property (strong, nonatomic) UIButton *mainButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (assign, nonatomic) NSUInteger index;
- (instancetype)initWithTabBarController:(UITabBarController *)tabBarController index:(NSUInteger)index;
- (void)setupItem;
- (void)handleClick;
- (void)releaseAnim;
- (void)selectedAnim;

@end
