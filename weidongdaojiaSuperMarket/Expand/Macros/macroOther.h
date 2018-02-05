//
//  macroOther.h
//  weidongdaojiaC
//
//  Created by 嘚嘚以嘚嘚 on 2017/7/19.
//  Copyright © 2017年 嘚嘚以嘚嘚. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 设置视图大小，原点不变 */
extern void SetViewSize(UIView *view, CGSize size);

void SetViewSizeWidth(UIView *view, CGFloat width);

void SetViewSizeHeight(UIView *view, CGFloat height);

void SetViewOrigin(UIView *view, CGPoint pt);


/** 设置视图原点x坐标，大小不变 */
extern void SetViewOriginX(UIView *view, CGFloat x);
/** 设置视图原点y坐标，大小不变 */
extern void SetViewOriginY(UIView *view, CGFloat y);

extern void ApplicationOpenTelWithPhoneNumber(NSString*phoneNum);

/** 根据字符串、最大尺寸、字体计算字符串最合适尺寸 */
extern CGSize CGSizeOfString(NSString * text, CGSize maxSize, UIFont * font);
