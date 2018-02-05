//
//  OrderDetailAddressCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/30.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailAddressCell.h"
#import "AddressListModel.h"
@interface OrderDetailAddressCell ()
/** 默认状态 */
@property(nonatomic,strong) UILabel * titleLabel;
/**  送货上门图标 */
@property(nonatomic,strong) UIImageView * addressImg;
/** 送货上门地址 */
@property(nonatomic,strong) UILabel * addressLabel;
/** 送货上门姓名 */
@property(nonatomic,strong) UILabel * nameLabel;
/** 送货上门电话 */
@property(nonatomic,strong) UILabel * phoneLabel;
/** 到店自提距离 */
@property(nonatomic,strong) UILabel * disLabel;
/** 到店自提地址 */
@property(nonatomic,strong) UILabel * shopAddressLabel;
/** 到店自提店名 */
@property(nonatomic,strong) UILabel * shopNameLabel;

@property(nonatomic,strong)UIImageView * returnImg;

@end

@implementation OrderDetailAddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
        self.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initSubviews{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"收货地址";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.addressImg = [[UIImageView alloc] init];
    self.addressImg.image = [UIImage imageNamed:@"addressImg"];
    [self.contentView addSubview:self.addressImg];
    
    self.addressLabel = [[UILabel alloc] init];
    
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    self.addressLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.addressLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] init];
    
    self.phoneLabel.font = [UIFont systemFontOfSize:13];
    self.phoneLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.phoneLabel];
    
    self.returnImg = [[UIImageView alloc] init];
    self.returnImg.image = [UIImage imageNamed:@"returnimg"];
    [self.contentView addSubview:self.returnImg];
    
}
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(10, 14));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg.mas_right).offset(5);
        make.centerY.equalTo(self.addressImg);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg);
        make.top.equalTo(self.addressImg.mas_bottom).offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(20);
    }];
    
    [self.returnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-13);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
}
-(void)UpDataCell:(AddressListModel *)model{
    if (model) {
        self.titleLabel.hidden = YES;
        self.addressImg.hidden = NO;
        self.addressLabel.text = model.address;
        self.nameLabel.text = model.name;
        self.phoneLabel.text = model.phone;
        CGRect frame = [self frame];
        //计算出自适应的高度
        frame.size.height = 70;        
        self.frame = frame;
        
    }else{
        self.titleLabel.hidden = NO;
        self.addressImg.hidden = YES;
        CGRect frame = [self frame];
        frame.size.height = 40;
        
        self.frame = frame;
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
