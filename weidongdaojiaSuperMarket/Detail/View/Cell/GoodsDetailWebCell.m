//
//  GoodsDetailWebCell.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "GoodsDetailWebCell.h"
@interface GoodsDetailWebCell ()<UIWebViewDelegate>
@property(nonatomic,strong)UIImageView * titleImg;
@property(nonatomic,strong)UIWebView * webView;
@end
@implementation GoodsDetailWebCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews{
    self.titleImg = [[UIImageView alloc]init];
    self.titleImg.image = [UIImage imageNamed:@"titileDetail"];
    [self.contentView addSubview:self.titleImg];
    
    self.webView = [[UIWebView alloc]init];
    self.webView.backgroundColor = [UIColor whiteColor];
    [_webView setOpaque:NO];//opaque是不透明的意思
    [_webView setScalesPageToFit:YES];
    [self.contentView addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.userInteractionEnabled = NO;


}
-(void)layoutSubviews{
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@41);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleImg.mas_bottom);
    }];
}
-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    NSURL * url = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
//        NSLog(@"url: %@", request.URL.absoluteURL.description);
    
    if (self.webView.canGoBack) {
        
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGSize size = [webView sizeThatFits:CGSizeZero];
//    LLog(@"webview:%@",NSStringFromCGSize(size));
//    LLog(@"%f",size.height);
    self.webViewHeightBlock(size.height);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)dealloc{
    LLog(@"web销毁");
    self.webView.delegate = nil;
    self.webView = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
