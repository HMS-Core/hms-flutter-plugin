/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

part of huawei_wallet;

abstract class WalletPassConstant {
  static const String passCommonFieldKeyBackgroundImg = 'backgroundImage';
  static const String passCommonFieldKeyLogo = 'logo';
  static const String passCommonFieldKeyMerchantName = 'merchantName';
  static const String passCommonFieldKeyName = 'name';
  static const String passCommonFieldKeyCardNumber = 'cardNumber';
  static const String passCommonFieldKeyBalance = 'balance';
  static const String passCommonFieldKeyBalanceRefreshTime =
      'balanceRefreshTime';
  static const String passCommonFieldKeyBlancePin = 'pin';
  static const String passCommonFieldKeyMemberName = 'memberName';
  static const String passCommonFieldKeyProviderName = 'providerName';
  static const String passAppendFieldKeyBackgroundColor = 'backgroundColor';
  static const String passAppendFieldKeyEventNumber = 'eventNumber';
  static const String passAppendFieldKeyNearbyLocations = 'nearbyLocations';
  static const String passAppendFieldKeyMainpage = 'website';
  static const String passAppendFieldKeyHotline = 'hotline';
  static const String passAppendFieldKeyPoints = 'points';
  static const String passAppendFieldKeyRewardsLevel = 'level';
  static const String passAppendFieldKeyDetails = 'details';
  static const String passAppendFieldKeyDisclaimer = 'declaration';
  static const String passStateCompleted = 'completed';
  static const String passStateExpired = 'expired';
  static const String passStateInactive = 'inactive';
  static const String passStateActive = 'active';
  static const int errorCodeServiceUnavailable = -10;
  static const int errorCodeUnsupportedApiRequest = -11;
  static const int errorCodeInternalError = 3;
  static const int errorCodeOthers = -100;
  static const int errorCodeInvalidParameters = 1;
  static const int errorCodeUserAccountError = 2;
  static const int errorCodeDeveloperError = 10;
  static const int errorCodeMerchantAccountError = 101;
  static const String extraErrorCode = 'com.huawei.wallet.EXTRA_ERROR_CODE';
  static const String passFormatVersion = '10.0';
}
