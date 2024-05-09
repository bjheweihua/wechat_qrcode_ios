//
//  JDDCameraViewController.h
//  JDTQRScan
//
//  Created by heweihua on 2021/3/2.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import "ELCameraControlCapture.h"
#import <opencv2/opencv2.h>

//模型文件：https://github.com/WeChatCV/opencv_3rdparty

NS_ASSUME_NONNULL_BEGIN

@interface JDDCameraViewController : UIViewController{

}
@property (nonatomic,strong) WeChatQRCode *qrcode;

// 相机部分
@property (strong, nonatomic) ELCameraControlCapture *cameraCapture;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preLayer;
@property (assign, atomic) Boolean isDetecting;
@property (assign, atomic) Boolean isPhoto;
@property (assign, atomic) bool isAlert;
@property (nonatomic) dispatch_queue_t queue;

@end


NS_ASSUME_NONNULL_END
