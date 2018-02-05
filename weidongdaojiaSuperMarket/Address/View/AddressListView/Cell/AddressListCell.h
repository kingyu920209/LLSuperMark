//
//  AddressListCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressListModel;
typedef void (^EditAddressBlock) (void);
@interface AddressListCell : UITableViewCell
@property(nonatomic,copy)EditAddressBlock editAddressBlock;
-(void)setModel:(AddressListModel *)model;

@end
