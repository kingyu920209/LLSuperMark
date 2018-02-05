//
//  GoodsDetailWebCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WebViewHeightBlock)(CGFloat height);
@interface GoodsDetailWebCell : UITableViewCell
@property(nonatomic,copy)NSString * urlStr;
@property(nonatomic,copy)WebViewHeightBlock webViewHeightBlock;
@end
