//
//  ViewController.m
//  JDTQRScan
//
//  Created by heweihua on 2021/3/1.
//

#import "ViewController.h"
#import "JDDCameraViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat pointY = (CGRectGetHeight(self.view.frame) - 20)/2.;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, pointY, CGRectGetWidth(self.view.frame), 20)];
    label.text = @"微信扫码引擎-opencv版（只支持二维码）";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    pointY = CGRectGetHeight(self.view.frame) - 60 - 50;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(16, pointY, self.view.frame.size.width - 32, 50)];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"start camera" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

-(void) buttonAction{
    
    // 基于"opencv2/wechat_qrcode.hpp" 微信开源扫码引擎
    JDDCameraViewController *ctrl = [[JDDCameraViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}
@end
