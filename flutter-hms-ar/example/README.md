# Huawei AR Engine Flutter Plugin - Demo

---

## Contents

  - [Introduction](#1-introduction)
  - [Installation](#2-installation)
  - [Configuration](#3-configuration)
  - [Licensing and Terms](#4-licensing-and-terms)

---

## 1. Introduction

This demo project is an example to demonstrate the features of the **Huawei Flutter AR Engine** Plugin.

---

## 2. Installation

### Configure Application ID and Keystore

**Step 1.** Set an unique **Application ID** on the app level build gradle file located on **example/android/app/build.gradle**. You should also change the **package names** for the manifest files in the **/example/android/app/src/** directory and **MainActivity.java** to match with the defined Application ID.
```gradle
<!-- Other configurations ... -->
  defaultConfig {
    // Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html). 
    // You may need to change the package name on the AndroidManifest.xml and MainActivity.java respectively.
    applicationId "<Enter_Your_Package_Here>" // For ex: "com.example.myarproject"
    minSdkVersion 26
    <!-- Other configurations ... -->
}
```

**Step 2.** Open **key.properties** file located on **example/android/key.properties** and enter your keystore values. If you don't have a keystore file, you can follow the third step of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial.
```
storePassword=<keystore_password>
keyPassword=<key_password>
keyAlias=<key_alias>
storeFile=<keystore_file>
```



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

No configuration needed.

---

## 4. Licensing and Terms

Huawei AR Engine Flutter Plugin - Demo is licensed under [Apache 2.0 license](LICENSE)
