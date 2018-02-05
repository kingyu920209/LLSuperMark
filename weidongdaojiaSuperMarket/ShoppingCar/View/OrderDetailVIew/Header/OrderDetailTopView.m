//
//  OrderDetailTopView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/29.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailTopView.h"
@interface OrderDetailTopView ()
@property(nonatomic,strong)UISegmentedControl * segment;
@property(nonatomic,strong)UILabel * infoLabel;
@end

@implementation OrderDetailTopView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.backgroundColor = [UIColor getColor:@"f1f2f6"];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:@[@"送货上门",@"到店自提"]];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor whiteColor];
    segment.backgroundColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(changeSegment:) forControlEvents:(UIControlEventValueChanged)];
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    
    
    [segment setBackgroundImage:[self imageWithColor:[UIColor getColor:@"ff3b3b"]] forState:(UIControlStateSelected) barMetrics:(UIBarMetricsDefault)];
    [segment setBackgroundImage:[self imageWithColor:[UIColor getColor:@"d1d1d1"]] forState:(UIControlStateNormal) barMetrics:(UIBarMetricsDefault)];

    [self addSubview:segment];
    self.segment = segment;
    
    self.infoLabel = [[UILabel alloc]init];
    self.infoLabel.text = @"温馨提示：本店营业时间为7:00-23:00";
    self.infoLabel.font = [UIFont systemFontOfSize:12];
    self.infoLabel.textColor = [UIColor getColor:@"737373"];
    [self addSubview:self.infoLabel];
    
}
-(void)layoutSubviews{
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@215);
        make.height.equalTo(@30);
    }];
    [self.segment layoutIfNeeded];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.segment.bounds cornerRadius:8];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.segment.layer.mask = layer;
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.segment.mas_bottom).offset(10);
        
    }];
}
- (void)changeSegment:(UISegmentedControl *)sender {
    LLog(@"%ld",(long)sender.selectedSegmentIndex);
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
