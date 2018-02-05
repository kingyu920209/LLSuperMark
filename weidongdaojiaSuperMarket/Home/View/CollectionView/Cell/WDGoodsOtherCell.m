//
//  WDGoodsOtherCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/15.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDGoodsOtherCell.h"

#import "GoodsActiveItem.h"
@interface WDGoodsOtherCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 现价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 标题 */
@property (strong , nonatomic)UILabel *titleLabel;
/* 原始价格 */
@property (strong , nonatomic)UILabel *opriceLabel;
/* 增加按钮 */
@property (strong , nonatomic)UIButton * addButton;
/* 减少按钮 */
@property (strong , nonatomic)UIButton * reduceButton;
/* 显示个数 */
@property (strong , nonatomic)UILabel * numLable;

@property (assign , nonatomic)NSInteger  num;

@end
@implementation WDGoodsOtherCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
//    self.num =0;
    self.goodsImageView = [[UIImageView alloc] init];
//    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.goodsImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.titleLabel];
//    self.titleLabel.text = @"11";
    self.opriceLabel  = [[UILabel alloc]init];
    self.opriceLabel.font = [UIFont systemFontOfSize:13];
    self.opriceLabel.textColor = [UIColor getColor:@"9e9e9e"];
    [self addSubview:self.opriceLabel];
    
    self.priceLabel  = [[UILabel alloc]init];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:18];
    self.priceLabel.textColor = [UIColor getColor:@"333333"];
    [self addSubview:self.priceLabel];
    
    self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
    self.addButton.showsTouchWhenHighlighted = YES;
    [self addSubview:self.addButton];
  
    
    self.reduceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.reduceButton setBackgroundImage:[UIImage imageNamed:@"reduce"] forState:(UIControlStateNormal)];
    self.reduceButton.hidden = YES;
    self.reduceButton.showsTouchWhenHighlighted = YES;
    [self addSubview:self.reduceButton];
    
    self.numLable = [[UILabel alloc] init];
    self.numLable.textColor = [UIColor getColor:@"333333"];
    self.numLable.hidden = YES;
    self.numLable.textAlignment = NSTextAlignmentCenter;
    self.numLable.layer.masksToBounds = YES;
    self.numLable.layer.borderWidth = 0.5;
    self.numLable.layer.borderColor =[UIColor getColor:@"9e9e9e"].CGColor;
    self.numLable.layer.cornerRadius =10;
    [self addSubview:self.numLable];
//    kWeakSelf(weakSelf);
//    kStrongSelf(strongSelf);
    self.addButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        self.num++;
        self.numLable.text =[NSString stringWithFormat:@"%ld",self.num];
        if (self.num>0) {
            self.reduceButton.hidden=NO;
            self.numLable.hidden=NO;
            self.opriceLabel.hidden = YES;
        }
        self.addNumBlock([NSString stringWithFormat:@"%ld",(long)self.num]);
        return [RACSignal empty];
    }];
    self.reduceButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        self.num--;
        self.numLable.text =[NSString stringWithFormat:@"%ld",self.num];
        if (self.num<=0) {
            self.reduceButton.hidden=YES;
            self.numLable.hidden=YES;
            self.opriceLabel.hidden = NO;
        }
        self.reduceNumBlock([NSString stringWithFormat:@"%ld",(long)self.num]);

        return [RACSignal empty];
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@85);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(10);

    }];
    
    [self.opriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(self).offset(10);
        
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.opriceLabel);
        make.top.equalTo(self.opriceLabel.mas_bottom).offset(15);
        
    }];

    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.opriceLabel);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.opriceLabel);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.opriceLabel);
        make.left.equalTo(self.reduceButton.mas_right).offset(5);
        make.right.equalTo(self.addButton.mas_left).offset(-5);
        make.height.equalTo(@20);
    }];
}
-(void)setOtherItem:(GoodsActiveItem *)otherItem{
    _otherItem = otherItem;
    self.num = [otherItem.goodsNum integerValue];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:otherItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];

    self.titleLabel.text = otherItem.title;

    NSUInteger length = [otherItem.oprice length]+1;

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",otherItem.oprice]];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor getColor:@"9e9e9e"] range:NSMakeRange(0, length)];
    [self.opriceLabel setAttributedText:attri];

    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",otherItem.price];
    NSMutableAttributedString * priceAttributed = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
    NSRange priceRange = [[priceAttributed string]rangeOfString:@"¥"];
    [priceAttributed addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:priceRange];
    self.priceLabel.attributedText = priceAttributed;
    self.numLable.text =[NSString stringWithFormat:@"%@",otherItem.goodsNum];

    if ([otherItem.goodsNum integerValue]>0) {
        self.reduceButton.hidden=NO;
        self.numLable.hidden=NO;
        self.opriceLabel.hidden = YES;
    }else{
        self.reduceButton.hidden=YES;
        self.numLable.hidden=YES;
        self.opriceLabel.hidden = NO;
    }
//    LLog(@"%@",otherItem.price);
}
@end
