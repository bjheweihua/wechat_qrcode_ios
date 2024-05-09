//
//  UIPointView.m
//  JDTQRScan
//
//  Created by heweihua on 2021/7/7.
//

#import "UIPointView.h"

@implementation UIPointView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        CGFloat w = CGRectGetWidth(frame);
        CGFloat h = CGRectGetHeight(frame);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = w/2.;
        btn.layer.borderWidth = 2.5;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.masksToBounds = YES;
        btn.enabled = YES;
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

-(void)setupHeartbeatAnimationInView:(UIView *)view{
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.4; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:0.8]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.1]; // 结束时的倍率
    animation.removedOnCompletion = NO;
    // 添加动画
    [view .layer addAnimation:animation forKey:@"scale-layer"];
}

-(void) setAnimation:(BOOL)yesOrNo{
    
    if (yesOrNo) {
        //[self run];
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    }
}

-(void) run{
    [self setupHeartbeatAnimationInView:self];
}

-(void) btnAction{
    
//    NSString *url = [NSString stringWithFormat:@"JDDRoute://push/UIWKWebViewController?url=%@",self.result];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"识别结果" message:self.result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
