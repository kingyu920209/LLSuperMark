//
//  GoodsActiveCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/16.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "GoodsActiveCell.h"
#import "GoodsActiveItem.h"
@interface GoodsActiveCell ()
@property (nonatomic , strong) UIImageView * titleImg;//图片
@property (nonatomic , strong) UILabel * titleLabel;//标题
@property (nonatomic , strong) UILabel * guigeLabel;//规格
@property (nonatomic , strong) UILabel * priceLabel;//价格
@property (nonatomic , strong) UILabel * oPriceLabel;//原价
@property (nonatomic , strong) UIView * lineView;//底部横线
@property (nonatomic , strong) UIButton * addBtn;//添加按钮
/* 减少按钮 */
@property (strong , nonatomic)UIButton * reduceBtn;
/* 显示个数 */
@property (strong , nonatomic)UILabel * numLable;

@property (assign , nonatomic)NSInteger  num;

@end

@implementation GoodsActiveCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews{
    self.num = 0;
    self.titleImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImg];
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.backgroundColor = self.backgroundColor;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.guigeLabel = [[UILabel alloc] init];
    self.guigeLabel.backgroundColor = self.backgroundColor;
    self.guigeLabel.font = [UIFont systemFontOfSize:13];
    self.guigeLabel.textColor = [UIColor getColor:@"777777"];
    [self.contentView addSubview:self.guigeLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.backgroundColor = self.backgroundColor;
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
    
    self.addBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
    self.addBtn.showsTouchWhenHighlighted = YES;
    [self.contentView addSubview:self.addBtn];
    
    self.reduceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.reduceBtn setBackgroundImage:[UIImage imageNamed:@"reduce"] forState:(UIControlStateNormal)];
    self.reduceBtn.hidden = YES;
    self.reduceBtn.showsTouchWhenHighlighted = YES;
    [self addSubview:self.reduceBtn];
    
    self.numLable = [[UILabel alloc] init];
    self.numLable.textColor = [UIColor getColor:@"333333"];
    self.numLable.hidden = YES;
    self.numLable.textAlignment = NSTextAlignmentCenter;
    self.numLable.layer.masksToBounds = YES;
    self.numLable.layer.borderWidth = 0.5;
    self.numLable.layer.borderColor =[UIColor getColor:@"9e9e9e"].CGColor;
    self.numLable.layer.cornerRadius =10;
    [self addSubview:self.numLable];
    kWeakSelf(weakSelf);
    self.addBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        weakSelf.num++;
        weakSelf.numLable.text =[NSString stringWithFormat:@"%ld",weakSelf.num];
        if (weakSelf.num>0) {
            weakSelf.reduceBtn.hidden=NO;
            weakSelf.numLable.hidden=NO;
            
        }
        weakSelf.addNumBlock([NSString stringWithFormat:@"%ld",(long)weakSelf.num]);

        
        return [RACSignal empty];
    }];
    self.reduceBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        weakSelf.num--;
        weakSelf.numLable.text =[NSString stringWithFormat:@"%ld",weakSelf.num];
        if (weakSelf.num<=0) {
            weakSelf.reduceBtn.hidden=YES;
            weakSelf.numLable.hidden=YES;
            
        }
        weakSelf.reduceNumBlock([NSString stringWithFormat:@"%ld",(long)weakSelf.num]);
        
        return [RACSignal empty];
    }];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
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
    
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.priceLabel);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.addBtn);
        make.right.equalTo(self.addBtn.mas_left).offset(-5);
        make.width.equalTo(@44);
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLable.mas_left).offset(-5);
        make.bottom.equalTo(self.priceLabel);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

}
-(void)setModel:(GoodsActiveItem *)model{
    self.num = [model.goodsNum integerValue];
    self.titleLabel.text = model.title;
    self.guigeLabel.text = model.guige;
    self.priceLabel.text =[NSString stringWithFormat:@"¥%@",model.price] ;
    NSMutableAttributedString * priceString = [[NSMutableAttributedString alloc]initWithString:self.priceLabel.text];
    NSRange priceRange = [[priceString string]rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]];
    [priceString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:priceRange];
    self.priceLabel.attributedText = priceString;
    
    
    NSUInteger length = [model.oprice length]+1;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.oprice]];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor getColor:@"9e9e9e"] range:NSMakeRange(0, length)];
    [self.oPriceLabel setAttributedText:attri];
    
    
    if (model.iconImage.length == 0) return;
    if ([[model.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        self.titleImg.image = [UIImage imageNamed:model.iconImage];
    }
    self.numLable.text = [NSString stringWithFormat:@"%ld",(long)self.num];
    if ([model.goodsNum integerValue]>=1) {
        self.reduceBtn.hidden=NO;
        self.numLable.hidden=NO;
    }else{
        self.reduceBtn.hidden=YES;
        self.numLable.hidden=YES;
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
