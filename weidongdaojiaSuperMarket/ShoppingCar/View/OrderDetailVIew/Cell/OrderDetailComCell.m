//
//  OrderDetailComCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/30.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailComCell.h"
@interface OrderDetailComCell ()
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * infoLabel;
@property(nonatomic,strong)UIImageView * returnImg;
@end
@implementation OrderDetailComCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = @"优惠券";
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.font = [UIFont systemFontOfSize:14];
    self.infoLabel.text = @"无优惠";
    self.infoLabel.textColor = [UIColor getColor:@"333333"];
    self.infoLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.infoLabel];
    
    self.returnImg = [[UIImageView alloc] init];
    self.returnImg.image = [UIImage imageNamed:@"returnimg"];
    [self.contentView addSubview:self.returnImg];
}
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.returnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-13);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.returnImg.mas_left).offset(-5);
        make.centerY.equalTo(self.contentView);
    }];
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
