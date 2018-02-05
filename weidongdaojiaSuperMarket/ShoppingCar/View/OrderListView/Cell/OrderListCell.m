//
//  OrderListCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderListCell.h"
#import "GoodsActiveItem.h"
@interface OrderListCell ()
@property (nonatomic , strong) UIImageView * titleImg;//图片
@property (nonatomic , strong) UILabel * titleLabel;//标题
@property (nonatomic , strong) UILabel * guigeLabel;//规格
@property (nonatomic , strong) UILabel * priceLabel;//价格
@property (nonatomic , strong) UILabel * oPriceLabel;//原价
@property (nonatomic , strong) UIView * lineView;//底部横线
@end

@implementation OrderListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews{
    self.titleImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImg];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.guigeLabel = [[UILabel alloc] init];
    self.guigeLabel.font = [UIFont systemFontOfSize:13];
    self.guigeLabel.textColor = [UIColor getColor:@"777777"];
    [self.contentView addSubview:self.guigeLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:18];
    self.priceLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.priceLabel];
    
    self.oPriceLabel = [[UILabel alloc]init];
    self.oPriceLabel.font = [UIFont systemFontOfSize:13];
    self.oPriceLabel.textColor = [UIColor getColor:@"9e9e9e"];
    [self.contentView addSubview:self.oPriceLabel];
    
    self.lineView=  [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor getColor:@"f1f1f1"];
    [self.contentView addSubview:self.lineView];
}
-(void)layoutSubviews{
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@((self.contentView.frame.size.height-20)*110/85));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImg.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(19);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@14);
    }];
    
    [self.guigeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
        make.height.equalTo(@13);
        
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.guigeLabel.mas_bottom).offset(13);
        make.height.equalTo(@18);
        
    }];
    
    [self.oPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel);
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        make.height.equalTo(@13);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12);
        make.height.equalTo(@0.5);
    }];
}
-(void)setModel:(GoodsActiveItem *)model{
    
    self.titleLabel.text = model.title;
    self.guigeLabel.text = model.guige;
    self.priceLabel.text = model.price;
    
    NSUInteger length = [model.oprice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:model.oprice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor getColor:@"9e9e9e"] range:NSMakeRange(0, length)];
    [self.oPriceLabel setAttributedText:attri];
    
    
    if (model.iconImage.length == 0) return;
    if ([[model.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        self.titleImg.image = [UIImage imageNamed:model.iconImage];
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
