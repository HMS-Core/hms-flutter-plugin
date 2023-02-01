## 4.0.5+300

- Updated the components on which the Wallet SDK depends.

- **Breaking Changes:**
  - Migrated to **null-safety**.
  - Modified the internal structure of the plugin. Please use import **package:huawei_wallet/huawei_wallet.dart** not to get any errors.
  - Constants in the `WalletPassErrorCode` have been moved into `WalletPassConstant`.
  - HuaweiWallet:
    - Return type of `enableLogger` changed to `Future<void>` from `Future<bool>`.
    - Return type of `disableLogger` changed to `Future<void>` from `Future<bool>`.
  - BarCode:
    - Name of `barcodeTypeCodebar` constant updated to `barcodeTypeCodabar`.
  - WalletPassApiResponse:
    - Name of `passStatuslist` updated to `passStatusList`.
    - Name of `cardInfolist` updated to `cardInfoList`.

## 4.0.4+302

- Updated HMSLogger.

## 4.0.4+301

- Initial release.
