//
//  OrderDetailTotalCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/30.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailTotalCell.h"
@interface OrderDetailTotalCell ()
/** 优惠价格 */
@property(nonatomic,strong)UILabel * comPrice;
/** 优惠 */
@property(nonatomic,strong)UILabel * comTitle;
/** 运费价格 */
@property(nonatomic,strong)UILabel * freePrice;
/** 运费 */
@property(nonatomic,strong)UILabel * freeTitle;
/** 商品总价 */
@property(nonatomic,strong)UILabel * totalTitle;
/** 总价格 */
@property(nonatomic,strong)UILabel * goodsTotal;
@end

@implementation OrderDetailTotalCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    self.totalTitle = [[UILabel alloc] init];
    self.totalTitle.text = @"商品总价";
    self.totalTitle.font = [UIFont systemFontOfSize:14];
    self.totalTitle.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.totalTitle];
    
    self.goodsTotal = [[UILabel alloc] init];
    self.goodsTotal.text = @"¥0.00";
    self.goodsTotal.font = [UIFont systemFontOfSize:14];
    self.goodsTotal.textAlignment = NSTextAlignmentRight;
    self.goodsTotal.textColor = [UIColor getColor:@"f23030"];
    [self.contentView addSubview:self.goodsTotal];
    
    self.freeTitle = [[UILabel alloc] init];
    self.freeTitle.text = @"运费";
    self.freeTitle.font = [UIFont systemFontOfSize:14];
    self.freeTitle.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.freeTitle];
    
    self.freePrice = [[UILabel alloc] init];
    self.freePrice.text = @"¥0.00";
    self.freePrice.font = [UIFont systemFontOfSize:14];
    self.freePrice.textAlignment = NSTextAlignmentRight;
    self.freePrice.textColor = [UIColor getColor:@"f23030"];
    [self.contentView addSubview:self.freePrice];
    
    self.comTitle = [[UILabel alloc] init];
    self.comTitle.text = @"优惠";
    self.comTitle.textColor = [UIColor getColor:@"333333"];
    self.comTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.comTitle];
    
    self.comPrice = [[UILabel alloc] init];
    self.comPrice.textAlignment = NSTextAlignmentRight;
    self.comPrice.textColor = [UIColor getColor:@"f23030"];
    self.comPrice.text = @"¥0.00";
    self.comPrice.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.comPrice];
    
}
-(void)layoutSubviews{
    [self.totalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.contentView).offset(13);
        make.height.equalTo(@14);
    }];
    
    [self.freeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalTitle);
        make.top.equalTo(self.totalTitle.mas_bottom).offset(12);
        make.height.equalTo(@14);
    }];
    
    [self.comTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalTitle);
        make.top.equalTo(self.freeTitle.mas_bottom).offset(12);
        make.height.equalTo(@14);
    }];
    
    [self.goodsTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-13);
        make.baseline.equalTo(self.totalTitle);
    }];
    
    [self.freePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsTotal);
        make.baseline.equalTo(self.freeTitle);
    }];
    
    [self.comPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsTotal);
        make.baseline.equalTo(self.comTitle);
    }];
}
-(void)setTotalMoney:(NSString *)totalMoney{
    _totalMoney = totalMoney;
    if (_totalMoney) {
        self.goodsTotal.text = [NSString stringWithFormat:@"¥%@",totalMoney];

    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
