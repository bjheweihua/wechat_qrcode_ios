//
//  AppDelegate.m
//  JDTQRScan
//
//  Created by heweihua on 2021/3/1.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    ViewController* controller = [[ViewController alloc]init];
    UINavigationController *_naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    _naviController.navigationBarHidden = YES;
    _naviController.interactivePopGestureRecognizer.enabled = YES;
    _naviController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:_naviController];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


@end

