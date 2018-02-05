//
//  WDGoodsOtherItem.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/15.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDGoodsOtherItem : NSObject


@end
@interface WDGoodsOtherItemDetail : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *title;
/** 原价  */
@property (nonatomic, copy ,readonly) NSString *oprice;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *price;
@end
