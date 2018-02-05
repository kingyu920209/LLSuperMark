//
//  NewPhoneAndNameCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/2/1.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "NewPhoneAndNameCell.h"
@interface NewPhoneAndNameCell ()
@property(nonatomic,strong)UIView * rightView;
@property(nonatomic,strong)UIImageView * addressBookImg;
@property(nonatomic,strong)UILabel * addressBookLabel;
@property(nonatomic,strong)UIButton * addressBookBtn;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * phoneLabel;
@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UIView * lineView;

@end

@implementation NewPhoneAndNameCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellStyleDefault;
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.rightView = [[UIView alloc] init];
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.rightView];
    
    self.addressBookImg = [[UIImageView alloc] init];
    self.addressBookImg.image = [UIImage imageNamed:@"addressBook"];
    [self.contentView addSubview:self.addressBookImg];
    
    self.addressBookLabel = [[UILabel alloc] init];
    self.addressBookLabel.text = @"快速查找";
    self.addressBookLabel.textColor = [UIColor getColor:@"333333"];
    self.addressBookLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.addressBookLabel];
    
    self.addressBookBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.addressBookBtn];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor getColor:@"dedede"];
    [self.contentView addSubview:self.lineView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor =[UIColor getColor:@"333333"];
    self.nameLabel.text = @"联系人：";
    [self.contentView addSubview:self.nameLabel];
    
    self.nameField = [[UITextField alloc] init];
    self.nameField.placeholder = @"收货人姓名";
    self.nameField.textColor = [UIColor getColor:@"333333"];
    [self.nameField setValue:[UIColor getColor:@"bfbfbf"] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameField.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameField];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.font = [UIFont systemFontOfSize:14];
    self.phoneLabel.textColor = [UIColor getColor:@"333333"];
    self.phoneLabel.text = @"手机号：";
    [self.contentView addSubview:self.phoneLabel];
    
    self.phoneField = [[UITextField alloc] init];
    self.phoneField.placeholder = @"收货人手机号";
    self.phoneField.textColor = [UIColor getColor:@"333333"];
    [self.phoneField setValue:[UIColor getColor:@"bfbfbf"] forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneField.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.phoneField];

}
-(void)layoutSubviews{
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self.contentView);
        make.width.equalTo(@110);
    }];
    
    [self.addressBookImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightView);
        make.top.equalTo(self.rightView).offset(30);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [self.addressBookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightView);
        make.top.equalTo(self.addressBookImg.mas_bottom).offset(10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.rightView.mas_left);
    }];
    [self.addressBookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.rightView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.lineView.mas_top);
        make.width.equalTo(@60);
    }];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.rightView.mas_left);
        make.top.bottom.equalTo(self.nameLabel);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(@60);

    }];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right);
        make.right.equalTo(self.rightView.mas_left);
        make.top.bottom.equalTo(self.phoneLabel);
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
