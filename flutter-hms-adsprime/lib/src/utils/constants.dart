/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_adsprime.dart';

class ActivateStyle {
  /// Banner at the bottom.
  static const ActivateStyle BOTTOM_BANNER = ActivateStyle._(1);

  /// Confirmation pop-up.
  static const ActivateStyle CONFIRM_DIALOG = ActivateStyle._(2);

  final int value;
  const ActivateStyle._(this.value);
}

class AdParamErrorCode {
  /// Internal error.
  /// For example, an invalid response is received from the ad server.
  static const AdParamErrorCode INNER = AdParamErrorCode._(0);

  /// Invalid ad request.
  /// For example, the ad unit ID is not set or the banner ad dimensions are invalid.
  static const AdParamErrorCode INVALID_REQUEST = AdParamErrorCode._(1);

  /// Failed to send the ad request due to a network connection error.
  static const AdParamErrorCode NETWORK_ERROR = AdParamErrorCode._(2);

  /// The ad request is sent successfully, but the server returns a response indicating no available ad assets.
  static const AdParamErrorCode NO_AD = AdParamErrorCode._(3);

  /// The ad is being loaded and cannot be requested again.
  static const AdParamErrorCode AD_LOADING = AdParamErrorCode._(4);

  /// The API version is not supported by Ads Kit.
  static const AdParamErrorCode LOW_API = AdParamErrorCode._(5);

  /// The banner ad has expired.
  static const AdParamErrorCode BANNER_AD_EXPIRE = AdParamErrorCode._(6);

  /// The banner ad task is removed.
  static const AdParamErrorCode BANNER_AD_CANCEL = AdParamErrorCode._(7);

  /// The HMS Core (APK) version does not support the setting of AppInfo.
  static const AdParamErrorCode HMS_NOT_SUPPORT_SET_APP = AdParamErrorCode._(8);

  final int value;
  const AdParamErrorCode._(this.value);
}

class ContentClassification {
  /// Content suitable for widespread audiences.
  static const ContentClassification AD_CONTENT_CLASSIFICATION_W =
      ContentClassification._('W');

  /// Content suitable for audiences with parental guidance.
  static const ContentClassification AD_CONTENT_CLASSIFICATION_PI =
      ContentClassification._('PI');

  /// Content suitable for junior and older audiences.
  static const ContentClassification AD_CONTENT_CLASSIFICATION_J =
      ContentClassification._('J');

  /// Content suitable for adults only.
  static const ContentClassification AD_CONTENT_CLASSIFICATION_A =
      ContentClassification._('A');

  final String value;
  const ContentClassification._(this.value);
}

class Gender {
  /// Unknown.
  static const Gender UNKNOWN = Gender._(0);

  /// Male.
  static const Gender MALE = Gender._(1);

  /// Female.
  static const Gender FEMALE = Gender._(2);

  final int value;
  const Gender._(this.value);
}

class NonPersonalizedAd {
  /// Requests both personalized and non-personalized ads.
  static const NonPersonalizedAd ALLOW_ALL = NonPersonalizedAd._(0);

  /// Requests only non-personalized ads.
  static const NonPersonalizedAd ALLOW_NON_PERSONALIZED =
      NonPersonalizedAd._(1);

  final int value;
  const NonPersonalizedAd._(this.value);
}

class TagForChild {
  /// Whether to process ad requests according to the COPPA is not specified.
  static const TagForChild TAG_FOR_CHILD_PROTECTION_UNSPECIFIED =
      TagForChild._(-1);

  /// Does not process ad requests according to the COPPA.
  static const TagForChild TAG_FOR_CHILD_PROTECTION_FALSE = TagForChild._(0);

  /// Processes ad requests according to the COPPA.
  static const TagForChild TAG_FOR_CHILD_PROTECTION_TRUE = TagForChild._(1);

  final int value;
  const TagForChild._(this.value);
}

class UnderAge {
  /// Whether to process ad requests as directed to users under the age of consent is not specified.
  static const UnderAge PROMISE_UNSPECIFIED = UnderAge._(-1);

  /// Does not process ad requests as directed to users under the age of consent.
  static const UnderAge PROMISE_FALSE = UnderAge._(0);

  /// Processes ad requests as directed to users under the age of consent.
  static const UnderAge PROMISE_TRUE = UnderAge._(1);

  final int value;
  const UnderAge._(this.value);
}

class NativeAdAssetNames {
  /// Title asset ID.
  static const NativeAdAssetNames TITLE = NativeAdAssetNames._('1');

  /// Button text asset ID.
  static const NativeAdAssetNames CALL_TO_ACTION = NativeAdAssetNames._('2');

  /// Icon asset ID.
  static const NativeAdAssetNames ICON = NativeAdAssetNames._('3');

  /// Description asset ID.
  static const NativeAdAssetNames DESC = NativeAdAssetNames._('4');

  /// Advertiser asset ID.
  static const NativeAdAssetNames AD_SOURCE = NativeAdAssetNames._('5');

  /// Image asset ID.
  static const NativeAdAssetNames IMAGE = NativeAdAssetNames._('8');

  /// MediaView asset ID.
  static const NativeAdAssetNames MEDIA_VIDEO = NativeAdAssetNames._('10');

  /// Ad choice asset ID.
  static const NativeAdAssetNames CHOICES_CONTAINER =
      NativeAdAssetNames._('11');

  final String value;
  const NativeAdAssetNames._(this.value);
}

class NativeAdChoicesPosition {
  /// The ad choice icon is in the top left corner.
  static const NativeAdChoicesPosition TOP_LEFT = NativeAdChoicesPosition._(0);

  /// The ad choice icon is in the top right corner.
  static const NativeAdChoicesPosition TOP_RIGHT = NativeAdChoicesPosition._(1);

  /// The ad choice icon is in the bottom right corner.
  static const NativeAdChoicesPosition BOTTOM_RIGHT =
      NativeAdChoicesPosition._(2);

  /// The ad choice icon is in the bottom left corner.
  static const NativeAdChoicesPosition BOTTOM_LEFT =
      NativeAdChoicesPosition._(3);

  /// The ad choice icon is invisible.
  static const NativeAdChoicesPosition INVISIBLE = NativeAdChoicesPosition._(4);

  final int value;
  const NativeAdChoicesPosition._(this.value);
}

class NativeAdDirection {
  /// Any orientation.
  static const NativeAdDirection ANY = NativeAdDirection._(0);

  /// Landscape.
  static const NativeAdDirection PORTRAIT = NativeAdDirection._(1);

  /// Portrait.
  static const NativeAdDirection LANDSCAPE = NativeAdDirection._(2);

  final int value;
  const NativeAdDirection._(this.value);
}

class RewardAdErrorCode {
  /// Internal error.
  static const RewardAdErrorCode INTERNAL = RewardAdErrorCode._(0);

  /// Duplicate ad.
  static const RewardAdErrorCode REUSED = RewardAdErrorCode._(1);

  /// The ad has not been loaded.
  static const RewardAdErrorCode NOT_LOADED = RewardAdErrorCode._(2);

  /// The rewarded ad is played in the background.
  static const RewardAdErrorCode BACKGROUND = RewardAdErrorCode._(3);

  final int value;
  const RewardAdErrorCode._(this.value);
}

class ImageViewScaleType {
  static const ImageViewScaleType FIT_START = ImageViewScaleType._('FIT_START');
  static const ImageViewScaleType FIT_CENTER =
      ImageViewScaleType._('FIT_CENTER');
  static const ImageViewScaleType FIT_END = ImageViewScaleType._('FIT_END');
  static const ImageViewScaleType CENTER = ImageViewScaleType._('CENTER');
  static const ImageViewScaleType CENTER_CROP =
      ImageViewScaleType._('CENTER_CROP');
  static const ImageViewScaleType CENTER_INSIDE =
      ImageViewScaleType._('CENTER_INSIDE');

  final String value;
  const ImageViewScaleType._(this.value);
}

class ConsentConstant {
  static const String spName = 'HuaweiAdsSdkSharedPreferences';
  static const String spProtocolKey = 'protocol';
  static const String spConsentKey = 'consent';
  static const int defaultSpProtocolValue = 0;
  static const int defaultSpConsentValue = -1;
}

enum DebugNeedConsent {
  DEBUG_DISABLED,
  DEBUG_NEED_CONSENT,
  DEBUG_NOT_NEED_CONSENT,
}

enum ConsentStatus {
  PERSONALIZED,
  NON_PERSONALIZED,
  UNKNOWN,
}

abstract class SplashAdOrientation {
  static const int landscape = 0;
  static const int portrait = 1;
}

abstract class ErrorCodes {
  static const String NULL_PARAM = '900';
  static const String NOT_FOUND = '901';
  static const String INVALID_PARAM = '902';
  static const String LOAD_FAILED = '903';
  static const String VERIFY_FAILED = '904';
  static const String INNER = '905';
  static const String NULL_VIEW = '906';
  static const String NULL_AD = '907';
  static const String NOT_READY = '908';
}
