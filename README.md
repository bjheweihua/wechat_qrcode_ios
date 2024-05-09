
# OpenCV微信扫码引擎,制作成iOS的framework

如何把opencv_contrib中的扫码引擎（wechat_qrcode）打包到 opencv 中，并生成iOS用的framework

1、环境要求：
macOS Monterey 12.0.1
Xcode 13.3
cmake 3.22.1

2、[opencv](https://opencv.org)首页，如下图所示
![opencv_home](media/https://github.com/bjheweihua/wechat_qrcode_ios/blob/main/readme_res/opencv_home.png)

下面我们开始把opencv版微信扫码引擎库，集成到opencv中，并打包成framework。

## 第1步：克隆|下载opencv原代码

1. 下载[opencv](https://github.com/opencv/opencv/tree/master)。选择master最新稳定版本。
2. 下载[opencv_contrib](https://github.com/opencv/opencv_contrib/tree/master)，选择master最新稳定版本。
3. 将下载好的opencv、opencv_contrib放入同一个目录下：
![1](media/17150505298270/1.png)


## 第2步：微信扫码引擎（wechat_qrcode），放到主工程（opencv）

1. 根据路径找到，微信扫码引擎
   opencv_contrib -> modules -> wechat_qrcode
![2](media/17150505298270/2.png)


2. 拷贝wechat_qrcode源码，粘贴到opencv目录下
opencv -> modules -> wechat_qrcode
![3](media/17150505298270/3.png)

## 第3步： 安装工具包
 brew install cmake
 
## 第4步： 编译打包

参考opencv官方文档：https://docs.opencv.org/4.9.0/d5/da3/tutorial_ios_install.html

在存放opencv、opencv_contrib目录下，执行如下命令：
python opencv/platforms/ios/build_framework.py ios
![4](media/https://github.com/bjheweihua/wechat_qrcode_ios/blob/main/readme_res/4.png)

执行几分钟后，framework包就编译好了
在当前目录下，会自动生成ios目录，如下图所示：
![5](media/https://github.com/bjheweihua/wechat_qrcode_ios/blob/main/readme_res/5.png)
注意事项：
官方的build_framework.py 好久没更新了，里面要改几处代码，不然会报错
1. IPHONEOS_DEPLOYMENT_TARGET='12.0' (iOS9改成iOS12)
2. xcode11以后打包不支持模拟器架构i386 x86_64 
iphoneos_archs = ["armv7", "armv7s", "arm64"]去掉armv7、armv7s xcode已经不支持了
3. 如果swift报错，又不需要swift，也可以干掉（需要的话，查资料解决）

## 第5步： 下载模型文件
模型文件地址：https://github.com/WeChatCV/opencv_3rdparty
1. 目标检测模型文件：detect.caffemodel、detect.prototxt
2. 超分辨率模型文件：sr.caffemodel、sr.prototxt
![6](media/https://github.com/bjheweihua/wechat_qrcode_ios/blob/main/readme_res/6.png)


## 第6步：导入iOS工程，Demo工程集成
1. 将打包好的opencv2.framework + 模型文件导入到demo工程
2. oc代码调用c++代码，见[demo](https://github.com/bjheweihua/wechat_qrcode_ios)
   
4. demo效果如下：
![qr_scan_0](media/https://github.com/bjheweihua/wechat_qrcode_ios/blob/main/readme_res/qr_scan_0.jpg)
![qr_scan_1](media/https://github.com/bjheweihua/wechat_qrcode_ios/blob/main/readme_res/qr_scan_1.jpg)




## OpenCV版微信扫码引擎，只开源了二维码识别，条形码并未开放

