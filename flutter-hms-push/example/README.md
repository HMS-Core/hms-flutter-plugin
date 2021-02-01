## Huawei Push Kit Flutter Plugin - Demo

---

## Contents

  - [Introduction](#1-introduction)
  - [Installation](#2-installation)
  - [Configuration](#3-configuration)
  - [Licensing and Terms](#4-licensing-and-terms)

---

## 1. Introduction

This demo project is an example to demonstrate the features of the **Huawei Flutter Push Kit** Plugin.

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-push/example/.docs/mainPage.jpg" width = 40% height = 40% style="margin:1.5em"><img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-push/example/.docs/localNotification.jpg" width = 40% height = 40% style="margin:1.5em">

---

## 2. Installation

Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

### Creating a Project in AppGallery Connect

Creating an app in AppGallery Connect is required in order to communicate with the Huawei services. To create an app, perform the following steps:

**Step 1.** Set an unique **Application ID** on the app level build gradle file located on **example/android/app/build.gradle**. You should also change the **package names** for the manifest files in the **/example/android/app/src/** directory to match with the Application ID. 
  ```gradle
  <!-- Other configurations ... -->
    defaultConfig {
      // Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html). You may need to change the package name on AndroidManifest.xml and MainActivity.java respectively.
      // The Application ID here should match with the Package Name on the AppGalleryConnect
      applicationId "<Enter_Your_Package_Here>" // For ex: "com.example.mypushproject"
      minSdkVersion 17
      <!-- Other configurations ... -->
  }
  ```
**Step 2.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)  and select **My projects**.

**Step 3.** Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 4.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 5.** On the **Add app** page, enter the **Application ID** you've defined before as the **Package Name** here, then fill the necessary fields and click **OK**.

### Configuring the Signing Certificate Fingerprint

A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in the **AppGallery Connect**. You can refer to 3rd and 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Setting** > **General information**. In the **App information** field, click the  icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA-256 certificate fingerprint**.

**Step 2:**  After completing the configuration, click **OK** to save the changes. (Check mark icon)

**Step 3:** Enter the properties of the key you generated to the **key.properties** file located on **example/android/key.properties**.

```
storePassword=<your keystore password>
keyPassword=<your key password>
keyAlias=<key>
storeFile=<location of the keystore file, for example: D:/Users/<user_name>/key.jks>
```

### Enabling the Huawei Push Kit Service 

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Growing > Push Kit** and click **Enable Now** to enable the Huawei Push Kit Service. You can also check **Manage APIs** tab on the **Project Settings** page for the enabled HMS services on your app.

**Step 2:** Go to **Project Setting > General information** page, under the **App information** field, click **agconnect-services.json** to download the configuration file.

**Step 3:** Copy the **agconnect-services.json** file to the **example/android/app/** directory of the project. 

### Build & Run the project

**Step 1:** Run the following command to update package info.
```
[project_path]> flutter pub get
``` 
**Step 2:** Run the following command to start the demo app.
```
[project_path]> flutter run
```
---

## 3. Configuration

No.

---

## 4. Licensing and Terms

Huawei Push Kit Flutter Plugin - is licensed under [Apache 2.0 license](LICENSE)
