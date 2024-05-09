//
//  UIMaskView.h
//  JDTQRScan
//
//  Created by heweihua on 2021/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QRBoxInfo;
@interface UIMaskView : UIView

@property(nonatomic, assign) BOOL show;
-(void) reloadData:(NSArray<QRBoxInfo*> *)list;
@end

NS_ASSUME_NONNULL_END
