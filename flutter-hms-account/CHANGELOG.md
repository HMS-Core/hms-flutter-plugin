## 5.0.3+303

* Remove unsupported classes.
## 5.0.3+302

**HmsAccount** and its API's are divided to 5 modules which are:
* HmsAuthService
    - signIn
    - signOut
    - silentSignIn
    - revokeAuthorization
    - enableLogger and disableLogger API's have been added under this module.

* HmsAuthManager
    - getAuthResult
    - getAuthResultWithScopes
    - addAuthScopes
    - containScopes

* HmsAuthTool
    - deleteAuthInfo
    - requestAccessToken
    - requestUnionId

* HmsNetworkTool
    - buildNetworkUrl
    - buildNetworkCookie

* HmsSmsManager
    - smsVerification
    - obtainHashcode

**AuthParamHelper** is changed to **HmsAuthParamHelper**

**AuthParams** is changed to **HmsAuthParams**

**Scope** is changed to **HmsScope**

**Account** is changed to **HmsAccount**

**AuthHuaweiId** is changed to **HmsAuthHuaweiId**

**ErrorCodes** is changed to **HmsAccountErrorCodes**

**HuaweiIdAuthButton** is changed to **HmsAuthButton**

## 5.0.0+300

* Added repository url.
* Reformatted dart files.

## 5.0.0

* Initial release.
