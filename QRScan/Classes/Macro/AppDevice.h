//
//  AppDevice.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//
//设备定义

#ifndef app_AppDevice_h
#define app_AppDevice_h

#define Screeen_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480)
#define Screeen_4_0_INCH ([[UIScreen mainScreen] bounds].size.height >= 568)

#define kMainScreenW   ([[UIScreen mainScreen] bounds].size.width)
#define kMainScreenH   ([[UIScreen mainScreen] bounds].size.height)

#define kBlueColor            @"#508CEE"
#define kBlueColorHighlighted @"#4B84E1"
#define kIousBlueColor kBlueColor
#define kLineColor     @"#dddddd"     // 线的颜色

//线的高度 (h)像素的高度
#define SINGLE_LINE_HEIGHT(h)           (h / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET(h)    ((h / [UIScreen mainScreen].scale) / 2)

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)


#define kNaviBarHeight 44.f
#define kNaviTextColor [UIColor whiteColor]
#define kStateBarHeight 20.f


//判断当前版本是否等于某个版本
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] \
compare:v options:NSNumericSearch] == NSOrderedSame)

//判断两个版本是否大于某个版本
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] \
compare:v options:NSNumericSearch] == NSOrderedDescending)

//判断两个版本是否大于或等于某个版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] \
compare:v options:NSNumericSearch] != NSOrderedAscending)

//判断两个版本是否小于或等于某个版本
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] \
compare:v options:NSNumericSearch] != NSOrderedDescending)


#define IOS7 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
#define IOS8 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
#define IOS9 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
#define IOS10 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))

#ifdef DEBUG
#define isdebug YES
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#define isdebug NO
#endif


#define kLineColor @"#dddddd"
#define kNaviBarColor @"#35343a" // 黑色

// 判断iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//判断itouch
#define iPod_touch [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]
#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

//版本
#define JDBT_version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kUserPassword @"kUserPassword"

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6PlusBigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define kHomeBarH ((iPhoneX || iPhoneXR || iPhoneXSMax)?34:0)


#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define kStatusBarH              (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define StateBar_H               (kStatusBarH ? kStatusBarH : ((iPhoneX || iPhoneXR || iPhoneXSMax)?44:20))
#define NAVIGATION_BAR_HEIGHT    (44)
#define NAVIGATION_TOTAL_HEIGHT  (StateBar_H + NAVIGATION_BAR_HEIGHT)
#define UIScreen_W CGRectGetWidth([[UIScreen mainScreen] bounds])
#define UIScreen_H CGRectGetHeight([[UIScreen mainScreen] bounds])

#endif








