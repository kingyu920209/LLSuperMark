//
//  ShoppingCarToolView.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/29.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GoOrderDetailBlock) (void);/** 去订单详情 */
typedef void (^SelectAllGoodsBlock) (BOOL select);/** 全选 */
@interface ShoppingCarToolView : UIView

@property(nonatomic,copy)GoOrderDetailBlock goOrderDetailBlock;
@property(nonatomic,copy)SelectAllGoodsBlock selectAllGoodsBlock;
@property(nonatomic,copy)NSString *  totalMoney;
@property(nonatomic,assign)BOOL isSelect;//是否全选;
@property(nonatomic,copy)NSString * selectNum;
@end
