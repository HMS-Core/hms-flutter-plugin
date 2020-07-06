 # ![logo](.docs/logo.png)  Huawei Push Kit Flutter Plugin

## Contents
1. Introduction
2. Installation Guide
3. Function Definitions
4. Configuration & Description
5. Licencing & Terms

## 1. Intruduction

This module enables communication between HUAWEI Push Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI Push Kit SDK.

## 2. Installation Guide
To complete this guide , you have to be installed and running flutter on your machine successfully. 

- HUAWEI Flutter Push Library comes with ready demo example.
- Clone the project into your desktop or download the zip file and unzip it.
- Open the project in Android Studio.
- Open terminal in Android Studio and run `flutter pub get`
- Make sure that your device is connected. You can run `flutter doctor` to become sure that everything is okay.
- Start flutter project in Android Studio.

The plugin library is in the `android/src/main` folder in the root directory. 
```
|_HP_HMSCore-Plugin-Flutter_Push-Library
    |_ android
        |_src
    ...
```


## 3. Function Definitions
- Usage of every functions are in the `example/lib/main.dart` file.

|Return Type     |Function                                     |
|:---------------|:--------------------------------------------|
|Future<String>  | Push.getId()                                |
|Future<String>  | Push.getAAID()                              |
|Future<String>  | Push.getAppId()                             |
|Future<String>  | Push.getToken()                             |
|Future<String>  | Push.getCreationTime()                      |
|Future<String>  | Push.deleteToken()                          |
|Future<String>  | Push.subscribe()                            |
|Future<String>  | Push.unsubscribe()                          |
|Future<String>  | Push.setAutoInitEnabled()                   |
|Future<String>  | Push.isAutoInitEnabled()                    |
|Future<String>  | Push.turnOnPush()                           |
|Future<String>  | Push.turnOffPush()                          |
|Future<String>  | Push.getAgConnectValues()                   |

## 3. Confuguration & Description
No.

## 4. Licencing & Terms
Apache 2.0 license.