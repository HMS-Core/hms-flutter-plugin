# Huawei In App Purchases Flutter Plugin

## Table of Contents
* [Introduction](#introduction)
* [Installation Guide](#installation-guide)
* [API Reference](#api-reference)
* [Configuration Description](#configuration-description)
* [Licensing and Terms](#licensing-and-terms)

## Introduction

This plugin enables communication between Huawei IAP SDK and Flutter platform. Huawei's In-App Purchases (IAP) service allows you to offer in-app purchases and facilitates in-app payment. Users can purchase a variety of virtual products, including one-time virtual products and subscriptions, directly within your app.

Huawei IAP provides the following core capabilities you need to quickly build apps with which your users can buy, consume and subscribe services you provide:
- **IsEnvReady**: Returns a response which indicates user's login and capable of buy status.
- **IsSandboxActivated**: Returns a response which indicates user's account capabilities of sandbox testing.
- **ObtainProductInfo**: Returns a list of product information. 
- **StartIapActivity**: Starts an activity to manage and edit subscriptions.
- **CreatePurchaseIntent**: Starts an activity to buy the desired product or subscribe a product. 
- **ConsumeOwnedPurchase**: Consumes the desired purchased product.
- **ObtainOwnedPurchases**: Returns a list of products that purchased by user.
- **ObtainOwnedPurchaseRecord**: Returns a list of products that purchased and consumed by user. 

## Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app by referring to [Creating an AppGallery Connect Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521853252) and [Adding an App to the Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521946133).

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect.  For details, please refer to [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3).

- Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My apps**. Then, on the **Project Setting** page, set **SHA-256 certificate fingerprint** to the SHA-256 fingerprint from [Configuring the Signing Certificate Fingerprint](https://developer.huawei.com/consumer/en/doc/development/HMS-Guides/iap-configuring-appGallery-connect).

- In [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html), on **My projects** page, in **Manage APIs** tab, find and activate **In App Purchases**, then on **My projects** page, find **In-App Purchases** and set required settings. For more information, please refer to [Setting In-App Purchases Parameters](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-enable_service#h1-1587376818335).

- In [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html), on **My apps** page, find your app from the list and click the app name. Go to **Development > Overview > App Information**. Click **agconnect-service.json** to download configuration file. 

- Copy the **agconnect-service.json** file to the **android/app** directory of your project.

- Open the **build.gradle** file in the **android** directory of your project.
    - Go to **buildscript** then configure the Maven repository address and agconnect plugin for the  HMS SDK.

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
                classpath 'com.huawei.agconnect:agcp:1.3.1.300'
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

- Open the **build.gradle** file in the **android/app** directory.

    - Add `apply plugin: 'com.huawei.agconnect'` line after the `apply plugin: 'com.android.application'` line.

        ```gradle
        apply plugin: 'com.android.application'
        apply plugin: 'com.huawei.agconnect'
        apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
        ```

    - Set your package name in **defaultConfig** > **applicationId** and set **minSdkVersion** to **19** or **higher**.
        Package name must match with the **package_name** entry in **agconnect-services.json** file.
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

    - Configure the signature in **android** according to the signature file information.

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
                    signingConfig signingConfigs.config
                }
            }
        }
        ```

- On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies. For more details please refer the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

    ```yaml
    dependencies:
        huawei_iap:
            # Replace {library path} with actual library path of Huawei IAP Flutter Plugin.
            path: {library path}
    ```

- Run following command to update package info.

    ```
    [project_path]> flutter pub get
    ```

- Run following command to start the app.

    ```
    [project_path]> flutter run
    ```

## API Reference

| Class                      | Description                                                                               |
|:--------------------------:|:-----------------------------------------------------------------------------------------:|
| ConsumeOwnedPurchaseReq    | Represents a request object used to consume a product.                                    |
| ConsumeOwnedPurchaseResult | Represents a response object used to consume a product.                                   |
| ConsumePurchaseData        | Represents details about consumed product.                                                |
| InAppPurchaseData          | Represents details about purchased product.                                               |
| IsEnvReadyResult           | Represents a response object used to gather information about user environment.           |
| IsSandboxActivatedResult   | Represents a response object to gather information about user's sandbox permissions.      |
| OwnedPurchasesReq          | Represents a request object used to obtain owned purchases or owned purchase record.      |
| OwnedPurchasesResult       | Represents a response object used to obtain owned purchases or owned purchase record.     |
| ProductInfo                | Represents details of product.                                                            |
| ProductInfoReq             | Represents a request object used to obtain product information.                           |
| ProductInfoResult          | Represents a response object used to obtain product information.                          |
| PurchaseIntentReq          | Represents a request object used to create a purchase intent.                             |
| PurchaseResultInfo         | Represents a response object used to create a purchase intent.                            |
| StartIapActivityReq        | Represents a request object used to start activity for editing or managing subscriptions. |
| Status                     | Represents status of the API call.                                                        |
| IapClient                  | Entry class of the Huawei IAP service.                                                    |


You can read more and get detailed information about the interfaces described above from [developer.huawei.com](https://developer.huawei.com)

## Configuration Description

No.

## Licensing and Terms

Huawei In App Purchases (IAP) Flutter Plugin uses the Apache 2.0 license.
