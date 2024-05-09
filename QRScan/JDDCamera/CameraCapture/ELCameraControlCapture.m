//
//  ELCameraControlCapture.m
//  AVCaptureDemo
//
//  Created by yin linlin on 2018/5/17.
//  Copyright © 2018年 yin linlin. All rights reserved.
//

#import "ELCameraControlCapture.h"

@implementation ELCameraControlCapture

#pragma mark 切换摄像头
- (BOOL)switchCamera {
    if (![self canSwitchCamera]) {
        return NO;
    }
    //获取切换的摄像头
    AVCaptureDevice *videoDevice = nil;
    if (self.captureDevice.position == AVCaptureDevicePositionBack) {
        videoDevice = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    else {
        videoDevice = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    if (!videoDevice) {
        return NO;
    }
    self.captureDevice = videoDevice;
    //重新定义输入流
    NSError *error;
    AVCaptureDeviceInput *videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (videoInput) {
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:self.captureInput];
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.captureInput = videoInput;
        }
        else {
            [self.captureSession addInput:self.captureInput];
        }
        [self.captureSession commitConfiguration];
        return YES;
    }
    return NO;
}

//#pragma mark -设置摄像头基础参数： 白平衡、自动对焦、自动曝光
//-(void) setDefaultsParams{
//    
//    NSError *error = nil;
//    
//    [self.input.device lockForConfiguration:&error];
//    
//    // 自动白平衡
//    if ([self.input.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
//        [self.input.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
//    }
//    //先进行判断是否支持控制对焦,不开启自动对焦功能，很难识别二维码。
//    if (self.input.device.isFocusPointOfInterestSupported &&[self.input.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]){
//        [self.input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
//    }
//    // 自动曝光
//    if ([self.input.device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
//        [self.input.device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
//    }
//    
//    // 视频流输出方向
//    AVCaptureConnection* videoConnection = [_videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
//    if([videoConnection isVideoOrientationSupported]) {
//        videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
//    }
//    
//    [self.input.device unlockForConfiguration];
//}


// 能否切换前置后置
- (BOOL)canSwitchCamera {
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}
#pragma mark 设置闪光灯模式
- (BOOL)setFlashMode:(AVCaptureFlashMode)flashMode {
    AVCaptureDevice *device = self.captureDevice;
    if (device.flashMode != flashMode &&
        [device isFlashModeSupported:flashMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.flashMode = flashMode;
            [device unlockForConfiguration];
            return YES;
        }
    }
    return NO;
}
#pragma mark 设置手电筒开关
- (BOOL)setTorchMode:(AVCaptureTorchMode)torchMode {
    AVCaptureDevice *device = self.captureDevice;
    if (device.torchMode != torchMode &&
        [device isTorchModeSupported:torchMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.torchMode = torchMode;
            [device unlockForConfiguration];
            return YES;
        }
    }
    return NO;
}
#pragma mark 焦距调整
- (BOOL)setFocusMode:(AVCaptureFocusMode)focusMode {
    AVCaptureDevice *device = self.captureDevice;
    if (device.focusMode != focusMode &&
        [device isFocusModeSupported:focusMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusMode = focusMode;
            [device unlockForConfiguration];
            return YES;
        }
    }
    return NO;
}

- (BOOL)setFocusPoint:(CGPoint)point {
    AVCaptureDevice *device = self.captureDevice;
    if (device.isFocusPointOfInterestSupported &&
        [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusPointOfInterest = point;
            device.focusMode = AVCaptureFocusModeAutoFocus;
            [device unlockForConfiguration];
            return YES;
        }
    }
    return NO;
}

#pragma mark 曝光量调节
- (BOOL)setExposureMode:(AVCaptureExposureMode)exposureMode {
    AVCaptureDevice *device = self.captureDevice;
    if (device.exposureMode != exposureMode &&
        [device isExposureModeSupported:exposureMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.exposureMode = exposureMode;
            [device unlockForConfiguration];
            return YES;
        }
    }
    return NO;
}

#pragma mark 白平衡
- (BOOL)setWhiteBalanceMode:(AVCaptureWhiteBalanceMode)whiteBalanceMode {
    AVCaptureDevice *device = self.captureDevice;
    if (device.whiteBalanceMode != whiteBalanceMode &&
        [device isWhiteBalanceModeSupported:whiteBalanceMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.whiteBalanceMode = whiteBalanceMode;
            [device unlockForConfiguration];
            return YES;
        }
    }
    return NO;
}



@end
