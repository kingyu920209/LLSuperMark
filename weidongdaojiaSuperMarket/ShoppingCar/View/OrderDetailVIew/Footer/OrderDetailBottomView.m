//
//  OrderDetailBottomView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/30.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailBottomView.h"
@interface OrderDetailBottomView ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *infoLabel;
@property(nonatomic,strong)UIButton *payBtn;
@end
@implementation OrderDetailBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text  = @"实付款:";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc]init];
    self.infoLabel.textColor = [UIColor getColor:@"333333"];
    self.infoLabel.font = [UIFont boldSystemFontOfSize:18];
    self.infoLabel.text = @"¥0.00";
    [self addSubview:self.infoLabel];
    
    NSMutableAttributedString * infoString = [[NSMutableAttributedString alloc]initWithString:self.infoLabel.text];
    NSRange infoRange = [[infoString string] rangeOfString:[NSString stringWithFormat:@"¥"]];
    [infoString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:infoRange];
    self.infoLabel.attributedText = infoString;
    
    self.payBtn  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.payBtn.backgroundColor = [UIColor getColor:@"ff001f"];
    [self.payBtn setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [self.payBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.payBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.payBtn];
    self.payBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

        return [RACSignal empty];
    }];
}
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.centerY.equalTo(self);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.baseline.equalTo(self.titleLabel);        
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(@106);
    }];
}
-(void)setTotalMoney:(NSString *)totalMoney{
    _totalMoney = totalMoney;
    if (_totalMoney) {
        self.infoLabel.text = [NSString stringWithFormat:@"¥%@",totalMoney];
        NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc]initWithString:self.infoLabel.text];
        NSRange infoRange = [[infoStr string] rangeOfString:@"¥"];
        [infoStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:infoRange];
        self.infoLabel.attributedText = infoStr;
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
