//
//  GoodsShopCarToolView.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/17.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GoShopBlock)(void);/** 去购物车 */
typedef void (^GoSumBlock)(void);/** 去结算 */
@interface GoodsShopCarToolView : UIView
@property(nonatomic,copy)GoShopBlock goShopBlock;
@property(nonatomic,copy)GoSumBlock goSumBlock;
/** 商品个数 */
PropertyString(goodsNum);
/** 价钱 */
PropertyString(goodsPrice);
@end
