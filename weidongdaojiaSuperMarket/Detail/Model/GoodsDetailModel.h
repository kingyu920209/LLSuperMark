//
//  GoodsDetailModel.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject
/** 标题 */
PropertyString(title);
/** 价格 */
PropertyString(price);
/** 原价 */
PropertyString(oprice);
/** 品牌 */
PropertyString(brand);
/** 产品规格 */
PropertyString(specification);
/** 保质期 */
PropertyString(shelfLife);
/** 标题高度 */
@property(nonatomic,assign)float titleHeight;
/** 参数高度 */
@property(nonatomic,assign)float infoHeight;
@property(nonatomic,assign)float slidesHeight;


@end
