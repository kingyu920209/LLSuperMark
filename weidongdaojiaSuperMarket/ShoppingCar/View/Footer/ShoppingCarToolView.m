//
//  ShoppingCarToolView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/29.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "ShoppingCarToolView.h"
@interface ShoppingCarToolView ()
/** 全选按钮 */
@property (nonatomic , strong) UIButton * selectBtn;
/** 全选 */
@property (nonatomic , strong) UILabel * selectLabel;
/** 合计 */
@property (nonatomic , strong) UILabel * totalLabel;
/** 合计价格 */
@property (nonatomic , strong) UILabel * totalInfo;
/** 去结算 */
@property (nonatomic , strong) UIButton * goShopBtn;

@end

@implementation ShoppingCarToolView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.backgroundColor = [UIColor getColor:@"fafafa"];

    self.selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.selectBtn setImage:[UIImage imageNamed:@"noSelectGoods"] forState:(UIControlStateNormal)];
    [self.selectBtn setImage:[UIImage imageNamed:@"selectGoods"] forState:(UIControlStateSelected)];
    [self addSubview:self.selectBtn];
    self.selectBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        if (self.selectBtn.isSelected) {
            self.selectBtn.selected = NO;
        }else{
            self.selectBtn.selected = YES;
        }
        self.selectAllGoodsBlock(self.selectBtn.selected);
        
        return [RACSignal empty];
    }];
    
    self.selectLabel = [[UILabel alloc]init];
    self.selectLabel.text = @"全选";
    self.selectLabel.font = [UIFont systemFontOfSize:12];
    self.selectLabel.textColor = [UIColor getColor:@"333333"];
    [self addSubview:self.selectLabel];
    
    self.totalLabel =[[UILabel alloc] init];
    self.totalLabel.text = @"合计:";
    self.totalLabel.textColor = [UIColor getColor:@"333333"];
    self.totalLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.totalLabel];
    
    self.totalInfo = [[UILabel alloc] init];
    self.totalInfo.font = [UIFont boldSystemFontOfSize:18];
    self.totalInfo.textColor = [UIColor getColor:@"333333"];
    self.totalInfo.text = @"¥0.00";
    NSMutableAttributedString * totlaString = [[NSMutableAttributedString alloc]initWithString:self.totalInfo.text];
    NSRange totalRange = [[totlaString string]rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]];
    [totlaString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:totalRange];
    self.totalInfo.attributedText = totlaString;
    [self addSubview:self.totalInfo];
    
    self.goShopBtn  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.goShopBtn.backgroundColor = [UIColor getColor:@"ff001f"];
    [self.goShopBtn setTitle:@"去结算" forState:(UIControlStateNormal)];
    [self.goShopBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.goShopBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.goShopBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.goShopBtn];
    self.goShopBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        self.goOrderDetailBlock();
        return [RACSignal empty];
    }];
}
-(void)layoutSubviews{
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@40);
    }];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right);
        make.centerY.equalTo(self);
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectLabel.mas_right).offset(11);
        make.centerY.equalTo(self);
    }];
    
    [self.totalInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalLabel.mas_right);
        make.baseline.equalTo(self.totalLabel);
    }];
    
    [self.goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(@106);
    }];
    
}
-(void)setSelectNum:(NSString *)selectNum{
    _selectNum = selectNum;
    if (_selectNum) {
        [self.goShopBtn setTitle:[NSString stringWithFormat:@"结算(%@)",selectNum] forState:(UIControlStateNormal)];

    }
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    self.selectBtn.selected = isSelect;

}
-(void)setTotalMoney:(NSString *)totalMoney{
    _totalMoney = totalMoney;
    if (_totalMoney) {
        self.totalInfo.text = [NSString stringWithFormat:@"¥%@",totalMoney];
        NSMutableAttributedString * totlaString = [[NSMutableAttributedString alloc]initWithString:self.totalInfo.text];
        NSRange totalRange = [[totlaString string]rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]];
        [totlaString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:totalRange];
        self.totalInfo.attributedText = totlaString;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
