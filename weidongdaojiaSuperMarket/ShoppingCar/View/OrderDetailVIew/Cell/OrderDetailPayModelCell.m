//
//  OrderDetailPayModelCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/30.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailPayModelCell.h"
@interface OrderDetailPayModelCell ()
@property(nonatomic,strong)UIImageView *titleImg;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIImageView * selectImg;
@end

@implementation OrderDetailPayModelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    self.titleImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.titleImg];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.titleLabel];

    self.selectImg = [[UIImageView alloc] init];
    self.selectImg.image = [UIImage imageNamed:@"noSelectGoods"];
    [self.contentView addSubview:self.selectImg];
//    self.selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.selectBtn setImage:[UIImage imageNamed:@"selectGoods"] forState:(UIControlStateSelected)];
//    [self.selectBtn setImage:[UIImage imageNamed:@"noSelectGoods"] forState:(UIControlStateNormal)];
//    [self.contentView addSubview:self.selectBtn];
}
-(void)layoutSubviews{
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImg.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
}
-(void)setImgStr:(NSString *)imgStr{
    _imgStr = imgStr;
    if (_imgStr) {
        self.titleImg.image = [UIImage imageNamed:imgStr];
    }
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    if (_titleStr) {
        self.titleLabel.text = titleStr;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectImg.image = [UIImage imageNamed:@"selectGoods"];

    }else{
        self.selectImg.image = [UIImage imageNamed:@"noSelectGoods"];

    }
    // Configure the view for the selected state
}

@end
