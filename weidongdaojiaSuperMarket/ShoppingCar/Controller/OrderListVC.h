//
//  OrderListVC.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDRootVC.h"
@class GoodsActiveItem;
@interface OrderListVC : WDRootVC
@property (strong , nonatomic)NSMutableArray<GoodsActiveItem *> *goodsArray;

@end
