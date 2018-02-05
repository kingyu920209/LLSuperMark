//
//  AddressListVC.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDRootVC.h"
@class AddressListModel;

typedef void (^AddressModelBlock) (AddressListModel * model);

@interface AddressListVC : WDRootVC
@property(nonatomic,copy)AddressModelBlock addressModelBlock;
@end
