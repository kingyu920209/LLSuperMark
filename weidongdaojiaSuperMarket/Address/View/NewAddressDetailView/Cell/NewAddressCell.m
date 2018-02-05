
//
//  NewAddressCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/2/1.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "NewAddressCell.h"
@interface NewAddressCell ()
@property(nonatomic,strong)UIImageView * returnImg;
@property(nonatomic,strong)UILabel * titleLabel;
@end
@implementation NewAddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellStyleDefault;
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    
    self.returnImg = [[UIImageView alloc] init];
    self.returnImg.image = [UIImage imageNamed:@"returnimg"];
    [self.contentView addSubview:self.returnImg];
    
    self.textField = [[UITextField alloc]init];
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textColor = [UIColor getColor:@"333333"];
    [self.textField setValue:[UIColor getColor:@"bfbfbf"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:self.textField];
    
}
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@75);
    }];
    
    [self.returnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-13);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.returnImg.mas_left);
        make.top.bottom.equalTo(self.contentView);
    }];
    
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    if (_titleStr) {
        self.titleLabel.text = titleStr;
    }
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _placeholderStr = placeholderStr;
    if (_placeholderStr) {
        self.textField.placeholder = placeholderStr;
    }
}
-(void)setTextFieldEnabled:(BOOL)textFieldEnabled{
    _textFieldEnabled = textFieldEnabled;
    if (!_textFieldEnabled) {
        self.textField.userInteractionEnabled = textFieldEnabled;
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
