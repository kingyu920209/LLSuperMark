//
//  GoodsDetailTitleCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//
#import "GoodsDetailModel.h"
#import "GoodsDetailTitleCell.h"
@interface GoodsDetailTitleCell ()

/** 标题 */
@property(nonatomic,strong)UILabel * titleLabel;
/** 价格 */
@property(nonatomic,strong)UILabel * priceLabel;
/** 原价 */
@property(nonatomic,strong)UILabel * opriceLabel;

@property(nonatomic,strong)UIView * lineView;

@end

@implementation GoodsDetailTitleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.priceLabel setTextColor:[UIColor getColor:@"333333"]];
    [self.contentView addSubview:self.priceLabel];
    
    self.opriceLabel = [[UILabel alloc]init];
    self.opriceLabel.font = [UIFont systemFontOfSize:12];
    self.opriceLabel.textColor = [UIColor getColor:@"9e9e9e"];
    [self.contentView addSubview:self.opriceLabel];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor getColor:@"dcdcdc"];
    [self.contentView addSubview:self.lineView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.right.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(10);
        make.height.equalTo(@16);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(19);
        make.height.equalTo(@24);
    }];
    
    [self.opriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        make.baseline.equalTo(self.priceLabel);
        make.height.equalTo(@12);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}
-(void)setUpData:(GoodsDetailModel *)model{
    self.titleLabel.text = model.title;
    self.priceLabel.text = model.price;
    NSUInteger length = [model.oprice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:model.oprice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor getColor:@"9e9e9e"] range:NSMakeRange(0, length)];
    [self.opriceLabel setAttributedText:attri];
    
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
