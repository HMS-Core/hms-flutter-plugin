## 5.0.4+304

* Updated Huawei Game Service version to 5.0.4.303.
* Added CheckUpdateCallback class for update callbacks.
* Added ProductOrderInfo class for missed products.
* Added UpdateInfo class for update information.
* Added ApkUpgradeInfo class for upgrade information.
* Added JosAppsClient. 
    * [Breaking Change] Added JosAppsClient.init method to initialize the Huawei Game Service. This method should be called before calling any other plugin methods. 
    * Added JosAppsClient.getAppId method to obtain app id. 
    * Added JosAppsClient.checkAppUpdate method to obtain update callbacks.
    * Added JosAppsClient.showUpdateDialog method for showing update dialog. 
    * Added JosAppsClient.releaseCallback method for releasing callbacks. 
    * Added JosAppsClient.getMissProductOrder method to obtain missed products.

## 5.0.4+303

* Updated HMSLogger.
* Added GameScopes class for scope constants.
* Fixed the bug that prevents intent methods to resolve.
* Fix formatting errors.

## 5.0.4+302

* Initial release.
