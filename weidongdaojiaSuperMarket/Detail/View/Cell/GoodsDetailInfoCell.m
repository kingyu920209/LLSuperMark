//
//  GoodsDetailInfoCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

CGFloat const leftLayout = 12;

#import "GoodsDetailModel.h"
#import "GoodsDetailInfoCell.h"
@interface GoodsDetailInfoCell ()
/** 标题 */
@property(nonatomic,strong)UILabel *titleLabel;
/** 品牌 */
@property(nonatomic,strong)UILabel *brandLabel;
/** 产品规格 */
@property(nonatomic,strong)UILabel *specificationLabel;
/** 保质期 */
@property(nonatomic,strong)UILabel *shelfLifeLabel;

@property(nonatomic,strong)UIView * lineView;

@end

@implementation GoodsDetailInfoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor getColor:@"9e9e9e"];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.text = @"产品参数";
    [self.contentView addSubview:self.titleLabel];
    
    self.brandLabel = [[UILabel alloc] init];
    self.brandLabel.textColor = [UIColor getColor:@"333333"];
    self.brandLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.brandLabel];
    
    self.specificationLabel = [[UILabel alloc] init];
    self.specificationLabel.textColor = [UIColor getColor:@"333333"];
    self.specificationLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.specificationLabel];
    
    self.shelfLifeLabel = [[UILabel alloc] init];
    self.shelfLifeLabel.textColor = [UIColor getColor:@"333333"];
    self.shelfLifeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.shelfLifeLabel];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor getColor:@"dcdcdc"];
    [self.contentView addSubview:self.lineView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(leftLayout);
        make.top.equalTo(self.contentView).offset(10);
        make.height.equalTo(@13);
    }];
    
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.height.equalTo(@13);
    }];
    
    [self.specificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.brandLabel.mas_bottom).offset(10);
        make.height.equalTo(@13);
    }];
    
    [self.shelfLifeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.specificationLabel.mas_bottom).offset(10);
        make.height.equalTo(@13);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}
-(void)setUpData:(GoodsDetailModel *)model{
//    [NSString stringWithFormat:@"品牌：%@",]
    
    self.brandLabel.text = [NSString stringWithFormat:@"品       牌：%@",model.brand];
    self.specificationLabel.text = [NSString stringWithFormat:@"产品规格：%@",model.specification];
    self.shelfLifeLabel.text = [NSString stringWithFormat:@"保质日期：%@",model.shelfLife];

}
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
    
}
- (NSAttributedString*)changeWordSpaceForLabel:(NSString *)string WithSpace:(float)space {
    
//    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, [string length]);

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;

    
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
