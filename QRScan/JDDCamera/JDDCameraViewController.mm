//
//  JDDCameraViewController.m
//  JDTQRScan
//
//  Created by heweihua on 2021/3/2.
//

#import "JDDCameraViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIJDDNavigationBar.h"
#import "QRBoxInfo.h"
#import "UIMaskView.h"

#define k_scan_text (@"扫二维码/条码")
#define k_scan_more (@"轻触小红点，打开页面")
#define kHomeBarH \
({CGFloat homebarh = 0;\
if (@available(iOS 11.0, *)) {\
homebarh = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(homebarh);})

@interface JDDCameraViewController ()<UIJDDNavigationBarDelegate>{
}
@property (atomic,    assign) CGFloat scaleW;
@property (atomic,    assign) CGFloat scaleH;
@property (nonatomic, strong) UIMaskView *maskView;
@property (nonatomic, strong) UIJDDNavigationBar *navBar;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UILabel *tipsLabel;


@end

@implementation JDDCameraViewController

-(instancetype) init{
    
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addNavigationBar:@""];
    self.queue = dispatch_queue_create("ncnn", DISPATCH_QUEUE_CONCURRENT);
    self.isDetecting = NO;
    self.isPhoto = NO;
    [self initView];
    [self setCameraUI];
    [self.view addSubview:self.tipsLabel];
    [self.view bringSubviewToFront:self.navBar];
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self applicationDidBecomeActive];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self applicationWillResignActive];
}

// 进入前台
-(void)applicationDidBecomeActive{
    
    if ([self.navigationController.topViewController isEqual:self]) {
        if (!self.presentedViewController){
            
            if(_maskView && _maskView.show){
                return;
            }
            if (!self.isPhoto && !self.isAlert) {
                [_maskView reloadData:@[]];
                [self.cameraCapture startSession];
            }
        }
    }
}
    
// 即将进入后台台
-(void) applicationWillResignActive{
    
    if (!self.isPhoto) {
        [self.cameraCapture stopSession];
    }
}
    
- (void)didMoveToParentViewController:(nullable UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    if (!parent) {
        [self leftButtonDown];
    }
}
    
- (void)addNavigationBar:(NSString*)title{
    
    self.navBar = [[UIJDDNavigationBar alloc] initWithTitle:title];
    self.navBar.bar_delegate = self;
    [self.view addSubview:self.navBar];
    
    [self.navBar addNavgationItemLeftButtonWithImageName:@"com_icon_backup_u" PressedImgName:@"com_icon_backup_u"];
    self.navBar.backgroundColor = [UIColor clearColor];
    self.navBar.titleLable.textColor = [UIColor whiteColor];
    //[self.navBar addNavigationItemRightButtonWithText:@"相册" textUpColor:[UIColor whiteColor] textDownColor:[UIColor lightGrayColor] target:self selector:@selector(choicePhoto:)];
}

- (void)leftButtonDown{
    
    if(self.maskView && self.maskView.show){
        [self.maskView reloadData:@[]];
        [self.cameraCapture startSession];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark 设置相机并回调
- (void)setCameraUI {
    
    [self setVideoPreview];
     __weak __typeof(self) _self = self;
    self.cameraCapture.imageBlock = ^(UIImage *image) {
        
        __strong typeof(_self) self = _self;
        if (self.isDetecting || self.isPhoto) {
            return;
        }
        self.isDetecting = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            int image_h = image.size.height;
            int image_w = image.size.width;
            self.scaleW = 1.0f * CGRectGetWidth(self.preLayer.frame) / image_w;
            self.scaleH = 1.0f * CGRectGetHeight(self.preLayer.frame) / image_h;
            [self detectImage:image];
            self.isDetecting = NO;
         });
    };
    [self.cameraCapture startSession];
}

- (ELCameraControlCapture *)cameraCapture {
    if (!_cameraCapture) {
        _cameraCapture = [[ELCameraControlCapture alloc] init];
    }
    return _cameraCapture;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        CGFloat y = CGRectGetHeight(self.view.frame) - kHomeBarH - 20 - 80;
        CGRect rect = CGRectMake(16, y, CGRectGetWidth(self.view.frame)-32, 20);
        _tipsLabel = [[UILabel alloc] initWithFrame:rect];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.text = k_scan_text;
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    }
    return _tipsLabel;
}


#pragma mark 相机预览画面位置
- (void)setVideoPreview {
    
    self.preLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.cameraCapture.captureSession];
    self.preLayer.backgroundColor = [[UIColor clearColor] CGColor];
    self.preLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05].CGColor;
    [self.view.layer addSublayer:self.preLayer];
    
    _maskView = [[UIMaskView alloc] initWithFrame:self.preLayer.frame];
    [self.view addSubview:self.maskView];
}

- (void)tapImageViewRecognizer {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 1;
//    self.imageView.userInteractionEnabled = YES;
//    [self.imageView addGestureRecognizer:tap];
}

- (void)tapClick {
    
    self.isAlert = false;
    self.isPhoto = NO;
    self.isDetecting = NO;
    [self.cameraCapture startSession];
}


- (void)initView {

    [self tapImageViewRecognizer];
}

#pragma mark 照片
- (void)choicePhoto:(id)sender {
    
    self.isPhoto = YES;
    UIImagePickerController *imgpicker = [[UIImagePickerController alloc] init];
    //picVC.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
    imgpicker.allowsEditing = NO;
    [self presentViewController:imgpicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    self.isDetecting = YES;
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    __weak __typeof(self) _self = self;
    dispatch_async(self.queue, ^{
        
        __strong typeof(_self) self = _self;
        [self detectImage:image];
    });
    [self dismissViewControllerAnimated:YES completion:^{
        self.isPhoto = NO;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    self.isPhoto = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.isPhoto = NO;
        self.isDetecting = NO;
    }];
}

#pragma mark 相机回调图片
-(void) detectImage:(UIImage *)image {
  
    Mat *cvImage = [self _cvMatWithImage:image];
    NSMutableArray *points = [[NSMutableArray alloc] init];
    NSArray *codes = [self.qrcode detectAndDecode:cvImage points:points];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (int i = 0; i < [codes count]; ++i) {
        
        Mat *point = points[i];
        if (!point) {break;}
        // 去掉[]
        NSString *dump = point.dump;
        //NSLog(@"dump = %@",point.dump);
        if (!dump) {break;}

        /*
         [496.97809, 953.35089;
          837.99261, 953.35089;
          837.99261, 1298.8114;
          496.97809, 1298.8114]
         */
        dump = [dump stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        dump = [dump stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        dump = [dump stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        dump = [dump stringByReplacingOccurrencesOfString:@" " withString:@""];
        dump = [dump stringByReplacingOccurrencesOfString:@"[" withString:@""];
        dump = [dump stringByReplacingOccurrencesOfString:@"]" withString:@""];

        NSArray *points = [dump componentsSeparatedByString:@";"];
        if ([points count] != 4) {break;}
        
        // 获取四个坐标点
        CGPoint PA,PC;
        for (int i = 0; i < [points count]; ++i) {
            NSArray *p = [points[i] componentsSeparatedByString:@","];
            if ([p count] == 2) {
                
                CGFloat x = [p[0] floatValue] * self.scaleW;
                CGFloat y = [p[1] floatValue] * self.scaleH;
                if (0 == i) {
                    PA = CGPointMake(x, y);
                }
                else if (2 == i) {
                    PC = CGPointMake(x, y);
                }
            }
        }
        
        QRBoxInfo *box = [[QRBoxInfo alloc] init];
        box.result = codes[i];
        // 去掉字符串首尾空格
        box.result = [box.result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        box.x1 = PA.x;
        box.y1 = PA.y;
        box.x2 = PC.x;
        box.y2 = PC.y;
        box.cx = PA.x + (PC.x - PA.x)/2.0;
        box.cy = PA.y + (PC.y - PA.y)/2.0;
        if (box) {
            [results addObject:box];
        }
    }
    
    if (NO == [self.cameraCapture.captureSession isRunning]) {
        return;
    }
    
    if ([results count] > 0) {
        [self.cameraCapture stopSession];
        self.isDetecting = false;
        
        AudioServicesPlaySystemSound(1520);
//        [self didOutputObjects:list];
        
//        self.isAlert = true;
//    #warning 只获取数字第一个值，做简单的处理
//        QRBoxInfo* box = results.firstObject;
//        NSString *result = [NSString stringWithFormat:@"%@\n{(%.2f,%.2f), (%.2f,%.2f)}",box.result, box.x1, box.y1, box.x2, box.y2];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"识别结果" message:result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
    }
    
//    __weak __typeof(self) _self = self;
//    dispatch_sync(dispatch_get_main_queue(), ^{
//
//        __strong typeof(_self) self = _self;
        
        
        if ([results count] > 1) {
            [self.tipsLabel setText:k_scan_more];
        }
        else{
            [self.tipsLabel setText:k_scan_text];
        }
        [_maskView removeFromSuperview];
        _maskView = [[UIMaskView alloc] initWithFrame:self.preLayer.bounds];
        
        // 这样设置，button小红点，点击不了，改成下面的
        //[self.preLayer addSublayer:self.maskView.layer];
        [self.view addSubview:self.maskView];
        [self.maskView reloadData:results];
//    });
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self tapClick];
}


-(WeChatQRCode *)qrcode{

    if (!_qrcode) {
        
        NSString *detect_prototxt_path = [[NSBundle mainBundle] pathForResource:@"detect" ofType:@"prototxt"];
        NSString *detect_caffemodel_path = [[NSBundle mainBundle] pathForResource:@"detect" ofType:@"caffemodel"];
        NSString *sr_prototxt_path = [[NSBundle mainBundle] pathForResource:@"sr" ofType:@"prototxt"];
        NSString *sr_caffemodel_path = [[NSBundle mainBundle] pathForResource:@"sr" ofType:@"caffemodel"];
        _qrcode = [[WeChatQRCode alloc] initWithDetector_prototxt_path:detect_prototxt_path detector_caffe_model_path:detect_caffemodel_path super_resolution_prototxt_path:sr_prototxt_path super_resolution_caffe_model_path:sr_caffemodel_path];
    }
    return _qrcode;
}

- (Mat *)_cvMatWithImage:(UIImage *)image{

    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    Mat* cvMat = [[Mat alloc] initWithRows:rows cols:cols type:CV_8UC4];
//    Mat* cvMat = [[Mat alloc] initWithRows:rows cols:cols type:1];
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.dataPtr,
                                                 cols,
                                                 rows,
                                                 8,
                                                 cvMat.step1,
                                                 colorSpace,
                                                 kCGImageAlphaNoneSkipLast |
                                                 kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    return cvMat;
}


@end
