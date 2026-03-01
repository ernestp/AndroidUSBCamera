# AUSBC - Android USB Camera

[![GitHub last commit](https://img.shields.io/github/last-commit/ernestp/AndroidUSBCamera?style=flat-square)](https://github.com/ernestp/AndroidUSBCamera/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/ernestp/AndroidUSBCamera?style=flat-square)](https://github.com/ernestp/AndroidUSBCamera/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/ernestp/AndroidUSBCamera?style=flat-square)](https://github.com/ernestp/AndroidUSBCamera/pulls)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/ernestp/AndroidUSBCamera?style=flat-square)](https://github.com/ernestp/AndroidUSBCamera/releases)
[![License](https://img.shields.io/github/license/ernestp/AndroidUSBCamera?style=flat-square)](LICENSE)
[![JitPack](https://jitpack.io/v/ernestp/AndroidUSBCamera.svg)](https://jitpack.io/#ernestp/AndroidUSBCamera)

Flexible and useful UVC camera engine for Android. Easily open your UVC camera (supports multi-camera setups) without system permissions—just ensure your device has USB OTG support.

This is the **actively maintained, canonical fork** of the original AndroidUSBCamera project. It upgraded to latest Android SDK, Gradle and NDK, fixed permission issues and improved reliability. Stars, forks, issues, and PRs are welcome!

- **Latest Release**: v3.4.5 (includes AUSBC APK demo) – [Download here](https://github.com/ernestp/AndroidUSBCamera/releases/latest)
- **API Support**: 23+
- **License**: Apache 2.0

## 🚀 Project Status (Updated March 2026)
This repo is **actively developed and maintained** by @ernestp and contributors.
- Recent highlights: Compatibility with **Android 16** and **16K page size**, fixed permission issues and reliability issues.
- Original upstream [jiangdongguo/AndroidUSBCamera](https://github.com/jiangdongguo/AndroidUSBCamera) is no longer actively maintained (last commit: Sep 2024; last release: Feb 2023).

&nbsp;

![multi-road camera](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/75a8f700d97c4de4979c9d0927764af9~tplv-k3u1fbpfcp-watermark.image?)

&emsp;[@ Example showing](https://live.csdn.net/v/226993)



Feature
-------

- Support opening multi-road camera;
- Support opening uvc camera on Android 6.0+;
- Support previewing 480p、720p、1080p，etc;
- Support adding effects with OpenGL ES 2.0;
- Support capture photo(`.jpg`)、viedo(`.mp4`/`.h264`/`yuv`) and audio(`pcm`/`mp3`/`aac`)
- Support rotating camera view;
- Support offscreen rendering;
- Support recording media along with acquiring YUV/RGBA/PCM/H.264/AAC stream, you can push it to your media server;
- Support acquiring all resolutions and usb devices, etc;
- Support acquiring system or device mic(UAC) audio data;
- Support armeabi-v7a, arm64-v8a, x86 & x86_64;

Usages
-------

&emsp;`AUSBC 3.0`  was refactored by kotlin and It is simpler to use and more feature-rich. So, I highly recommend you to use the current version and let's build it together.

- **Get AUSBC**

&emsp;First,  add it in your root **build.gradle** or **settings.gradle** at the end of repositories: 

```groovy
allprojects {
    repositories {
        google()
        jcenter()
        maven { url "https://jitpack.io" }
    }
}
```

&emsp;Second, add the dependency in your **app.gradle** , latest tag is [![](https://jitpack.io/v/ernestp/AndroidUSBCamera.svg)](https://jitpack.io/#ernestp/AndroidUSBCamera):

```groovy
dependencies {
    implementation 'com.github.ernestp.AndroidUSBCamera:libausbc:tag'
}
```

- **Simply usage**

&emsp; As for how to use this module correctly,  just  making your Fragment or Activity implement **CameraFragment** or **CameraActivity**.

```kotlin
class DemoFragment: CameraFragment() {
    private var mViewBinding: FragmentUvcBinding? = null

    override fun getRootView(inflater: LayoutInflater, container: ViewGroup?): View? {
        if (mViewBinding == null) {
            mViewBinding = FragmentUvcBinding.inflate(inflater, container, false)
        }
        return mViewBinding?.root
    }

    // if you want offscreen render
    // please return null
    override fun getCameraView(): IAspectRatio? {
        return mViewBinding?.tvCameraRender
    }

    // if you want offscreen render
    // please return null, the same as getCameraView()
    override fun getCameraViewContainer(): ViewGroup? {
        return mViewBinding?.container
    }

    // camera open status callback
    override fun onCameraState(self: ICamera, 
                               code: ICameraStateCallBack.State,
                               msg: String?) {
        when (code) {
            ICameraStateCallBack.State.OPENED -> handleCameraOpened()
            ICameraStateCallBack.State.CLOSED -> handleCameraClosed()
            ICameraStateCallBack.State.ERROR -> handleCameraError()
        }
    }
    
    override fun getGravity(): Int = Gravity.TOP
}
```

&emsp;The most important is that you should override `getRootView()`/`getCameraViewContainer()`/
`getCameraView()` at least which means fragment's root view 、texture  or surface view and it's container。Of course, the same as **CameraActivity** and now you can see the uvc camera preview。

- **Advanced usage**

&emsp;If you want some custom configurations, you can do like this in your **DemoFragment**: 

```kotlin
// if you want to open a camera default
// please override getDefaultCamera()
override fun getDefaultCamera(): UsbDevice? {
    return super.getDefaultCamera()
}

// if you want to custom camera requst
// please override getCameraRequest()
override fun getCameraRequest(): CameraRequest {
    return CameraRequest.Builder()
    .setPreviewWidth(1280) // camera preview width
    .setPreviewHeight(720) // camera preview height
    .setRenderMode(CameraRequest.RenderMode.OPENGL) // camera render mode
    .setDefaultRotateType(RotateType.ANGLE_0) // rotate camera image when opengl mode
    .setAudioSource(CameraRequest.AudioSource.SOURCE_AUTO) // set audio source
    .setPreviewFormat(CameraRequest.PreviewFormat.FORMAT_YUYV) // set preview format, MJPEG recommended
    .setAspectRatioShow(true) // aspect render,default is true
    .setCaptureRawImage(false) // capture raw image picture when opengl mode
    .setRawPreviewData(false)  // preview raw image when opengl mode
    .create()
}


```

&emsp;Of course, you can also capture a **jpg** image or a **mp4** video or  a **mp3** audio file and update resolution or different uvc camera and acquring the stream of **H264/AAC/YUV/PCM**  by calling those method:

```kotlin
// capture jpg image
captureImage(callBack, savePath)
// capture mp4 video
captureVideoStart(callBack, path, durationInSec)
captureVideoStop()
// capture stream(H.264/AAC) only
captureStreamStart()
captureStreamStop()
// capture mp4 video
captureVideoStart(callBack, path, durationInSec)
captureVideoStop()
// capture mp3 audio
captureAudioStart(callBack, path)
captureAudioStop()
// play mic in real time
startPlayMic(callBack)
stopPlayMic()
// rotate camera
// base on opening opengl es
setRotateType(type)
// switch different camera
switchCamera(UsbDevice)
// update resolution
updateResolution(width, height)
// get all preview sizes
getAllPreviewSizes(aspectRatio)
// acquire encode data(H.264 or AAC)
addEncodeDataCallBack(callBack)
// acquire raw data(NV21 or RGBA)
setPreviewDataCallBack(callBack)
// get current camera
getCurrentCamera()
// get current camera status
isCameraOpened()
// get all camera device list
getDeviceList()
```

&emsp;Or, camera configuration:

```kotlin
setZoom(0)
setSharpness(0)
setHue(0)
setSaturation(0)
setContrast(0)
setGamma(0)
setGain(0)
setAutoWhiteBalance(true)
setAutoFocus(true)
// send custom command to camera
sendCameraCommand(command)
```

&emsp;For more advanced features, you can even add some **filters** to your camera.This library providers some default filters, sush as **EffectBlackWhite**、**EffectSoul** and **EffectZoom**, and more filters will be added in the future.Of coure, you can also relize your own filters by extending **AbstractEffect**. For example：

```kotlin
// First, extending AbstractEffect
class EffectBlackWhite(ctx: Context) : AbstractEffect(ctx) {

    override fun getId(): Int = ID

    override fun getClassifyId(): Int = CameraEffect.CLASSIFY_ID_FILTER

    override fun getVertexSourceId(): Int = R.raw.base_vertex

    override fun getFragmentSourceId(): Int = R.raw.effect_blackw_fragment

    companion object {
        const val ID = 100
    }
}

// Second, adding or updating or removing filter
addRenderEffect(effect)
removeRenderEffect(effect)
updateRenderEffect(classifyId, effect)
```

&emsp;At last, If you want to realize streaming, maybe **IPusher** and **AusbcPusher** can help you.

- open multi-road camera

&emsp;If you want to open multi-road camera, you can make your Fragment or Activity extend **MultiCameraFragment** or **MultiCameraActivity**.Just do like this and more details please look up **DemoMultiCameraFragment**：

```kotlin
class DemoMultiCameraFragment : MultiCameraFragment(), ICameraStateCallBack {

    // a camera be attached
    override fun onCameraAttached(camera: MultiCameraClient.Camera) {}
    
	// a camera be detached
    override fun onCameraDetached(camera: MultiCameraClient.Camera) {}

    // a camera be connected
    override fun onCameraConnected(camera: MultiCameraClient.Camera) {
  		camera.openCamera(textureView, getCameraRequest())
        camera.setCameraStateCallBack(this)
    }

    // a camera be disconnected
    override fun onCameraDisConnected(camera: MultiCameraClient.Camera) {
         camrea.closeCamera()
    }

    // a camera be opened or closed or error
    override fun onCameraState(
        self: MultiCameraClient.Camera,
        code: ICameraStateCallBack.State,
        msg: String?) {
		when (code) {
            ICameraStateCallBack.State.OPENED -> handleCameraOpened()
            ICameraStateCallBack.State.CLOSED -> handleCameraClosed()
            ICameraStateCallBack.State.ERROR -> handleCameraError()
        }
    }

    override fun getRootView(inflater: LayoutInflater, container: ViewGroup?): View {
        return rootView
    }
    
    // [optional]
    // If you want to open the specified camera,
    // you need to let isAutoRequestPermission() false.
    // And then you need to call requestPermission(device) in your own Fragment/Activity
    // when onAttachDev() called, default is true.
    protected fun isAutoRequestPermission() = true
}
```



- Debug online

&emsp;If you want to debug the project online or modify something, those steps you should do:

&emsp;**First**, modifying the **Settings.gradle** file and making those to module. 

```groovy
include ':app'

// For debug online
include ':libausbc'
include ':libuvc'
include ':libnative'
include ':libuvccommon'
```

&emsp;**Second**, let **app.gradle** dependenced on `':libausbc'` .

```groovy
dependencies {

    // For debug online
    implementation project(':libausbc')

    // demo
    //implementation 'com.github.ernestp.AndroidUSBCamera:libausbc:latest_tag'
}
```



[@ 中文文档](https://juejin.cn/post/7115229806844706847/)



Demo
-------

&emsp;[AUSBC.apk](https://github.com/ernestp/AndroidUSBCamera/releases/download/3.4.5/ausbc-3.4.5.apk)


Version
-------

[Update details](https://github.com/ernestp/AndroidUSBCamera/releases)

Q & A
-------

[FAQ](https://github.com/ernestp/AndroidUSBCamera/blob/master/FAQ.md)


## Community & Updates
-------

&emsp;If you have any question or fun ideas, please file issue on GitHub as [feature].  
 

&emsp;So, do not forget to send logs from location **Android/data/com.jiangdg.ausbc/files** and collect logcat information by executing command `adb shell logcat -v threadtime > usbcamera.log`


Maintenance
-----------

This project is actively maintained by the community under the stewardship of [@ernestp](https://github.com/ernestp).
Bug reports and pull requests are welcome.

If you are using this library in production and need fixes or improvements,
please open an issue with detailed logs.

Thanks
-------

 [jiangdongguo/AndroidUSBCamera](https://github.com/jiangdongguo/AndroidUSBCamera)
 
 [saki4510t/UVCCamera](https://github.com/saki4510t/UVCCamera)



License
-------

```c
Copyright © 2017-2023 Jiangdongguo
Copyright © 2025-present Ernest Poletaev and contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
