//
//  LeftCategoryCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/18.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftCategoryItem;
@interface LeftCategoryCell : UITableViewCell
-(void)setModel:(LeftCategoryItem *)model;
PropertyString(titleColor);
PropertyString(bgColor);
PropertyString(leftColor);
@end
