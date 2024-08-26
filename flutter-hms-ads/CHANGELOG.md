## 13.4.72+300

- Added the `autoPlayNetwork` property to the `VideoConfiguration` class.
- Added the `AutoPlayNetwork` enum.
- Added the `getBiddingInfo` method to the to the `NativeAd`, `InstreamAd`, `RewardAd`, `InterstitialAd`, `InstreamAd`, `BannerAd` and `SplashAd`  classes.
- Added the `tMax` property to the `AdParam` and `RequestOptions` classes.
- Added the `addBiddingParamMap` and `setBiddingParamMap` methods to the `AdParam` and `RequestOptions` classes.
- Added the `BiddingParam` and `BiddingInfo` classes.

## 13.4.69+302

- Added the `AppInfo` class which is the return type of `getAppInfo` method.
- Added the `PromoteInfo` class which is the return type of `getPromoteInfo` method.
- Added the `showAppDetailPage`, `getPromoteInfo`, `getAppInfo`, `showPrivacyPolicy`, `showPermissionPage` methods to the `NativeAdController` class.

## 13.4.67+302

- Added the `showTransparencyDialog` and `hideTransparencyDialog` methods to the `InstreamAdView` class.
- Added the `isTransparencyOpen` and `getTransparencyTplUrl` methods to the `NativeAd` and `InstreamAd` classes.

## 13.4.65+300

- Updated Ads to the latest version 13.4.65.300.

## 13.4.61+304

- Optimized the landing page download experience.
- Added the AdvertiserInfo class to obtain and display advertiser information, adapting the Russian advertising law.
- Added the `hasAdvertiserInfo` and `getAdvertiserInfo` methods to the `InstreamAd` and `NativeAd` classes.
- Added the `showAdvertiserInfoDialog` and `hideAdvertiserInfoDialog` methods to the `InstreamAdViewController` and `NativeAdController` classes.

## 13.4.58+304

- Optimized the feedback function of HUAWEI Ads for users to give comments.
- Added the getInstallChannel method to the ReferrerDetails class to support the function of obtaining the channel information.
- Fixed an issue that caused BannerAd listeners to not work properly.

## 13.4.55+301

- Fixed an issue when destroying NativeAd.
- Fixed an issue that caused RewardAd listeners to not work properly.
- Fixed an issue that caused InterstitialAd listeners to not work properly.
- Fixed an issue that caused some device information to be processed without user agreement.

## 13.4.55+300

- Optimized tablet UX experience.
- Optimized the interactive landing page experience of rewarded ads.
- Optimized the interaction experience when requesting a splash ad for the first time.
- Added the advanced banner ad and its dimensions.
- Added the getAppActivateStyle, setAppActivateStyle, setAppInstalledNotify, and isAppInstalledNotify methods to the HwAds class.
- Added the pop-up for reminding users of app activation.
- Added the location to the AdParam class for setting the location information passed by your app.
- Added the contentBundle to the AdParam class for setting the content bundle.
- Added VAST ads.
- Supported on devices running Android 12.
- Supported app download while video watching in rewarded ads.
- Fixed adaption issues with the app download button in ads.
- Allowed users to swipe up on a splash ad screen to access the app details page or directly launch the advertised app.
- Notified apps of the request status of an express splash ad when necessary.

## 13.4.45+309

- Deleted the capability of prompting users to install HMS Core (APK).

## 13.4.45+308

- Native Ad - New template with App Download Button.
- Ads Kit sdk updated to 13.4.45.308.

## 13.4.40+302

- Nullsafety migration.
- Ads Kit sdk updated to 13.4.40.302.

## 13.4.35+301

- Updated HMSLogger.

## 13.4.35+300

- Banner Ad - Platform View implementation
- Instream Ad - implementation
- HMSLogger - implementation
- New function implementations comes with 'HMS Ads Kit: 13.4.35.300'
- General bug fixes and improvements

## 13.4.32

- Initial release.

