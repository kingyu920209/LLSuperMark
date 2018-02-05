//
//  NewAddressCell.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/2/1.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAddressCell : UITableViewCell

@property(nonatomic,strong)UITextField * textField;

@property(nonatomic,copy)NSString * placeholderStr;

@property(nonatomic,copy)NSString * titleStr;

@property(nonatomic,assign)BOOL textFieldEnabled;
@end
