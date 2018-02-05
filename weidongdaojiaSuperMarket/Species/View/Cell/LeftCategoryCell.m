//
//  LeftCategoryCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/18.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//
#import "LeftCategoryItem.h"
#import "LeftCategoryCell.h"

@interface LeftCategoryCell ()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) UIView * rightView;
@end

@implementation LeftCategoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];

    }
    return self;
}
-(void)initSubviews{

    
    self.contentView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.leftView = [[UIView alloc] init];
    self.leftView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    [self.contentView addSubview:self.leftView];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor getColor:@"dcdcdc"];
    [self.contentView addSubview:self.lineView];
    
    self.rightView = [[UIView alloc]init];
    [self.rightView setBackgroundColor:[UIColor getColor:@"dcdcdc"]];
    [self.contentView addSubview:self.rightView];
    
}
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@4);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@0.5);
    }];
}
-(void)setModel:(LeftCategoryItem *)model{
    self.titleLabel.text = model.title;
}
-(void)setLeftColor:(NSString *)leftColor{
    _leftColor = leftColor;
    self.leftView.backgroundColor = [UIColor getColor:leftColor];
}
-(void)setTitleColor:(NSString *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = [UIColor getColor:titleColor];
}
-(void)setBgColor:(NSString *)bgColor{
    _bgColor = bgColor;
    self.contentView.backgroundColor = [UIColor getColor:bgColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
        self.titleColor = selected?@"8dc445": @"333333";
        self.leftColor = selected?@"8dc445": @"f1f2f6";
        self.bgColor = selected?@"ffffff": @"f1f2f6";
    // Configure the view for the selected state
}

@end
