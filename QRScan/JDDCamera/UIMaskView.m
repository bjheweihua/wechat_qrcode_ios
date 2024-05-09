//
//  UIMaskView.m
//  JDTQRScan
//
//  Created by heweihua on 2021/7/7.
//

#import "UIMaskView.h"
#import "UIPointView.h"
#import "QRBoxInfo.h"
#import "AppDevice.h"


@interface UIMaskView()


@end

@implementation UIMaskView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void) btnAction{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        
    }];
}

-(void) reloadData:(NSArray<QRBoxInfo*> *)list{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if ([list count] > 0) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    else{
        self.backgroundColor = [UIColor clearColor];
    }
    
//    NSString *string = NULL;
    for (QRBoxInfo *box in list) {
        
        UIPointView *point = [[UIPointView alloc] initWithFrame:CGRectMake(0, 0, kPointwh, kPointwh)];
        point.center = CGPointMake(box.cx, box.cy);
        point.result = box.result;
        [point setAnimation:list.count>1?YES:NO];
        [self addSubview:point];
    }

    
    
//    if ([list count] == 1) {
//        QRBoxInfo *box = list[0];
//        NSString *url = [NSString stringWithFormat:@"JDDRoute://push/UIWKWebViewController?url=%@",box.result];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//    }
    if ([list count] >1) {
        self.show = YES;
    }
    else{
        self.show = NO;
    }
}

@end
