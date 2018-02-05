//
//  Macros.h
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/9.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define KNotificationCenter [NSNotificationCenter defaultCenter]

#define kWeakSelf(weakSelf) __weak __typeof(self) weakSelf = self;

#define kStrongSelf(strongSelf) __strong __typeof(weakSelf) strongSelf = weakSelf;

#define   WDDJLocalizedString(M)    NSLocalizedStringFromTable(M, @"Localized", nil)



#define KStringIsEmpty(str) ([str  isKindOfClass:[NSNull class]]||str==nil||[str length]<1||str==NULL||[str isEqualToString:@"<null>"]||[str isEqualToString:@"(null)"]||[str isEqualToString:@"-1"]||[str isEqualToString:@"-1.0"]||[str isEqualToString:@"1970-1-1 8:00:00"]?YES:NO)

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width

#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define KGetHeight(h) (h)*(isIPhoneX?736.0:KScreenheight)/1334

#define KGetWight(w) (w)*KScreenWidth/750

#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone5 (KScreenHeight == 568)


#define IPHONENAVIGATIONHEIGHT isIPhoneX?94.0:64.0


#define UIimageWithimageName(str) [UIImage imageNamed:str]

#define PropertyString(s)@property(nonatomic,copy)NSString * s

#define PropertyNSInteger(s)@property(nonatomic,assign)NSIntegers

#define PropertyFloat(s)@property(nonatomic,assign)floats

#define PropertyLongLong(s)@property(nonatomic,assign)long long s

#define PropertyNSDictionary(s)@property(nonatomic,strong)NSDictionary * s

#define PropertyNSArray(s)@property(nonatomic,strong)NSArray * s

#define PropertyNSMutableArray(s)@property(nonatomic,strong)NSMutableArray * s

#define NSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

#ifdef DEBUG

#define LLog(fmt,...)NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);

#else

#define LLog(...)

#endif



#define SafeStr(f)(StrValid(f)?f:@"")

#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f)StrValid(f)

#define ValidDict(f)(f!=nil &&[f isKindOfClass:[NSDictionary class]])

#define ValidArray(f)(f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)

#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])

#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])

#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])

#endif /* Macros_h */
