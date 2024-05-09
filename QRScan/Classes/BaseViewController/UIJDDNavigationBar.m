//
//  UIJDDNavigationBar.m
//  JDMobile
//
//  Created by duying on 14-7-21.
//  Copyright (c) 2014年 duying. All rights reserved.
//

#import "UIJDDNavigationBar.h"
#import "AppDevice.h"

#define k_tag_leftButton               201407211
#define k_tag_rightButton              201407212
#define k_tag_rightLeftButton          201511301
#define k_tag_shareButton              201802061

#define k_tag_titleLabel               201407213
#define k_tag_titleSegmented           201407214
#define k_tag_SegmentedPointLabel      201407215



#define kLeftBtnW 65
#define kLeftBtnH 44

#define kLeftBtnTitleFont 14
#define kTitleLabelX (65)
#define kTitleLabelW (UIScreen_W - kTitleLabelX*2)
#define kOffsetX (16.f)



@implementation UIJDDNavigationBar
    
- (id)initWithTitle:(NSString*)title{
    
    _navBarOriginH = NAVIGATION_TOTAL_HEIGHT;
    _navBtnOriginY = StateBar_H;
    CGRect frame = CGRectMake(0, 0, UIScreen_W, _navBarOriginH);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.backgroundColor = [UIColor clearColor];
    [self setNavigationBarTitle:title];
    [self addNavgationItemLeftButton];
    return self;
}
    
- (void)setNavigationBarTitle:(NSString *)title{
    
    UILabel *label = (UILabel *)[self viewWithTag:k_tag_titleLabel];
    if (nil == label){
        
        UIFont* font = [UIFont systemFontOfSize:17.];
        CGRect rect = CGRectMake(kTitleLabelX, _navBtnOriginY, kTitleLabelW, NAVIGATION_BAR_HEIGHT);
        label = [[UILabel alloc] initWithFrame:rect];
        label.tag = k_tag_titleLabel;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = font;
        label.textColor = [UIColor purpleColor];
        label.text = @"";
        [self addSubview:label];
    }
    label.text = title;
    self.titleLable = label;
}

//默认的左边返回按钮
- (void)addNavgationItemLeftButton{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *imagePressed = [UIImage imageNamed:@"com_icon_backup_u"];
    UIImage *image = [UIImage imageNamed:@"com_icon_backup_u"];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagePressed forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, _navBtnOriginY, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    [self addSubview:button];
    _leftButton = button;
}

- (void)addNavgationItemLeftButtonWithImageName:(NSString*)imageName PressedImgName:(NSString*)pressedImgName
{
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_leftButton];
    if (button)
    {
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *imagePressed = [UIImage imageNamed:pressedImgName];
    UIImage *image = [UIImage imageNamed:imageName];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagePressed forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, _navBtnOriginY, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    [self addSubview:button];
    _leftButton = button;
}
    
- (void)addNavigationItemRightButtonWithText:(NSString *)text textUpColor:(UIColor *)uColor textDownColor:(UIColor *)dColor target:(id)target selector:(SEL)selector{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_rightButton];
    if (button){
        [button removeFromSuperview];
        button = nil;
    }
    
    UIFont *font = [UIFont systemFontOfSize:kLeftBtnTitleFont];
    CGSize size = [self jr_sizeWithFont:font string:text];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_rightButton;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
    [button setTitleColor:uColor forState:UIControlStateNormal];
    [button setTitleColor:dColor forState:UIControlStateHighlighted];
    CGFloat pointW = size.width + kOffsetX*2; // kOffsetX 距离右边间隔
    [button setFrame:CGRectMake(UIScreen_W - pointW, _navBtnOriginY, pointW, NAVIGATION_BAR_HEIGHT)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = font;
    button.backgroundColor = [UIColor clearColor];
    [button setExclusiveTouch:YES];
    [self addSubview:button];
    _rightButton = button;
}
    
-(CGSize)jr_sizeWithFont:(UIFont*)font string:(NSString*)string{
    
    if (!font) {
        return CGSizeMake(0, 0);
    }
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    return CGSizeMake((size.width), (size.height));
}
    
#pragma mark- 响应
- (void)back{
    
    if (self.bar_delegate){
        
        [self.bar_delegate leftButtonDown];
    }
}

@end
