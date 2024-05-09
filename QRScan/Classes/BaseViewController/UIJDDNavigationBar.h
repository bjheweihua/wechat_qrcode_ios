//
//  UIJDDNavigationBar.h
//  JDMobile
//
//  Created by duying on 14-7-21.
//  Copyright (c) 2014年 duying. All rights reserved.
//

#import <UIKit/UIKit.h>

#define knavigationBarTitleFontSize 17

@protocol UIJDDNavigationBarDelegate <NSObject>
- (void)leftButtonDown;
@end

@interface UIJDDNavigationBar : UIView{
    
    CGFloat _navBarOriginH;
}
@property (nonatomic, weak) id<UIJDDNavigationBarDelegate>  bar_delegate;
@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, assign) CGFloat navBtnOriginY;
@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIButton *rightLeftButton;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, strong) UIView *navBotLine;

- (id)initWithTitle:(NSString*)title;

//默认的左边返回按钮
- (void)addNavgationItemLeftButtonWithImageName:(NSString*)imageName PressedImgName:(NSString*)pressedImgName;

//定制右侧按钮
- (void)addNavigationItemRightButtonWithText:(NSString *)text textUpColor:(UIColor *)uColor textDownColor:(UIColor *)dColor target:(id)target selector:(SEL)selector;
@end
