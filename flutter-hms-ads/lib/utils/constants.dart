/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
class ConsentConstant {
  static const String spName = "HuaweiAdsSdkSharedPreferences";
  static const String spProtocolKey = "protocol";
  static const String spConsentKey = "consent";
  static const int defaultSpProtocolValue = 0;
  static const int defaultSpConsentValue = -1;
}

enum DebugNeedConsent {
  DEBUG_DISABLED,
  DEBUG_NEED_CONSENT,
  DEBUG_NOT_NEED_CONSENT
}

enum ConsentStatus { PERSONALIZED, NON_PERSONALIZED, UNKNOWN }

class Gender {
  static const int unknown = 0;
  static const int male = 1;
  static const int female = 2;
}

class NonPersonalizedAd {
  static const int allowNonPersonalized = 1;
  static const int allowAll = 0;
}

class AudioFocusType {
  static const int gainAudioFocusAll = 0;
  static const int notGainAutoFocusWhenMute = 1;
  static const int notGainAudioFocusAll = 2;
}

class ContentClassification {
  static const String w = "W";
  static const String pi = "PI";
  static const String j = "J";
  static const String a = "A";
  static const String unknown = "";
}

class UnderAge {
  static const int promiseTrue = 1;
  static const int promiseFalse = 0;
  static const int promiseUnspecified = -1;
}

class TagForChild {
  static const int protectionUnspecified = -1;
  static const int protectionFalse = 0;
  static const int protectionTrue = 1;
}

class AdParamErrorCode {
  static const int inner = 0;
  static const int invalidRequest = 1;
  static const int networkError = 2;
  static const int noAd = 3;
  static const int adLoading = 4;
  static const int lowApi = 5;
  static const int bannerAdExpire = 6;
  static const int bannerAdCancel = 7;
  static const int hmsNotSupportedSetApp = 8;
}

class RewardAdErrorCode {
  static const int internal = 0;
  static const int reused = 1;
  static const int notLoaded = 2;
  static const int background = 3;
}

class SplashAdOrientation {
  static const int landscape = 0;
  static const int portrait = 1;
}

class NativeAdAssetNames {
  static const String title = "1";
  static const String callToAction = "2";
  static const String icon = "3";
  static const String desc = "4";
  static const String adSource = "5";
  static const String image = "8";
  static const String mediaVideo = "10";
  static const String choicesContainer = "11";
}

class NativeAdChoicesPosition {
  static const int bottomLeft = 3;
  static const int bottomRight = 2;
  static const int topLeft = 0;
  static const int topRight = 1;
  static const int invisible = 4;
}

class NativeAdDirection {
  static const int any = 0;
  static const int landscape = 2;
  static const int portrait = 1;
}

class ImageViewScaleType {
  static const String fitStart = 'FIT_START';
  static const String fitCenter = 'FIT_CENTER';
  static const String fitEnd = 'FIT_END';
  static const String center = 'CENTER';
  static const String centerCrop = 'CENTER_CROP';
  static const String centerInside = 'CENTER_INSIDE';
}

class ErrorCodes {
  static const String NULL_PARAM = "900";
  static const String NOT_FOUND = "901";
  static const String INVALID_PARAM = "902";
  static const String LOAD_FAILED = "903";
  static const String VERIFY_FAILED = "904";
  static const String INNER = "905";
  static const String NULL_VIEW = "906";
  static const String NULL_AD = "907";
  static const String NOT_READY = "908";
}
