# Huawei Ads Kit Flutter Plugin

---

## Contents

* [1. Introduction](#1-introduction)
* [2. Installation Guide](#2-installation-guide)
* [3. API Reference](#3-api-reference)
    * [Ads](#ads)
        * [Banner Ad](#banner-ad)
        * [Interstitial Ad](#interstitial-ad)
        * [Reward Ad](#reward-ad)
        * [Splash Ad](#splash-ad)
        * [Native Ad](#native-ad)
        * [Instream Ad](#instream-ad)
    * [Consent](#consent)
    * [Identifier Service](#identifier-service)
* [4. Configuration Description](#4-configuration-description)
* [5. Preparing for Release](#5-preparing-for-release)
* [6. Sample Project](#6-sample-project)
* [7. Questions or Issues](#6-questions-or-issues)
* [8. Licensing and Terms](#7-licensing-and-terms)

# 1. Introduction

This plugin enables communication between Huawei Ads SDK and Flutter platform. Huawei Ads Kit Plugin for Flutter provides the following 2 services:
- **Publisher Service**: HUAWEI Ads Publisher Service utilizes Huawei's vast user base and extensive data capabilities to deliver targeted, high quality ad content to users. With this service, your app will be able to generate revenues while bringing your users content which is relevant to them.
- **Identifier Service**: HUAWEI Ads Kit provides the open advertising identifier (OAID) for advertisers to deliver personalized ads and attribute conversions.
- **HMSLogger**: HMSLogger used for sending usage analytics of Ads SDK's methods to improve the service quality.
    - [enableLogger](#enablelogger): This method enables the HMSLogger.
    - [disableLogger](#disableLogger): This method disables the HMSLogger.

# 2. Installation Guide

- Complate the HUAWEI Ads Publisher Service integration process by referring to [App Integration Process](https://developer.huawei.com/consumer/en/doc/distribution/monetize/0603).

- Create an ad unit for refering to [Add app and unit](https://developer.huawei.com/consumer/en/doc/distribution/monetize/Monetizeaddappandunit).

- On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies to download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

 ```yaml
 dependencies:
  huawei_ads: {library version}
 ```

 ***or***

 If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.
 ```yaml
 dependencies:
  huawei_ads:
# Replace {library path} with actual library path of Huawei Ads Kit Plugin for Flutter.
path: {library path}
 ```

- Run

 ```
 flutter pub get
 ```
 ***or***

 **From Android Studio/IntelliJ**: Click the **Packages get** action ribbon which appears on the top right corner when you open the **pubspec.yaml** file.
 
 **From VS Code**: Click **Get Packages** located in right side of the action ribbon at the top of pubspec.yaml.

- Add a corresponding *import* statement in the Dart code and start the app.

# 3. API Reference

This section does not cover all of the API. To read more, please visit [HUAWEI Developer](https://developer.huawei.com/) website.

# **Ads**

## AdListener

A function type defined for listening to ad events.

| Definition | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void AdListener(AdEvent event, {int errorCode}) | Ad status listener. |

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| event | AdEvent | Ad event. |
| errorCode | int | ErrorCode. |

## AdEvent

Enumerated object that represents the events of an ad.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| clicked | Ad is tapped. |
| closed | Ad is closed. |
| failed | Ad request failed. |
| impression | An impression is recorded for an ad. |
| leave | Ad leaves an app. |
| loaded | Ad is loaded successfully. |
| opened | Ad is opened. |
| disliked | Ad is disliked. |

## AdParam

Ad request parameters.

## Properties
| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| gender | int | User gender. |
| countryCode | int | Code of the country/region to which an app belongs. |
| requestOptions | RequestOptions | Child-directed setting, setting directed to users under the age of consent, and ad content rating. |

## AdSize

Ad size.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| AdSize({int width, int height}) | Ad size constructor. |

## Constructors

AdSize({int width, int height})

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| width | final int | Ad height. |
| height | final int | Ad width. |

## HwAds

Ad initialization.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future\<void\> | [init()](#init) | Initializes the HUAWEI Ads SDK. |
| Future\<void\> | [initWithAppCode(String appCode)](#initwithappcodestring-appcode) | Initializes the HUAWEI Ads SDK. |
| Future\<String\> | [getSdkVersion](#getsdkversion) | Obtains the version number of the HUAWEI Ads SDK. |
| Future\<RequestOptions\> | [getRequestOptions](#getrequestoptions) | Obtains the global request configuration. |
| Future\<void\> | [setRequestOptions(RequestOptions options)](#setrequestoptionsrequestoptions-options) | Provides the global ad request configuration. |
| Future\<void\> | [setConsent(String consent)](#setconsentstring-consent) | Provides the consent configuration. |
| Future\<void\> | [enableLogger()](#enablelogger) | This method enables the HMSLogger capability which is used for sending usage analytics of Ads SDK's methods to improve the service quality. |
| Future\<void\> | [disableLogger()](#disablelogger) | This method disables the HMSLogger capability which is used for sending usage analytics of Ads SDK's methods to improve the service quality. |
## Methods
### init()

Initializes the HUAWEI Ads SDK.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await HwAds.init();
```

### initWithAppCode(String appCode)

Initializes the HUAWEI Ads SDK.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| appCode | String | App code. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await HwAds.initWithAppCode(appCode);
```

### getSdkVersion

Obtains the version number of the HUAWEI Ads SDK.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Obtains the version number of the HUAWEI Ads SDK. |

**Call Example**

```dart
String sdkVersion = await HwAds.getSdkVersion;
```

### getRequestOptions

Obtains the global request configuration.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<RequestOptions\> | Global RequestOptions. |

**Call Example**

```dart
RequestOptions options = await HwAds.getRequestOptions;
```

### setRequestOptions(RequestOptions options)

Provides the global ad request configuration.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| options | RequestOptions | RequestOptions to set globally. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await HwAds.setRequestOptions(RequestOptions());
```

### setConsent(String consent)

Provides the consent configuration.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| consent | String | Consent. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await HwAds.setConsent(consent);
```

### enableLogger()

This method enables the HMSLogger capability which is used for sending usage analytics of Ads SDK's methods to improve the service quality.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await HwAds.enableLogger();
```

### disableLogger()

This method disables the HMSLogger capability which is used for sending usage analytics of Ads SDK's methods to improve the service quality.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await HwAds.disableLogger();
```
## RequestOptions

Child-directed setting, setting directed to users under the age of consent, and ad content rating.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| RequestOptions({ String adContentClassification, String tagForUnderAgeOfPromise, int tagForChildProtection, int nonPersonalizedAd, String appCountry, String appLang, String consent }) | Constructor for global ad request options. |

## Constructors

RequestOptions({ String adContentClassification, String tagForUnderAgeOfPromise, int tagForChildProtection, int nonPersonalizedAd, String appCountry, String appLang, String consent })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adContentClassification | String | Ad content rating. |
| tagForUnderAgeOfPromise | int| The setting directed to users under the age of consent. |
| tagForChildProtection | int | Child-directed setting. |
| nonPersonalizedAd | int | Whether to request non-personalized ads. |
| appCountry | String | The country code corresponding to the language in which an ad needs to be returned for an app. |
| appLang | String | The language in which an ad needs to be returned for an app. |
| consent | String | Provides the consent configuration. |

## VideoConfiguration

Video configuration used to control video playback.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| VideoConfiguration({ int audioFocusType, bool customizeOperationRequested, bool startMuted }) | Video configuration constructor. |

## Constructors

VideoConfiguration({ int audioFocusType, bool customizeOperationRequested, bool startMuted })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| audioFocusType | int | Video playback scenario where the audio focus needs to be obtained. |
| customizeOperationRequested | bool | Whether a custom video control is used for a video ad. |
 | startMuted | bool | Whether a video is initially muted. |

## **Banner Ad**

Contains classes for banner ads.

## BannerAdSize

Banner ad size.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| const BannerAdSize({ int width, int height }) : super(width: width, height: height) | Banner ad size constructor. Extends ad size. |

## Constants
| Constants | Type| Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| s360x57 | BannerAdSize | Banner ad size: 360 x 57 dp |
| s360x144 | BannerAdSize | Banner ad size: 360 x 144 dp |
| s320x50 | BannerAdSize | Banner ad size: 320 x 50 dp |
| s468x60 | BannerAdSize | Banner ad size: 468 x 60 dp |
| s320x100 | BannerAdSize | Banner ad size: 320 x 100 dp |
| s728x90 | BannerAdSize | Banner ad size: 728 x 90 dp |
| s300x250 | BannerAdSize | Banner ad size: 300 x 250 dp |
| s160x600 | BannerAdSize | Banner ad size: 160 x 600 dp |
| sInvalid | BannerAdSize | Invalid size. No ad can be requested using this size. |
| sDynamic | BannerAdSize | Dynamic banner ad size. The width of the parent layout and the height of the ad content are used. |
| sSmart | BannerAdSize | Dynamic banner ad size. The screen width and an adaptive height are used. |

## Method Summary
| Return Type | Method | Description|
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future\<int\> | [getWidthPx](#getwidthpx) | Obtains the ad width, in pixels. If it fails to be obtained, –1 is returned. |
| Future\<int\> | [getHeightPx](#getheightpx) | Obtains the ad height, in pixels. If it fails to be obtained, –1 is returned. |
| bool | [isAutoHeightSize](#isautoheightsize) | Checks whether an adaptive height is used. |
| bool | [isDynamicSize](#isdynamicsize) | Checks whether a dynamic size is used. |
| bool | [isFullWidthSize](#isfullwidthsize) | Checks whether a full-screen width is used. |
| Future \<BannerAdSize\> | [getCurrentDirectionBannerSize(int width)](#getcurrentdirectionbannersizeint-width) | Creates a banner ad size based on the current device orientation and a custom width. |
| Future \<BannerAdSize\> | [getLandscapeBannerSize(int width)](#getlandscapebannersizeint-width) | Creates a banner ad size based on a custom width in landscape orientation. |
| Future \<BannerAdSize\> | [getPortraitBannerSize(int width)](#getportraitbannersizeint-width) | Creates a banner ad size based on a custom width in portrait orientation. |

## Methods
### getWidthPx

Obtains the ad width, in pixels. If it fails to be obtained, –1 is returned.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<int\> | width in px. |

**Call Example**

```dart
double width = await BannerAdSize.s320x50.getWidthPx;
```
### getHeightPx

Obtains the ad height, in pixels. If it fails to be obtained, –1 is returned.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<int\> | height in px. |

**Call Example**

```dart
double height = await BannerAdSize.s320x50.getHeightPx;
```

### isAutoHeightSize

Checks whether an adaptive height is used.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| bool | Adaptive height is used. |

**Call Example**

```dart
bool isAutoHeight = BannerAdSize.s320x50.isAutoHeightSize;
```

### isDynamicSize

Checks whether a dynamic size is used.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| bool | Dynamic size is used |

**Call Example**

```dart
bool isAutoHeight = BannerAdSize.s320x50.isDynamicSize;
```
### isFullWidthSize

Checks whether a full-screen width is used.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| bool | Whether a full-screen width is used. |

**Call Example**

```dart
bool isFullWidth = BannerAdSize.s320x50.isFullWidthSize;
```

### getCurrentDirectionBannerSize(int width)

Creates a banner ad size based on the current device orientation and a custom width.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future \<BannerAdSize\> | BannerAdSize. |

**Call Example**

```dart
BannerAdSize adSize = await BannerAdSize.getCurrentDirectionBannerSize(int width);
```

### getLandscapeBannerSize(int width)

Creates a banner ad size based on a custom width in landscape orientation.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future \<BannerAdSize\> | BannerAdSize. |

**Call Example**

```dart
BannerAdSize adSize = await BannerAdSize.getLandscapeBannerSize(int width);
```

### getPortraitBannerSize(int width)

Creates a banner ad size based on a custom width in portrait orientation.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future \<BannerAdSize\> | BannerAdSize. |

**Call Example**

```dart
BannerAdSize adSize = await BannerAdSize.getPortraitBannerSize(int width);
```

## BannerAd

Banner ad.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| BannerAd({ String adSlotId, BannerAdSize size, int bannerRefreshTime, AdListener listener, AdParam adParam }) | Banner ad constructor. |

## Constructors

BannerAd({ String adSlotId, BannerAdSize size, int bannerRefreshTime, AdListener listener, AdParam adParam })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adSlotId | String | Ad slot ID. |
| size | BannerAdSize | Size of a banner ad. |
| bannerRefreshTime | int | Rotation interval for banner ads. |
| adParam | AdParam | Ad request. |
| listener | AdListener | Ad listener for an ad. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| void | [setAdListener(AdListener listener)](#setadlisteneradlistener-listener) | Sets an ad listener for an ad. |
| AdListener | [getAdListener](#getadlistener) | Obtains an ad listener. |
| Future\<bool\> | [loadAd()](#loadad) | Loads an ad. |
| Future\<bool\> | [show({ Gravity gravity, double offset })](#show-gravity-gravity-double-offset-) | Displays an ad. |
| Future\<bool\> | [isLoading()](#isloading) | Checks whether ads are being loaded. |
| Future\<bool\> | [pause()](#pause) | Pauses any additional processing related to an ad. |
| Future\<bool\> | [resume()](#resume) | Resumes an ad after the pause() method is called last time. |
| Future\<bool\> | [destroy()](#destroy) | Destroys an ad. |

## Methods
### setAdListener(AdListener listener)

Sets an ad listener for an ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| listener | AdListener | Listener for an ad. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
banner.setAdListener = (AdEvent event, {int errorCode}) {
    // your code here
};
```

### getAdListener

Gets an ad listener for an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| AdListener | Listener for an ad. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
AdListener listener = banner.getAdListener;
```

### loadAd()

Loads an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
await banner.loadAd();
```

### show({ Gravity gravity, double offset })

Displays an ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| gravity | Gravity | Enum that specifies where the banner ad should be displayed on the screen. Gravity options: bottom, center, and top |
| offset | double | Vertical offset from the specified position. NOTE: A positive offset value from the top will slide the ad downwards. Otherwise, the ad slides upwards. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
await banner.show(
    gravity: Gravity.bottom,
    offset: 0.0,
);
```

### isLoading()

Checks whether ads are loading.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether an ad is loading. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
bool loading = await banner.isLoading();
```

### pause()

Pauses any additional processing related to an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
await banner.pause();
```

### resume()

Resumes an ad after the pause() method is called last time.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
await banner.resume();
```

### destroy()

Destroys an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
BannerAd banner = BannerAd(adSlotId: _testAdSlotId, size: BannerAdSize.sSmart, adParam: adParam);
await banner.destroy();
```

## Gravity
## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| bottom | Ad is displayed at the bottom of the screen. |
| center | Ad is displayed at the center of the screen. |
| top | Ad is displayed on the top of the screen. |

## BannerView

Banner Ad Widget which utilizes [Android Platform Views](https://github.com/flutter/flutter/wiki/Android-Platform-Views).

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| BannerView({String adSlotId, BannerAdSize size, Color backgroundColor, bool loadOnStart, Duration refreshDuration, BannerViewController controller, AdParam adParam}) | BannerView constructor. |

## Constructors

BannerView({String adSlotId, BannerAdSize size, Color backgroundColor, bool loadOnStart, Duration refreshDuration, BannerViewController controller, AdParam adParam})

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adSlotId | String | Ad slot ID. |
| size | BannerAdSize | Size of the BannerView. (Default value is BannerAdSize.s320x50.) |
| backgroundColor | Color | Background color of the BannerView. |
| refreshDuration | Duration | Refresh duration of the banner ad. |
| loadOnStart | bool | Should banner bd loaded after Platform View creation. (Default value is true. If there is no BannerViewController specified for this view, this value ignored and overriden to true.) |
| controller | BannerViewController | Controller for listening ad events and operate functions over BannerView. |
| adParam | AdParam | Ad params. |

## BannerViewController

Controller for Banner Ad Widget.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| BannerViewController({AdListener listener, Function onBannerViewCreated}) | BannerViewController constructor. |

## Constructors

BannerViewController({AdListener listener, Function onBannerViewCreated})

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| AdListener | listener | Listener for ad evenets. |
| Function | onBannerViewCreated | Called when BannerView is created. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future\<bool\> | [pause()](#1-pause) | Pauses banner ad. |
| Future\<bool\> | [resume()](#1-resume) | Resumes banner ad. |
| Future\<bool\> | [loadAd()](#1-loadad) | loads ad when loadOnStart specified to false on BannerView. |
| Future\<bool\> | [isLoading()](#isloading) | loading status of banner ad. |
## Methods

### <a name="1-loadad"></a>loadAd()

Loads an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
bannerViewController.loadAd();
```

### isLoading()

Checks whether ads are being loaded.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether an ad is loading. |

**Call Example**

```dart
bool loading = await bannerViewController.isLoading();
```

### <a name="1-pause"></a>pause()

Pauses any additional processing related to an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await bannerViewController.pause();
```

### <a name="1-resume"></a>resume()

Resumes an ad after the pause() method is called last time.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await bannerViewController.resume();
```

## **Interstitial Ad**

Contains classes for interstitial ads.

## InterstitialAd

Interstitial ad.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| InterstitialAd({ String adSlotId, bool openInHmsCore, AdParam adParam, AdListener listener, RewardAdListener rewardAdListener }) | Interstitial ad constructor. |

## Constructors

InterstitialAd({ String adSlotId, bool openInHmsCore, AdParam adParam, AdListener listener, RewardAdListener rewardAdListener })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adSlotId | String | Ad slot ID. |
| openInHmsCore | bool | Decides to reward ad will be opened on independed HmsCore activity outside of client app. |
| adParam | AdParam | Ad request. |
| listener | AdListener | Ad listener. |
| rewardAdListener | RewardAdListener | Rewared ad listener. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| void | [setAdListener(AdListener listener)](#setadlisteneradlistener-listener) | Sets an ad listener for an ad. |
| AdListener | [getAdListener](#1-getadlistener) | Obtains an ad listener. |
| RewardAdListener | [setRewardAdListener(RewardAdListener listener)](#setrewardadlistenerrewardadlistener-listener) | Sets a rewarded ad listener for an interstitial ad. |
| AdListener | [getRewardAdListener](#getrewardadlistener) | Obtains a rewarded ad listener from an interstitial ad. |
| Future\<bool\> | [loadAd()](#2-loadad) | Loads an ad. |
| Future\<bool\> | [isLoading()](#1-isloading) | Checks whether ads are being loaded. |
| Future\<bool\> | [isLoaded()](#isloaded) | Checks whether ad loading is complete. |
| Future\<bool\> | [show()](#show) | Displays an ad. |
| Future\<bool\> | [destroy()](#1-destroy) | Destroys an ad. |

## Methods
### setAdListener(AdListener listener)

Sets an ad listener for an ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| listener | AdListener | Sets an ad listener. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
interstitialAd.setAdListener = (AdEvent event, {int errorCode}) {
    // your code here
};
```

### <a name="1-getadlistener"></a>getAdListener

Sets an ad listener for an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| AdListener | Listener function for ad events. If it is not set, null is returned. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
AdListener listener = interstitialAd.getAdListener;
```

### setRewardAdListener(RewardAdListener listener)

Sets a rewarded ad listener for an interstitial ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| listener | RewardAdListener | Listener function for rewarded ad events. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
interstitialAd.setRewardAdListener = (RewardAdEvent event, {Reward reward, int errorCode}) {
    // your code here
};
```

### getRewardAdListener

Obtains a rewarded ad listener from an interstitial ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| RewardAdListener | Listener function for ad events. If it is not set, null is returned. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
RewardAdListener listener = interstitialAd.getRewardAdListener;
```

### <a name="2-loadad"></a>loadAd()

Initiates a request to load an ad. The android.permission.INTERNET permission must be added. If the ad slot ID is not set, IllegalStateException is thrown on the platform side.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | 	Indicates that the method has finished execution. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
await interstitialAd.loadAd();
```

### show()

Displays an interstitial ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
await interstitialAd.loadAd();
await interstitialAd.show();
```

### <a name="1-isloading"></a>isLoading()

Checks whether ads are being loaded.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether an ad is being loaded. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
bool loading = await interstitialAd.isLoading();
```

### isLoaded()

Checks whether ad loading is complete.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether an ad has been loaded. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
bool loaded = await interstitialAd.isLoaded();
```

### <a name="1-destroy"></a>destroy()

Destroys an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InterstitialAd interstitialAd = InterstitialAd(adSlotId: adSlotId, adParam: _adParam);
await interstitialAd.destroy();
```

## **Reward Ad**

Contains classes and other utilities for rewarded ads.

## Reward

Information about the reward item in a rewarded ad.

## Properties
| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| name | final String | Name of a reward item. |
| amount | final int |Number of reward items. |

## RewardAd

Rewarded ad.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| RewardAd({ String userId, String data, bool openInHmsCore, RewardAdListener listener }) | Rewarded ad constructor. |

## Constructors

RewardAd({ String userId, String data, bool openInHmsCore, RewardAdListener listener })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| userId | String | User ID. |
| data | String | Custom data. |
| openInHmsCore | bool | Decides to reward ad will be opened on independed HmsCore activity outside of client app. |
| listener | RewardAdListener | Reward ad listener. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| RewardAdListener | [getRewardAdListener](#getrewardadlistener) | Obtains a rewarded ad loading listener. |
| void | [setRewardAdListener(RewardAdListener listener)](#1-setrewardadlistener) | Sets a rewarded ad listener. |
| Future\<Reward\> | [getReward()](#getreward) |Obtains reward item information. |
| Future\<bool\> | [loadAd({ String adSlotId, AdParam adParam })](#loadad-string-adslotid-adparam-adparam) | Requests a rewarded ad. |
| Future\<bool\> | [isLoaded()](#1-isloaded) | Checks whether a rewarded ad is successfully loaded. |
| Future\<bool\> | [show()](#show) | Displays a rewarded ad. |
| Future\<bool\> | [pause()](#2-pause) | Pauses a rewarded ad. |
| Future\<bool\> | [resume()](#2-resume) | Resumes a rewarded ad. |
| Future\<bool\> | [destroy()](#2-destroy) | Destroys a rewarded ad. |

## Methods
### getRewardAdListener

Obtains a rewarded ad listener from an interstitial ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| RewardAdListener | Rewarded ad listener. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
```

### <a name="1-setrewardadlistener"></a>setRewardAdListener(RewardAdListener listener)

Sets a rewarded ad listener for an interstitial ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| listener | RewardAdListener | Rewarded ad listener. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
rewardAd.setRewardAdListener = (RewardAdEvent event, {Reward reward, int errorCode}) {
    // your code here
};
```

### getReward()

Obtains reward item information.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<Reward\> | Reward item information. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
Reward reward = await rewardAd.getReward();
```

### loadAd({ String adSlotId, AdParam adParam })

Loads an ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| adSlotId | String | Ad slot ID. |
| adParam | AdParam | Ad request parameters. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
await rewardAd.loadAd(
    adSlotId: _testAdSlotId, 
    adParam: _adParam,
);
```

### show()

Displays an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
await rewardAd.loadAd(
    adSlotId: _testAdSlotId, 
    adParam: _adParam,
);
await rewardAd.show();
```

### <a name="1-isloaded"></a>isLoaded()

Checks whether ad loading is complete.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether ad has been loaded. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
bool loaded = await rewardAd.isLoaded();
```

### pause()
### <a name="2-pause"></a>pause()

Pauses a rewarded ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
await rewardAd.pause();
```

### resume()
### <a name="2-resume"></a>resume()

Resumes a rewarded ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
await rewardAd.resume();
```

### destroy()
### <a name="2-destroy"></a>destroy()

Destroys an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
RewardAd rewardAd = RewardAd();
await rewardAd.destroy();
```

## RewardAdListener

Listener for rewarded ad events.

| Constructor | Description|
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void RewardAdListener(RewardAdEvent event, {Reward reward, int errorCode}) | Ad status listener. |

## RewardAdEvent

Enumerated object that represents the events of rewarded ads.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| loaded | Rewarded ad is successfully loaded. |
| failedToLoad | Rewarded ad fails to be loaded. |
| opened | Rewarded ad is opened. |
| leftApp | User exits an app. |
| closed | Rewarded ad is closed |
| rewarded | Reward item when rewarded ad playback is completed. |
| started | Rewarded ad starts playing. |
| completed | Rewarded ad playback is completed. |
| failedToShow | Rewarded ad fails to be displayed. |

## RewardVerifyConfig

Builder for server-side verification parameters.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| RewardVerifyConfig({ String userId, String data }) | Constructor for a RewardVerifyConfig object. |

## Constructors

RewardVerifyConfig({ String userId, String data })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| userId | String | User ID. |
| data | String | Custom data. |
## **Splash Ad**

Contains classes and other utilities for splash ads.

## SplashAd

Splash ad.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| SplashAd({ SplashAdType adType, SplashAdDisplayListener displayListener, SplashAdLoadListener loadListener, String ownerText, String footerText, String logoResId, String logoBgResId, String mediaNameResId, String sloganResId, String wideSloganResId, int audioFocusType }) | Splash ad constructor. |

## Constructors

SplashAd({ SplashAdType adType, SplashAdDisplayListener displayListener, SplashAdLoadListener loadListener, String ownerText, String footerText, String logoResId, String logoBgResId, String mediaNameResId, String sloganResId, String wideSloganResId, int audioFocusType })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adType | SplashAdType | Splash ad layout type. |
| ownerText | String | Ad owner text. |
| footerText | String | Ad footer text. |
| displayListener | SplashAdDisplayListener | Listener for the splash ad display or click event. |
| loadListener | SplashAdLoadListener | Splash ad loading listener. |
| logoResId | String | App logo resource ID. |
| logoBgResId | String | App background logo resource ID. |
| mediaNameResId | String | App text resource ID. |
| sloganResId | String | Default app launch image in portrait mode, which is displayed before a splash ad is displayed. |
| wideSloganResId | String | Default app launch image in landscape mode, which is displayed before a splash ad is displayed. |
| audioFocusType | int | Audio focus preemption policy for a video splash ad. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future\<bool\> | [preloadAd({ String adSlotId, int orientation, AdParam adParam })](#preloadad-string-adslotid-int-orientation-adparam-adparam-) | Preloads a splash ad. |
| Future\<bool\> | [loadAd({ String adSlotId, int orientation, AdParam adParam, double topMargin})](#loadad-string-adslotid-int-orientation-adparam-adparam-double-topmargin) | Loads and displays a splash ad. |
| Future\<bool\> | [isLoading()](#3-isloading) | Checks whether a splash ad is being loaded. |
| Future\<bool\> | [isLoaded()](#2-isloaded) | Checks whether a splash ad has been loaded. |
| Future\<bool\> | [pause()](#3-pause) | Suspends a splash ad. |
| Future\<bool\> | [resume()](#3-resume) | Resumes a splash ad. |
| Future\<bool\> | [destroy()](#3-destroy) | Destroys a splash ad. |

## Methods
### preloadAd({ String adSlotId, int orientation, AdParam adParam })

Preloads a splash ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| adSlotId | String | Ad unit ID. |
| orientation | int | Screen orientation. |
| adParam | AdParam | Ad request parameters. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
await splashAd.preloadAd(
    adSlotId: _testAdSlotId,
    orientation: SplashAdOrientation.portrait,
    adParam: _adParam,
);
```

### loadAd({ String adSlotId, int orientation, AdParam adParam, double topMargin})

Loads and displays a splash ad.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| adSlotId | String | Ad unit ID. |
| orientation | int | Screen orientation. |
| adParam | AdParam | Ad request parameters. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
await splashAd.loadAd(
    adSlotId: _testAdSlotId,
    orientation: SplashAdOrientation.portrait,
    adParam: _adParam,
);
```

### <a name="3-isloading"></a>isLoading()

Checks whether ads are being loaded.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether a splash ad is being loaded. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
bool loading = await splashAd.isLoading();
```

### <a name="2-isloaded"></a>isLoaded()

Checks whether ad loading is complete.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether a splash ad has been loaded. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
bool loading = await splashAd.isLoaded();
```

### <a name="3-pause"></a>pause()

Pauses ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
await splashAd.pause();
```

### <a name="3-resume"></a>resume()

Resumes ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
await splashAd.resume();
```

### <a name="3-destroy"></a>destroy()

Destroys an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
SplashAd splashAd = SplashAd();
await splashAd.destroy();
```

## SplashAdLoadListener

Listener for splash ad load events.

| Constructor | Description|
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void SplashAdLoadListener(SplashAdLoadEvent event, {int errorCode}) | Splash ad loading listener. |

## SplashAdDisplayListener

Listener for splash ad display events.

| Constructor | Description|
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void SplashAdDisplayListener(SplashAdDisplayEvent event) | Splash ad display listener. |

## SplashAdLoadEvent

Enumerated object that represents the load events of splash ads.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| loaded | Splash ad is loaded successfully. |
| dismissed | Splash ad disappears. |
| failedToLoad | Splash ad fails to be loaded. |

## SplashAdDisplayEvent

Enumerated object that represents the display or click events of splash ads.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| showed | Splash ad is displayed. |
| click | Splash ad is clicked. |

## **Native Ad**

Contains classes and other utilities for native ads.

## NativeAd

Native ad widget which utilizes [Android Platform Views](https://github.com/flutter/flutter/wiki/Android-Platform-Views).

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| NativeAd(String adSlotId, NativeStyle styles, NativeAdType type, NativeAdController controller) | Native ad constructor. |

## Constructors

NativeAd(String adSlotId, NativeStyle styles, NativeAdType type, NativeAdController controller)

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adSlotId | final String | Ad slot ID. |
| styles | final NativeStyles | Style options for the views present in a native ad. |
| type | final NativeAdType | Native ad layout type. |
| controller | final NativeAdController | Controller object that grants control over native ads. |

## NativeAdController

Controller class that gives you access to the methods that are associated with a native ad.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future\<VideoOperator\> | [getVideoOperator()](#getvideooperator) | Obtains the video controller of an ad. |
| void | [gotoWhyThisAdPage()](#gotowhythisadpage) | Goes to the page explaining why an ad is displayed. |
| Future\<bool\> | [isLoading()](#4-isloading) | Checks whether ads are being loaded. |
| void | [setAllowCustomClick()](#setallowcustomclick) | Enables custom tap gestures. |
| Future\<bool\> | [isCustomClickAllowed()](#iscustomclickallowed) | Checks whether custom tap gestures are enabled. |
| Future\<String\> | [getAdSource()](#getadsource) | Obtains an ad source. |
| Future\<String\> | [getDescription()](#getdescription) | Obtains the description of an ad. |
| Future\<String\> | [getCallToAction()](#getcalltoaction) | Obtains the text to be displayed on a button, for example, View Details or Install. |
| Future\<String\> | [getTitle()](#gettitle) | Obtains the title of an ad. |
| Future\<bool\> | [dislikeAd(DislikeAdReason reason)](#dislikeaddislikeadreason-reason) | Does not display the current ad. After this method is called, the current ad is closed. |
| Future\<bool\> | [isCustomDislikeThisAdEnabled()](#iscustomdislikethisadenabled) | Checks whether custom tap gestures are enabled. |
| Future\<bool\> | [triggerClick(Bundle bundle)](#triggerclickbundle-bundle) | Reports a tap. |
| Future\<bool\> | [recordClickEvent()](#recordclickevent) | Reports a custom tap gesture. |
| Future\<bool\> | [recordImpressionEvent(Bundle bundle)](#recordimpressioneventbundle-bundle) | Reports an ad impression. |
| Future\<List\<DislikeAdReason\>\> | [getDislikeAdReasons()](#getdislikeadreasons) | Obtains the choice of not displaying the current ad. |
| void | [destroy()](#4-destroy) | Destroys an ad object. |
| Future\<String\> | [getAdSign()](#getadsign) | Obtains the sign of an ad. |
| Future\<String\> | [getWhyThisAd()](#getwhythisad) | Obtains the url of why this ad showing page. |

## Methods
### getVideoOperator()

Obtains the video controller of an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<VideoOperator\> | Video controller of an ad. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

VideoOperator videoOperator = await controller.getVideoOperator();
```

### gotoWhyThisAdPage()

Goes to the page explaining why an ad is displayed.

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

controller.gotoWhyThisAdPage();
```

### <a name="4-isloading"></a>isLoading()

Checks whether ads are being loaded.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<void> | true if an ad is being loaded; false otherwise. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

bool loading = await controller.isLoading();
```

### setAllowCustomClick()

Enables custom tap gestures.

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

controller.setAllowCustomClick();
```

### isCustomClickAllowed()

Checks whether custom tap gestures are enabled.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether custom click gestures are enabled. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

bool allowed = await controller.isCustomClickAllowed();
```

### getAdSource()

Obtains an ad source.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Ad source. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

String adSource = await controller.getAdSource();
```

### getDescription()

Obtains the description of an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Description. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

String description = await controller.getDescription();
```

### getCallToAction()

Obtains the text to be displayed on a button, for example, View Details or Install.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Text to be displayed on a button. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

String callToAction = await controller.getCallToAction();
```

### getTitle()

Obtains the title of an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Title of an ad. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

String title = await controller.getTitle();
```

### dislikeAd(DislikeAdReason reason)

Does not display the current ad. After this method is called, the current ad is closed.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| reason | DislikeAdReason | Reason why a user chooses not to display the current ad. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

await controller.dislikeAd(DislikeAdReason());
```

### isCustomDislikeThisAdEnabled()

Checks whether custom tap gestures are enabled.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether the custom ad closing is enabled. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

bool enabled = await controller.isCustomDislikeThisAdEnabled();
```

### triggerClick(Bundle bundle)

Reports a tap.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| bundle | Bundle | Bundled data associated with the click. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

await controller.triggerClick(Bundle());
```

### recordClickEvent()

Reports a custom tap gesture.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

await controller.recordClickEvent();
```

### recordImpressionEvent(Bundle bundle)

Reports an ad impression.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| bundle | Bundle | Bundled data associated with the ad impression. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

await controller.recordImpressionEvent(Bundle());
```

### getDislikeAdReasons()

Obtains the choice of not displaying the current ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<List\<DislikeAdReason\>\> | Choice of not displaying the current ad. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

List<DislikeAdReason> reasons = await controller.getDislikeAdReasons();
```

### <a name="4-destroy"></a>destroy()

Destroys an ad object.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

await controller.destroy();
```

### getAdSign()

Obtains the sign of an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Sign of an ad. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

String adSign = await controller.getAdSign();
```

### getWhyThisAd()

Obtains the url of why this ad showing page.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | The url of why this ad showing page. |

**Call Example**

```dart
NativeAdController controller = NativeAdController();

// Use controller in NativeAd Widget
... NativeAd( adSlotId: _testAdSlotId, controller: controller)

String whyThisAdUrl = await controller.getWhyThisAd();
```

## NativeAdConfiguration

Native ad configuration.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| NativeAdConfiguration({ AdSize adSize, int choicesPosition, int mediaDirection, int mediaAspect, bool requestCustomDislikeAd, bool requestMultiImages, bool returnUrlsForImages, VideoConfiguration configuration }) | NativeAdConfiguration constructor. |

## Constructors

NativeAdConfiguration({ AdSize adSize, int choicesPosition, int mediaDirection, int mediaAspect, bool requestCustomDislikeAd, bool requestMultiImages, bool returnUrlsForImages, VideoConfiguration configuration })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adSize | AdSize | Requested ad size. |
| choicesPosition | int | Position of an ad choice icon. |
| mediaDirection | int | Direction of an ad image. |
| mediaAspect | int | Aspect ratio of an ad image. |
| requestCustomDislikeAd | bool | Whether to customize the function of not displaying the ad. |
| requestMultiImages | bool | Whether multiple ad images are requested. |
| returnUrlsForImages | bool | Whether the SDK is allowed to download native ad images. |
| videoConfiguration | VideoConfiguration | Information about a native video. |

## NativeStyles

Style options for the views present in a native ad.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| NativeAdConfiguration({ AdSize adSize, int choicesPosition, int mediaDirection, int mediaAspect, bool requestCustomDislikeAd, bool requestMultiImages, bool returnUrlsForImages, VideoConfiguration configuration }) | NativeAdConfiguration constructor. |

## Constructors

NativeAdConfiguration({ AdSize adSize, int choicesPosition, int mediaDirection, int mediaAspect, bool requestCustomDislikeAd, bool requestMultiImages, bool returnUrlsForImages, VideoConfiguration configuration })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| showMedia | bool | Whether to show the media content of the native ad. |
| mediaImageScaleType | String | Scale type of the native ad image. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| void | [setFlag({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })](#setflag-bool-isvisible-double-fontsize-fontweight-fontweight-color-color-color-bgcolor-) | Sets the style for the ad flag text view. |
| void | [setTitle({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })](#settitle-bool-isvisible-double-fontsize-fontweight-fontweight-color-color-color-bgcolor-) | Sets the style for the ad title text view. |
| void | [setSource({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })](#setsource-bool-isvisible-double-fontsize-fontweight-fontweight-color-color-color-bgcolor-) | Sets the style for the ad owner text view. |
| void | [setDescription({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })](#setdescription-bool-isvisible-double-fontsize-fontweight-fontweight-color-color-color-bgcolor-) | Sets the style for the ad description text view. |
| void | [setCallToAction({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })](#setcalltoaction-bool-isvisible-double-fontsize-fontweight-fontweight-color-color-color-bgcolor-) | Sets the style for the ad action button. |

## Methods

### setFlag({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })

Sets the style for the ad flag text view.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| isVisible | bool | Indicates whether the ad flag component is visible. |
| fontSize | double | Font size of the ad flag text. |
| fontWeight | FontWeight | Font weight of the ad flag text. |
| color | Color | Color of the ad flag text. |
| bgColor | Color | Background color of the ad flag text view. |

**Call Example**

```dart
NativeStyles style = NativeStyles()..setFlag();
```

### setTitle({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })

Sets the style for the ad title text view.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| isVisible | bool | Indicates whether the title component is visible. |
| fontSize | double | Font size of the  title text. |
| fontWeight | FontWeight | Font weight of the title text. |
| color | Color | Color of the title text. |
| bgColor | Color | Background color of the title text view. |

**Call Example**

```dart
NativeStyles style = NativeStyles()..setTitle();
```

### setSource({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })

Sets the style for the ad owner text view.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| isVisible | bool | Indicates whether the owner component is visible. |
| fontSize | double | Font size of the owner text. |
| fontWeight | FontWeight | Font weight of the owner text. |
| color | Color | Color of the owner text. |
| bgColor | Color | Background color of the owner text view. |

**Call Example**

```dart
NativeStyles style = NativeStyles()..setSource();
```

### setDescription({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })

Sets the style for the ad description text view.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| isVisible | bool | Indicates whether the description component is visible. |
| fontSize | double | Font size of the description text. |
| fontWeight | FontWeight | Font weight of the description text. |
| color | Color | Color of the description text. |
| bgColor | Color | Background color of the description text view. |

**Call Example**

```dart
NativeStyles style = NativeStyles()..setDescription();
```

### setCallToAction({ bool isVisible, double fontSize, FontWeight fontWeight, Color color, Color bgColor })

Sets the style for the ad button.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| isVisible | bool | Indicates whether the button is visible. |
| fontSize | double | Font size of the button text. |
| fontWeight | FontWeight | Font weight of the button text. |
| color | Color | Color of the button text. |
| bgColor | Color | Background color of the button. |

**Call Example**

```dart
NativeStyles style = NativeStyles()..setCallToAction();
```

## NativeFontWeight

Enumerated object that represents the available font weights for text.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| normal | Normal text. |
| bold | Bold text. |
| italic | Italic text. |
| boldItalic | Bold and italic text. |

## DislikeAdListener

Listener function for ad dislike events. Ads that a user dislikes will not be displayed any more.

| Constructor | Description|
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void DislikeAdListener(AdEvent event) | Listens for when a native ad is closed |

## DislikeAdReason

Contains the reason why a user dislikes an ad.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| String | [getDescription](#getdescription) | Obtains the reason why a user dislikes an ad. |

## Methods

### getDescription

Obtains the reason why a user dislikes an ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| String | The reason why a user dislikes an ad. |

**Call Example**

```dart
String descriptopn = reason.getDescription;
```

## **Instream Ad**

Contains classes and other utilities for instream ads.

## InstreamAdLoader
## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| InstreamAdLoader(String adId, Duration this.totalDuration, int maxCount, Function(List<InstreamAd\>) onAdLoaded, Function(int errorCode) onAdFailed) | InstreamAdLoader constructor. |

## Constructors

InstreamAdLoader(String adId, Duration this.totalDuration, int maxCount, Function(List<InstreamAd\>) onAdLoaded, Function(int errorCode) onAdFailed)

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| adId | String | Ad id for InstreamAd. |
| totalDuration | Duration | Total maximum duration for requested instream ads. |
| maxCount | int | Maximum ad count. |
| onAdLoaded | Function(List<InstreamAd\>) | Callback for retireving loaded ads. |
| onAdFailed | Function(int errorCode) | Callback for possible errors while ad loading. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future<bool\> | [loadAd(AdParam adParam)](#loadad(adparam-adparam)) | Starts ad loading progress with an Adparam object. |
| Future<bool\> | [isLoading()](#5-isloading) | Returns the status of ad loading progress. |

## Methods

### loadAd(AdParam adParam)

Starts ad loading progress with an Adparam object.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| adParam | AdParam | AdParam. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
adLoader = InstreamAdLoader(
    adId: 'testy3cglm3pj0',
    totalDuration: Duration(minutes: 1),
    maxCount: 8,
    onAdLoaded: (List<InstreamAd>) { },
    onAdFailed: (int errorCode) { },
);
await adLoader.loadAd(AdParam());
```

### <a name="4-isloading"></a>isLoading()

Returns the status of ad loading progress.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether an ad is being loaded. |

**Call Example**

```dart
adLoader = InstreamAdLoader(
    adId: 'testy3cglm3pj0',
    totalDuration: Duration(minutes: 1),
    maxCount: 8,
    onAdLoaded: (List<InstreamAd>) { },
    onAdFailed: (int errorCode) { },
);
bool isLoading = await adLoader.isLoading();
```

## InstreamAdView

Widget for displaying instream ads.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| InstreamAdView(List<InstreamAd\> instreamAds, InstreamAdViewController controller) | InstreamAdView Widget constructor. |

## Constructors

InstreamAdView(List<InstreamAd\> instreamAds, InstreamAdViewController controller)

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| instreamAds | List<InstreamAd\> | Instream Ads to display. |
| controller | InstreamAdViewController | Controller for InstreamAdView. |

## InstreamAdViewController

Controller object for InstreamAdView.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| InstreamAdViewController(Function onClick, Function(InstreamAd) onSegmentMediaChange, Function(int per, int playTime) onMediaProgress, Function(int playTime) onMediaStart, Function(int playTime) onMediaPause, Function(int playTime) onMediaStop, Function(int playTime) onMediaCompletion, Function(int playTime, int errorCode, int extra) onMediaError, Function onMute, Function onUnMute) | InstreamAdViewController contructor. |

## Constructors

InstreamAdViewController(Function onClick, Function(InstreamAd) onSegmentMediaChange, Function(int per, int playTime) onMediaProgress, Function(int playTime) onMediaStart, Function(int playTime) onMediaPause, Function(int playTime) onMediaStop, Function(int playTime) onMediaCompletion, Function(int playTime, int errorCode, int extra) onMediaError, Function onMute, Function onUnMute)

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| onClick | Function | Called when InstreamAdView clicked. |
| onSegmentMediaChange | Function(InstreamAd ad) | Called when InstreamAdView changes InstreamAd. |
| onMediaProgress | Function(int per, int playTime) | Called while InstreamAd playing. |
| onMediaStart | Function(int playTime) | Called when InstreamAd starts to play. |
| onMediaPause | Function(int playTime) | Called when InstreamAd paused. |
| onMediaStop | Function(int playTime) | Called when InstreamAd stopped. |
| onMediaCompletion | Function(int playTime) | Called when InstreamAd complated. |
| onMediaError | Function(int playTime, int errorCode, int extra) | Called when InstreamAd encounter an error while playing. |
| onMute | Function | Called when InstreamAd muted. |
| onUnMute | Function | Called when InstreamAd unmuted. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future<bool\> | [destroy()](#5-destroy) | Destroys InstreamAdView. |
| Future<bool\> | [isPlaying()](#isplaying) | Obtains whether the ad is playing. |
| Future<bool\> | [mute()](#mute) | Mutes InstreamAd. |
| Future<bool\> | [onClose()](#onclose) | Closes InstreamAd. |
| Future<bool\> | [pause()](#4-pause) | Pauses InstreamAd. |
| Future<bool\> | [play()](#play) | Plays InstreamAd. |
| Future<bool\> | [removeInstreamMediaChangeListener()](#removeinstreammediachangelistener) | Removes MediaChangeListener. Media change related callbacks not called after this execution. |
| Future<bool\> | [removeInstreamMediaStateListener()](#removeinstreammediastatelistener) | Removes MediaStateListener. Media state related callbacks not called after this execution. |
| Future<bool\> | [removeMediaMuteListener()](#removemediamutelistener) | Removes MediaMuteListener. Media mute related callbacks not called after this execution. |
| Future<bool\> | [stop()](#stop) | Stops InstreamAd. |
| Future<bool\> | [unmute()](#unmute) | Unmutes InstreamAd. |

## Methods

### <a name="5-destroy"></a>destroy()

Destroys InstreamAdView.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.destroy();
```

### isPlaying()

Obtains whether the ad is playing.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether an ad is playing. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

bool playing = await controller.isPlaying();
```

### mute()

Mutes InstreamAd.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.mute();
```

### onClose()

Closes InstreamAd.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.onClose();
```

### <a name="4-pause"></a>pause()

Pauses InstreamAd.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.pause();
```

### play()

Plays InstreamAd.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.play();
```

### removeInstreamMediaChangeListener()

Removes MediaChangeListener. Media change related callbacks not called after this execution.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.removeInstreamMediaChangeListener();
```

### removeInstreamMediaStateListener()

Removes MediaStateListener. Media state related callbacks not called after this execution.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.removeInstreamMediaStateListener();
```

### removeMediaMuteListener()

Removes MediaMuteListener. Media mute related callbacks not called after this execution.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.removeMediaMuteListener();
```

### stop()

Stops InstreamAd.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.stop();
```

### unmute()

Mutes InstreamAd.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
InstreamAdViewController controller = InstreamAdViewController();

// Use controller in InstreamAdView Widget
... InstreamAdView(instreamAds: instreamAds, controller: adViewController)

await controller.unmute();
```

## InstreamAd

InstreamAd objects will be created for each loaded Instream Ad.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| InstreamAd(int id) | InstreamAd constuctor. Created by plugin. |

## Constructors

InstreamAd(int id)

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| id | String | Identifier for platform channel. Used by plugin. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future<String\> | [getAdSource()](#1-getadsource) | Obtains ad source text. |
| Future<String\> | [getCallToAction()](#1-getcalltoaction) | Obtains call to action text. |
| Future<int\> | [getDuration()](#getduration) | Obtains ad duration in milliseconds. |
| Future<String\> | [getWhyThisAd()](#1-getwhythisad) | Obtains the url of why this ad showing page. |
| Future<String\> | [getAdSign()](#1-getadsign) | Obtains the ad sign. |
| Future<bool\> | [isClicked()](#isclicked) | Obtains whether the ad is clicked. |
| Future<bool\> | [isExpired()](#isexpired) | Obtains whether the ad is expired. |
| Future<bool\> | [isImageAd()](#isimagead) | Obtains whether the ad is an image ad. |
| Future<bool\> | [isShown()](#isshown) | Obtains whether the ad is shown. |
| Future<bool\> | [isVideoAd()](#isvideoad) | Obtains whether the ad is a video ad. |
| Future<bool\> | [gotoWhyThisAdPage()](#1-gotowhythisadpage) | Launches the why this ad page. |

## Methods

### <a name="1-getadsource"></a>getAdSource()

Obtains ad source text.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Ad source text. |

**Call Example**

```dart
String adSource = await instreamAd.getAdSource();
```

### <a name="1-getcalltoaction"></a>getCallToAction()

Obtains call to action text.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Call to action text. |

**Call Example**

```dart
String callToAction = await instreamAd.getCallToAction();
```

### getDuration()

Obtains ad duration in milliseconds.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<int\> | Ad duration in milliseconds. |

**Call Example**

```dart
int durationInMilliseconds = await instreamAd.getDuration();
```

### <a name="1-getwhythisad"></a>getWhyThisAd()

Obtains the url of why this ad showing page.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | The url of why this ad showing page. |

**Call Example**

```dart
String whyThisAd = await instreamAd.getWhyThisAd();
```

### <a name="1-getadsign"></a>getAdSign()

Obtains the ad sign.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Ad sign. |

**Call Example**

```dart
String adSign = await instreamAd.getAdSign();
```

### isClicked()

Obtains whether the ad is clicked.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether the ad is clicked. |

**Call Example**

```dart
bool clicked = await instreamAd.isClicked();
```

### isExpired()

Obtains whether the ad is expired.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether the ad is expired. |

**Call Example**

```dart
bool expired = await instreamAd.isExpired();
```

### isImageAd()

Obtains whether the ad is an image ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether the ad is an image ad. |

**Call Example**

```dart
bool isImage = await instreamAd.isImageAd();
```

### isShown()

Obtains whether the ad is shown.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether the ad is shown. |

**Call Example**

```dart
bool shown = await instreamAd.isShown();
```

### isVideoAd()

Obtains whether the ad is a video ad.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Whether the ad is an image ad. |

**Call Example**

```dart
bool isVideo = await instreamAd.isVideoAd();
```

### <a name="1-gotowhythisadpage"></a>gotoWhyThisAdPage()

Launches the why this ad page.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await instreamAd.gotoWhyThisAdPage();
```

# **Consent**

Contains classes and other utilities for processing user consent.

## Consent

Provides functions to process user consent.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Consent | [instance](#instance) | Retrieves the test device id. |
| Future\<String\> | [getTestDeviceId()](#gettestdeviceid) | Retrieves the test device id. |
| Future\<bool\> | [addTestDeviceId(String deviceId)](#addtestdeviceidstring-deviceid) | Adds a new test device id. |
| Future\<bool\> | [setDebugNeedConsent(DebugNeedConsent needConsent)](#setdebugneedconsentdebugneedconsent-needconsent) | Set whether user consent is needed. |
| Future\<bool\> | [setUnderAgeOfPromise(bool ageOfPromise)](#setunderageofpromisebool-ageofpromise) | Whether to process ad requests as directed to users under the age of consent. |
| Future\<bool\> | [setConsentStatus(ConsentStatus status)](#setconsentstatusconsentstatus-status) | Whether to display personalized ads. |
| void | [requestConsentUpdate(ConsentUpdateListener listener)](#requestconsentupdateconsentupdatelistener-listener) | Request consent information. |
| Future\<bool\> | [updateSharedPreferences(String key, int value)](#updatesharedpreferencesstring-key-int-value) | Update the shared preferences related to user consent |
| Future\<int\> | [getSharedPreferences(String key)](#getsharedpreferencesstring-key) | Retrieve a shared preference related to user consent. |

## Methods

### instance

Returns a singleton Consent instance.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Consent | Consent instance. |

**Call Example**

```dart
Consent instance = Consent.instance;
```

### getTestDeviceId()

Retrieves the test device id.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<String\> | Test device ID. |

**Call Example**

```dart
String deviceId = await Consent.instance.getTestDeviceId();
```

### addTestDeviceId(String deviceId)

Adds a new test device id.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| deviceId | String | Test device ID. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await Consent.instance.addTestDeviceId(deviceId);
```

### setDebugNeedConsent(DebugNeedConsent needConsent)

Set whether user consent is needed.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| needConsent | DebugNeedConsent | Whether user consent is needed. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await Consent.instance.setDebugNeedConsent(DebugNeedConsent());
```

### setUnderAgeOfPromise(bool ageOfPromise)

Whether to process ad requests as directed to users under the age of consent.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| ageOfPromise | bool | Indicates whether to process ad requests as directed to users under the age of consent. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await Consent.instance.setUnderAgeOfPromise(promise);
```

### setConsentStatus(ConsentStatus status)

Whether to display personalized ads.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| status | ConsentStatus | Status that indicates whether the user has given consent.  |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await Consent.instance.setConsentStatus(ConsentStatus.PERSONALIZED);
```

### requestConsentUpdate(ConsentUpdateListener listener)

Request consent information.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| listener | ConsentUpdateListener | Listener function for consent update events. |

**Call Example**

```dart
await Consent.instance.requestConsentUpdate((
  ConsentUpdateEvent event, {
  ConsentStatus consentStatus,
  bool isNeedConsent,
  List<AdProvider> adProviders,
  String description,
}));
```

### updateSharedPreferences(String key, int value)

Update the shared preferences related to user consent

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| key | String | One of the predefined keys used to update the app's shared preferences for the purpose of testing the consent service. |
| value | int | One of the predefined values used to update the app's shared preferences for the purpose of testing the consent service. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | Indicates that the method has finished execution. |

**Call Example**

```dart
await Consent.instance.updateSharedPreferences(key, value);
```

### getSharedPreferences(String key)

Retrieve a shared preference related to user consent.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| key | String | One of the predefined keys used to obtain the app's shared preferences for the purpose of testing the consent service. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<int\> | Shared preference related to user consent. |

**Call Example**

```dart
int value = await Consent.instance.getSharedPreferences(key);
```

## ConsentUpdateListener

Enumerated object that represents the consent update events.

| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void ConsentUpdateListener(ConsentUpdateEvent event, {ConsentStatus consentStatus, bool isNeedConsent, List<AdProvider> adProviders, String description}) | Ad status listener. |

## ConsentUpdateEvent

Enumerated object that represents the consent update events.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| success | Consent update was successful. |
| failed | Consent update failed. |

## AdProvider

Contains information about ad providers.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| AdProvider({ String id, String name, String serviceArea, String privacyPolicyUrl }) | Ad provider constructor. |

## Constructors

AdProvider({ String id, String name, String serviceArea, String privacyPolicyUrl })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| id | String | Ad provider id. |
| name | String | Ad provider name. |
| serviceArea | String | Service area information. |
| privacyPolicyUrl | String | Url for privacy policy. |

# **Identifier Service**

Contains classes for [Identifier Service](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides-V1/identifier-service-0000001050194446-V1). After the hms-ads-identifier SDK is integrated, you can use related APIs to obtain the OAID and setting of Disable personalized ads.

## AdvertisingIdClient

Obtains an AdvertisingIdClientInfo object.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Future\<AdvertisingIdClientInfo\> | [getAdvertisingIdInfo()](#getadvertisingidinfo) | Obtains the OAID and setting of Disable personalized ads. |
| Future\<bool\> | [verifyAdId(String adId, bool limitTracking)](#verifyadidstring-adid-bool-limittracking) | Verifies the OAID and setting of Disable personalized ads. |

## Methods

### getAdvertisingIdInfo()

Obtains the OAID and setting of Disable personalized ads.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<AdvertisingIdClientInfo\> | If the operation is successful, Future succeeds to the AdvertisingIdClientInfo object. If the API fails to be called, IOException is thrown on the platform side. |

**Call Example**

```dart
AdvertisingIdClientInfo client = await AdvertisingIdClient.getAdvertisingIdInfo();
```

### verifyAdId(String adId, bool limitTracking)

Verifies the OAID and setting of Disable personalized ads.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| adId | String | OAID. |
| limitTracking | bool | Setting of Disable personalized ads. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | true if the OAID and setting of Disable personalized ads are valid. false if the OAID and setting of Disable personalized ads are invalid. |

**Call Example**

```dart
await AdvertisingIdClient.verifyAdId(adId, limitTracking);
```

## AdvertisingIdClientInfo

Obtains the OAID and setting of Disable personalized ads.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| String | [getId](#getid) | Obtains the current OAID. |
| bool | [isLimitAdTrackingEnabled](#islimitadtrackingenabled) | Obtains the current setting of Disable personalized ads. |

## Methods

### getId

Obtains the current OAID.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| String | An OAID. Example: fcffd123-372b-d965-daff-77726234f5ec |

**Call Example**

```dart
String id = clientiInfo.getId;
```

### isLimitAdTrackingEnabled

Obtains the current setting of Disable personalized ads.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| bool | true if personalized ads are disabled. false if personalized ads are not disabled. |

**Call Example**

```dart
bool trackingEnabled = clientiInfo.isLimitAdTrackingEnabled;
```

## **Identifier Service - InstallReferrer**

Contains classes for [Identifier Service](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides-V1/identifier-service-0000001050194446-V1). After the ads-installreferrer SDK is integrated, you can use related APIs to obtain install referrer information.

## InstallReferrerClient

Obtains install referrer information.

## Constructor Summary
| Constructor | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| InstallReferrerClient({ InstallReferrerStateListener stateListener, bool test }) | Install referrer client constructor. |

## Constructors

InstallReferrerClient({ InstallReferrerStateListener stateListener, bool test })

| Name | Type | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| stateListener | InstallReferrerStateListener | Install referrer connection state listener. |
| test | bool | Specify if it is test. |

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| void | [setTest](#settest) | Sets whether to run the service in test mode. |
| void | [startConnection([bool isTest])](#startconnectionbool-istest) | Starts the connection to the install referrer service. |
| void | [endConnection()](#endconnection) | Ends the service connection and releases all occupied resources. |
| Future\<bool\> | [isReady()](#isready) | Indicates whether the service connection is ready. |
| Future\<ReferrerDetails\> | [getInstallReferrer()](#getinstallreferrer) | Obtains install referrer information. |

## Methods

### setTest

Sets whether to run the service in test mode.

**Call Example**

```dart
InstallReferrerClient referer = new InstallReferrerClient();
referer.setTest = true;
```

### startConnection([bool isTest])

Starts the connection to the install referrer service.

**Parameters**

| Name  | Type  | Description            |
| ----- | ----- | ---------------------- |
| isTest | bool | Indicates whether to use the test mode. Set it to true for testing. |

**Call Example**

```dart
InstallReferrerClient referer = new InstallReferrerClient();
await referer.startConnection();
```

### endConnection()

Ends the service connection and releases all occupied resources.

**Call Example**

```dart
InstallReferrerClient referer = new InstallReferrerClient();
await referer.endConnection();
```

### isReady()

Indicates whether the service connection is ready.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<bool\> | true if the service is connected and ready to be called. false if the service has not been connected and cannot be called. |

**Call Example**

```dart
InstallReferrerClient referer = new InstallReferrerClient();
bool isReady = await referer.isReady();
```

### getInstallReferrer()

Obtains install referrer information

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| Future\<ReferrerDetails\> | Referrer information. |

**Call Example**

```dart
InstallReferrerClient referer = new InstallReferrerClient();
ReferrerDetails details = await referer.getInstallReferrer;
```

## InstallReferrerStateEvent

Enumerated object that represents the events of install referrer connections.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| setupFinished | Service connection is complete. |
| connectionClosed | Service connection is closed. |
| disconnected | Connection is lost and the service is disconnected. |

## InstallReferrerStateListener

Listener for install referrer state events.

| Constructor | Description|
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| void InstallReferrerStateListener(InstallReferrerStateEvent event, {ReferrerResponse responseCode}) | Install referrer connection state listener. |

## ReferrerResponse

Enumerated object that represents install referrer result codes.

## Enum Values
| Values | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| disconnected | Failed to connect to the service. |
| ok | Connected to the service successfully. |
| unavailable | The service does not exist. |
| featureNotSupported | The service is not supported. |
| developerError | A call error occurred. |

## ReferrerDetails

Describes install referrer information.

## Method Summary
| Return Type | Method | Description |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| String | [getInstallReferrer](#getinstallreferrer) | Obtains install referrer information. |
| int | [getReferrerClickTimestampMillisecond](#getreferrerclicktimestampmillisecond) | Obtains the ad click timestamp, in milliseconds. |
| int | [getInstallBeginTimestampMillisecond](#getinstallbegintimestampmillisecond) | Obtains the app installation timestamp, in milliseconds. |

## Methods

### getInstallReferrer

Obtains install referrer information.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| String | An install referrer defined by you. Example: this is test install referrer. |

**Call Example**

```dart
String installreferer = refererDetails.getInstallReferrer;
```

### getReferrerClickTimestampMillisecond

Checks whether ads are being loaded.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| int | Timestamp when the ad was clicked. The value is the number of milliseconds since 1970-01-01 00:00:00 UTC. Example: 1481009302123 |

**Call Example**

```dart
int clickTimestamp = refererDetails.getReferrerClickTimestampMillisecond;
```

### getInstallBeginTimestampMillisecond

Obtains the app installation timestamp, in milliseconds.

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| int | Timestamp when the app was installed. The value is the number of milliseconds since 1970-01-01 00:00:00 UTC. Example: 1481009302123 |

**Call Example**

```dart
int beginTimestamp = refererDetails.getInstallBeginTimestampMillisecond;
```

# 4. Configuration Description

No.

# 5. Preparing for Release

Before building a release version of your app you may need to customize the <span>**proguard-rules</span>.pro** obfuscation configuration file to prevent the HMS Core SDK from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

**<flutter_project>/android/app/proguard-rules&#46;pro**
```
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-keep class com.huawei.hms.flutter.** { *; }
-repackageclasses
```

**<flutter_project>/android/app/build.gradle**
```gradle
buildTypes {
    debug {
        signingConfig signingConfigs.config
    }
    release {
        signingConfig signingConfigs.config
        // Enables code shrinking, obfuscation and optimization for release builds
        minifyEnabled true
        // Unused resources will be removed.
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
   }
}
```

## 6. Sample Project

This plugin includes a demo project in the [example](example) folder, there you can find more usage examples.

# 7. Questions or Issues

If you have questions about how to use HMS samples, try the following options:
- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
**huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

# 8. Licensing and Terms

Huawei Ads Kit Flutter Plugin uses the Apache 2.0 license.