//
//  AddressListCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "AddressListCell.h"
#import "AddressListModel.h"
@interface AddressListCell ()
/** 送货上门地址 */
@property(nonatomic,strong) UILabel * addressLabel;
/** 送货上门姓名 */
@property(nonatomic,strong) UILabel * nameLabel;
/** 送货上门电话 */
@property(nonatomic,strong) UILabel * phoneLabel;

@property(nonatomic,strong)UIButton * returnBtn;

@end

@implementation AddressListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellStyleDefault;
        [self initSubview];
    }
    return self;
}
-(void)initSubview{
    self.addressLabel = [[UILabel alloc] init];
    
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    self.addressLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.addressLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] init];
    
    self.phoneLabel.font = [UIFont systemFontOfSize:14];
    self.phoneLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.phoneLabel];
    
    self.returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.returnBtn setImage:[UIImage imageNamed:@"editAddress"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.returnBtn];
    self.returnBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        self.editAddressBlock();
        return [RACSignal empty];
    }];
}
-(void)layoutSubviews{
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.contentView).offset(15);
        make.height.equalTo(@13);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(20);
    }];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];

}
-(void)setModel:(AddressListModel *)model{
    self.addressLabel.text = model.address;
    self.nameLabel.text = model.name;
    self.phoneLabel.text = model.phone;
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
