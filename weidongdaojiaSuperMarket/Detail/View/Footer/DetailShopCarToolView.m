//
//  DetailShopCarToolView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "DetailShopCarToolView.h"
@interface DetailShopCarToolView ()
/** 价格 */
@property(nonatomic,strong)UILabel * priceLabel;
/** 数量 */
@property(nonatomic,strong)UILabel * goodsNumLabel;
/** 去购物车 */
@property(nonatomic,strong)UIButton * goShopBtn;
@end

@implementation DetailShopCarToolView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.backgroundColor = [UIColor getColor:@"fafafa"];
  
    
    self.goShopBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.goShopBtn setImage:[UIImage imageNamed:@"shopcar"] forState:(UIControlStateNormal)];
    self.goShopBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    //    [self.goShopBtn setBackgroundImage:[UIImage imageNamed:@"shopcar"] forState:(UIControlStateNormal)];
    [self addSubview:self.goShopBtn];
    kWeakSelf(weakSelf)
    self.goShopBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        weakSelf.goShopBlock();
        return [RACSignal empty];
    }];
    
    self.goodsNumLabel = [[UILabel alloc]init];
    self.goodsNumLabel.font = [UIFont systemFontOfSize:10];
    self.goodsNumLabel.textAlignment = NSTextAlignmentCenter;
    self.goodsNumLabel.layer.masksToBounds = YES;
    self.goodsNumLabel.layer.cornerRadius= 9;
    self.goodsNumLabel.textColor = [UIColor getColor:@"222222"];
    self.goodsNumLabel.backgroundColor = [UIColor getColor:@"af2942"];
    [self addSubview:self.goodsNumLabel];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.textColor = [UIColor getColor:@"333333"];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:self.priceLabel];

}
-(void)layoutSubviews{
    

    
    [self.goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(9);
        //        make.size.mas_equalTo(CGSizeMake(65, 65));
        make.bottom.equalTo(self).offset(-15);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.goShopBtn.mas_right).offset(0);
    }];
    
    [self.goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goShopBtn).offset(-3);
        make.top.equalTo(self.goShopBtn).offset(3);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
}
-(void)setGoodsNum:(NSString *)goodsNum{
    _goodsNum = goodsNum;
    self.goodsNumLabel.text = [NSString stringWithFormat:@"%@",goodsNum];
}
-(void)setGoodsPrice:(NSString *)goodsPrice{
    _goodsPrice = goodsPrice;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",goodsPrice];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
