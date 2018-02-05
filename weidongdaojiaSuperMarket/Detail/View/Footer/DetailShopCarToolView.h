//
//  DetailShopCarToolView.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GoShopBlock)(void);/** 去购物车 */

@interface DetailShopCarToolView : UIView
@property(nonatomic,copy)GoShopBlock goShopBlock;
/** 商品个数 */
PropertyString(goodsNum);
/** 价钱 */
PropertyString(goodsPrice);
@end
