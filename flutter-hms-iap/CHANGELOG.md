## 5.0.2+301
* Updated HMSLogger.

## 5.0.2+300

* Upgrade Huawei IAP SDK to v5.0.2.300
* Result codes added (HmsIapResults).
* PurchaseIntentReq new field: reservedInfor (key/value pairs as String).
* InAppPurchaseData new field: graceExpirationTime (int field).
* Minor bug fixes.
* Equality and hash code support for classes added. 
* rawValue field, which is unparsed JSON String of response, added to ConsumeOwnedPurchaseResult, OwnedPurchasesResult and PurchaseResultInfo.
* Missing toJson, toMap, fromJson, fromMap methods added for classes. 
* Demo Project updated. 
* HMS logger addded for usage analytics of IAP SDK.
    - enableLogger method added. 
    - disableLogger method added. 

## 5.0.0+300

* Changed plugin description.

## 5.0.0

* Initial release.
