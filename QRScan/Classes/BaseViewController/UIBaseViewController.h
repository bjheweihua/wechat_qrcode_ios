//
//  UIBaseViewController.h
//  TabBarDemo
//
//  Created by heweihua on 14-11-27.
//  Copyright (c) 2014年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDevice.h"

#define BaseViewHeight (kMainScreenW-64.0f)

@interface UIBaseViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLable;

- (void)addNavigationBar:(NSString*)title;
- (void)addNavigationBar:(NSString*)title withColor:(UIColor*)color;
- (void)addNavigationBar:(NSString*)title withNaviImageName:(NSString*)iName;


//默认的左边返回按钮
- (void)addLeftBarButtonItem;
- (void)addHLeftBarButtonItem;

//定制左侧按钮
- (void)addLeftButtonItemWithTitle:(NSString*)title;
- (void)addLeftButtonItemWithTitle:(NSString*)title titleColor:(NSString*)color;
- (void)addLeftButtonItemWithImageName:(NSString*)iNameU pressedImgName:(NSString*)iNameD;

//定制右侧按钮
- (void)addRightButtonItemWithImageName:(NSString *)iNameU pressedImgName:(NSString*)iNameD target:(id)target selector:(SEL)selector;
- (void)addRightButtonItemWithTitle:(NSString *)String target:(id)target selector:(SEL)selector;
- (void)addRightButtonItemWithTitle:(NSString *)title titleColor:(NSString*)color target:(id)target selector:(SEL)selector;

- (void)removeNavigationItemLeft;
- (void)removeNavigationItemRight;

//定制titleView
- (void)addNavigationTitleView:(UIView *)titleView;
- (void)addNavigationBarWithCamera:(NSString*)title;

- (void) leftButtonDown;


//下拉刷新
-(void)setHeadRefresh:(UIScrollView*)scrollView isLoading:(BOOL)isLoading;
-(void)setHeadRefreshLoading;
-(void)endHeadRefresh:(CGFloat)sec;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
-(void)setHeadRefreshLoadingManual;
-(void)setHeadRefreshLoadingShort;
@end














