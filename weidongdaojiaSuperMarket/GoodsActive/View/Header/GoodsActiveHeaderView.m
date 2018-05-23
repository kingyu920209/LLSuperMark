//
//  GoodsActiveHeaderView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/16.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "GoodsActiveHeaderView.h"
@interface GoodsActiveHeaderView ()
@property(nonatomic,strong)UIImageView * banerImageView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIView * bottomView;

@end
static NSString * const headerViewID  = @"GoodsActiveHeaderView";

@implementation GoodsActiveHeaderView
+(instancetype)headerViewWithTableView:(UITableView *)tableView
{
    GoodsActiveHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (!headerView) {
        headerView = [[GoodsActiveHeaderView alloc]initWithReuseIdentifier:headerViewID];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self customUI];
    }
    
    return self;
}
- (void)customUI
{
//    self.backgroundColor = [UIColor getColor:@"fafafa"];
    self.banerImageView = [[UIImageView alloc]init];
    [self addSubview:self.banerImageView];
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor getColor:@"fafafa"];
    [self addSubview:self.bottomView];
    
    self.imageView = [[UIImageView alloc] init];
//    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.bottomView addSubview:self.imageView];
}
-(void)layoutSubviews{
    [self.banerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(238));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.banerImageView.mas_bottom);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(124, 15));
    }];
}
-(void)setBanerURL:(NSString *)banerURL{
    _banerURL = banerURL;
    if ([[banerURL substringToIndex:4] isEqualToString:@"http"]) {
        [self.banerImageView sd_setImageWithURL:[NSURL URLWithString:banerURL]placeholderImage:[UIImage imageNamed:@"default_49_11"]];

    }else{
        self.banerImageView.image = [UIImage imageNamed:banerURL];

    }

}
-(void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    if ([[imageURL substringToIndex:4] isEqualToString:@"http"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
        
    }else{
//        imageWithContentsOfFile
//      self.imageView.image=  [UIImage imageWithContentsOfFile: [[NSBundle mainBundle]pathForResource:imageURL ofType:@"png"]];

        self.imageView.image = [UIImage imageNamed:imageURL];
        
    }
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
