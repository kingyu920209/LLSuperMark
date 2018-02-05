//
//  WDGoodsOtherCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/15.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReduceNumBlock)(NSString * num);
typedef void (^AddNumBlock)(NSString * num);

@class GoodsActiveItem;
@interface WDGoodsOtherCell : UICollectionViewCell
@property (strong , nonatomic)GoodsActiveItem *otherItem;
@property(nonatomic,copy)ReduceNumBlock reduceNumBlock;
@property(nonatomic,copy)AddNumBlock addNumBlock;
@end
