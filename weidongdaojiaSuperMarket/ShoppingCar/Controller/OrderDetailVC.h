//
//  OrderDetailVC.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/29.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDRootVC.h"
@class GoodsActiveItem;
@interface OrderDetailVC : WDRootVC

@property (strong , nonatomic)NSMutableArray<GoodsActiveItem *> *goodsArray;

@property (nonatomic , copy)NSString * totalMoney;
@end
