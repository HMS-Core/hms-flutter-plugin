# Huawei DTM Flutter Plugin - Demo

---

## Contents

  - [Introduction](#1-introduction)
  - [Installation](#2-installation)
  - [Configuration](#3-configuration)
  - [Licensing and Terms](#4-licensing-and-terms)

---

## 1. Introduction

This demo project is an example to demonstrate the features of the **Huawei Flutter DTM Kit** Plugin.

---

## 2. Installation

Before you get started, you must register as a Huawei developer and complete identity verification on the [Huawei Developer](https://developer.huawei.com/consumer/en?ha_source=hms1) website. For details, please refer to [Register a Huawei ID](https://developer.huawei.com/consumer/en/doc/10104?ha_source=hms1).

### Creating a Project in AppGallery Connect

Creating an app in AppGallery Connect is required in order to communicate with Huawei services. To create an app, perform the following steps:

**Step 1.** Set an unique **Application ID** on the app level build gradle file located on **example/android/app/build.gradle**. You should also change the **package names** for the manifest files in the **/example/android/app/src/** directory to match with the Application ID. 
  ```gradle
  <!-- Other configurations ... -->
    defaultConfig {
      // Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html). You may need to change the package name on AndroidManifest.xml and MainActivity.java respectively.
      // The Application ID here should match with the Package Name on the AppGalleryConnect.
        applicationId "<package_name>"
        minSdkVersion 19
      <!-- Other configurations ... -->
  }
  ```

**Step 2.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html?ha_source=hms1)  and select **My projects**.

**Step 3.** Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 4.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 5.** On the **Add app** page, enter the **Application ID** you've defined before as the **Package Name** here, then fill the necessary fields and click **OK**.

### Configuring the Signing Certificate Fingerprint

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core service through the HMS Core SDK. Before using HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect. Ensure that the JDK has been installed on your computer. 

- You can refer to 3rd and 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2?ha_source=hms1) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html?ha_source=hms1) and select your project from **My Projects**. Then go to **Project Setting** > **General information**. In the **App information** field, click the  icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA-256 certificate fingerprint**.

**Step 2.**  After completing the configuration, click **OK** to save the changes. (Check mark icon)

**Step 3.** Copy the signature file that you have generated to **android/app** directory.

**Step 4.** Enter the properties of the signature file to **android/app/build.gradle** file.

  ```gradle
      android {
          /*
           * <Other configurations>
           */

          signingConfigs {
              config {
                  storeFile file('<keystore_file>')
                  storePassword '<keystore_password>'
                  keyAlias '<key_alias>'
                  keyPassword '<key_password>'
              }
          }
      }
  ```

### Enabling the Huawei Analytics Service

To use Huawei DTM, you need to enable **Huawei Analytics** in the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html?ha_source=hms1) and select your project from **My Projects**. Then go to **Huawei Analytics** and click **Enable Analytics service**. You can also check **Manage APIs** tab on the **Project Settings** page for the enabled HMS services on your app.

**Step 2.** Go to **Project Setting > General information** page, under the **App information** field, click **agconnect-services.json** to download the configuration file.

**Step 3.** Copy the **agconnect-services.json** file to the **example/android/app/** directory of the project. 

### Build & Run the project

**Step 1.** Run the following command to update package info.
```
[project_path]> flutter pub get
```
**Step 2.** Follow the [configuration](#3-configuration) steps. 

**Step 3.** Run the following command to start the demo app.
```
[project_path]> flutter run
```

---

## 3. Configuration

### Operations on the Server

#### Overview

To access the DTM portal, perform the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html?ha_source=hms1) and click **My Projects**.

**Step 2.** Find your app project, and click the desired app name.

**Step 3.** Go to **Grow > Dynamic Tag Manager**.

If you completed all the configurations, you must create **Variables**, **Conditions** and **Tags** as follows for the demo app to function properly. 

#### Create Variable

A variable is a placeholder used in a condition or tag. For example, the App Name variable indicates the name of an Android app. DTM provides preset variables which can be used to configure most tags and conditions. You can also create your own custom variables. Currently, DTM provides 18 types of preset variables and 6 types of custom variables. Preset variable values can be obtained from the app without specifying any information. For a custom variable, you need to specify the mode to obtain its value.

Go to **Variable** section in **Dynamic Tag Manager** page.

**Step 1.** Create a custom variable.

   - **Name** : PantsPrice

   - **Type** : Function call

   - **Class path** : com.huawei.hms.flutter.dtm.interfaces.CustomVariable

   - **Key:** varName , **Value:**  PantsPrice

     ![PantsPriceVariable](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/PantsPriceVariable.png)



**Step 2.** Create a variable.

   - **Name** : PlatformName

   - **Type** : Event parameter

   - **Event parameter key** : platformName

     ![PlatformNameVariable](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/PlatformNameVariable.png)



**Step 3.** Create a parameter (Event Name).

   - Press **Configure** button in **Variable** page. Then click **Event Name** and press **OK**.  

     ![EventNameVariable](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/EventNameVariable.png)

#### Create Condition

A condition is the prerequisite for triggering a tag and determines when the tag is executed. A tag must contain at least one trigger condition.

Go to **Condition** section in **Dynamic Tag Manager** page.

**Step 1.** Create a condition for PurchasePants tag.

   - **Name** : PurchasePants

   - **Type** : Custom

   - **Trigger** : Some events

        - **Variable** : Event Name
        - **Operator** : Equals
        - **Value** : PurchasePants

     ![PurchasePantsCondition](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/PurchasePantsCondition.png)

**Step 2.** Create a condition for SetPantsPrice tag.

   - **Name** : SetPantsPrice

   - **Type** : Custom

   - **Trigger** : Some events

        - **Variable** : Event Name
        - **Operator** : Equals
        - **Value** : SetPantsPrice

     ![SetPantsPriceCondition](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/SetPantsPriceCondition.png)

**Step 3.** Create a condition for PurchaseShoes tag.

   - **Name** : PurchaseShoes

   - **Type** : Custom

   - **Trigger** : Some events

        - **Variable** : Event Name
        - **Operator** : Equals
        - **Value** : PurchaseShoes

     ![PurchaseShoesCondition](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/PurchaseShoesCondition.png)

#### Create Tag

A tag is used in your app to track events. DTM supports the Huawei Analytics and custom function templates, as well as many third-party tag extension templates. With DTM, you do not need to add additional third-party tracking tags in your app. You can set parameters and trigger conditions for a tag in DTM, and release the configuration version to track events. You can also update and release tags for your app in DTM after you have released it, so you can adjust tag configurations in real time.

Go to **Tag** section in **Dynamic Tag Manager** page.

**Step 1.** Create a  Custom Tag for CustomTag button.

   - **Name** : PurchaseShoes

   - **Extension** : Custom Function

   - **Class path** : com.huawei.hms.flutter.dtm.interfaces.CustomTag

   - **Add**

     - **Key:** itemName , **Value:** Shoes
     - **Key:** quantity , **Value:**  40

        ![PurchaseShoesTag](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/PurchaseShoesTag.png)

- **Condition** : PurchaseShoes

**Step 2.** Create a Custom Tag to setCustomVariable.

   - **Name** : SetPantsPrice

   - **Extension** : Custom Function

   - **Class path** : com.huawei.hms.flutter.dtm.interfaces.CustomTag

   - **Add**

     - **Key:** discount , **Value:** 10
     - **Key:** price , **Value:**  70

     ![SetPantsPriceTag](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/SetPantsPriceTag.png)

- **Condition** : SetPantsPrice

**Step 3.** Create a Tag that uses the PantsPrice customVariable value.

   - **Name** : PurchasePants

   - **Extension** : Huawei Analytics

   - **Add**

     - **Key:** price , **Value:**  {{PantsPrice}}

     ![PurchasePantsTag](https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/example/.docs/PurchasePantsTag.png)

- **Condition** : PurchasePants

#### Create Version

Go to **Version** section in **Dynamic Tag Manager** page. Press **Create** button in **Version** page. Enter a version name and click **OK**. Press the version which is created. 

#### Note

> You do not need to manually download **DTM-\*\*\*\*.json** file and import it to your Andorid Studio project.

---

## 4. Licensing and Terms

Huawei DTM Flutter Plugin - Demo is licensed under [Apache 2.0 license](../LICENSE)
