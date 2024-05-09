//
//  QRBoxInfo.h
//  JDTQRScan
//
//  Created by heweihua on 2021/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRBoxInfo : NSObject

@property(nonatomic, assign) float x1;
@property(nonatomic, assign) float y1;
@property(nonatomic, assign) float x2;
@property(nonatomic, assign) float y2;
@property(nonatomic, copy  ) NSString *result;

// 中心点坐标
@property(nonatomic, assign) float cx;
@property(nonatomic, assign) float cy;
@end

NS_ASSUME_NONNULL_END
