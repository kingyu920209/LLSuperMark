//
//  GoodsActiveCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/16.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 添加 */
typedef void (^AddNumBlock)(NSString * num);
/** 减少 */
typedef void (^ReduceNumBlock)(NSString * num);
@class GoodsActiveItem;
@interface GoodsActiveCell : UITableViewCell
@property(nonatomic,copy)AddNumBlock addNumBlock;
@property(nonatomic,copy)ReduceNumBlock reduceNumBlock;
-(void)setModel:(GoodsActiveItem *)model;

@end
