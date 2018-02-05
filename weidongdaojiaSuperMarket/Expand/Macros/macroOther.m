//
//  macroOther.m
//  weidongdaojiaC
//
//  Created by 嘚嘚以嘚嘚 on 2017/7/19.
//  Copyright © 2017年 嘚嘚以嘚嘚. All rights reserved.
//

#import "macroOther.h"
/** 设置视图大小，原点不变 */
void SetViewSize(UIView *view, CGSize size)
{
    CGRect frame = view.frame;
    frame.size = size;
    view.frame = frame;
}

/** 设置视图宽度，其他不变 */
void SetViewSizeWidth(UIView *view, CGFloat width)
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

/** 设置视图高度，其他不变 */
void SetViewSizeHeight(UIView *view, CGFloat height)
{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

/** 设置视图原点，大小不变 */
void SetViewOrigin(UIView *view, CGPoint pt)
{
    CGRect frame = view.frame;
    frame.origin = pt;
    view.frame = frame;
}

/** 设置视图原点x坐标，大小不变 */
void SetViewOriginX(UIView *view, CGFloat x)
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

/** 设置视图原点y坐标，大小不变 */
void SetViewOriginY(UIView *view, CGFloat y)
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

void ApplicationOpenTelWithPhoneNumber(NSString*phoneNum)
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    [[UIApplication sharedApplication]openURL:url];
}
/** 根据字符串、最大尺寸、字体计算字符串最合适尺寸 */
CGSize CGSizeOfString(NSString * text, CGSize maxSize, UIFont * font)
{
    CGSize fitSize;
    if (text.length==0 || !text) {
        fitSize = CGSizeMake(0, 0);
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            fitSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
        } else {
            fitSize = [text sizeWithFont:font constrainedToSize:maxSize];
        }
    }
    return fitSize;
}
void ApplicationIconBadgeNumber(NSInteger num)
{
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:num];
}
