## 6.13.0+302

- Dart improvements.

## 6.13.0+301

- Minor optimization and bug fixes. 

## 6.13.0+300

- Updated Huawei In-App Purchases SDK version to 6.13.0.300.
- Minor optimization.

## 6.10.0+300

- Android API 33 support has been added.
- Added the BaseReq class, which is now the base class for ConsumeOwnedPurchaseReq, OwnedPurchasesReq, ProductInfoReq, and PurchaseIntentReq.
- Minor bug fixes.

## 6.4.0+302

- **Breaking Change:** Modified the internal structure of the plugin. Please use import package:huawei_iap/huawei_iap.dart not to get any errors.
- Improved the code quality.

## 6.4.0+301

- Updated to support latest Huawei In-App Purchases SDK.
- Added enablePendingPurchase API.
- Added result code 60057 in HmsIapResult.
- Added a new constant PENDING in InAppPurchaseData.

## 6.2.0+301

- Updated to support latest Huawei In-App Purchases SDK.

## 6.2.0+300

- Updated to support Huawei In-App Purchases SDK version 6.2.0.300.
- Added the offerUsedStatus property to ProductInfo.

## 6.0.0+300

- Updated to support Huawei In-App Purchases SDK version 6.0.0.300.

## 5.3.0+300

- [Breaking Change] Added null-safety support.
- Updated Huawei IAP SDK version to 5.3.0.300
- isSupportAppTouch parameter is added to isEnvReady API for AppTouch.
- Added carrierId and country to IsEnvReadyResult for obtaining the carrier ID and the country of the currently signed-in ID.
- Added a class of constants, named SignAlgorithmConstants, which contains the algorithm that you pass for calling a certain IapClient API.
- Added signatureAlgorithm to ConsumeOwnedPurchaseReq, OwnedPurchasesReq and PurchaseIntentReq classes to specify signature algorithm to sign the result data.
- Added signatureAlgorithm to ConsumeOwnedPurchaseResult, OwnedPurchasesResult and PurchaseResultInfo to verify the signature algorithm.

## 5.0.2+301

- Updated HMSLogger.

## 5.0.2+300

- Upgrade Huawei IAP SDK to v5.0.2.300
- Result codes added (HmsIapResults).
- PurchaseIntentReq new field: reservedInfor (key/value pairs as String).
- InAppPurchaseData new field: graceExpirationTime (int field).
- Minor bug fixes.
- Equality and hash code support for classes added.
- rawValue field, which is unparsed JSON String of response, added to ConsumeOwnedPurchaseResult, OwnedPurchasesResult and PurchaseResultInfo.
- Missing toJson, toMap, fromJson, fromMap methods added for classes.
- Demo Project updated.
- HMS logger addded for usage analytics of IAP SDK.
  - enableLogger method added.
  - disableLogger method added.

## 5.0.0+300

- Changed plugin description.

## 5.0.0

- Initial release.
