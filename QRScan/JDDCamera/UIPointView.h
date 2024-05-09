//
//  UIPointView.h
//  JDTQRScan
//
//  Created by heweihua on 2021/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kPointwh (35.)
@interface UIPointView : UIView

@property(nonatomic, copy  ) NSString *result;
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setAnimation:(BOOL)yesOrNo;
@end

NS_ASSUME_NONNULL_END
