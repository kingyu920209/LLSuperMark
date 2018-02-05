//
//  GoodsActiveHeaderView.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/16.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsActiveHeaderView : UITableViewHeaderFooterView
PropertyString(banerURL);
PropertyString(imageURL);
+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
