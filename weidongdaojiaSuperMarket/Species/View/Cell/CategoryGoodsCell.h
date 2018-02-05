//
//  CategoryGoodsCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsActiveItem.h"
@class LeftCategoryItem;
typedef void (^ReduceNumBlock)(NSString * num);
typedef void (^AddNumBlock)(NSString * num);

@interface CategoryGoodsCell : UICollectionViewCell
-(void)setModel:(GoodsActiveItem *)model;
@property(nonatomic,copy)ReduceNumBlock reduceNumBlock;
@property(nonatomic,copy)AddNumBlock addNumBlock;
@end
