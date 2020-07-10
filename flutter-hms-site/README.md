# Huawei Site Kit Flutter Plugin

## Table of Contents
* [Introduction](#introduction)
* [Installation Guide](#installation-guide)
* [API Reference](#api-reference)
* [Configuration Description](#configuration-description)
* [Licensing and Terms](#licensing-and-terms)

## Introduction

This plugin enables communication between Huawei Site SDK and Flutter platform. With Huawei Site Kit, your app can provide users with convenient and secure access to diverse, place-related services.

Huawei Site Kit provides the following core capabilities you need to quickly build apps with which your users can explore the world around them:
- **Place Search**: Returns a place list based on keywords entered by the user.
- **Nearby Place Search**: Searches for nearby places based on the current location of the user's device.
- **Place Details**: Searches for details about a place.
- **Search Suggestion**: Returns a list of place suggestions.

## Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app by referring to [Creating an AppGallery Connect Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521853252) and [Adding an App to the Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521946133).

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect.  For details, please refer to [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3).

- Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My apps**. Then, on the **Project Setting** page, set **SHA-256 certificate fingerprint** to the SHA-256 fingerprint from [Configuring the Signing Certificate Fingerprint](https://developer.huawei.com/consumer/en/doc/development/HMS-Guides/hms-site-configuringagc#h1-1578534708499).

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
        huawei_site:
            # Replace {library path} with actual library path of Huawei Site Kit Flutter Plugin.
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

|          Class          |                                   Description                                    |
|:-----------------------:|:--------------------------------------------------------------------------------:|
|      AddressDetail      |                        Represents details about a place.                         |
|       Coordinate        | Represents the location (that is, the latitude and longitude object) of a place. |
|    CoordinateBounds     |                          Represents coordinate bounds.                           |
|   DetailSearchRequest   |          Represents a request object used to search for place details.           |
|  DetailSearchResponse   |     Represents a response object containing the place details search result.     |
|      SearchService      |                      An entry interface of HUAWEI Site Kit.                      |
|      LocationType       |                             Enumerates place types.                              |
|   NearbySearchRequest   |          Represents a request object used to search for nearby places.           |
|  NearbySearchResponse   |     Represents a response object containing search results of nearby places.     |
|      OpeningHours       |                    Describes weekly opening hours of a place.                    |
|         Period          |                               Represents a period.                               |
|           Poi           |           Represents a POI object containing detailed POI information.           |
| QuerySuggestionRequest  |         Represents a request object used to provide search suggestions.          |
| QuerySuggestionResponse |           Represents a response object containing search suggestions.            |
|          Site           |                    A model class representing a place object.                    |
|    TextSearchRequest    |        Represents a request object used to search for places by keyword.         |
|   TextSearchResponse    |      Represents a response object containing keyword-based search results.       |
|       TimeOfWeek        |                  Represents a time point on a day of the week.                   |

You can read more and get detailed information about the interfaces described above from [developer.huawei.com](https://developer.huawei.com)

## Configuration Description

No.

## Licensing and Terms

Huawei Site Kit Flutter Plugin uses the Apache 2.0 license.
