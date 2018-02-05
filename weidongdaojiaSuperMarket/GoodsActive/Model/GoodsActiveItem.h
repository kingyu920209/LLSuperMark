//
//  GoodsActiveItem.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/16.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsActiveItem : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *title;
/** 原价  */
@property (nonatomic, copy ,readonly) NSString *oprice;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *price;
/** 商品ID  */
@property (nonatomic, copy ,readonly)NSString * orderID;
/** 商品数量  */
@property (nonatomic, copy)NSString * goodsNum;
/** 是否选中  */
@property (nonatomic, assign)BOOL  goodsSelect;
/** 规格  */
@property (nonatomic, copy ,readonly)NSString * guige;
@end
