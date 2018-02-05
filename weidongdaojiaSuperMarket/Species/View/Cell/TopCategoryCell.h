//
//  TopCategoryCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/18.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftCategoryItem;
@interface TopCategoryCell : UICollectionViewCell
-(void)setModel:(LeftCategoryItem *)model;
@property(nonatomic,copy)NSString * titleColor;
@end
