## 6.12.0+301

- Updated the `agcp` dependency.

## 6.12.0+300

- Deprecated `accessToken` in the `AuthAccount` class. You are advised not to use it.
- Deprecated `ReadSmsManager` class.

## 6.11.0+300

- Deprecated `familyName` and `givenName` in the `AuthAccount` class.
- Resolved a performance-related issue to improve the service reliability. You do not need to do anything.
- Updated targetSdkVersion to 33, to make sure that your app can run properly on Android 13.

## 6.4.0+301

- **BREAKING CHANGES**

  - **AccountAuthService** structure slightly changed. Now you have to create AccountAuthService object with **AccountAuthManager.getService** method.

- Added the **setIdTokenSignAlg** method for specifying the signature algorithm type for the ID token to the AccountAuthParamsHelper class.

## 6.1.0+304

- Deleted the capability of prompting users to install HMS Core (APK).

## 6.1.0+302

- Added **carrierId** to signed id.
- Added **independentSignIn** method to AccountAuthService.

## 5.2.0+301

- Migrated to **Null Safety**.

## 5.2.0+300

**Breaking Changes**

- HmsAuthService is changed to **AccountAuthService**.
- HmsAuthManager is changed to **AccountAuthManager**.
- HmsSmsManager is changed to **ReadSmsManager**.
- HmsNetworkTool is changed to **NetworkTool**.
- HmsAuthTool is changed to **HuaweiIdAuthTool**.
- HmsAuthHaweiId is changed to **AuthAccount**.

## 5.0.3+302

- Added HmsAuthService module.
- Added HmsAuthManager module.
- Added HmsAuthTool module.
- Added HmsNetworkTool module.
- Added HmsSmsManager module.
- Added enableLogger and disableLogger methods to enable & disable the HMS Plugin Method Analytics.

## 5.0.0+300

- Added repository url.
- Reformatted dart files.

## 5.0.0

- Initial release.
