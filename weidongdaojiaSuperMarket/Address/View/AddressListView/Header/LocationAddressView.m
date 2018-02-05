//
//  LocationAddressView.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "LocationAddressView.h"
@interface LocationAddressView ()
@property(nonatomic,strong)UIImageView * locationImg;
@property(nonatomic,strong)UILabel * currentLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@end

@implementation LocationAddressView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor getColor:@"f77f7a"];
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    self.locationImg = [[UIImageView alloc] init];
    self.locationImg.image = [UIImage imageNamed:@"locationAddress"];
    [self addSubview:self.locationImg];
    
    self.currentLabel = [[UILabel alloc] init];
    self.currentLabel.textColor = [UIColor whiteColor];
    self.currentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.currentLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"当前位置";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.titleLabel];
    
}
-(void)layoutSubviews{
    [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(15, 20));
    }];
    
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.locationImg.mas_right).offset(9);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.currentLabel.mas_right).offset(9);
    }];
}
-(void)setLocationAddress:(NSString *)locationAddress{
    _locationAddress = locationAddress;
    if (_locationAddress) {
        self.currentLabel.text = locationAddress;
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
