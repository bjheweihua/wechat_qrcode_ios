//
//  UIColor+Additions.h
//  JDMobile
//
//  Created by heweihua on 13-8-2.
//  Copyright (c) 2013年 jd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)jrColorWithHex:(NSString *)hexColor;//7 9(argb)
+ (UIColor *)jrColorWithHex:(NSString *)hexColor withAlpha:(float)alpha_;//7
+ (UIColor *)jrColor:(UIColor *)color_ withAlpha:(float)alpha_;

@end
