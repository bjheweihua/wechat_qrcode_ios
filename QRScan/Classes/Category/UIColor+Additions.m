//
//  UIColor+Additions.m
//  JDMobile
//
//  Created by heweihua on 13-8-2.
//  Copyright (c) 2013年 jd. All rights reserved.
//

#import "UIColor+Additions.h"
#import "AppDevice.h"

@implementation UIColor (Additions)

+ (UIColor *)jrColorWithHex:(NSString *)hexColor
{
    if (hexColor.length == 7)
    {
        unsigned int red, green, blue;
        NSRange range;
        range.length = 2;
        
        range.location = 1;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 3;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 5;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
    }
    else if (hexColor.length == 9)
    {
        unsigned int red, green, blue, al;
        NSRange range;
        range.length = 2;
        
        range.location = 1;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&al];
        range.location = 3;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 5;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 7;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        return [self jrColorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:al/255.0f];
    }
    else
    {
        return [UIColor blackColor];
    }
}

+ (UIColor *)jrColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    if (IOS10)
        return [UIColor colorWithDisplayP3Red:red green:green blue:blue alpha:alpha];
    else
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)jrColor:(UIColor *)color_ withAlpha:(float)alpha_
{
    UIColor *uicolor = color_;
    CGColorRef colorRef = [uicolor CGColor];
    
    size_t numComponents = CGColorGetNumberOfComponents(colorRef);
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    //    CGFloat alpha = 0.0;
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(colorRef);
        red = components[0];
        green = components[1];
        blue = components[2];
        //        alpha = components[3];
    }
    
    return [self jrColorWithRed:red green:green blue:blue alpha:alpha_];
}

+ (UIColor *)jrColorWithHex:(NSString *)hexColor withAlpha:(float)alpha_
{
    if (hexColor.length != 7)
        return [UIColor blackColor];
    UIColor * color = [UIColor jrColorWithHex:hexColor];
    return [UIColor jrColor:color withAlpha:alpha_];
}



@end
