# Huawei IAP Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Creating Project in App Gallery Connect](#creating-project-in-app-gallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating Flutter IAP Plugin](#integrating-flutter-iap-plugin)
  - [3. API Reference](#3-api-reference)
    - [IapClient](#iapclient)
    - [Data Types](#data-types)
    - [Constants](#constants)
  - [4. Configuration and Description](#4-configuration-and-description)
    - [Preparing for Release](#preparing-for-release)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

Huawei's In-App Purchases (IAP) service allows you to offer in-app purchases and facilitates in-app payment. Users can purchase a variety of virtual products, including one-time virtual products and subscriptions, directly within your app.

Huawei IAP provides the following core capabilities you need to quickly build apps with which your users can buy, consume and subscribe services you provide:
- **isEnvReady**: Returns a response which indicates user's environment status.
- **isSandboxActivated**: Returns a response which indicates user's account capabilities of sandbox testing.
- **obtainProductInfo**: Returns a list of product information. 
- **startIapActivity**: Starts an activity to manage and edit subscriptions.
- **createPurchaseIntent**: Starts an activity to buy the desired product or subscribe a product. 
- **consumeOwnedPurchase**: Consumes the desired purchased product.
- **obtainOwnedPurchases**: Returns a list of products that purchased by user.
- **obtainOwnedPurchaseRecord**: Returns a list of products that purchased and consumed by user. 
- **enableLogger**:  This method enables the HMSLogger capability which is used for sending usage analytics of IAP SDK's methods to improve the service quality.
- **disableLogger**: This method disables the HMSLogger capability which is used for sending usage analytics of IAP SDK's methods to improve the service quality.

This plugin enables communication between HUAWEI IAP Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI IAP Kit SDK.

---

## 2. Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app in your project is required in AppGallery Connect in order to communicate with Huawei services. To create an app, perform the following steps:

### Creating Project in App Gallery Connect

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en) and select **My projects**.

**Step 2.** Click your project from the project list.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**. If an app exists in the project, and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 4.** On the **Add app** page, enter app information, and click **OK**.

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core service through the HMS Core SDK. Before using HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect. Ensure that the JDK has been installed on your computer.

- To use HUAWEI IAP, you need to enable the IAP service first and also set IAP parameters. For details, please refer to [Enabling Services](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-enable_service#h1-1574822945685).

### Configuring the Signing Certificate Fingerprint

**Step 1:** Go to **Project Setting** > **General information**. In the **App information** field, click the icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA256 certificate fingerprint**.

**Step 2:** After completing the configuration, click check mark.

### Integrating Flutter IAP Plugin

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My projects**.

**Step 2:** Find your app project, and click the desired app name.

**Step 3:** Go to **Project Setting** > **General information**. In the **App information** section, click **agconnect-service.json** to download the configuration file.

**Step 4:** Create a Flutter project if you do not have one.

**Step 5:** Copy the **agconnect-service.json** file to the **android/app** directory of your Flutter project.

**Step 6:** Copy the signature file that generated in [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3) section, to the android/app directory of your Flutter project.

**Step 7:** Check whether the **agconnect-services.json** file and signature file are successfully added to the **android/app** directory of the Flutter project.

**Step 8:** Open the **build.gradle** file in the **android** directory of your Flutter project.

- Go to **buildscript** then configure the Maven repository address and agconnect plugin for the HMS SDK.

  ```gradle
      buildscript {
          repositories {
              google()
              jcenter()
              maven { url 'https://developer.huawei.com/repo/' }
          }

          dependencies {
              /*
               * <Other dependencies>
               */
              classpath 'com.huawei.agconnect:agcp:1.4.1.300'
          }
      }
  ```

- Go to **allprojects** then configure the Maven repository address for the HMS SDK.

  ```gradle
      allprojects {
          repositories {
              google()
              jcenter()
              maven { url 'https://developer.huawei.com/repo/' }
          }
      }
  ```

**Step 9:** Open the **build.gradle** file in the **android/app** directory.

- Add `apply plugin: 'com.huawei.agconnect'` line after the `apply` entries.

  ```gradle
      apply plugin: 'com.android.application'
      apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
      apply plugin: 'com.huawei.agconnect'
  ```

- Set your package name in **defaultConfig** > **applicationId** and set **minSdkVersion** to **19** or **higher**.

- Package name must match with the **package_name** entry in **agconnect-services.json** file.

  ```gradle
      defaultConfig {
              applicationId "<package_name>"
              minSdkVersion 19
              /*
               * <Other configurations>
               */
          }
  ```

- Copy the signature file that generated in [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3) to **android/app** directory.

- Configure the signature in **android** according to the signature file information and configure Obfuscation Scripts.

  ```gradle
      android {
          /*
           * <Other configurations>
           */

          signingConfigs {
              config {
                  storeFile file('<keystore_file>.jks')
                  storePassword '<keystore_password>'
                  keyAlias '<key_alias>'
                  keyPassword '<key_password>'
              }
          }

          buildTypes {
              debug {
                  signingConfig signingConfigs.config
              }
              release {
                  minifyEnabled true
                  shrinkResources true
                  proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
                  signingConfig signingConfigs.config
              }
          }
      }
  ```

- For Obfuscation Scripts, please refer to [Configuring Obfuscation Scripts](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/config-obfuscation-scripts-0000001050260710).

**Step 10:** On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies.

- To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

  ```yaml
  dependencies:
    huawei_iap: { library version }
  ```

  **or**

  If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

  ```yaml
  dependencies:
    huawei_iap:
      # Replace {library path} with actual library path of Huawei IAP Plugin for Flutter.
      path: { library path }
  ```

  - Replace {library path} with the actual library path of Flutter IAP Plugin. The following are examples:
    - Relative path example: `path: ../huawei_iap`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_iap`

**Step 11:** Run following command to update package info.

```
  [project_path]> flutter pub get
```

**Step 12:** Run following command to start the app.

```
  [project_path]> flutter run
```

---

## 3. API Reference

### IapClient

Entry class of the Huawei IAP service.

#### Public Constants

| Constant             | Type | Value | Description     |
| -------------------- | ---- | :---- | --------------- |
| IN_APP_CONSUMABLE    | int  | 0     | Consumable.     |
| IN_APP_NONCONSUMABLE | int  | 1     | Non-consumable. |
| IN_APP_SUBSCRIPTION  | int  | 2     | Subscription.   |

#### Public Method Summary

| Method                                                       | Return Type                           | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------- | ------------------------------------------------------------ |
| [isEnvReady()](#futureisenvreadyresult-isenvready-async)     | Future\<*IsEnvReadyResult*>           | Returns a response which indicates user's environment status. |
| [isSandboxActivated()](#futureissandboxactivatedresult-issandboxactivated-async) | Future\<*IsSandboxActivatedResult*>   | Returns a response which indicates user's account capabilities of sandbox testing. |
| [obtainProductInfo(*ProductInfoReq* request)](#futureproductinforesult-obtainproductinfoproductinforeq-request-async) | Future\<*ProductInfoResult*>          | Returns a list of product information.                       |
| [startIapActivity(*StartIapActivityReq* request)](#futurevoid-startiapactivitystartiapactivityreq-request-async) | Future\<void>                         | Starts an activity to manage and edit subscriptions.         |
| [createPurchaseIntent(*PurchaseIntentRequest* request)](#futurepurchaseresultinfo-createpurchaseintentpurchaseintentreq-request-async) | Future\<*PurchaseResultInfo*>         | Starts an activity to buy the desired product or subscribe a product. |
| [consumeOwnedPurchase(*ConsumeOwnedPurchaseReq* request)](#futureconsumeownedpurchaseresult-consumeownedpurchaseconsumeownedpurchasereq-request-async) | Future\<*ConsumeOwnedPurchaseResult*> | Consumes the desired purchased product.                      |
| [obtainOwnedPurchases(*OwnedPurchasesReq* request)](#futureownedpurchasesresult-obtainownedpurchasesownedpurchasesreq-request-async) | Future\<*OwnedPurchasesResult*>       | Returns a list of products that purchased by user.           |
| [obtainOwnedPurchaseRecord(*OwnedPurchasesReq* request)](#futureownedpurchasesresult-obtainownedpurchaserecordownedpurchasesreq-request-async) | Future\<*OwnedPurchasesResult*>       | Returns a list of products that purchased and consumed by user. |
| [disableLogger()](#futurevoid-disablelogger-async)           | Future\<void>                         | Disables HMS Logger.                                         |
| [enableLogger()](#futurevoid-enablelogger-async)             | Future\<void>                         | Enables HMS Logger.                                          |

#### Public Methods

##### Future\<IsEnvReadyResult> isEnvReady() *async*

Checks whether the currently signed-in Huawei ID is located in a country or region where Huawei IAP is available.

###### Return Type

| Return Type                                      | Description                                                  |
| ------------------------------------------------ | ------------------------------------------------------------ |
| Future\<[*IsEnvReadyResult*](#isenvreadyresult)> | Represents a response object used to gather information about user environment. |

###### Call Example

```dart
//Call isEnvReady API.
IsEnvReadyResult result = await IapClient.isEnvReady();

//Print the returnCode property.
log(result.returnCode);
```

##### Future\<IsSandboxActivatedResult> isSandboxActivated() *async*

Checks whether the signed-in Huawei ID and the app APK version meet the requirements of the sandbox testing.

###### Return Type

| Return Type                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Future\<[*IsSandboxActivatedResult*](#issandboxactivatedresult)> | Represents a response object to gather information about user's sandbox permissions. |

###### Call Example

```dart
//Call isSandboxActivated API.
IsSandboxActivatedResult result = await IapClient.isSandboxActivated();

//Print the isSandboxUser property.
log(result.isSandboxUser);
```

##### Future\<ProductInfoResult> obtainProductInfo(ProductInfoReq request) *async*

Obtains product details configured in AppGallery Connect. If you use Huawei's PMS to price products, you can use this method to obtain product details from the PMS to ensure that the product information in your app is the same as that displayed on the checkout page of Huawei IAP.

###### Parameters

| Name    | Description                                 |
| ------- | ------------------------------------------- |
| request | [*ProductInfoReq*](#productinforeq) object. |

###### Return Type

| Return Type                                        | Description                                                  |
| -------------------------------------------------- | ------------------------------------------------------------ |
| Future\<[*ProductInfoResult*](#productinforesult)> | Represents a response object used to obtain product information. |

###### Call Example

```dart
//Constructing request.
ProductInfoReq request = ProductInfoReq();
request.priceType = IapClient.IN_APP_CONSUMABLE; //You may also use 0 for consumables.
request.skuIds = ["consumable_product_1", "consumable_product_2"];
    
//Call the obtainProductInfo API.
ProductInfoResult result = await IapClient.obtainProductInfo(request);

//Print product name of the first product in the productInfoList.
log(result.productInfoList[0].productName)
```

##### Future\<void> startIapActivity(StartIapActivityReq request) *async*

Brings up in-app payment pages, including:

- Subscription editing page
- Subscription management page

###### Parameters

| Name    | Description                                           |
| ------- | ----------------------------------------------------- |
| request | [*StartIapActivityReq*](#startiapactivityreq) object. |

###### Return Type

| Return Type   | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
//Constructing request.
StartIapActivityReq request = StartIapActivityReq();
request.type = StartIapActivityReq.TYPE_SUBSCRIBE_MANAGER_ACTIVITY;

//Call the startIapActivity API.
await IapClient.startIapActivity(request);
```

##### Future\<PurchaseResultInfo> createPurchaseIntent(PurchaseIntentReq request) *async*

Creates orders for PMS products, including consumables, non-consumables, and subscriptions.

After creating a product in AppGallery Connect, you can call this method to open the HUAWEI IAP checkout page and display the product, price, and payment method. Huawei can adjust product prices by foreign exchange rate changes. To ensure price consistency, your app needs to call the *obtainProductInfo* method to obtain product details from Huawei instead of your own server.

###### Parameters

| Name    | Description                                       |
| ------- | ------------------------------------------------- |
| request | [*PurchaseIntentReq*](#purchaseintentreq) object. |

###### Return Type

| Return Type                                          | Description                                      |
| ---------------------------------------------------- | ------------------------------------------------ |
| Future\<[*PurchaseResultInfo*](#purchaseresultinfo)> | Represents a response object of purchase intent. |

###### Call Example

```dart
//Constructing request.
PurchaseIntentReq request = PurchaseIntentReq();
request.priceType = IapClient.IN_APP_CONSUMABLE; //You may also use 0 for consumables.
request.productId = "consumable_product_1";
request.developerPayload = "Test";

//Call the createPurchaseIntent API.
PurchaseResultInfo result = await IapClient.createPurchaseIntent(request);

//Print inAppDataSignature property. 
log(result.inAppDataSignature) 
```

##### Future\<OwnedPurchasesResult> obtainOwnedPurchases(OwnedPurchasesReq request) *async*

###### Parameters

| Name    | Description                                       |
| ------- | ------------------------------------------------- |
| request | [*OwnedPurchasesReq*](#ownedpurchasesreq) object. |

###### Return Type

| Return Type                                              | Description                                                  |
| -------------------------------------------------------- | ------------------------------------------------------------ |
| Future\<[*OwnedPurchasesResult*](#ownedpurchasesresult)> | Represents a response object of obtain owned purchases or owned purchase record APIs. |

###### Call Example

```dart
//Constructing request.
OwnedPurchasesReq request = OwnedPurchasesReq();
request.priceType = IapClient.IN_APP_CONSUMABLE; //You may also use 0 for consumables.

//Call the obtainOwnedPurchases API.
OwnedPurchasesResult result = await IapClient.obtainOwnedPurchases(request);

//Print productId of the first product in inAppPurchaseDataList.
log(result.inAppPurchaseDataList[0].productId);
```

##### Future\<ConsumeOwnedPurchaseResult> consumeOwnedPurchase(ConsumeOwnedPurchaseReq request) *async*

Consumes a consumable after the consumable is delivered to a user who has completed payment.

###### Parameters

| Name    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| request | [*ConsumeOwnedPurchaseReq*](#consumeownedpurchasereq) object. |

###### Return Type

| Return Type                                                  | Description                                |
| ------------------------------------------------------------ | ------------------------------------------ |
| Future\<[*ConsumeOwnedPurchaseResult*](#consumeownedpurchaseresult)> | Represents details about consumed product. |

###### Call Example

```dart
//Constructing request.
ConsumeOwnedPurchaseReq request = ConsumeOwnedPurchaseReq();
request.purchaseToken = "PURCHASE_TOKEN"

//Call the consumeOwnedPurchase API.
ConsumeOwnedPurchaseResult result = await IapClient.consumeOwnedPurcases(request);

//Print dataSignature property.
log(result.dataSignature);
```

##### Future\<OwnedPurchasesResult> obtainOwnedPurchaseRecord(OwnedPurchasesReq request) *async*

Obtains the historical consumption information about a consumable or all subscription receipts of a subscription.

- For consumables, this method returns information about products that have been delivered or consumed in the product list.

- For non-consumables, this method **does not** return product information.
- For subscriptions, this method returns all subscription receipts of the current user in this app

###### Parameters

| Name    | Description                                       |
| ------- | ------------------------------------------------- |
| request | [*OwnedPurchasesReq*](#ownedpurchasesreq) object. |

###### Return Type

| Return Type                                            | Description                                                  |
| ------------------------------------------------------ | ------------------------------------------------------------ |
| Future\<[OwnedPurchasesResult](#ownedpurchasesresult)> | Represents a response object of obtain owned purchases or owned purchase record APIs. |

###### Call Example

```dart
//Constructing request.
OwnedPurchasesReq request = OwnedPurchasesReq();
request.priceType = IapClient.IN_APP_CONSUMABLE; //You may also use 0 for consumables.

//Call the obtainOwnedPurchaseRecord API.
OwnedPurchasesResult result = await IapClient.obtainOwnedPurchaseRecord(request);

//Print product ids from purchase history
for(int i = 0; i < result.inAppPurchaseDataList.length; i++){
    log(result.inAppPurchaseDataList[i].productId);}
```

##### Future\<void> disableLogger() *async*

This method disables the HMSLogger capability which is used for sending usage analytics of IAP SDK's methods to improve the service quality.

###### Return Type

| Return Type   | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
//Call disableLogger API.
await IapClient.disableLogger();
```

##### Future\<void> enableLogger() *async*

This method enables the HMSLogger capability which is used for sending usage analytics of IAP SDK's methods to improve the service quality.

###### Return Type

| Return Type   | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```
//Call enableLogger API.
await IapClient.enableLogger();
```

### Data Types

#### Data Types Summary


| Class                                                     | Description                                                  |
| :-------------------------------------------------------- | :----------------------------------------------------------- |
| [ConsumeOwnedPurchaseReq](#consumeownedpurchasereq)       | Represents a request object used to consume a product.       |
| [ConsumeOwnedPurchaseResult](#consumeownedpurchaseresult) | Represents a response object used to consume a product.      |
| [ConsumePurchaseData](#consumepurchasedata)               | Represents details about consumed product.                   |
| [InAppPurchaseData](#inapppurchasedata)                   | Represents details about purchased product.                  |
| [IsEnvReadyResult](#isenvreadyresult)                     | Represents a response object used to gather information about user environment. |
| [IsSandboxActivatedResult](#issandboxactivatedresult)     | Represents a response object to gather information about user's sandbox permissions. |
| [OwnedPurchasesReq](#ownedpurchasesreq)                   | Represents a request object used to obtain owned purchases or owned purchase record. |
| [OwnedPurchasesResult](#ownedpurchasesresult)             | Represents a response object used to obtain owned purchases or owned purchase record. |
| [ProductInfo](#productinfo)                               | Represents details of product.                               |
| [ProductInfoReq](#productinforeq)                         | Represents a request object used to obtain product information. |
| [ProductInfoResult](#productinforesult)                   | Represents a response object used to obtain product information. |
| [PurchaseIntentReq](#purchaseintentreq)                   | Represents a request object used to create a purchase intent. |
| [PurchaseResultInfo](#purchaseresultinfo)                 | Represents a response object used to create a purchase intent. |
| [StartIapActivityReq](#startiapactivityreq)               | Represents a request object used to start activity for editing or managing subscriptions. |
| [Status](#status)                                         | Represents status of the API call.                           |
| [HmsIapResult](#hmsiapresult)                             | Represents an error class for *HmsIapResults*.               |

#### ConsumeOwnedPurchaseReq

Request information of the *consumeOwnedPurchase* API.

##### Public Properties

| Name               | Type   | Description                                                  |
| ------------------ | ------ | ------------------------------------------------------------ |
| purchaseToken      | String | Purchase token, which is generated by the Huawei IAP server during payment and returned to the app through [*InAppPurchaseData*](#inapppurchasedata). The app passes this parameter for the Huawei IAP server to update the order status and then deliver the product. |
| developerChallenge | String | Custom challenge, which uniquely identifies a consumption request. After the consumption is successful, the challenge is recorded in the purchase information and returned. Note: The value length of this parameter is within (0,64). |

##### Public Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ConsumeOwnedPurchaseReq({String purchaseToken, String developerChallenge}) | Default constructor.                                         |
| ConsumeOwnedPurchaseReq.fromJson(String source)              | Creates a *ConsumeOwnedPurchaseReq* object from a JSON string. |

##### Public Constructors

###### ConsumeOwnedPurchaseReq({String purchaseToken, String developerChallenge})

Constructor for *ConsumeOwnedPurchaseReq* object.

| Parameter          | Type   | Description                                                  |
| ------------------ | ------ | ------------------------------------------------------------ |
| purchaseToken      | String | Purchase token, which is generated by the Huawei IAP server during payment and returned to the app through [*InAppPurchaseData*](#inapppurchasedata). The app passes this parameter for the Huawei IAP server to update the order status and then deliver the product. |
| developerChallenge | String | Custom challenge, which uniquely identifies a consumption request. After the consumption is successful, the challenge is recorded in the purchase information and returned. Note: The value length of this parameter is within (0,64). |

###### ConsumeOwnedPurchaseReq.fromJson(String source) 

Creates a *ConsumeOwnedPurchaseReq* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### ConsumeOwnedPurchaseResult

Information returned when the *consumeOwnedPurchase* API is successfully called.

##### Public Properties

| Name                | Type                                          | Description                                                  |
| ------------------- | --------------------------------------------- | ------------------------------------------------------------ |
| consumePurchaseData | [*ConsumePurchaseData*](#consumepurchasedata) | [*ConsumePurchaseData*](#consumepurchasedata) object that contains consumption result data. |
| dataSignature       | String                                        | Signature string generated after consumption data is signed using a private payment key. The signature algorithm is SHA256withRSA |
| errMsg              | String                                        | Result code description.                                     |
| returnCode          | String                                        | Result code.                                                 |
| status              | [*Status*](#status)                           | [*Status*](#status) object that contains the task processing result. |
| rawValue            | String                                        | Unparsed JSON String of response. NOTE: IAP SDK does not return a JSON response. This field is the response class converted to JSON. |

##### Public Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ConsumeOwnedPurchaseResult({*ConsumePurchaseData* consumePurchaseData, String dataSignature, String errMsg, String returnCode, *Status* status}) | Default Constructor                                          |
| ConsumeOwnedPurchaseResult.fromJson(String source)           | Creates a *ConsumeOwnedPurchaseResult* object from a JSON string. |

##### Public Constructors

###### ConsumeOwnedPurchaseResult({*ConsumePurchaseData* consumePurchaseData, String dataSignature, String errMsg, String returnCode, *Status* status})

Constructor for *ConsumeOwnedPurchaseResult* object.

| Parameter           | Type                                          | Description                                                  |
| ------------------- | --------------------------------------------- | ------------------------------------------------------------ |
| consumePurchaseData | [*ConsumePurchaseData*](#consumepurchasedata) | [*ConsumePurchaseData*](#consumepurchasedata) object that contains consumption result data. |
| dataSignature       | String                                        | Signature string generated after consumption data is signed using a private payment key. The signature algorithm is SHA256withRSA |
| errMsg              | String                                        | Result code description.                                     |
| returnCode          | String                                        | Result code.                                                 |
| status              | [*Status*](#status)                           | [*Status*](#status) object that contains the task processing result. |

###### ConsumeOwnedPurchaseResult.fromJson(String source)

Creates a *ConsumeOwnedPurchaseResult* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### ConsumePurchaseData

Object that contains consumption result data.

##### Public Properties

<details>
  <summary>Click to expand/collapse Properties table</summary>

| Name               | Type   | Description                                                  |
| ------------------ | ------ | ------------------------------------------------------------ |
| applicationId      | int    | ID of an app that initiates a purchase.                      |
| autoRenewing       | bool   | Indicates whether the subscription is automatically renewed. Currently, the value is always **false**. |
| confirmed          | int    | Confirmation.                                                |
| orderId            | String | Order ID on the Huawei IAP server, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| kind               | int    | Product type.                                                |
| packageName        | String | Software package name of the app that initiates a purchase.  |
| payOrderId         | String | Merchant ID, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| payType            | String | Payment method. **0**: HUAWEI Points **3**: Credit card **4**: Alipay **6**: Carrier billing **13**: PayPal **16**: Debit card **17**: WeChat Pay **19**: Gift card **20**: Balance **21**: HUAWEI Point card **24**: WorldPay **31**: HUAWEI Pay **32**: Ant Credit Pay **200**: M-Pesa |
| productId          | String | Product ID.                                                  |
| productName        | String | Product name.                                                |
| purchaseTime       | int    | Purchase timestamp, which is the number of milliseconds from 00:00:00 on January 1, 1970 to the purchase time. |
| purchaseTimeMillis | int    | Purchase time.                                               |
| purchaseType       | int    | Purchase type. **0**: In the sandbox **1**: In the promotion period (currently unsupported). This parameter is not returned during formal purchase. |
| purchaseState      | int    | Order status. **-1**: initialized and invisible **0**: Purchased **1**: Canceled **2**: Refunded |
| developerPayload   | String | Reserved information on the merchant side, which is passed by the app during payment. |
| purchaseToken      | String | Purchase token, which uniquely identifies the mapping between a product and a user. It is generated by the Huawei IAP server when the payment is complete. |
| developerChallenge | String | Challenge defined when the app initiates a consumption request, which uniquely identifies a consumption request. |
| consumptionState   | int    | Consumption status. **0**: Not consumed **1**: Consumed      |
| acknowledged       | int    | Receiving status. **0**: Not received **1**: Received. This parameter is valid only for receiving APIs. The value is always **0**. You can **ignore this parameter**. |
| currency           | String | Currency. The value must be a currency defined in the [ISO 4217](https://www.iso.org/iso-4217-currency-codes.html) standard. Example: USD, CNY, and TRY |
| price              | int    | Value after the actual price of a product is multiplied by 100. The actual price is accurate to two decimal places. For example, if the value of this parameter is **501**, the actual product price is 5.01. |
| country            | String | Country or region code of a user service area. The value must comply with the [ISO 3166](https://www.iso.org/iso-3166-country-codes.html) standard. Example: US, CN, and TR |
| responseCode       | String | Response code. **0**: The execution is successful.           |
| responseMessage    | String | Response information.                                        |

</details>

##### Public Constructor Summary

| Constructor                                                  | Description                                                |
| ------------------------------------------------------------ | ---------------------------------------------------------- |
| ConsumePurchaseData({int applicationId, bool autoRenewing, String orderId, String packageName, String productId, int purchaseTime, int purchaseState, String developerPayload, String purchaseToken, String developerChallenge, int consumptionState, int acknowledged, String currency, int price, String country, String responseCode, String responseMessage, int kind, String productName, int purchaseTimeMillis, int confirmed, int purchaseType, String payOrderId, String payType}) | Default constructor.                                       |
| ConsumePurchaseData.fromJson(String source)                  | Creates a *ConsumePurchaseData* object from a JSON string. |

##### Public Constructors

###### ConsumePurchaseData({int applicationId, bool autoRenewing, String orderId, String packageName, String productId, int purchaseTime, int purchaseState, String developerPayload, String purchaseToken, String developerChallenge, int consumptionState, int acknowledged, String currency, int price, String country, String responseCode, String responseMessage, int kind, String productName, int purchaseTimeMillis, int confirmed, int purchaseType, String payOrderId, String payType})

Constructor for *ConsumePurchaseData* object.

<details>
  <summary>Click to expand/collapse Parameter table</summary>

| Parameter          | Type   | Description                                                  |
| ------------------ | ------ | ------------------------------------------------------------ |
| applicationId      | int    | ID of an app that initiates a purchase.                      |
| autoRenewing       | bool   | Indicates whether the subscription is automatically renewed. Currently, the value is always **false**. |
| confirmed          | int    | Confirmation.                                                |
| orderId            | String | Order ID on the Huawei IAP server, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| kind               | int    | Product type.                                                |
| packageName        | String | Software package name of the app that initiates a purchase.  |
| payOrderId         | String | Merchant ID, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| payType            | String | Payment method. **0**: HUAWEI Points **3**: Credit card **4**: Alipay **6**: Carrier billing **13**: PayPal **16**: Debit card **17**: WeChat Pay **19**: Gift card **20**: Balance **21**: HUAWEI Point card **24**: WorldPay **31**: HUAWEI Pay **32**: Ant Credit Pay **200**: M-Pesa |
| productId          | String | Product ID.                                                  |
| productName        | String | Product name.                                                |
| purchaseTime       | int    | Purchase timestamp, which is the number of milliseconds from 00:00:00 on January 1, 1970 to the purchase time. |
| purchaseTimeMillis | int    | Purchase time.                                               |
| purchaseType       | int    | Purchase type. **0**: In the sandbox **1**: In the promotion period (currently unsupported). This parameter is not returned during formal purchase. |
| purchaseState      | int    | Order status. **-1**: initialized and invisible **0**: Purchased **1**: Canceled **2**: Refunded |
| developerPayload   | String | Reserved information on the merchant side, which is passed by the app during payment. |
| purchaseToken      | String | Purchase token, which uniquely identifies the mapping between a product and a user. It is generated by the Huawei IAP server when the payment is complete. |
| developerChallenge | String | Challenge defined when the app initiates a consumption request, which uniquely identifies a consumption request. |
| consumptionState   | int    | Consumption status. **0**: Not consumed **1**: Consumed      |
| acknowledged       | int    | Receiving status. **0**: Not received **1**: Received. This parameter is valid only for receiving APIs. The value is always **0**. You can **ignore this parameter**. |
| currency           | String | Currency. The value must be a currency defined in the [ISO 4217](https://www.iso.org/iso-4217-currency-codes.html) standard. Example: USD, CNY, and TRY |
| price              | int    | Value after the actual price of a product is multiplied by 100. The actual price is accurate to two decimal places. For example, if the value of this parameter is **501**, the actual product price is 5.01. |
| country            | String | Country or region code of a user service area. The value must comply with the [ISO 3166](https://www.iso.org/iso-3166-country-codes.html) standard. Example: US, CN, and TR |
| responseCode       | String | Response code. **0**: The execution is successful.           |
| responseMessage    | String | Response information.                                        |

</details>

###### ConsumePurchaseData.fromJson(String source)

Creates a *ConsumePurchaseData* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### InAppPurchaseData

Purchase information about products including consumables, non-consumables, and subscriptions.

##### Public Properties

<details>
  <summary>Click to expand/collapse Properties table</summary>

| Name                 | Type   | Description                                                  |
| -------------------- | ------ | ------------------------------------------------------------ |
| applicationId        | int    | ID of an app that initiates a purchase.                      |
| autoRenewing         | bool   | Indicates whether the subscription is automatically renewed. Currently, the value is always **false**. |
| orderId              | String | Order ID on the Huawei IAP server, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| packageName          | String | Software package name of the app that initiates a purchase.  |
| productId            | String | Product ID.                                                  |
| productName          | String | Product name.                                                |
| purchaseTime         | int    | Purchase timestamp, which is the number of milliseconds from 00:00:00 on January 1, 1970 to the purchase time. |
| purchaseState        | int    | Order status. **-1**: Initialized and invisible **0**: Purchased **1**: Canceled **2**: Refunded |
| developerPayload     | String | Reserved information on the merchant side, which is passed by the app during payment. |
| purchaseToken        | String | Purchase token, which uniquely identifies the mapping between a product and a user. It is generated by the Huawei IAP server when the payment is complete. |
| purchaseType         | int    | Purchase type.**0**: in the sandbox**1**: in the promotion period (currently unsupported)This parameter is not returned during formal purchase. |
| currency             | String | Currency. The value must be a currency defined in the [ISO 4217](https://www.iso.org/iso-4217-currency-codes.html) standard. Example: USD, CNY, and TRY |
| price                | int    | Value after the actual price of a product is multiplied by 100. The actual price is accurate to two decimal places. For example, if the value of this parameter is **501**, the actual product price is 5.01. |
| country              | String | Country or region code of a user service area. The value must comply with the [ISO 3166](https://www.iso.org/iso-3166-country-codes.html) standard. Example: US, CN, and TR |
| lastOrderId          | String | Order ID generated by the Huawei IAP server during fee deduction on the previous renewal. |
| productGroup         | String | ID of the subscription group to which a subscription belongs. |
| oriPurchaseTime      | int    | First fee deduction timestamp, which is the number of milliseconds since 00:00:00 on January 1, 1970. |
| subscriptionId       | String | Subscription ID.                                             |
| quantity             | int    | Purchase quantity.                                           |
| daysLasted           | int    | Days of a paid subscription, excluding the free trial period and promotion period. |
| numOfPeriods         | int    | Number of successful standard renewal periods (that is, renewal periods without promotion). If the parameter is set to **0** or left empty, no renewal has been performed successfully. |
| numOfDiscounts       | int    | Number of successful renewal periods with promotion.         |
| expirationDate       | int    | Subscription expiration timestamp. For an automatic renewal receipt where the fee has been deducted successfully, this parameter indicates the renewal date or expiration date. If the value is a past time for the latest receipt of a product, the subscription has expired. |
| expirationIntent     | int    | Reason why a subscription expires. **1**: Canceled by a user. **2**: Product being unavailable. **3**: Abnormal user signing information. **4**: Billing error. **5**: Price increase disagreed with by a user. **6**: Unknown error |
| retryFlag            | int    | Indicates whether the system still tries to renew an expired subscription. |
| introductoryFlag     | int    | Indicates whether a subscription is in the renewal period with promotion. |
| trialFlag            | int    | Indicates whether a subscription is in the free trial period. |
| cancelTime           | int    | Subscription cancellation timestamp. This parameter has a value when a user makes a complaint and cancels a subscription through the customer service, or when a user performs subscription upgrade or cross-grade that immediately takes effect and cancels the previous receipt of the original subscription. |
| cancelReason         | int    | Reason why a subscription is canceled. **0**: Others. For example, a user mistakenly purchases a subscription and has to cancel it. **1**: A user encounters a problem within the app and cancels the subscription. **2**: A user performs subscription upgrade or cross-grade. |
| appInfo              | String | App information, which is reserved.                          |
| notifyClosed         | int    | Indicates whether a user has disabled the subscription notification function. |
| renewStatus          | int    | Renewal status. **1**: The subscription renewal is normal. **0**: The user cancels subscription renewal. |
| priceConsentStatus   | int    | User opinion on the price increase of a product. **1**: The user has agreed to the price increase. **0**: The user does not take any action. After the subscription expires, it becomes invalid. |
| renewPrice           | int    | Renewal price.                                               |
| subIsvalid           | bool   | **true**: A user has been charged for a product, the product has not expired, and no refund has been made. In this case, you can provide services for the user. **false**: The purchase of a product is not finished, the product has expired, or a refund has been made for the product after its purchase is the subscription valid. |
| cancelledSubKeepDays | int    | Number of days for retaining a subscription relationship after the subscription is canceled. |
| kind                 | int    | Product type. **0**: Consumable. **1**: Non-consumable. **2**: Renewable subscription. **3**: Non-renewable subscription |
| developerChallenge   | String | Challenge defined when an app initiates a consumption request, which uniquely identifies the consumption request. This parameter is valid only for one-off products. |
| consumptionState     | int    | Consumption status, which is valid only for one-off products. The options are as follows: **0**: Not consumed. **1**: Consumed. |
| payOrderId           | String | Merchant ID, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| payType              | String | Payment method. **0**: HUAWEI Points **3**: Credit card **4**: Alipay **6**: Carrier billing **13**: PayPal **16**: Debit card **17**: WeChat Pay **19**: Gift card **20**: Balance **21**: HUAWEI Point card **24**: WorldPay **31**: HUAWEI Pay **32**: Ant Credit Pay **200**: M-Pesa |
| deferFlag            | int    | Indicates whether to postpone the settlement date. The value **1** indicates that the settlement date is postponed. |
| oriSubscriptionId    | String | Original subscription ID. If the parameter is set to a value, the current subscription is switched from another one. The value can be associated with the original subscription. |
| cancelWay            | int    | Subscription cancellation initiator. **0**: User **1**: Developer **2**: Huawei |
| cancellationTime     | int    | Subscription cancellation time in UTC.                       |
| resumeTime           | int    | Time when a subscription is resumed.                         |
| accountFlag          | int    | Account type. **1**: AppTouch ID. **Other values**: HUAWEI ID |
| purchaseTimeMillis   | int    | Purchase time.                                               |
| confirmed            | int    | Confirmation.                                                |
| graceExpirationTime  | int    | Obtains timestamp when a grace period ends.                  |

</details>

##### Public Constants

| Constant    | Type | Value       | Description  |
| ----------- | ---- | :---------- | ------------ |
| NOT_PRESENT | int  | -2147483648 | Not present. |
| INITIALIZED | int  | -2147483648 | Initialized. |
| PURCHASED   | int  | 0           | Purchased.   |
| CANCELED    | int  | 1           | Canceled.    |
| REFUNDED    | int  | 2           | Refunded.    |

##### Public Constructor Summary

| Constructor                                                  | Description                                               |
| ------------------------------------------------------------ | --------------------------------------------------------- |
| InAppPurchaseData({int applicationId, bool autoRenewing, String orderId, String packageName, String productId, String productName, int purchaseTime, int purchaseState, String developerPayload, String purchaseToken, int purchaseType, String currency, int price, String country, String lastOrderId, String productGroup, int oriPurchaseTime, String subscriptionId, int quantity, int daysLastes, int numOfPeriods, int numOfDiscounts, int expirationDate, int expirationIntent, int retryFlag, int introductoryFlag, int TrialFlag, int cancelTime, int cancelReason, String appInfo, int notifyClosed, int renewStatus, int priceConsentStatus, int renewPrice, bool subIsvalid, int cancelledSubKeepDays, int kind, String developerChallenge, int consumptionState, String payOrderId, String payType, int deferFlag, String orioriSubscriptionId, int cancelWay, int cancellationTime, int resumeTime, int accountFlag, int purchaseTimeMillis, int confirmed}) | Default constructor.                                      |
| InAppPurchaseData.fromJson(String source)                    | Creates an *InAppPurchaseData* object from a JSON string. |

##### Public Constructors

###### InAppPurchaseData({int applicationId, bool autoRenewing, String orderId, String packageName, String productId, String productName, int purchaseTime, int purchaseState, String developerPayload, String purchaseToken, int purchaseType, String currency, int price, String country, String lastOrderId, String productGroup, int oriPurchaseTime, String subscriptionId, int quantity, int daysLastes, int numOfPeriods, int numOfDiscounts, int expirationDate, int expirationIntent, int retryFlag, int introductoryFlag, int TrialFlag, int cancelTime, int cancelReason, String appInfo, int notifyClosed, int renewStatus, int priceConsentStatus, int renewPrice, bool subIsvalid, int cancelledSubKeepDays, int kind, String developerChallenge, int consumptionState, String payOrderId, String payType, int deferFlag, String orioriSubscriptionId, int cancelWay, int cancellationTime, int resumeTime, int accountFlag, int purchaseTimeMillis, int confirmed, int graceExpirationTime})

Constructor for *InAppPurchaseData* object. 

<details>
  <summary>Click to expand/collapse Parameter table</summary>

| Parameter            | Type   | Description                                                  |
| -------------------- | ------ | ------------------------------------------------------------ |
| applicationId        | int    | ID of an app that initiates a purchase.                      |
| autoRenewing         | bool   | Indicates whether the subscription is automatically renewed. Currently, the value is always **false**. |
| orderId              | String | Order ID on the Huawei IAP server, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| packageName          | String | Software package name of the app that initiates a purchase.  |
| productId            | String | Product ID.                                                  |
| productName          | String | Product name.                                                |
| purchaseTime         | int    | Purchase timestamp, which is the number of milliseconds from 00:00:00 on January 1, 1970 to the purchase time. |
| purchaseState        | int    | Order status. **-1**: Initialized and invisible **0**: Purchased **1**: Canceled **2**: Refunded |
| developerPayload     | String | Reserved information on the merchant side, which is passed by the app during payment. |
| purchaseToken        | String | Purchase token, which uniquely identifies the mapping between a product and a user. It is generated by the Huawei IAP server when the payment is complete. |
| purchaseType         | int    | Purchase type.**0**: in the sandbox**1**: in the promotion period (currently unsupported)This parameter is not returned during formal purchase. |
| currency             | String | Currency. The value must be a currency defined in the [ISO 4217](https://www.iso.org/iso-4217-currency-codes.html) standard. Example: USD, CNY, and TRY |
| price                | int    | Value after the actual price of a product is multiplied by 100. The actual price is accurate to two decimal places. For example, if the value of this parameter is **501**, the actual product price is 5.01. |
| country              | String | Country or region code of a user service area. The value must comply with the [ISO 3166](https://www.iso.org/iso-3166-country-codes.html) standard. Example: US, CN, and TR |
| lastOrderId          | String | Order ID generated by the Huawei IAP server during fee deduction on the previous renewal. |
| productGroup         | String | ID of the subscription group to which a subscription belongs. |
| oriPurchaseTime      | int    | First fee deduction timestamp, which is the number of milliseconds since 00:00:00 on January 1, 1970. |
| subscriptionId       | String | Subscription ID.                                             |
| quantity             | int    | Purchase quantity.                                           |
| daysLasted           | int    | Days of a paid subscription, excluding the free trial period and promotion period. |
| numOfPeriods         | int    | Number of successful standard renewal periods (that is, renewal periods without promotion). If the parameter is set to **0** or left empty, no renewal has been performed successfully. |
| numOfDiscounts       | int    | Number of successful renewal periods with promotion.         |
| expirationDate       | int    | Subscription expiration timestamp. For an automatic renewal receipt where the fee has been deducted successfully, this parameter indicates the renewal date or expiration date. If the value is a past time for the latest receipt of a product, the subscription has expired. |
| expirationIntent     | int    | Reason why a subscription expires. **1**: Canceled by a user. **2**: Product being unavailable. **3**: Abnormal user signing information. **4**: Billing error. **5**: Price increase disagreed with by a user. **6**: Unknown error |
| retryFlag            | int    | Indicates whether the system still tries to renew an expired subscription. |
| introductoryFlag     | int    | Indicates whether a subscription is in the renewal period with promotion. |
| trialFlag            | int    | Indicates whether a subscription is in the free trial period. |
| cancelTime           | int    | Subscription cancellation timestamp. This parameter has a value when a user makes a complaint and cancels a subscription through the customer service, or when a user performs subscription upgrade or cross-grade that immediately takes effect and cancels the previous receipt of the original subscription. |
| cancelReason         | int    | Reason why a subscription is canceled. **0**: Others. For example, a user mistakenly purchases a subscription and has to cancel it. **1**: A user encounters a problem within the app and cancels the subscription. **2**: A user performs subscription upgrade or cross-grade. |
| appInfo              | String | App information, which is reserved.                          |
| notifyClosed         | int    | Indicates whether a user has disabled the subscription notification function. |
| renewStatus          | int    | Renewal status. **1**: The subscription renewal is normal. **0**: The user cancels subscription renewal. |
| priceConsentStatus   | int    | User opinion on the price increase of a product. **1**: The user has agreed to the price increase. **0**: The user does not take any action. After the subscription expires, it becomes invalid. |
| renewPrice           | int    | Renewal price.                                               |
| subIsvalid           | bool   | **true**: A user has been charged for a product, the product has not expired, and no refund has been made. In this case, you can provide services for the user. **false**: The purchase of a product is not finished, the product has expired, or a refund has been made for the product after its purchase is the subscription valid. |
| cancelledSubKeepDays | int    | Number of days for retaining a subscription relationship after the subscription is canceled. |
| kind                 | int    | Product type. **0**: Consumable. **1**: Non-consumable. **2**: Renewable subscription. **3**: Non-renewable subscription |
| developerChallenge   | String | Challenge defined when an app initiates a consumption request, which uniquely identifies the consumption request. This parameter is valid only for one-off products. |
| consumptionState     | int    | Consumption status, which is valid only for one-off products. The options are as follows: **0**: Not consumed. **1**: Consumed. |
| payOrderId           | String | Merchant ID, which uniquely identifies a transaction and is generated by the Huawei IAP server during payment. |
| payType              | String | Payment method. **0**: HUAWEI Points **3**: Credit card **4**: Alipay **6**: Carrier billing **13**: PayPal **16**: Debit card **17**: WeChat Pay **19**: Gift card **20**: Balance **21**: HUAWEI Point card **24**: WorldPay **31**: HUAWEI Pay **32**: Ant Credit Pay **200**: M-Pesa |
| deferFlag            | int    | Indicates whether to postpone the settlement date. The value **1** indicates that the settlement date is postponed. |
| oriSubscriptionId    | String | Original subscription ID. If the parameter is set to a value, the current subscription is switched from another one. The value can be associated with the original subscription. |
| cancelWay            | int    | Subscription cancellation initiator. **0**: User **1**: Developer **2**: Huawei |
| cancellationTime     | int    | Subscription cancellation time in UTC.                       |
| resumeTime           | int    | Time when a subscription is resumed.                         |
| accountFlag          | int    | Account type. **1**: AppTouch ID. **Other values**: HUAWEI ID |
| purchaseTimeMillis   | int    | Purchase time.                                               |
| confirmed            | int    | Confirmation.                                                |
| graceExpirationTime  | int    | Obtains timestamp when a grace period ends.                  |

</details>

###### InAppPurchaseData.fromJson(String source)

Creates an *InAppPurchaseData* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### IsEnvReadyResult

Information returned when the *isEnvReady* API is successfully called.

##### Public Properties

| Name       | Type                | Description                                                  |
| ---------- | ------------------- | ------------------------------------------------------------ |
| returnCode | String              | Result code. **0**: The country or region of the signed-in HUAWEI ID supports HUAWEI IAP. |
| status     | [*Status*](#status) | [*Status*](#status) object that contains the task processing result. |

##### Public Constructor Summary

| Constructor                                            | Description                                              |
| ------------------------------------------------------ | -------------------------------------------------------- |
| IsEnvReadyResult({String returnCode, *Status* status}) | Default constructor.                                     |
| IsEnvReadyResult.fromJson(String source)               | Creates an *IsEnvReadyResult* object from a JSON string. |

##### Public Constructors

###### IsEnvReadyResult({String returnCode, *Status* status})

Constructor for *IsEnvReadyResult* object.

| Parameter  | Type                | Description                                                  |
| ---------- | ------------------- | ------------------------------------------------------------ |
| returnCode | String              | Result code. **0**: The country or region of the signed-in HUAWEI ID supports HUAWEI IAP. |
| status     | [*Status*](#status) | [*Status*](#status) object that contains the task processing result. |

###### IsEnvReadyResult.fromJson(String source)

Creates an *IsEnvReadyResult* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### IsSandboxActivatedResult

Information returned when the *isSandboxActivated* API is successfully called. 

##### Public Properties

| Name            | Type                | Description                                                  |
| --------------- | ------------------- | ------------------------------------------------------------ |
| errMsg          | String              | Result code description.                                     |
| isSandboxApk    | bool                | Indicates whether the app APK version meets the requirements of the sandbox testing. |
| isSandboxUser   | bool                | Indicates whether a sandbox testing account is used.         |
| returnCode      | String              | Result code. **0**: Success                                  |
| versionFrMarket | String              | Information about the app version that is last released on HUAWEI AppGallery. |
| versionInApk    | String              | App version information.                                     |
| status          | [*Status*](#status) | [*Status*](#status) object that contains the task processing result. |

##### Public Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| IsSandboxActivatedResult({String errMsg, bool isSandboxApk, isSandboxUser, String returnCode, String versionFrMarket, String versionInApk, *Status* status}) | Default constructor.                                         |
| IsSandboxActivatedResult.fromJson(String source)             | Creates an *IsSandboxActivatedResult* object from a JSON string. |

##### Public Constructors

###### IsSandboxActivatedResult({String errMsg, bool isSandboxApk, isSandboxUser, String returnCode, String versionFrMarket, String versionInApk, *Status* status})

Constructor for *IsSandboxActivatedResult* object.

| Parameter       | Type                | Description                                                  |
| --------------- | ------------------- | ------------------------------------------------------------ |
| errMsg          | String              | Result code description.                                     |
| isSandboxApk    | bool                | Indicates whether the app APK version meets the requirements of the sandbox testing. |
| isSandboxUser   | bool                | Indicates whether a sandbox testing account is used.         |
| returnCode      | String              | Result code. **0**: Success                                  |
| versionFrMarket | String              | Information about the app version that is last released on HUAWEI AppGallery. |
| versionInApk    | String              | App version information.                                     |
| status          | [*Status*](#status) | [*Status*](#status) object that contains the task processing result. |

###### IsSandboxActivatedResult.fromJson(String source)

Creates an *IsSandboxActivatedResult* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### OwnedPurchasesReq

Request information of the *obtainOwnedPurchases* and *obtainOwnedPurchaseRecord* API.

##### Public Properties

| Name              | Type   | Description                                                  |
| ----------------- | ------ | ------------------------------------------------------------ |
| priceType         | int    | Type of a product to be queried. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| continuationToken | String | Data location flag for query in pagination mode. This parameter is optional for the first query. After the API is called, the returned information contains this parameter. If query in pagination mode is required for the next API call, this parameter can be set for the second query. |

##### Public Constructor Summary

| Constructor                                                  | Description                                               |
| ------------------------------------------------------------ | --------------------------------------------------------- |
| OwnedPurchasesReq({int priceType, String continuationToken}) | Default constructor.                                      |
| OwnedPurcahsesReq.fromJson(String source)                    | Creates an *OwnedPurchasesReq* object from a JSON string. |

##### Public Constructors

###### OwnedPurchasesReq({int priceType, String continuationToken})

Constructor for *OwnedPurchasesReq* object.

| Parameter         | Type   | Description                                                  |
| ----------------- | ------ | ------------------------------------------------------------ |
| priceType         | int    | Type of a product to be queried. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| continuationToken | String | Data location flag for query in pagination mode. This parameter is optional for the first query. After the API is called, the returned information contains this parameter. If query in pagination mode is required for the next API call, this parameter can be set for the second query. |

###### OwnedPurcahsesReq.fromJson(String source)

Creates an *OwnedPurchasesReq* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### OwnedPurchasesResult

Information returned when the *obtainedOwnedPurchases* and *obtainOwnedPurchaseRecord* API is successfully called. 

##### Public Properties

| Name                        | Type                                             | Description                                                  |
| --------------------------- | ------------------------------------------------ | ------------------------------------------------------------ |
| continuationToken           | String                                           | Data location flag. If a user has a large number of products and the response contains **continuationToken**, the app must initiate another call on the current method and pass **continuationToken** currently received. If product query is still incomplete, the app needs to call the API again until no **continuationToken** is returned, indicating that all products are returned. |
| errMsg                      | String                                           | Result code description.                                     |
| inAppPurchaseDataList       | List\<[*InAppPurchaseData*](#inapppurchasedata)> | Information about products that have been purchased but not consumed or about all existing subscription relationships of users using the *obtainOwnedPurchases* method. Historical consumable information or all subscription receipts, which are returned using the *obtainOwnedPurchaseRecord* method. |
| inAppSignature              | List\<String>                                    | Signature character string of each subscription relationship in the **InAppPurchaseDataList** list. |
| itemList                    | List\<String>                                    | ID list of found products. The value is a string array.      |
| returnCode                  | String                                           | Result code.**0**: The query is successful.                  |
| status                      | [*Status*](#status)                              | [*Status*](#status) object that contains the task processing result. |
| placedInappPurchaseDataList | List\<String>                                    | Subscription relationship information about a user who has performed subscription switchover. The value is a JSON string array. For details about the parameters contained in each JSON string, please refer to the description of [*InAppPurchaseData*](#inapppurchasedata). |
| placedInappSignatureList    | List\<String>                                    | Signature string of each subscription relationship in the **placedInappPurchaseDataList** list. |
| rawValue                    | String                                           | Unparsed JSON String of response. NOTE: IAP SDK does not return a JSON response. This field is the response class converted to JSON. |

##### Public Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| OwnedPurchasesResult({String continuationToken, String errMsg, List\<*InAppPurchaseData*> inAppPurchaseDataList, List\<String> inAppSignature, List\<String> itemList, String returnCode, *Status* status, List\<String> placedInappPurchaseDataList, List\<String> placedInappSignatureList}) | Default constructor.                                         |
| OwnedPurchasesResult.fromJson(String source)                 | Creates an *OwnedPurchasesResult* object from a JSON string. |

##### Public Constructors

###### OwnedPurchasesResult({String continuationToken, String errMsg, List\<*InAppPurchaseData*> inAppPurchaseDataList, List\<String> inAppSignature, List\<String> itemList, String returnCode, *Status* status, List\<String> placedInappPurchaseDataList, List\<String> placedInappSignatureList})

Constructor for *OwnedPurchasesResult* object.

| Parameter                   | Type                                             | Description                                                  |
| --------------------------- | ------------------------------------------------ | ------------------------------------------------------------ |
| continuationToken           | String                                           | Data location flag. If a user has a large number of products and the response contains **continuationToken**, the app must initiate another call on the current method and pass **continuationToken** currently received. If product query is still incomplete, the app needs to call the API again until no **continuationToken** is returned, indicating that all products are returned. |
| errMsg                      | String                                           | Result code description.                                     |
| inAppPurchaseDataList       | List\<[*InAppPurchaseData*](#inapppurchasedata)> | Information about products that have been purchased but not consumed or about all existing subscription relationships of users using the *obtainOwnedPurchases* method. Historical consumable information or all subscription receipts, which are returned using the *obtainOwnedPurchaseRecord* method. |
| inAppSignature              | List\<String>                                    | Signature character string of each subscription relationship in the **InAppPurchaseDataList** list. |
| itemList                    | List\<String>                                    | ID list of found products. The value is a string array.      |
| returnCode                  | String                                           | Result code.**0**: The query is successful.                  |
| status                      | [*Status*](#status)                              | [*Status*](#status) object that contains the task processing result. |
| placedInappPurchaseDataList | List\<String>                                    | Subscription relationship information about a user who has performed subscription switchover. The value is a JSON string array. For details about the parameters contained in each JSON string, please refer to the description of [*InAppPurchaseData*](#inapppurchasedata). |
| placedInappSignatureList    | List\<String>                                    | Signature string of each subscription relationship in the **placedInappPurchaseDataList** list. |

###### OwnedPurchasesResult.fromJson(String source)

Creates an *OwnedPurchasesResult* object from a JSON string. 

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### ProductInfo

Details of a product.

##### Public Properties

<details>
  <summary>Click to expand/collapse Properties table</summary>

| Name                   | Type   | Description                                                  |
| ---------------------- | ------ | ------------------------------------------------------------ |
| productId              | String | Product ID.                                                  |
| priceType              | int    | Product type. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| price                  | String | Displayed price of a product, including the currency symbol and actual price of the product. The value is in the **Currency symbolPrice** format, for example, ¥0.15. The price includes the tax. |
| microsPrice            | int    | Product price in micro unit, which equals to the actual product price multiplied by 1,000,000. For example, if the actual price of a product is US$1.99, the product price in micro unit is 1990000 (1.99 x 1000000). |
| originalLocalPrice     | String | Original price of a product, including the currency symbol and actual price of the product. The value is in the **Currency symbolPrice** format, for example, ¥0.15. The price includes the tax. |
| originalMicroPrice     | int    | Original price of a product in micro unit, which equals to the original product price multiplied by 1,000,000. For example, if the original price of a product is US$1.99, the product price in micro unit is 1990000 (1.99 x 1000000). |
| currency               | String | Currency used to pay for a product. The value must comply with the [ISO 4217](https://www.iso.org/iso-4217-currency-codes.html) standard. Example: USD, CNY, and TRY |
| productName            | String | Product name, which is set during product information configuration. The name is displayed on the checkout page. |
| productDesc            | String | Description of a product, which is set during product information configuration. |
| subSpecialPriceMicros  | int    | Promotional subscription price in micro unit, which equals to the actual promotional subscription price multiplied by 1,000,000. For example, if the actual price of a product is US$1.99, the product price in micro unit is 1990000 (1.99 x 1000000). This parameter is returned only when subscriptions are queried. |
| subSpecialPeriodCycles | int    | Number of promotion periods of a subscription. It is set when you set the promotional price of a subscription in AppGallery Connect. For details, please refer to [Setting a Promotional Price](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-modify_product#h1-1575968939349). This parameter is returned only when subscriptions are queried. |
| subProductLevel        | int    | Level of a subscription in its subscription group.           |
| status                 | int    | Product status. **0**: Valid. **1**: Deleted. Products in this state cannot be renewed or subscribed to. **6**: Removed. New subscriptions are not allowed, but users who have subscribed to products can still renew them. |
| subFreeTrialPeriod     | String | Free trial period of a subscription. It is set when you set the promotional price of a subscription in AppGallery Connect. For details, please refer to [Setting a Promotional Price](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-modify_product#h1-1575968939349). |
| subGroupId             | String | ID of the subscription group to which a subscription belongs. |
| subGroupTitle          | String | Description of the subscription group to which a subscription belongs. |
| subSpecialPeriod       | String | Promotion period unit of a subscription, which complies with the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) standard. For example, P1W indicates 1 week, P1M indicates 1 month, P2M indicates 2 months, P6M indicates 6 months, and P1Y indicates 1 year. This parameter is returned only when subscriptions are queried. |
| subPeriod              | String | Unit of a subscription period, which complies with the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) standard. For example, P1W indicates 1 week, P1M indicates 1 month, P2M indicates 2 months, P6M indicates 6 months, and P1Y indicates 1 year. This parameter is returned only when subscriptions are queried. |
| subSpecialPrice        | String | Promotional price of a subscription, including the currency symbol and actual price. The value is in the **Currency symbolPrice** format, for example, ¥0.15. The price includes the tax. This parameter is returned only when subscriptions are queried. |

</details>

##### Public Constructor Summary

| Constructor                                                  | Description                                        |
| ------------------------------------------------------------ | -------------------------------------------------- |
| ProductInfo({String productId, int priceType, String price, int microsPrice, String originalLocalPrice, int originalMicroPrice, String currency, String productName, String productDesc, int subSpecialPriceMicros, int subSpecialPeriodCycles, int subProductLevel, int status, String subFreeTrialPeriod, String subGroupId, String subGroupTitle, String subSpecialPeriod, String subPeriod, String subSpecialPrice}) | Default constructor.                               |
| ProductInfo.fromJson(String source)                          | Creates a *ProductInfo* object from a JSON string. |

##### Public Constructors

###### ProductInfo({String productId, int priceType, String price, int microsPrice, String originalLocalPrice, int originalMicroPrice, String currency, String productName, String productDesc, int subSpecialPriceMicros, int subSpecialPeriodCycles, int subProductLevel, int status, String subFreeTrialPeriod, String subGroupId, String subGroupTitle, String subSpecialPeriod, String subPeriod, String subSpecialPrice})

Constructor for *ProductInfo* object.

<details>
  <summary>Click to expand/collapse Parameter table</summary>

| Parameter              | Type   | Description                                                  |
| ---------------------- | ------ | ------------------------------------------------------------ |
| productId              | String | Product ID.                                                  |
| priceType              | int    | Product type. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| price                  | String | Displayed price of a product, including the currency symbol and actual price of the product. The value is in the **Currency symbolPrice** format, for example, ¥0.15. The price includes the tax. |
| microsPrice            | int    | Product price in micro unit, which equals to the actual product price multiplied by 1,000,000. For example, if the actual price of a product is US$1.99, the product price in micro unit is 1990000 (1.99 x 1000000). |
| originalLocalPrice     | String | Original price of a product, including the currency symbol and actual price of the product. The value is in the **Currency symbolPrice** format, for example, ¥0.15. The price includes the tax. |
| originalMicroPrice     | int    | Original price of a product in micro unit, which equals to the original product price multiplied by 1,000,000. For example, if the original price of a product is US$1.99, the product price in micro unit is 1990000 (1.99 x 1000000). |
| currency               | String | Currency used to pay for a product. The value must comply with the [ISO 4217](https://www.iso.org/iso-4217-currency-codes.html) standard. Example: USD, CNY, and TRY |
| productName            | String | Product name, which is set during product information configuration. The name is displayed on the checkout page. |
| productDesc            | String | Description of a product, which is set during product information configuration. |
| subSpecialPriceMicros  | int    | Promotional subscription price in micro unit, which equals to the actual promotional subscription price multiplied by 1,000,000. For example, if the actual price of a product is US$1.99, the product price in micro unit is 1990000 (1.99 x 1000000). This parameter is returned only when subscriptions are queried. |
| subSpecialPeriodCycles | int    | Number of promotion periods of a subscription. It is set when you set the promotional price of a subscription in AppGallery Connect. For details, please refer to [Setting a Promotional Price](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-modify_product#h1-1575968939349). This parameter is returned only when subscriptions are queried. |
| subProductLevel        | int    | Level of a subscription in its subscription group.           |
| status                 | int    | Product status. **0**: Valid. **1**: Deleted. Products in this state cannot be renewed or subscribed to. **6**: Removed. New subscriptions are not allowed, but users who have subscribed to products can still renew them. |
| subFreeTrialPeriod     | String | Free trial period of a subscription. It is set when you set the promotional price of a subscription in AppGallery Connect. For details, please refer to [Setting a Promotional Price](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-modify_product#h1-1575968939349). |
| subGroupId             | String | ID of the subscription group to which a subscription belongs. |
| subGroupTitle          | String | Description of the subscription group to which a subscription belongs. |
| subSpecialPeriod       | String | Promotion period unit of a subscription, which complies with the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) standard. For example, P1W indicates 1 week, P1M indicates 1 month, P2M indicates 2 months, P6M indicates 6 months, and P1Y indicates 1 year. This parameter is returned only when subscriptions are queried. |
| subPeriod              | String | Unit of a subscription period, which complies with the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) standard. For example, P1W indicates 1 week, P1M indicates 1 month, P2M indicates 2 months, P6M indicates 6 months, and P1Y indicates 1 year. This parameter is returned only when subscriptions are queried. |
| subSpecialPrice        | String | Promotional price of a subscription, including the currency symbol and actual price. The value is in the **Currency symbolPrice** format, for example, ¥0.15. The price includes the tax. This parameter is returned only when subscriptions are queried. |

</details>

###### ProductInfo.fromJson(String source)

Creates a *ProductInfo* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### ProductInfoReq

Request object of the *obtainProductInfo* API.

##### Public Properties

| Name      | Type          | Description                                                  |
| --------- | ------------- | ------------------------------------------------------------ |
| priceType | int           | Type of a product to be queried. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| skuIds    | List\<String> | ID list of products to be queried. Each product ID must exist and be unique in the current app. The product ID is the same as that you set when configuring product information in AppGallery Connect. For details, please refer to [Adding a Product](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-create_product). |

##### Public Constructor Summary

| Constructor                                           | Description                                           |
| ----------------------------------------------------- | ----------------------------------------------------- |
| ProductInfoReq({int priceType, List\<String> skuIds}) | Default constructor.                                  |
| ProductInfoReq.fromJson(String source)                | Creates a *ProductInfoReq* object from a JSON string. |

##### Public Constructors

###### ProductInfoReq({int priceType, List\<String> skuIds})

Constructor for *ProductInfoReq* object.

| Parameter | Type          | Description                                                  |
| --------- | ------------- | ------------------------------------------------------------ |
| priceType | int           | Type of a product to be queried. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| skuIds    | List\<String> | ID list of products to be queried. Each product ID must exist and be unique in the current app. The product ID is the same as that you set when configuring product information in AppGallery Connect. For details, please refer to [Adding a Product](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-create_product). |

###### ProductInfoReq.fromJson(String source)

Creates a *ProductInfoReq* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### ProductInfoResult

Information returned when the *obtainProductInfo* API is successfully called.

##### Public Properties

| Name            | Type                                 | Description                                                  |
| --------------- | ------------------------------------ | ------------------------------------------------------------ |
| errMsg          | String                               | Result code description.                                     |
| productInfoList | List\<[*ProductInfo*](#productinfo)> | List of found products.                                      |
| returnCode      | String                               | Result code. **0**: The query is successful.                 |
| status          | [*Status*](#status)                  | [*Status*](#status) object that contains the task processing result. |

##### Public Constructor Summary

| Constructor                                                  | Description                                              |
| ------------------------------------------------------------ | -------------------------------------------------------- |
| ProductInfoResult({String errMsg, List\<*ProductInfo*> productInfoList, String returnCode, *Status* status}) | Default constructor.                                     |
| ProductInfoResult.fromJson(String source)                    | Creates a *ProductInfoResult* object from a JSON string. |

##### Public Constructors

###### ProductInfoResult({String errMsg, List\<ProductInfo> productInfoList, String returnCode, *Status* status})

Constructor for *ProductInfoResult* object.

| Parameter       | Type                                 | Description                                                  |
| --------------- | ------------------------------------ | ------------------------------------------------------------ |
| errMsg          | String                               | Result code description.                                     |
| productInfoList | List\<[*ProductInfo*](#productinfo)> | List of found products.                                      |
| returnCode      | String                               | Result code. **0**: The query is successful.                 |
| status          | [*Status*](#status)                  | [*Status*](#status) object that contains the task processing result. |

###### ProductInfoResult.fromJson(String source)

Creates a *ProductInfoResult* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### PurchaseIntentReq

Request object of the *createPurchaseIntent* API.

##### Public Properties

| Name             | Type   | Description                                                  |
| ---------------- | ------ | ------------------------------------------------------------ |
| priceType        | int    | Product type. **0**: Consumable **1**: Non-consumable **2**: Auto-renewable subscription |
| productId        | String | ID of a product to be paid. The product ID is the same as that you set when configuring product information in [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html). For details, please refer to [Adding a Product](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-create_product). |
| developerPayload | String | Information stored on the merchant side. If this parameter is set, the value will be returned in the callback result to the app after successful payment. Note: The value length of this parameter is within (0, 128). |
| reservedInfor    | String | This parameter is used to pass the extra fields set by a merchant in a JSON string in the key-value format. |

##### Public Constructor Summary

| Constructor                                                  | Description                                              |
| ------------------------------------------------------------ | -------------------------------------------------------- |
| PurchaseIntentReq({int priceType, String productId, String developerPayload, String reservedInfor}) | Default constructor.                                     |
| PurchaseIntentReq.fromJson(String source)                    | Creates a *PurchaseIntentReq* object from a JSON string. |

##### Public Constructors

###### PurchaseIntentReq({int priceType, String productId, String developerPayload, String reservedInfor})

Constructor for *PurchaseIntentReq* object.

| Parameter        | Type   | Description                                                  |
| ---------------- | ------ | ------------------------------------------------------------ |
| priceType        | int    | Product type.**0**: consumable**1**: non-consumable**2**: auto-renewable subscription |
| productId        | String | ID of a product to be paid. The product ID is the same as that you set when configuring product information in [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html). For details, please refer to [Adding a Product](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-create_product). |
| developerPayload | String | Information stored on the merchant side. If this parameter is set, the value will be returned in the callback result to the app after successful payment. Note: The value length of this parameter is within (0, 128). |
| reservedInfor    | String | This parameter is used to pass the extra fields set by a merchant in a JSON string in the key-value format. |

###### PurchaseIntentReq.fromJson(String source)

Creates a *PurchaseIntentReq* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### PurchaseResultInfo

Returned payment result information.

##### Public Properties

| Name               | Type                                      | Description                                                  |
| ------------------ | ----------------------------------------- | ------------------------------------------------------------ |
| returnCode         | String                                    | Result code. **0**: The payment is successful. **Other values**: The payment failed. For details about the result codes, please refer to [Troubleshooting and Common Result Codes](https://developer.huawei.com/consumer/en/doc/development/HMS-References/iap-ExceptionHandlingAndGeneralErrorCodes-v4). |
| inAppPurchaseData  | [*InAppPurchaseData*](#inapppurchasedata) | [*InAppPurchaseData*](#inapppurchasedata) object that contains purchase order details. For details about the parameters contained in the string, please refer to [*InAppPurchaseData*](#inapppurchasedata). |
| inAppDataSignature | String                                    | Signature string generated after purchase data is signed using a private payment key. The signature algorithm is SHA256withRSA. After the payment is successful, the app needs to perform signature verification on the string of [*InAppPurchaseData*](#inapppurchasedata) using the payment public key. For details about how to obtain the public key, please refer to [Querying IAP Information](https://developer.huawei.com/consumer/en/doc/development/HMS-Guides/appgallery_querypaymentinfo). |
| errMsg             | String                                    | Result code description.                                     |
| rawValue           | String                                    | Unparsed JSON String of response. NOTE: IAP SDK does not return a JSON response. This field is the response class converted to JSON. |

##### Public Constructor Summary

| Constructor                                                  | Description                                               |
| ------------------------------------------------------------ | --------------------------------------------------------- |
| PurchaseResultInfo({String returnCode, *InAppPurchaseData* inAppPurchaseData, String inAppDataSignature, String errMsg}) | Default constructor.                                      |
| PurchaseResultInfo.fromJson(String source)                   | Creates a *PurchaseResultInfo* object from a JSON string. |

##### Public Constructors

###### PurchaseResultInfo({String returnCode, *InAppPurchaseData* inAppPurchaseData, String inAppDataSignature, String errMsg})

Constructor for *PurchaseResultInfo* object

| Parameter          | Type                                      | Description                                                  |
| ------------------ | ----------------------------------------- | ------------------------------------------------------------ |
| returnCode         | String                                    | Result code. **0**: The payment is successful. **Other values**: The payment failed. For details about the result codes, please refer to [Troubleshooting and Common Result Codes](https://developer.huawei.com/consumer/en/doc/development/HMS-References/iap-ExceptionHandlingAndGeneralErrorCodes-v4). |
| inAppPurchaseData  | [*InAppPurchaseData*](#inapppurchasedata) | [*InAppPurchaseData*](#inapppurchasedata) object that contains purchase order details. For details about the parameters contained in the string, please refer to [*InAppPurchaseData*](#inapppurchasedata). |
| inAppDataSignature | String                                    | Signature string generated after purchase data is signed using a private payment key. The signature algorithm is SHA256withRSA. After the payment is successful, the app needs to perform signature verification on the string of [*InAppPurchaseData*](#inapppurchasedata) using the payment public key. For details about how to obtain the public key, please refer to [Querying IAP Information](https://developer.huawei.com/consumer/en/doc/development/HMS-Guides/appgallery_querypaymentinfo). |
| errMsg             | String                                    | Result code description.                                     |

###### PurchaseResultInfo.fromJson(String source)

Creates a *PurchaseResultInfo* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### StartIapActivityReq

Request object of *startIapActivity* API.

##### Public Properties

| Name      | Type   | Description                                                  |
| --------- | ------ | ------------------------------------------------------------ |
| type      | int    | Type of the page to be redirected to. **2**: Subscription management page. **3**: Subscription editing page. |
| productId | String | ID of a subscription.                                        |

##### Public Constants

| Constant                        | Type | Description                                                  |
| ------------------------------- | ---- | ------------------------------------------------------------ |
| TYPE_SUBSCRIBE_MANAGER_ACTIVITY | int  | Redirects your app to the subscription management page of HUAWEI IAP. |
| TYPE_SUBSCRIBE_EDIT_ACTIVITY    | int  | Redirects your app to the subscription editing page of HUAWEI IAP. |

##### Public Constructor Summary

| Constructor                                       | Description                                                |
| ------------------------------------------------- | ---------------------------------------------------------- |
| StartIapActivityReq({int type, String productId}) | Default constructor.                                       |
| StartIapActivityReq.fromJson(String source)       | Creates a *StartIapActivityReq* object from a JSON string. |

##### Public Constructors

###### StartIapActivityReq({int type, String productId})

Constructor for *StartIapActivityReq* object. 

| Parameter | Type   | Description                                                  |
| --------- | ------ | ------------------------------------------------------------ |
| type      | int    | Type of the page to be redirected to. **2**: Subscription management page. **3**: Subscription editing page. |
| productId | String | ID of a subscription                                         |

###### StartIapActivityReq.fromJson(String source)

Creates a *StartIapActivityReq* object from a JSON string.

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| source    | String | JSON string as a source. |

#### Status

Task processing result.

##### Public Properties

| Name          | Type                | Description                                                  |
| ------------- | ------------------- | ------------------------------------------------------------ |
| statusCode    | int                 | Status code. **0**: Success. **1**: Failure. **404**: No resource found. **500**: Internal error. |
| statusMessage | String              | Status description.                                          |
| status        | [*Status*](#status) | Task processing result.                                      |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| Status({int statusCode, String statusMessage, *Status* status}) | Default constructor. |

##### Public Constructors

###### Status({int statusCode, String statusMessage, *Status* status})

Constructor for *Status* object.

| Parameter     | Type                | Description                                                  |
| ------------- | ------------------- | ------------------------------------------------------------ |
| statusCode    | int                 | Status code. **0**: Success. **1**: Failure. **404**: No resource found. **500**: Internal error. |
| statusMessage | String              | Status description.                                          |
| status        | [*Status*](#status) | Task processing result.                                      |

#### HmsIapResult

Represents an error class for *HmsIapResults*.

##### Public Properties

| Name          | Type   | Description     |
| ------------- | ------ | --------------- |
| resultCode    | String | Result code.    |
| resultMessage | String | Result message. |

##### Public Constructor Summary

| Constructor                                             | Description          |
| ------------------------------------------------------- | -------------------- |
| HmsIapResult({String resultCode, String resultMessage}) | Default constructor. |

##### Public Constructors

###### HmsIapResult({String resultCode, String resultMessage})

Constructor for *HmsIapResult* object.

| Parameter     | Type   | Description     |
| ------------- | ------ | --------------- |
| resultCode    | String | Result code.    |
| resultMessage | String | Result message. |

### Constants

#### HmsIapResults

<details>
  <summary>Click to expand/collapse Constants table</summary>

| Constant                                  |              Type               |       Result Code (String)       | Result Message                                               | Possible Solution                                            |
| ----------------------------------------- | :-----------------------------: | :------------------------------: | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ORDER_STATE_SUCCESS                       | [*HmsIapResult*](#hmsiapresult) |                0                 | Success                                                      | -                                                            |
| ORDER_STATE_FAILED                        | [*HmsIapResult*](#hmsiapresult) |                -1                | Common failure result code.                                  | If this result code is returned by the purchase request, you are advised to use the *obtainOwnedPurchases* API to check whether the user has purchased the product. |
| ORDER_STATE_CANCEL                        | [*HmsIapResult*](#hmsiapresult) |              60000               | The user cancels the payment.                                | Record the order ID and execute the payment process when the user performs the payment operation again. |
| ORDER_STATE_PARAM_ERROR                   | [*HmsIapResult*](#hmsiapresult) |              60001               | Parameter error (including no parameter).                    | Check whether request parameters are missing and whether the parameter format is correct. |
| ORDER_STATE_IAP_NOT_ACTIVATED             | [*HmsIapResult*](#hmsiapresult) |              60002               | Huawei IAP is not enabled.                                   | To use HUAWEI IAP, you first need to enable the IAP service and also set IAP parameters. For details, please refer to [Enabling Services](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-enable_service#h1-1574822945685). |
| ORDER_STATE_PRODUCT_INVALID               | [*HmsIapResult*](#hmsiapresult) |              60003               | Incorrect product information.                               | Sign in to [AppGallery Connect](https://id1.cloud.huawei.com/CAS/portal/loginAuth.html?validated=true&themeName=red&service=https://oauth-login1.cloud.huawei.com/oauth2/v2/login?access_type=offline&client_id=6099200&display=page&h=1594104430.7100&lang=en-us&redirect_uri=https%3A%2F%2Fdeveloper.huawei.com%2Fconsumer%2Fen%2Fservice%2Fjosp%2Fagc%2FhandleLogin.html&response_type=code&state=5347051&v=5ac7d9f37c52a6bb104ce38116a14734a036f52956a4f3de37f3fad6d0ad1b93&loginChannel=89000000&reqClientType=89&lang=en-us&clientID=6099200). Choose **My apps**, select an app, and go to **Operate** > **Products** > **Product Management**. In the product list, check whether the product exists or whether all its mandatory information is available. |
| ORDER_STATE_CALLS_FREQUENT                | [*HmsIapResult*](#hmsiapresult) |              60004               | Too frequent API calls.                                      | Control the API call frequency.                              |
| ORDER_STATE_NET_ERROR                     | [*HmsIapResult*](#hmsiapresult) |              60005               | Network connection exception.                                | The app displays a message, asking the user to check the network. |
| ORDER_STATE_PMS_TYPE_NOT_MATCH            | [*HmsIapResult*](#hmsiapresult) |              60006               | Inconsistent product.                                        | Sign in to [AppGallery Connect](https://id1.cloud.huawei.com/CAS/portal/loginAuth.html?validated=true&themeName=red&service=https://oauth-login1.cloud.huawei.com/oauth2/v2/login?access_type=offline&client_id=6099200&display=page&h=1594104430.7100&lang=en-us&redirect_uri=https%3A%2F%2Fdeveloper.huawei.com%2Fconsumer%2Fen%2Fservice%2Fjosp%2Fagc%2FhandleLogin.html&response_type=code&state=5347051&v=5ac7d9f37c52a6bb104ce38116a14734a036f52956a4f3de37f3fad6d0ad1b93&loginChannel=89000000&reqClientType=89&lang=en-us&clientID=6099200). Choose **My apps**, select an app, and go to **Operate** > **Products** > **Product Management**. Find the product in the product list and check its type. |
| ORDER_STATE_PRODUCT_COUNTRY_NOT_SUPPORTED | [*HmsIapResult*](#hmsiapresult) |              60007               | Country not supported.                                       | Sign in to [AppGallery Connect](https://id1.cloud.huawei.com/CAS/portal/loginAuth.html?validated=true&themeName=red&service=https://oauth-login1.cloud.huawei.com/oauth2/v2/login?access_type=offline&client_id=6099200&display=page&h=1594104430.7100&lang=en-us&redirect_uri=https%3A%2F%2Fdeveloper.huawei.com%2Fconsumer%2Fen%2Fservice%2Fjosp%2Fagc%2FhandleLogin.html&response_type=code&state=5347051&v=5ac7d9f37c52a6bb104ce38116a14734a036f52956a4f3de37f3fad6d0ad1b93&loginChannel=89000000&reqClientType=89&lang=en-us&clientID=6099200). Choose **My apps**, select an app, and go to **Operate** > **Products** > **Product Management**. In the product list, check whether the product exists or whether all its mandatory information is available. |
| ORDER_VR_UNINSTALL_ERROR                  | [*HmsIapResult*](#hmsiapresult) |              60020               | VR APK is not installed.                                     | This code is returned in the VR payment scenario. Install the VR APK first. |
| ORDER_HWID_NOT_LOGIN                      | [*HmsIapResult*](#hmsiapresult) |              60050               | Huawei ID is not signed in.                                  | The sign-in scenario needs to be processed. For the payment and *isEnvReady* APIs, you can use **status** to instruct users to sign in. For other APIs, perform operations as needed. |
| ORDER_PRODUCT_OWNED                       | [*HmsIapResult*](#hmsiapresult) |              60051               | User already owns the product.                               | Use the *obtainOwnedPurcases* API to check whether the user has purchased the product. For a consumable that has been purchased, call the *ConsumeOwnedPurchase* API to consume the product after it is delivered. After being consumed, the product can be purchased next time. If the product is a non-consumable product or a subscription, the product cannot be purchased again. |
| ORDER_PRODUCT_NOT_OWNED                   | [*HmsIapResult*](#hmsiapresult) |              60052               | User does not owns the product.                              | Use the *obtainOwnedPurchases* API to check whether the user has purchased the product. |
| ORDER_PRODUCT_CONSUMED                    | [*HmsIapResult*](#hmsiapresult) |              60053               | Product already consumed.                                    | Use the *obtainOwnedPurchaseRecord* API to check whether the product has a consumption record. |
| ORDER_ACCOUNT_AREA_NOT_SUPPORTED          | [*HmsIapResult*](#hmsiapresult) |              60054               | Huawei IAP does not support country/region.                  | This result code may be returned when HUAWEI IAP is supported by a country or region but there is a service error. In this case, call related APIs again or contact Huawei technical support. |
| ORDER_NOT_ACCEPT_AGREEMENT                | [*HmsIapResult*](#hmsiapresult) |              60055               | Agreement error.                                             | Please accept user agreement.                                |
| ORDER_HIGH_RISK_OPERATIONS                | [*HmsIapResult*](#hmsiapresult) |              60056               | User triggers risk control.                                  | -                                                            |
| LOG_IN_ERROR                              | [*HmsIapResult*](#hmsiapresult) |        ERR_CAN_NOT_LOG_IN        | Can not log in.                                              | The sign-in scenario needs to be processed again.            |
| UNKNOWN_REQUEST_CODE                      | [*HmsIapResult*](#hmsiapresult) |       UNKNOWN_REQUEST_CODE       | This request code does not match with any available request codes. | Try recalling the API.                                       |
| ACTIVITY_RESULT                           | [*HmsIapResult*](#hmsiapresult) |      ACTIVITY_RESULT_ERROR       | Result is not OK.                                            | Try recalling the API.                                       |
| IS_SANDBOX_READY_ERROR                    | [*HmsIapResult*](#hmsiapresult) |      IS_SANDBOX_READY_ERROR      | null                                                         | Try recalling the API.                                       |
| OBTAIN_PRODUCT_INFO_ERROR                 | [*HmsIapResult*](#hmsiapresult) |    OBTAIN_PRODUCT_INFO_ERROR     | null                                                         | Try recalling the API.                                       |
| PURCHASE_INTENT_EXCEPTION                 | [*HmsIapResult*](#hmsiapresult) |    PURCHASE_INTENT_EXCEPTION     | null                                                         | Try recalling the API.                                       |
| CONSUME_OWNED_PURCHASE_ERROR              | [*HmsIapResult*](#hmsiapresult) |   CONSUME_OWNED_PURCHASE_ERROR   | null                                                         | Try recalling the API.                                       |
| OBTAIN_OWNED_PURCHASES_ERROR              | [*HmsIapResult*](#hmsiapresult) |   OBTAIN_OWNED_PURCHASES_ERROR   | null                                                         | Try recalling the API.                                       |
| START_IAP_ACTIVITY_ERROR                  | [*HmsIapResult*](#hmsiapresult) |     START_IAP_ACTIVITY_ERROR     | null                                                         | Try recalling the API.                                       |
| PURCHASE_INTENT_RESOLUTION                | [*HmsIapResult*](#hmsiapresult) | PURCHASE_INTENT_RESOLUTION_ERROR | null                                                         | Try recalling the API.                                       |
| NO_RESOLUTION                             | [*HmsIapResult*](#hmsiapresult) |          NO_RESOLUTION           | There is no resolution for error.                            | Try recalling the API.                                       |

</details>

You can read more and get detailed information about the interfaces described above from [developer.huawei.com](https://developer.huawei.com)

---

## 4. Configuration and Description

### Preparing for Release

Before building a release version of your app you may need to customize the **proguard-rules**.pro obfuscation configuration file to prevent the HMS Core SDK from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

**\<flutter_project>/android/app/proguard-rules.pro**

```
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
```

**\<flutter_project>/android/app/build.gradle**

```gradle
buildTypes {
    debug {
        signingConfig signingConfigs.config
    }
    release {
        signingConfig signingConfigs.config
        // Enables code shrinking, obfuscation and optimization for release builds
        minifyEnabled true
        // Unused resources will be removed, resources defined in the res/raw/keep.xml will be kept.
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
    }
}
```

---

## 5. Sample Project

This plugin includes a demo project in the [example](example) folder, there you can find more usage examples.

<img src="https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-iap/.docs/homeScreen.jpg" width = 40% height = 40% style="margin:1.5em">

---

## 6. Questions or Issues

If you have questions about how to use HMS samples, try the following options:
- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
**huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

---

## 7. Licensing and Terms

Huawei IAP Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
