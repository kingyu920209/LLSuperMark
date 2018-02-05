//
//  AddressPickerView.h
//  weidongdaojiaC
//
//  Created by 嘚嘚以嘚嘚 on 2017/11/8.
//  Copyright © 2017年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressPickerView : UIView
-(instancetype)initWithTWFrame:(CGRect)rect TWselectCityTitle:(NSString*)title;

/**
 *  显示
 */
-(void)showCityView:(void(^)(NSString *proviceStr,NSString *cityStr,NSString *distr))selectStr;


@end
