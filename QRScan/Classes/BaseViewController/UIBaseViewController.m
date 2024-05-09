//
//  UIBaseViewController.m
//  TabBarDemo
//
//  Created by heweihua on 14-11-27.
//  Copyright (c) 2014年 heweihua. All rights reserved.
//




#import "UIBaseViewController.h"
#import "UIColor+Additions.h"

#define kBgColor @"#efeff4"

#define k_tag_leftButton               201407211
#define k_tag_rightButton              201407212
#define k_tag_titleLabel               201407213
#define k_tag_titleSegmented           201407214
#define k_tag_SegmentedPointLabel      201407215
#define k_tag_middleButton             201411051
#define knavigationBarTitleFontSize 17
#define kLeftBtnW 65
#define kLeftBtnH 44
#define kLeftBtnTitleFont 14
#define kTitleLabelX (65)
#define kTitleLabelW (kMainScreenW - kTitleLabelX*2)

@interface UIBaseViewController (){
    
}
@end

@implementation UIBaseViewController


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (instancetype) init{
    
    self = [super init];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor jrColorWithHex:kBgColor];
    [self addLeftBarButtonItem];
    // 针对iOS11以下，UITableView会自动适配内部ContentInset，用以避免遮挡状态栏的问题。此处设置状态栏位置空白视图用以解决问题。
    if (@available(iOS 11.0, *)) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.view addSubview:view];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    NSInteger count = [self.navigationController.viewControllers count];
//    NSLog(@"viewWillDisappear: count= %@", @(count));
    if (count <= 2) {
        self.hidesBottomBarWhenPushed = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
}


-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addNavigationBar:(NSString*)title{
    
//    self.naviBar = [[UIBaseNavigationBar alloc] initWithTitle:title];
////    self.naviBar.bar_delegate = self;
//    [self.view addSubview:self.naviBar];

    
    if (nil == _titleLable){
        
        UIFont* font = [UIFont systemFontOfSize:knavigationBarTitleFontSize];
        CGRect rect = CGRectMake(kTitleLabelX, 0, kTitleLabelW, kNaviBarHeight);
        _titleLable = [[UILabel alloc] initWithFrame:rect];
        _titleLable.tag = k_tag_titleLabel;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = font;
        _titleLable.textColor = [UIColor jrColorWithHex:@"#333333"];
        _titleLable.text = title;
        self.navigationItem.titleView = _titleLable;
        return;
    }
    _titleLable.text = title;
    self.navigationItem.titleView = _titleLable;
}



- (void)addNavigationBar:(NSString*)title withColor:(UIColor*)color{
    
//    self.naviBar = [[UIBaseNavigationBar alloc] initWithTitle:title withColor:color];
////    self.navBar.bar_delegate = self;
//    [self.view addSubview:self.naviBar];
    
    if (nil == _titleLable){
        
        UIFont* font = [UIFont systemFontOfSize:knavigationBarTitleFontSize];
        CGRect rect = CGRectMake(kTitleLabelX, 0, kTitleLabelW, kNaviBarHeight);
        _titleLable = [[UILabel alloc] initWithFrame:rect];
        _titleLable.tag = k_tag_titleLabel;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = font;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.text = title;
        self.navigationItem.titleView = _titleLable;
        return;
    }
    _titleLable.text = title;
    self.navigationItem.titleView = _titleLable;
}

- (void)addNavigationBarWithCamera:(NSString*)title{
    
    //    self.naviBar = [[UIBaseNavigationBar alloc] initWithTitle:title withColor:color];
    ////    self.navBar.bar_delegate = self;
    //    [self.view addSubview:self.naviBar];
    
    if (nil == _titleLable){
        
        UIFont* font = [UIFont systemFontOfSize:25.];
        CGRect rect = CGRectMake(kTitleLabelX, 0, kTitleLabelW, kNaviBarHeight);
        _titleLable = [[UILabel alloc] initWithFrame:rect];
        _titleLable.tag = k_tag_titleLabel;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = font;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.text = title;
        self.navigationItem.titleView = _titleLable;
        return;
    }
    _titleLable.text = title;
    self.navigationItem.titleView = _titleLable;
}


- (void)addNavigationBar:(NSString*)title withNaviImageName:(NSString*)iName{
    
//    self.naviBar = [[UIBaseNavigationBar alloc] initWithTitle:title withNaviImageName:iName];
////    self.navBar.bar_delegate = self;
//    [self.view addSubview:self.naviBar];
//}

    // 背景图
    UIImage* image = [UIImage imageNamed:iName];
    UIImageView* naviImgV = [[UIImageView alloc] initWithImage:image];
    [naviImgV setBackgroundColor:[UIColor clearColor]];
    [naviImgV setFrame:CGRectMake(0, 0, kMainScreenW, kNaviBarHeight + kStateBarHeight)];
    
    if (nil == _titleLable){
        
        UIFont* font = [UIFont systemFontOfSize:knavigationBarTitleFontSize weight:UIFontWeightRegular];
        CGRect rect = CGRectMake(kTitleLabelX, 0, kTitleLabelW, kNaviBarHeight);
        _titleLable = [[UILabel alloc] initWithFrame:rect];
        _titleLable.tag = k_tag_titleLabel;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = font;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.text = title;
        [naviImgV addSubview:_titleLable];
        self.navigationItem.titleView = naviImgV;
        return;
    }
    _titleLable.text = title;
    self.navigationItem.titleView = naviImgV;
}


//默认的左边返回按钮
- (void)addLeftBarButtonItem {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *imagePressed = [UIImage imageNamed:@"navibar_back_icon"];
    UIImage *image = [UIImage imageNamed:@"navibar_back_icon"];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    button.tintColor = [UIColor whiteColor];
    button.autoresizesSubviews = YES;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagePressed forState:UIControlStateHighlighted];
//    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(leftButtonDown) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}


//默认的左边返回按钮
- (void)addHLeftBarButtonItem {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *image = [UIImage imageNamed:@"com_back_dark"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    button.tintColor = [UIColor redColor];
    button.autoresizesSubviews = YES;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    //    [button setTitle:@"返回" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14.];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(leftButtonDown) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}


-(void)addLeftButtonItemWithTitle:(NSString*)title{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, kStateBarHeight, kLeftBtnW, kLeftBtnH)];
    [button setTitleColor:[UIColor jrColorWithHex:@"#666666"]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor jrColorWithHex:@"#999999"]  forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:kLeftBtnTitleFont weight:UIFontWeightRegular];
    button.tag = k_tag_leftButton;
    [button setTitle:title forState:UIControlStateNormal];
    [button setExclusiveTouch:YES];
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    if (size.width > kLeftBtnW)
    {
        [button setFrame:CGRectMake(0, kStateBarHeight, size.width, kLeftBtnH)];
    }
    [button addTarget:self action:@selector(leftButtonDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)addLeftButtonItemWithTitle:(NSString*)title titleColor:(NSString*)color{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, kStateBarHeight, kLeftBtnW, kLeftBtnH)];
    [button setTitleColor:[UIColor jrColorWithHex:color]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor jrColorWithHex:color]  forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:kLeftBtnTitleFont weight:UIFontWeightRegular];
    button.tag = k_tag_leftButton;
    [button setTitle:title forState:UIControlStateNormal];
    [button setExclusiveTouch:YES];
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    if (size.width > kLeftBtnW)
    {
        [button setFrame:CGRectMake(0, kStateBarHeight, size.width, kLeftBtnH)];
    }
    [button addTarget:self action:@selector(leftButtonDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}



- (void)addLeftButtonItemWithImageName:(NSString*)iNameU pressedImgName:(NSString*)iNameD{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *imagePressed = [UIImage imageNamed:iNameD];
    UIImage *image = [UIImage imageNamed:iNameU];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagePressed forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, kStateBarHeight, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(leftButtonDown) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//定制右侧按钮
- (void)addRightButtonItemWithImageName:(NSString *)iNameU pressedImgName:(NSString*)iNameD target:(id)target selector:(SEL)selector{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_rightButton;
    UIImage *image = [UIImage imageNamed:iNameU];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:iNameD] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(kMainScreenW - image.size.width - 15.f, kStateBarHeight , image.size.width, image.size.height)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)addRightButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIFont * font = [UIFont systemFontOfSize:kLeftBtnTitleFont weight:UIFontWeightRegular];
    CGSize size = [title sizeWithFont:font];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_rightButton;
    [button setTitle:title  forState:UIControlStateNormal];
    [button setTitle:title  forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor jrColorWithHex:@"#666666"]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor jrColorWithHex:@"#999999"]  forState:UIControlStateHighlighted];
    CGFloat pointW = size.width + 20*2; // 20 距离右边间隔
    [button setFrame:CGRectMake(kMainScreenW - pointW, kStateBarHeight, pointW, kNaviBarHeight)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = font;
    button.backgroundColor = [UIColor clearColor];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addRightButtonItemWithTitle:(NSString *)title titleColor:(NSString*)color target:(id)target selector:(SEL)selector{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIFont * font = [UIFont systemFontOfSize:kLeftBtnTitleFont weight:UIFontWeightRegular];
    CGSize size = [title sizeWithFont:font];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_rightButton;
    [button setTitle:title  forState:UIControlStateNormal];
    [button setTitle:title  forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor jrColorWithHex:color]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor jrColorWithHex:color]  forState:UIControlStateHighlighted];
    CGFloat pointW = size.width + 20*2; // 20 距离右边间隔
    [button setFrame:CGRectMake(kMainScreenW - pointW, kStateBarHeight, pointW, kNaviBarHeight)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = font;
    button.backgroundColor = [UIColor clearColor];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}


-(void)removeNavigationItemLeft{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    self.navigationItem.leftBarButtonItem = nil;
}



-(void)removeNavigationItemRight{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    self.navigationItem.rightBarButtonItem = nil;
}

//定制titleView
- (void)addNavigationTitleView:(UIView *)titleView{
    
    [titleView setFrame:CGRectMake((kMainScreenW-titleView.frame.size.width)/2, kStateBarHeight, titleView.frame.size.width, kNaviBarHeight)];
    self.navigationItem.titleView = titleView;
}



-(void) leftButtonDown { // 有需要重载，可以继承该函数
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setHeadRefresh:(UIScrollView*)scrollView isLoading:(BOOL)isLoading{
    
}
//取消自动暂停
- (void)setHeadRefreshLoadingManual {
}

-(void)setHeadRefreshLoadingShort{
    
}

-(void)setHeadRefreshLoading{
    
}

-(void)endHeadRefresh:(CGFloat)sec{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

@end











