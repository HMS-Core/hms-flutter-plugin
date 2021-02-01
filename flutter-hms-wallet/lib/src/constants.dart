/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
class WalletPassConstant {
  static final String passCommonFieldKeyBackgroundImg = "backgroundImage";
  static final String passCommonFieldKeyLogo = "logo";
  static final String passCommonFieldKeyMerchantName = "merchantName";
  static final String passCommonFieldKeyName = "name";
  static final String passCommonFieldKeyCardNumber = "cardNumber";
  static final String passCommonFieldKeyBalance = "balance";
  static final String passCommonFieldKeyBalanceRefreshTime =
      "balanceRefreshTime";
  static final String passCommonFieldKeyBlancePin = "pin";
  static final String passCommonFieldKeyMemberName = "memberName";
  static final String passCommonFieldKeyProviderName = "providerName";
  static final String passAppendFieldKeyBackgroundColor = "backgroundColor";
  static final String passAppendFieldKeyEventNumber = "eventNumber";
  static final String passAppendFieldKeyNearbyLocations = "nearbyLocations";
  static final String passAppendFieldKeyMainpage = "website";
  static final String passAppendFieldKeyHotline = "hotline";
  static final String passAppendFieldKeyPoints = "points";
  static final String passAppendFieldKeyRewardsLevel = "level";
  static final String passAppendFieldKeyDetails = "details";
  static final String passAppendFieldKeyDisclaimer = "declaration";
  static final String passStateCompleted = "completed";
  static final String passStateExpired = "expired";
  static final String passStateInactive = "inactive";
  static final String passStateActive = "active";
  static final String extraErrorCode = "com.huawei.wallet.EXTRA_ERROR_CODE";
  static final String passFormatVersion = "10.0";
}

class WalletPassErrorCode {
  // CreateWalletPassResult error codes
  static final int errorCodeServiceUnavailable = -10;
  static final int errorCodeUnsupportedApiRequest = -11;
  static final int errorCodeInternalError = 3;
  static final int errorCodeOthers = -100;
  static final int errorCodeInvalidParameters = 1;
  static final int errorCodeUserAccountError = 2;
  static final int errorCodeDeveloperError = 10;
  static final int errorCodeMerchantAccountError = 101;
  // WalletPassApi codes
  static final int missingParam = 50000;
  static final int activityNotFound = 60000;
  static final int missingMethodResult = 70000;
}

enum CreateWalletPassResult {
  resultOk,
  resultCanceled,
  noOwner,
  hmsVersionCode,
  unknown,
}
