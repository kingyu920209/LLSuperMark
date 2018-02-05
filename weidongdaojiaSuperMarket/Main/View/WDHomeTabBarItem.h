//
//  WDHomeTabBarItem.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDAnimTabBarItem.h"
extern NSString * const NOTIFICATION_NAME_HOME_PAGE_DID_LOAD_DATA;

typedef NS_ENUM(NSUInteger, HomeTabBarItemStatus) {
    HomeTabBarItemStatusWeather = 0,
    HomeTabBarItemStatusReading = 1,
    HomeTabBarItemStatusNeedsRefresh = 2,
};
@interface WDHomeTabBarItem : WDAnimTabBarItem
@property (assign, nonatomic) HomeTabBarItemStatus itemStatus;

@end
