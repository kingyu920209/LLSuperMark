//
//  OrderDetailImgCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/30.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailImgCell.h"
#import "GoodsActiveItem.h"
@interface OrderDetailImgCell ()
@property(nonatomic,strong)UIImageView * oneImg;//第一个图片
@property(nonatomic,strong)UIImageView * twoImg;//第二个图片
@property(nonatomic,strong)UIImageView * threeImg;//第三个图片
@property(nonatomic,strong)UILabel * titleLabel;//标题
@property(nonatomic,strong)UILabel * guigeLabel;//规格
@property(nonatomic,strong)UIImageView * returnImg;
@property(nonatomic,strong)UILabel * totalGoodsLabel;//共多少件

@end
@implementation OrderDetailImgCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    self.oneImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.oneImg];
    
    self.twoImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.twoImg];
    
    self.threeImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.threeImg];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = @"德国进口牛奶";
    [self.contentView addSubview:self.titleLabel];
    
    self.guigeLabel = [[UILabel alloc] init];
    self.guigeLabel.textColor = [UIColor getColor:@"777777"];
    self.guigeLabel.font = [UIFont systemFontOfSize:13];
    self.guigeLabel.text = @"100g*10";
    [self.contentView addSubview:self.guigeLabel];
    
    self.returnImg = [[UIImageView alloc] init];
    self.returnImg.image = [UIImage imageNamed:@"returnimg"];
    [self.contentView addSubview:self.returnImg];
    
    self.totalGoodsLabel = [[UILabel alloc] init];
    self.totalGoodsLabel.textColor = [UIColor getColor:@"333333"];
    self.totalGoodsLabel.font = [UIFont systemFontOfSize:13];
    self.totalGoodsLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.totalGoodsLabel];
}
-(void)layoutSubviews{
    [self.oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(73, 56));
    }];
    
    [self.twoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneImg.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(self.oneImg);
    }];
    
    [self.threeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoImg.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(self.twoImg);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneImg.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(20);
        make.height.equalTo(@14);
    }];
    
    [self.guigeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.returnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-13);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
    
    [self.totalGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.returnImg);
        make.right.equalTo(self.returnImg.mas_left).offset(-5);
    }];
}
-(void)setImgArray:(NSArray *)imgArray{
    _imgArray = imgArray;
    if (_imgArray) {
        GoodsActiveItem * oneitem =[imgArray firstObject];
        [self.oneImg sd_setImageWithURL:[NSURL URLWithString:oneitem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];

        if (_imgArray.count>1) {
            if (imgArray.count>=3) {
                GoodsActiveItem * threeitem =imgArray[2];
                [self.threeImg sd_setImageWithURL:[NSURL URLWithString:threeitem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
                
            }
            self.totalGoodsLabel.text = [NSString stringWithFormat:@"共%lu件",(unsigned long)imgArray.count];
            GoodsActiveItem * twoitem =imgArray[1];
            [self.twoImg sd_setImageWithURL:[NSURL URLWithString:twoitem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
            
            self.twoImg.hidden = NO;
            self.threeImg.hidden = NO;
            self.titleLabel.hidden = YES;
            self.guigeLabel.hidden = YES;
        }else{
            self.titleLabel.text = oneitem.title;
            self.guigeLabel.text = oneitem.guige;
            self.twoImg.hidden = YES;
            self.threeImg.hidden = YES;
            self.titleLabel.hidden = NO;
            self.guigeLabel.hidden = NO;
        }
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
