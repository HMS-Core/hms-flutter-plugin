# Huawei ML Kit Flutter Plugin

# Contents

  * [1. Introduction](#1-introduction)
  * [2. Installation Guide](#2-installation-guide)
    * [Creating a Project in AppGallery Connect](#creating-a-project-in-appgallery-connect)
    * [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    * [Integrating Flutter ML Plugin](#integrating-flutter-ml-plugin)
  * [3. API Reference](#3-api-reference)
    * [MLAftEngine](#mlaftengine)
    * [MLAsrRecognizer](#mlasrrecognizer)
    * [MLBankcardAnalyzer](#mlbankcardanalyzer)
    * [MLClassificationAnalyzer](#mlclassificationanalyzer)
    * [MLCustomModel](#mlcustommodel)
    * [MLDocumentAnalyzer](#mldocumentanalyzer)
    * [MLDocumentSkewCorrectionAnalyzer](#mldocumentskewcorrectionanalyzer)
    * [MLFaceAnalyzer](#mlfaceanalyzer)
    * [ML3DFaceAnalyzer](#ml3dfaceanalyzer)
    * [MLFormRecognitionAnalyzer](#mlformrecognitionanalyzer)
    * [MLGeneralCardAnalyzer](#mlgeneralcardanalyzer)
    * [MLHandKeypointAnalyzer](#mlhandkeypointanalyzer)
    * [MLImageSuperResolutionAnalyzer](#mlimagesuperresolutionanalyzer)
    * [MLImageSegmentationAnalyzer](#mlimagesegmentationanalyzer)
    * [MLLandmarkAnalyzer](#mllandmarkanalyzer)
    * [MLLangDetector](#mllangdetector)
    * [LensEngine](#lensengine)
    * [MLLivenessCapture](#mllivenesscapture)
    * [MLApplication](#mlapplication)
    * [MLFrame](#mlframe)
    * [MLObjectAnalyzer](#mlobjectanalyzer)
    * [MLProductVisionSearchAnalyzer](#mlproductvisionsearchanalyzer)
    * [MLSpeechRealTimeTranscription](#mlspeechrealtimetranscription)
    * [MLSceneDetectionAnalyzer](#mlscenedetectionanalyzer)
    * [MLSkeletonAnalyzer](#mlskeletonanalyzer)
    * [MLSoundDetector](#mlsounddetector)
    * [MLTextAnalyzer](#mltextanalyzer)
    * [MLTextEmbeddingAnalyzer](#mltextembeddinganalyzer)
    * [MLTextImageSuperResolutionAnalyzer](#mltextimagesuperresolutionanalyzer)
    * [MLLocalTranslator](#mllocaltranslator)
    * [MLRemoteTranslator](#mlremotetranslator)
    * [MLTtsEngine](#mlttsengine)
  * [4. Configuration Description](#4-configuration-description)
  * [5. Preparing for Release](#5-preparing-for-release)
  * [6. Sample Project](#6-sample-project)
  * [7. Questions or Issues](#7-questions-or-issues)
  * [8. Licensing and Terms](#8-licensing-and-terms)

# 1. Introduction

This plugin enables communication between HUAWEI ML Kit Plugin provides following services:
- **Text Related Services**: These services allow you to recognize the text in images, documents, cards and forms.
- **Language/Voice Related Services**: These services provide text to speech, speech to text, translation and language detection capabilities.
- **Face/Body Related Services**: These services provide capabilities like face, skeleton and hand detections
- **Image Related Services**: These services provide capabilities like object classification, landmark recognition and image resolution.

# 2. Installation Guide

Before you get started, you must register as a HUAWEI Developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

### Creating a Project in AppGallery Connect

Creating an app in AppGallery Connect is required in order to communicate with the Huawei services. To create an app, perform the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My Projects**.

**Step 2**. Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 3.** Go to **Project Setting** > **General Information** and click **Add App**.

If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add App**.

**Step 4**. On the **Add App** page, enter the app information and click **Ok**.

### Configuring the Signing Certificate Fingerprint

A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in the **AppGallery Connect**. You can refer to 3rd or 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

### Integrating Flutter ML Plugin

**Step 1**. Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Manage APIs** tab on the **Project Settings** page and make sure **ML Kit** is enabled.

**Step 2**. Go to **Project Setting** > **General Information** page, under the **App information** field, click **agconnect-services.json** to download the configuration file.

**Step 3**. Copy the **agconnect-services.json** file to the **android/app** directory of your project.

**Step 4**. Open the **build.gradle** file in the **android** directory of your project.

- Navigate to the **buildscript** section and configure the Maven repository address and agconnect plugin for the HMS SDK.

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
          classpath 'com.huawei.agconnect:agcp:1.4.2.301'
      }
    }
  ```

- Go to **allprojects** and configure the Maven repository address for the HMS SDK.

  ```gradle
    allprojects {
      repositories {
          google()
          jcenter()
          maven { url 'https://developer.huawei.com/repo/' }
      }
    }
  ```

**Step 5**. Open the **build.gradle** file in the **android/app/** directory.

- Add `apply plugin: 'com.huawei.agconnect'` line after other `apply` entries.

  ```gradle
    apply plugin: 'com.android.application'
    apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
    apply plugin: 'com.huawei.agconnect'
  ```

- Set your  package name in **defaultConfig > applicationId** and set **minSdkVersion** to **19** or higher. Package name must match with the **package_name** entry in **agconnect-services.json** file.
- Set **multiDexEnabled** to true so the app won't crash. Because ML Plugin has many API's.

  ```
    defaultConfig {
        applicationId "<package_name>"
        minSdkVersion 19
        multiDexEnabled true
        /*
        * <Other configurations>
        */
    }
  ```

**Step 6**. Create a file **<app_dir>/android/key.properties** that contains a reference to your keystore which you generated on the previous step ([Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2)). Add the following lines to the **key.properties** file and change the values regarding to the keystore you've generated.

```
storePassword=<your_keystore_password>
keyPassword=<your_key_password>
keyAlias=key
storeFile=<location of the keystore file, for example: D:\\Users\\<user_name>\\key.jks>
```

> Warning: Keep this file private and don't include it on the public source control.

**Step 7**. Add the following code to **build.gradle** before android block for reading the **key.properties** file:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
        ...
}
```

**Step 8**. Edit **buildTypes** as follows and add **signingConfigs** below:

```gradle
signingConfigs {
    config {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
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
```

**Step 9**. On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_ml** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

- To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

  ```yaml
        dependencies:
          huawei_ml: {library version}
  ```

  **or**

  If you downloaded the package from HUAWEI Developer website, specify the **library path** on your local device.

  ```yaml
        dependencies:
          huawei_ml:
              # Replace {library path} with actual library path of Huawei ML Kit Plugin for Flutter.
              path: {library path}
  ```

  - Replace {library path} with the actual library path of Flutter ML Plugin. The following are examples:
    - Relative path example: `path: ../huawei_ml`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_ml`

**Step 10**. Run the following command to update package info.

```dart
    [project_path]> flutter pub get
```

**Step 11** Import the library to access services and methods.

```dart
    import 'package:huawei_ml/huawei_ml.dart';
```

**Step 12**. Run the following command to start the app.

```dart
    [project_path]> flutter run
```

# 3. API Reference

# MLAftEngine

Converts an audio file into a text file.

## Method Summary

| Return Type  | Method   | Description  |
| ------------ | ---------| -----------  |
| void  | [startRecognition(MLAftSetting setting)](#startrecognitionmlaftsetting-setting) | Stars the audio file transcription.   |
| void  | [setAftListener(MLAftListener listener)](#setaftlistenermlaftlistener-listener) | Sets the listener for transcription.    |
| Future\<void\> | [startTask(String taskId)](#starttaskstring-taskid)  | Resumes a long audio transcription task on the cloud. |
| Future\<void\> | [pauseTask(String taskId)](#pausetaskstring-taskid)  | Pauses a long audio transcription task on the cloud.  |
| Future\<void\> | [destroyTask(String taskId)](#destroytaskstring-taskid)   | Destroys the on cloud transcription.      |
| Future\<void\> | [getLongAftResult(String taskId)](#getlongaftresultstring-taskid)   | Updates the transcription information. |
| Future\<bool\> | [closeAftEngine()](#closeaftengine)       | Closes the aft engine. |

## Methods

### startRecognition(MLAftSetting setting)

Starts audio file transcription.

**Parameters**

| Name    | Type | Description      |
| ------- | ---- | ------------------ |
| setting | MLAftSetting | Configurations for recognition. |

**Return Type**

| Type | Description  |
| ---- | ------------ |
| void | No return value. |

**Call Example**

```dart
MLAftSetting setting = new MLAftSetting();
setting.path = "audio file path";

aftEngine.startRecognition(setting: setting);
```

### setAftListener(MLAftListener listener)

Sets the listener for transcription.

**Parameters**

| Name     | Type   | Description  |
| -------- | ------ | ------------ |
| listener | [MLAftListener](#mlaftlistener) | Listener for MLAftEngine. |

**Call Example**

```dart
MLAftEngine aftEngine = new MLAftEngine();

aftEngine.setAftListener((event, taskId, {errorCode, eventId, result, uploadProgress}) {
  // Your implementation here
});
```

### startTask(String taskId)

Resumes a long audio transcription task on the cloud.

**Parameters**

| Name   | Type   | Description   |
| ------ | ------ | ------------- |
| taskId | String | ID of the audio transcription task. |

**Return Type**

| Type           | Description  |
| -------------- | ----------------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await aftEngine.startTask(taskId: "task id");
```

### pauseTask(String taskId)

Pauses a long audio transcription task on the cloud.

**Parameters**

| Name   | Type   | Description    |
| ------ | ------ | ------------------ |
| taskId | String | ID of the audio transcription task. |

**Return Type**

| Type           | Description   |
| -------------- | ------------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await aftEngine.pauseTask(taskId: "task id");
```

### destroyTask(String taskId)

Destroys a long audio transcription task on the cloud. If the task is destroyed after the audio file is successfully uploaded, the transcription has started and charging cannot be canceled.

**Parameters**

| Name   | Type   | Description    |
| ------ | ------ | ------------- |
| taskId | String | ID of the audio transcription task. |

**Return Type**

| Type           | Description  |
| -------------- | ------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await aftEngine.destroyTask(taskId: "task id");
```

### getLongAftResult(String taskId)

Obtains the long audio transcription result from the cloud.

**Parameters**

| Name   | Type   | Description   |
| ------ | ------ | ------------- |
| taskId | String | ID of the audio transcription task. |

**Return Type**

| Type           | Description  |
| -------------- | ------------ |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await aftEngine.getLongAftResult(taskId: "task id");
```

### closeAftEngine()

Disables the audio transcription engine to release engine resources.

**Return Type**

| Type           | Description   |
| -------------- | ------------ |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
await aftEngine.closeAftEngine();
```

## Data Types

### MLAftListener

A function type defined for listening audio file transcription events.

| Definition   | Description   |
| ------------ | ------------- |
| void MLAftListener(MLAftEvent event, String taskId, {int eventId, MLAftResult result, int errorCode, double uploadProgress}) | Audio file transcription listener. |

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| event | [MLAftEvent](#mlaftevent) | Aft event listener. |
| taskId | String | Transcription task id. |
| eventId | int | Transcription event id. |
| result | MLAftResult | Transcription result. |
| errorCode | int | Error code on failure. |
| uploadProgress | double | Audio file upload progress. |

### enum MLAftEvent

Enumerated object that represents the events of audio file transcription.

| Value  | Description  |
| ------ | ------------ |
| onResult | Called when the audio transcription result is returned on the cloud. |
| onError | Called if an audio transcription error occurs.                       |
| onInitComplete | Reserved.   |
| onUploadProgress | Reserved.  |
| onEvent | Reserved. |

# MLAsrRecognizer

Automatically recognizes speech.

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<String\> | [startRecognizing(MLAsrSetting setting)](#startrecognizingmlasrsetting-setting) | Starts recognition without pickup ui.    |
| Future\<String\> | [startRecognizingWithUi(MLAsrSetting setting)](#startrecognizingwithuimlasrsetting-setting) | Starts recognition with pickup ui.   |
| Future\<bool\>   | [stopRecognition()](#stoprecognition)   | Stops the recognition.  |
| void  | [setListener(MLAsrListener listener)](#setlistenermlasrlistener-listener)  | Sets the listener callback function of the recognizer to receive the recognition result. |

## Methods

### startRecognizing(MLAsrSetting setting)

Starts recognition without pickup ui.

**Parameters**

| Name | Type | Description |
| ------- | ------------ | ----------- |
| setting | MLAsrSetting | Configurations for recognition. |

**Return Type**

| Type | Description   |
| ---- | ------------- |
| Future\<String\> | Returns the recognition result on a successful operation. |

**Call Example**

```dart
final setting = new MLAsrSetting();
setting.language = MLAsrSetting.LAN_EN_US;
setting.feature = MLAsrSetting.FEATURE_WORD_FLUX;

String result = await recognizer.startRecognizing(settings);
```

### startRecognizingWithUi(MLAsrSetting setting)

Starts recognition with pickup ui.

**Parameters**

| Name    | Type | Description   |
| ------- | ------------ | ------------- |
| setting | MLAsrSetting | Configurations for recognition. |

**Return Type**

| Type  | Description  |
| ----- | ------------ |
| Future\<String\> | Returns the recognition result on a successful operation. |

**Call Example**

```dart
final setting = new MLAsrSetting();
setting.language = MLAsrSetting.LAN_EN_US;
setting.feature = MLAsrSetting.FEATURE_WORD_FLUX;

String result = await recognizer.startRecognizingWithUi(settings);
```

### stopRecognition()

Stops the speech recognition.

**Return Type**

| Type | Description  |
| ---- | --------------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

```dart
await recognizer.stopRecognition();
```

### setListener(MLAsrListener listener)

Sets the listener callback function of the recognizer to receive the recognition result.

**Parameters**

| Name | Type | Description  |
| ---- | ---- | ------------ |
| listener | [MLAsrListener](#mlasrlistener) | Listener for speech recognition. |

**Call Example**

```dart
recognizer.setListener((event, info) {
  // Your implementation here
});
```

## Data Types

### MLAsrListener

A function type defined for listening speech recognition events.

| Definition | Description |
| ---------- | ----------- |
| void MLAsrListener(MLAsrEvent event, dynamic info) | Listener for speech recognition. |

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| event | [MLAsrEvent](#mlasrevent) | Asr event listener. |
| info | dynamic | All event information. |

### enum MLAsrEvent

Enumerated object that represents the events of speech recognition.

| Value    | Description |
| -------- | ----------- |
| onState  | Called when the audio transcription result is returned on the cloud. |
| onStartListening   | Called when the recorder starts to receive speech. |
| onStartingOfSpeech  | Called when a user starts to speak, that is, the speech recognizer detects that the user starts to speak. |
| onVoiceDataReceived | Returns the original PCM stream and audio power to the user. |
| onRecognizingResults | When the speech recognition mode is set to MLAsrConstants.FEATURE_WORDFLUX, the speech recognizer continuously returns the speech recognition result through this API. |

# MLBankcardAnalyzer

Contains bank card recognition plug-in APIs.

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<MLBankcard\> | [analyzeBankcard(MlBankcardSettings settings)](#analyzebankcardmlbankcardsettings-settings) | Recognizes bankcard from a local image.    |
| Future\<MLBankcard\> | [captureBankcard(MlBankcardSettings settings)](#capturebankcardmlbankcardsettings-settings) | Recognizes bankcard with capture activity. |
| Future\<bool\>  | [stopBankcardAnalyzer()](#stopbankcardanalyzer) | Stops bankcard recognition. |

## Methods

### analyzeBankcard(MlBankcardSettings settings)

Recognizes bankcard from a local image.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| settings | MLBankcardSettings | Configurations for recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLBankcard\> | Returns the object on a successful operation, throws PlatformException otherwise. |

**Call Example**

```dart
MLBankcardAnalyzer analyzer = new MLBankcardAnalyzer();
MLBankcardSettings settings = new MLBankcardSettings();
settings.path = "local image path";

MLBankcard card = await analyzer.analyzeBankcard(settings);
```

### captureBankcard(MlBankcardSettings settings)

Recognizes bankcard with a capture activity.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| settings | MLBankcardSettings | Configurations for recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLBankcard\> | Returns the object on a successful operation. |

**Call Example**

```dart
MLBankcardAnalyzer analyzer = new MLBankcardAnalyzer();
MLBankcardSettings settings = new MLBankcardSettings();
settings.orientation = MLBankcardSettings.ORIENTATION_AUTO;

MLBankcard card = await analyzer.captureBankcard(settings: settings);
```

### stopBankcardAnalyzer()

Stops the bankcard recognition.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
await analyzer.stopBankcardAnalyzer();
```

# MLClassificationAnalyzer

This package represents the image classification SDK. It contains image classification classes and APIs.

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<List\<MLImageClassification\>\> | [asyncAnalyzeFrame(MLClassificationAnalyzerSetting setting)](#asyncanalyzeframemlclassificationanalyzersetting-setting) | Analyzes asynchronously. |
| Future\<List\<MLImageClassification\>\> | [analyzeFrame(MLClassificationAnalyzerSetting setting)](#analyzeframemlclassificationanalyzersetting-setting) | Analyzes synchronously.  |
| Future\<int\>  | [getAnalyzerType()](#getanalyzertype) | Gets the analyzer type.  |
| Future\<bool\> | [stopClassification()](#stopclassification) | Stops the classification.|

## Methods

### asyncAnalyzeFrame(MLClassificationAnalyzerSetting setting)

Does classification asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLClassificationAnalyzerSetting | Configurations for classification. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLImageClassification\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLClassificationAnalyzer analyzer = new MLClassificationAnalyzer();
MLClassificationAnalyzerSetting setting = new MLClassificationAnalyzerSetting();
setting.path = "local image path";

List<MLImageClassification> list = await analyzer.asyncAnalyzeFrame(setting);
```

### analyzeFrame(MLClassificationAnalyzerSetting setting)

Does classification synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLClassificationAnalyzerSetting | Configurations for classification. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLImageClassification\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLClassificationAnalyzer analyzer = new MLClassificationAnalyzer();
MLClassificationAnalyzerSetting setting = new MLClassificationAnalyzerSetting();
setting.path = "local image path";

List<MLImageClassification> list = await analyzer.analyzeFrame(setting);
```

### getAnalyzerType()

Gets the analyzer type

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<int\> | Returns the type on success, throws PlatformException otherwise. |

**Call Example**

```dart
int result = await analyzer.getAnalyzerType();
```

### stopClassification()

Stops the classification.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopClassification();
```

# MLCustomModel

Allows to execute a custom AI model.

## Method Summary

| Return Type | Method  | Description  |
| ----------- | ------- | ------------ |
| Future\<bool\> | [prepareCustomModel(MLCustomModelSetting setting)](#preparecustommodelmlcustommodelsetting-setting) | Prepares the custom model executor.                                   |
| Future\<Map\<dynamic, dynamic\>\> | [executeCustomModel()](#executecustommodel)   | Performs inference using input and output configurations and content. |
| Future\<int\>  | [getOutputIndex(String name)](#getoutputindexstring-name)   | Obtains the channel index based on the output channel name.           |
| Future\<bool\> | [stopExecutor()](#stopexecutor)   | Stops an inference task to release resources.                         |

## Methods

### prepareCustomModel(MLCustomModelSetting setting)

Prepares the custom model executor.

**Parameters**

| Name | Type | Description |
| ------- | ---- | ----------- |
| setting | [MLCustomModelSetting](#mlcustommodelsetting) | Configurations for custom model execution. |

**Return Type**

| Type  | Description   |
| -------------- | ------------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLCustomModel customModel = new MLCustomModel();
MLCustomModelSetting setting = new MLCustomModelSetting();

setting.path = "local image path";
setting.modelName = "custom model name";
setting.labelFileName = "label file name";
setting.assetPathFile = "path of the custom model"

bool result = await customModel.prepareCustomModel(setting: setting);
```

### executeCustomModel()

Performs inference using input and output configurations and content.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<Map\<dynamic, dynamic\>\> | Returns the execution result on success, throws PlatformException otherwise. |

**Call Example**

```dart
Map<dynamic, dynamic> result = await customModel.executeCustomModel();
```

### getOutputIndex(String name)

Obtains the channel index based on the output channel name.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| name | String | Output channel name. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<int\> | Returns the output index on success, throws PlatformException otherwise. |

**Call Example**

```dart
int result = await customModel.getOutputIndex("channel name");
```

### stopExecutor()

Stops an inference task to release resources.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await customModel.stopExecutor();
```

## Data Types

### MLCustomModelSetting

#### Constants

| Constant | Type | Description |
| -------- | ---- | ----------- |
| FLOAT32 | int  | Model data type. |
| INT32 | int  | Model data type. |
| REGION_DR_CHINA  | int  | China.  |
| REGION_DR_AFILA  | int  | Africa, America  |
| REGION_DR_EUROPE | int  | Europe.  |
| REGION_DR_RUSSIA | int  | Russia.  |

#### Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath  | String | Local image path. **null** by default. |
| modelName  | String | Custom model name. **null** by default. |
| modelDataType | int    | Model data type. **1** by default. |
| assetPathFile  | String | Custom model path. **null** by default.   |
| localFullPathFile | String | Custom model path. **null** by default.  |
| isFromAsset  | bool   | Creates the executor depending on the custom model file path. **true** by default. |
| labelFileName  | String | Label file name. **null** by default. |
| bitmapSize  | int    | Sets the bitmap size while execution. **224** by default. |
| channelSize  | int    | Sets the channel size while execution. **3** by default. |
| outputLength  | int    | Number of categories supported by your model. **1001** by default. |
| region  | int    | Region. **1002** by default.   |
| needWifi   | bool   | Sets true if wifi is needed while downloading the model. **true** by default.  |
| needCharging  | bool   | Sets true if charging is needed while downloading the model. **false** by default. |
| needDeviceIdle  | bool   | Sets true if device idle is needed while downloading the model. **false** by default. |

# MLDocumentAnalyzer

Provides a document recognition component that recognizes text from images of documents.

## Method Summary

| Return Type  | Method  | Description |
| ------------ | ------- | ----------- |
| Future\<MLDocument\> | [asyncAnalyzeFrame(MLDocumentAnalyzerSetting setting)](#asyncanalyzeframemldocumentanalyzersetting-setting) | Analyzes the image asynchronously.  |
| Future\<bool\>  | [closeDocumentAnalyzer()](#closedocumentanalyzer)   | Closes the document analyzer.  |
| Future\<bool\>  | [stopDocumentAnalyzer()](#stopdocumentanalyzer)   | Stops the document analyzer.  |

## Methods

### asyncAnalyzeFrame(MLDocumentAnalyzerSetting setting)

Analyzes the image asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLDocumentAnalyzerSetting | Configurations for document recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLDocument\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLDocumentAnalyzerSetting setting = new MLDocumentAnalyzerSetting();
MLDocumentAnalyzer analyzer = new MLDocumentAnalyzer();

setting.path = "local image path";

MLDocument document = await analyzer.asyncAnalyzeFrame(setting);
```

### closeDocumentAnalyzer()

Closes the document analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.closeDocumentAnalyzer();
```

### stopDocumentAnalyzer()

Stops the document analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopDocumentAnalyzer();
```

# MLDocumentSkewCorrectionAnalyzer

Allows to detect and correct skew in images.

## Method Summary

| Return Type | Method | Description   |
| ----------- | ------ | ------------- |
| Future\<MLDocumentSkewDetectResult\> | [asyncDocumentSkewDetect(String imagePath)](#asyncdocumentskewdetectstring-imagepath) | Detects document skew asynchronously. |
| Future\<MLDocumentSkewCorrectionResult\> | [asyncDocumentSkewResult()](#asyncdocumentskewresult) | Gets the corrected document result asynchronously. |
| Future\<MLDocumentSkewDetectResult\> | [syncDocumentSkewDetect(String imagePath)](#syncdocumentskewdetectstring-imagepath) | Detects document skew synchronously. |
| Future\<MLDocumentSkewCorrectionResult\> | [syncDocumentSkewResult()](#syncdocumentskewresult) | Gets the corrected document result synchronously. |
| Future\<bool\> | [stopDocumentSkewCorrection()](#stopdocumentskewcorrection) | Stops the document skew detection & correction. |

## Methods

### asyncDocumentSkewDetect(String imagePath)

Detects document skew asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath | String | Local image path. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLDocumentSkewDetectResult\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLDocumentSkewCorrectionAnalyzer analyzer = new MLDocumentSkewCorrectionAnalyzer();

MLDocumentSkewDetectResult detectionResult = await analyzer.asyncDocumentSkewDetect("local image path");
```

### asyncDocumentSkewResult()

Gets the corrected document result asynchronously.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLDocumentSkewCorrectionResult\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLDocumentSkewCorrectionResult corrected = await analyzer.asyncDocumentSkewResult();
```

### syncDocumentSkewDetect(String imagePath)

Detects document skew synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath | String | Local image path. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLDocumentSkewDetectResult\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLDocumentSkewCorrectionAnalyzer analyzer = new MLDocumentSkewCorrectionAnalyzer();

MLDocumentSkewDetectResult detectionResult = await analyzer.syncDocumentSkewDetect("local image path");
```

### syncDocumentSkewResult()

Gets the corrected document result synchronously.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLDocumentSkewCorrectionResult\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLDocumentSkewCorrectionResult corrected = await analyzer.syncDocumentSkewResult();
```

### stopDocumentSkewCorrection()

Stops the document skew detection & correction.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws Exception otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopDocumentSkewCorrection();
```

# MLFaceAnalyzer

Serves as the face detection SDK. It contains face detection classes and APIs.

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<List\<MLFace\>\> | [asyncAnalyzeFrame(MLFaceAnalyzerSetting setting)](#asyncanalyzeframemlfaceanalyzersetting-setting) | Recognizes the face asynchronously. |
| Future\<List\<MLFace\>\> | [analyzeFrame(MLFaceAnalyzerSetting setting)](#analyzeframemlfaceanalyzersetting-setting) | Recognizes the face synchronously. |
| Future\<bool\> | [isAvailable()](#isavailable) | Checks whether the face analyzer is available. |
| Future\<bool\> | [stop()](#stop) | Stops the face analyzer. |

## Methods

### asyncAnalyzeFrame(MLFaceAnalyzerSetting setting)

Recognizes the face asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLFaceAnalyzerSetting](#mlfaceanalyzersetting) | Configurations for face recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLFace\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLFaceAnalyzer analyzer = new MLFaceAnalyzer();
MLFaceAnalyzerSetting setting = new MLFaceAnalyzerSetting();

setting.path = "local image path";

List<MLFace> faces = await analyzer.asyncAnalyzeFrame(setting);
```

### analyzeFrame(MLFaceAnalyzerSetting setting)

Recognizes the face synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLFaceAnalyzerSetting](#mlfaceanalyzersetting) | Configurations for face recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLFace\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLFaceAnalyzer analyzer = new MLFaceAnalyzer();
MLFaceAnalyzerSetting setting = new MLFaceAnalyzerSetting();

setting.path = "local image path";

List<MLFace> faces = await analyzer.analyzeFrame(setting);
```

### isAvailable()

Checks whether the face analyzer is available.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws Exception otherwise. |

**Call Example**

```dart
bool result = await analyzer.isAvailable();
```

### stop()

Stops the face analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stop();
```

## Data Types

### MLFaceAnalyzerSetting

Configurations for the face analyzer.

#### Constants

| Constant  | Type | Description |
| --------- | ---- | ----------- |
| TYPE_FEATURES    | int | Detects all facial features and expressions. |
| TYPE_FEATURE_AGE   | int | Detects the age. |
| TYPE_FEATURE_BEARD   | int | Detects whether a person has a beard. |
| TYPE_FEATURE_EMOTION   | int | Detects facial expressions. |
| TYPE_FEATURE_EYEGLASS  | int | Detects whether a person wears glasses. |
| TYPE_FEATURE_GENDER   | int | Detects the gender. |
| TYPE_FEATURE_HAT   | int | Detects whether a person wears a hat. |
| TYPE_FEATURE_OPEN_CLOSE_EYE | int | Detects eye opening and eye closing. |
| TYPE_UNSUPPORTED_FEATURES   | int | Detects only basic data: including contours, key points,  and three-dimensional rotation angles; does not detect facial features or expressions. |
| TYPE_KEY_POINTS   | int | Detects key face points. |
| TYPE_UNSUPPORTED_KEY_POINTS | int | Does not detect key face points. |
| TYPE_PRECISION  | int | Precision preference mode. This mode will detect more faces and be more precise in detecting key points and contours, but will run slower. |
| TYPE_SPEED   | int | Speed preference mode. This mode will detect fewer faces and be less precise in detecting key points and contours, but will run faster. |
| TYPE_SHAPES  | int | Detects facial contours. |
| TYPE_UNSUPPORTED_SHAPES  | int | Does not detect facial contours. |
| MODE_TRACING_ROBUST  | int | Common tracking mode. In this mode, initial detection is fast, but the performance of detection during tracking will be affected by face re-detection every several frames. The detection result in this mode is stable. |
| MODE_TRACING_FAST  | int | Fast tracking mode. In this mode, detection and tracking are performed at the same time. Initial detection has a delay, but the detection during tracking is fast. When used together with the speed preference mode, this mode can make the greatest improvements to the detection performance. |

#### Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| path    | String | Local image path. **null** by default. |
| frameType  | String | Recognition frame type. **MLFrameType.fromBitmap** by default. You are adviced to use it this way. |
| property  | String | Recognition property type. |
| featureType   | String | Sets the mode for an analyzer to detect facial features and expressions. **1** by default. |
| keyPointType   | String | Sets the mode for an analyzer to detect key face points. **1** by default. |
| maxSizeFaceOnly   | String | Sets whether to detect only the largest face in an image. **true** by default. |
| minFaceProportion | String | Sets the smallest proportion (range: 0.0-1.0) of a face in an image. **0.5** by default. |
| performanceType   | String | Sets the preference mode of an analyzer. **1** by default. |
| poseDisabled  | String | Sets whether to disable pose detection. **false** by default. |
| shapeType  | String | Sets the mode for an analyzer to detect facial contours. **2** by default. |
| tracingAllowed  | String | Sets whether to enable face tracking. **false** by default. |
| tracingMode  | String | Sets the tracing mode. **2** by default. |

# ML3DFaceAnalyzer

Serves as the 3D face detection SDK. It contains face detection classes and APIs.

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<List\<ML3DFace\>\> | [asyncAnalyzeFrame(ML3DFaceAnalyzerSetting setting)](#asyncanalyzeframeml3dfaceanalyzersetting-setting) | Recognizes the face asynchronously. |
| Future\<List\<ML3DFace\>\> | [analyzeFrame(ML3DFaceAnalyzerSetting setting)](#analyzeframeml3dfaceanalyzersetting-setting) | Recognizes the face synchronously. |
| Future\<bool\> | [isAvailable()](#is-available) | Checks whether the face analyzer is available. |
| Future\<bool\> | [stop()](#stop-3d) | Stops the 3D face analyzer. |

## Methods

### asyncAnalyzeFrame(ML3DFaceAnalyzerSetting setting)

Recognizes the face asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | ML3DFaceAnalyzerSetting | Configurations for recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<ML3DFace\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
ML3DFaceAnalyzer analyzer = new ML3DFaceAnalyzer();
ML3DFaceAnalyzerSetting setting = new ML3DFaceAnalyzerSetting();

setting.path = "local image path";

List<ML3DFace> faces = await analyzer.asyncAnalyzeFrame(setting);
```

### analyzeFrame(ML3DFaceAnalyzerSetting setting)

Recognizes the face synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | ML3DFaceAnalyzerSetting | Configurations for recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<ML3DFace\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
ML3DFaceAnalyzer analyzer = new ML3DFaceAnalyzer();
ML3DFaceAnalyzerSetting setting = new ML3DFaceAnalyzerSetting();

setting.path = "local image path";

List<ML3DFace> faces = await analyzer.analyzeFrame(setting);
```

### <a name="is-available"></a> isAvailable()

Checks whether the face analyzer is available.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.isAvailable();
```

### <a name="stop-3d"></a> stop()

Stops the 3D face analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stop();
```

# MLFormRecognitionAnalyzer

Allows to recognize text in forms.

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<MLTable\> | [asyncFormDetection(String imagePath)](#asyncformdetectionstring-imagepath) | Recognizes the form content asynchronously. |
| Future\<MLTable\> | [syncFormDetection(String imagePath)](#syncformdetectionstring-imagepath) | Recognizes the form content synchronously. |
| Future\<bool\>    | [stopFormRecognition()](#stopformrecognition) | Stops the form recognition. |

## Methods

### asyncFormDetection(String imagePath)

Recognizes the form content asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath | String | Local image path. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLTable\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLFormRecognitionAnalyzer analyzer = new MLFormRecognitionAnalyzer();

MLTable table = await analyzer.asyncFormDetection("local image path");
```

### syncFormDetection(String imagePath)

Recognizes the form content synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath | String | Local image path. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLTable\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLFormRecognitionAnalyzer analyzer = new MLFormRecognitionAnalyzer();

MLTable table = await analyzer.syncFormDetection("local image path");
```

### stopFormRecognition()

Stops the form recognition.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopFormRecognition();
```

# MLGeneralCardAnalyzer

Provides on-device APIs for general card recognition.

## Method Summary

| Return Type | Method    | Description   |
| ----------- | --------- | ------------- |
| Future\<MLGeneralCard\> | [capturePreview(MLGeneralCardAnalyzerSetting setting)](#capturepreviewmlgeneralcardanalyzersetting-setting) | Enables the plug-in for recognizing general cards in camera streams. |
| Future\<MLGeneralCard\> | [capturePhoto(MLGeneralCardAnalyzerSetting setting)](#capturephotomlgeneralcardanalyzersetting-setting) | Enables the plug-in for taking a photo of a general card and recognizing the general card on the photo. |
| Future\<MLGeneralCard\> | [captureImage(MLGeneralCardAnalyzerSetting setting)](#captureimagemlgeneralcardanalyzersetting-setting) | Enables the plug-in for recognizing static images of general cards. |

## Methods

### capturePreview(MLGeneralCardAnalyzerSetting setting)

Enables the plug-in for recognizing general cards in camera streams.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLGeneralCardAnalyzerSetting](#mlgeneralcardanalyzersetting) | Configurations for general card recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLGeneralCard\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLGeneralCardAnalyzerSetting setting = new MLGeneralCardAnalyzerSetting();

setting.scanBoxCornerColor = Colors.greenAccent;
setting.tipTextColor = Colors.black;
setting.tipText = "Hold still...";

MLGeneralCard card = await analyzer.capturePreview(setting);
```

### capturePhoto(MLGeneralCardAnalyzerSetting setting)

Enables the plug-in for taking a photo of a general card and recognizing the general card on the photo.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLGeneralCardAnalyzerSetting](#mlgeneralcardanalyzersetting) | Configurations for general card recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLGeneralCard\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLGeneralCardAnalyzerSetting setting = new MLGeneralCardAnalyzerSetting();

setting.scanBoxCornerColor = Colors.greenAccent;
setting.tipTextColor = Colors.black;
setting.tipText = "Hold still...";

MLGeneralCard card = await analyzer.capturePhoto(setting);
```

### captureImage(MLGeneralCardAnalyzerSetting setting)

Enables the plug-in for recognizing static images of general cards.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLGeneralCardAnalyzerSetting](#mlgeneralcardanalyzersetting) | Configurations for general card recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLGeneralCard\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLGeneralCardAnalyzerSetting setting = new MLGeneralCardAnalyzerSetting();

setting.path = "local image path";

MLGeneralCard card = await analyzer.captureImage(setting);
```

## Data Types

### MLGeneralCardAnalyzerSetting

Configuration class for general card recognition service.

#### Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | String | Local image path. **null** by default. |
| language | String | Recognition language. "zh" by default. |
| scanBoxCornerColor | Color | Scan box border color. Green by default. |
| tipTextColor | Color | Tip text color. White by default. |
| tipText | String | Tip text for scanning process. "Recognizing.." by default. |

# MLHandKeypointAnalyzer

Serves as the hand keypoint detection SDK, which contains hand keypoint detection classes and APIs.

## Method Summary

| Return Type  | Method  | Description  |
| ------------ | ------- | ------------ |
| Future\<List\<MLHandKeypoints\>\> | [asyncHandDetection(MLHandKeypointAnalyzerSetting setting)](#asynchanddetectionmlhandkeypointanalyzersetting-setting) | Recognizes the hand keypoints asynchronously. |
| Future\<List\<MLHandKeypoints\>\> | [syncHandDetection(MLHandKeypointAnalyzerSetting setting)](#synchanddetectionmlhandkeypointanalyzersetting-setting) | Recognizes the hand keypoints synchronously. |
| Future\<bool\> | [stopHandDetection()](#stophanddetection) | Stops the hand keypoint analyzer. |

## Methods

### asyncHandDetection(MLHandKeypointAnalyzerSetting setting)

Recognizes the hand keypoints asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLHandKeypointAnalyzerSetting | Configurations for hand keypoint recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLHandKeypoints\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLHandKeypointAnalyzer analyzer = new MLHandKeypointAnalyzer();
MLHandKeypointAnalyzerSetting setting = new MLHandKeypointAnalyzerSetting();

setting.path = "local image path";

List<MLHandKeypoints> list = await analyzer.asyncHandDetection(setting);
```

### syncHandDetection(MLHandKeypointAnalyzerSetting setting)

Recognizes the hand keypoints synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ------- |
| setting | MLHandKeypointAnalyzerSetting | Configurations for hand keypoint recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLHandKeypoints\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLHandKeypointAnalyzer analyzer = new MLHandKeypointAnalyzer();
MLHandKeypointAnalyzerSetting setting = new MLHandKeypointAnalyzerSetting();

setting.path = "local image path";

List<MLHandKeypoints> list = await analyzer.syncHandDetection(setting);
```

### stopHandDetection()

Stops the hand keypoint analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopHandDetection();
```

# MLImageSuperResolutionAnalyzer

This package represents the image super-resolution SDK. It contains image super-resolution classes and APIs.

## Method Summary

| Return Type  | Method  | Description  |
| ------------ | ------- | ------------ |
| Future\<MLImageSuperResolutionResult\> | [asyncImageResolution(MLImageSuperResolutionAnalyzerSetting setting)](#asyncimageresolutionmlimagesuperresolutionanalyzersetting-setting) | Performs super-resolution processing on the source image using the asynchronous method. |
| Future\<List\<MLImageSuperResolutionResult\>\> | [syncImageResolution(MLImageSuperResolutionAnalyzerSetting setting)](#syncimageresolutionmlimagesuperresolutionanalyzersetting-setting) | Performs super-resolution processing on the source image using the synchronous method. |
| Future\<bool\> | [stopImageSuperResolution()](#stopimagesuperresolution) | Releases resources used by an analyzer. |

## Methods

### asyncImageResolution(MLImageSuperResolutionAnalyzerSetting setting)

Performs super-resolution processing on the source image using the asynchronous method.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLImageSuperResolutionAnalyzerSetting | Configurations for the recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLImageSuperResolutionResult\> | Returns the resolution result on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLImageSuperResolutionAnalyzer analyzer = new MLImageSuperResolutionAnalyzer();
MLImageSuperResolutionAnalyzerSetting setting = new MLImageSuperResolutionAnalyzerSetting();

setting.path = "local image path";
setting.scale = MLImageSuperResolutionAnalyzerSetting.ISR_SCALE_1X;

MLImageSuperResolutionResult result = await analyzer.asyncImageResolution(setting);
```

### syncImageResolution(MLImageSuperResolutionAnalyzerSetting setting)

Performs super-resolution processing on the source image using the synchronous method.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLImageSuperResolutionAnalyzerSetting | Configurations for the recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLImageSuperResolutionResult\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLImageSuperResolutionAnalyzer analyzer = new MLImageSuperResolutionAnalyzer();
MLImageSuperResolutionAnalyzerSetting setting = new MLImageSuperResolutionAnalyzerSetting();

setting.path = "local image path";
setting.scale = MLImageSuperResolutionAnalyzerSetting.ISR_SCALE_1X;

List<MLImageSuperResolutionResult> result = await analyzer.syncImageResolution(setting);
```

### stopImageSuperResolution

Releases resources used by an analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopImageSuperResolution();
```

# MLImageSegmentationAnalyzer

Provides the image segmentation SDK. It contains image segmentation classes and APIs.

## Method Summary

| Return Type | Method  | Description |
| ----------- | ------- | ----------- |
| Future\<MLImageSegmentation\> | [asyncAnalyzeFrame(MLImageSegmentationAnalyzerSetting setting)](#asyncanalyzeframemlimagesegmentationanalyzersetting-setting) | Implements image segmentation in asynchronous mode. |
| Future\<List\<MLImageSegmentation\>\> | [analyzeFrame(MLImageSegmentationAnalyzerSetting setting)](#analyzeframemlimagesegmentationanalyzersetting-setting) | Implements image segmentation in synchronous mode. |
| Future\<bool\> | [stopSegmentation()](#stopsegmentation) | Releases resources, including input and output streams and loaded model files. |

## Methods

### asyncAnalyzeFrame(MLImageSegmentationAnalyzerSetting setting)

Implements image segmentation in asynchronous mode.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLImageSegmentationAnalyzerSetting](#mlimagesegmentationanalyzersetting) | Configurations for image segmentation. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLImageSegmentation\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLImageSegmentationAnalyzer analyzer = new MLImageSegmentationAnalyzer();
MLImageSegmentationAnalyzerSetting setting = new MLImageSegmentationAnalyzerSetting();

setting.path = "local image path";
setting.analyzerType = MLImageSegmentationAnalyzerSetting.BODY_SEG;
setting.scene = MLImageSegmentationAnalyzerSetting.ALL;

MLImageSegmentation segmentation = await analyzer.asyncAnalyzeFrame(setting);
```

### analyzeFrame(MLImageSegmentationAnalyzerSetting setting)

Implements image segmentation in synchronous mode.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLImageSegmentationAnalyzerSetting](#mlimagesegmentationanalyzersetting) | Configurations for image segmentation. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLImageSegmentation\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLImageSegmentationAnalyzer analyzer = new MLImageSegmentationAnalyzer();
MLImageSegmentationAnalyzerSetting setting = new MLImageSegmentationAnalyzerSetting();

setting.path = "local image path";
setting.analyzerType = MLImageSegmentationAnalyzerSetting.BODY_SEG;
setting.scene = MLImageSegmentationAnalyzerSetting.ALL;

List<MLImageSegmentation> list = await analyzer.analyzeFrame(setting);
```

### stopSegmentation()

Releases resources, including input and output streams and loaded model files.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopSegmentation();
```

## Data Types

### MLImageSegmentationAnalyzerSetting

Configuration class for image segmentation service.

#### Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | String | Local image path. **null** by default. |
| frameType | MLFrameType | Recognition frame type. **MLFrameType.fromBitmap** by default. You are adviced to use it this way. |
| property | MLFrameProperty | Recognition property type. |
| analyzerType | int | Sets the classification mode. For static image segmentation, **MLImageSegmentationAnalyzerSetting.BODY_SEG** (only the human body and background) and **MLImageSegmentationAnalyzerSetting.IMAGE_SEG** (11 categories, including the human body) can be set. |
| scene | int | Sets the type of the returned result. This setting takes effect only in **MLImageSegmentationAnalyzerSetting.BODY_SEG** mode. In **MLImageSegmentationAnalyzerSetting.IMAGE_SEG** mode, only the pixel-level label information is returned. The options are as follows: **MLImageSegmentationAnalyzerSetting.ALL** (return all segmentation results, including the pixel-level label information, human body image with a transparent background, and gray-scale image with a white human body and black background), **MLImageSegmentationAnalyzerSetting.MASK_ONLY** (return only the pixel-level label information), **MLImageSegmentationAnalyzerSetting.FOREGROUND_ONLY** (return only the human body image with a transparent background), and **MLImageSegmentationAnalyzerSetting.GRAYSCALE_ONLY** (return only the gray-scale image with a white human body and black background). |
| exactMode | bool | Determines whether to support fine detection. **true** by default. |

# MLLandmarkAnalyzer

Implements image landmark detection of HUAWEI ML Kit.

## Method Summary

| Return Type       | Method   | Description   |
| ----------------- | -------- | ------------- |
| Future\<List\<MLLandmark\>\> | [asyncAnalyzeFrame(MLLandmarkAnalyzerSetting setting)](#asyncanalyzeframemllandmarkanalyzersetting-setting) | Detects landmarks in a supplied image. |
| Future\<bool\> | [stopLandmarkDetection()](#stoplandmarkdetection) | Releases resources, including input and output streams. |

## Methods

### asyncAnalyzeFrame(MLLandmarkAnalyzerSetting setting)

Detects landmarks in a supplied image asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLLandmarkAnalyzerSetting | Configurations for landmark recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLLandmark\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLLandmarkAnalyzer analyzer = new MLLandmarkAnalyzer();
MLLandmarkAnalyzerSetting setting = new MLLandmarkAnalyzerSetting();

setting.path = "local image path";
setting.largestNumberOfReturns = 8;

List<MLLandmark> list = await analyzer.asyncAnalyzeFrame(setting);
```

### stopLandmarkDetection()

Releases resources, including input and output streams.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopLandmarkDetection();
```

# MLLangDetector

Detects languages.

## Method Summary

| Return Type       | Method    | Description   |
| ----------------- | --------- | ------------- |
| Future\<String\> | [firstBestDetect(MLLangDetectorSetting setting)](#firstbestdetectmllangdetectorsetting-setting) | Returns the language detection result with the highest confidence based on the supplied text. |
| Future\<String\> | [syncFirstBestDetect(MLLangDetectorSetting setting)](#syncfirstbestdetectmllangdetectorsetting-setting) | Synchronously returns the language detection result with the highest confidence based on the supplied text. |
| Future\<List\<MLDetectedLang\>\> | [probabilityDetect(MLLangDetectorSetting setting)](#probabilitydetectmllangdetectorsetting-setting) | Returns multi-language detection results based on the supplied text. |
| Future\<List\<MLDetectedLang\>\> | [syncProbabilityDetect(MLLangDetectorSetting setting)](#syncprobabilitydetectmllangdetectorsetting-setting) | Synchronously returns multi-language detection results based on the supplied text. |
| Future\<bool\> | [stop()](#stop-lang) | Releases resources, including input and output streams. |

## Methods

### firstBestDetect(MLLangDetectorSetting setting)

Returns the language detection result with the highest confidence based on the supplied text.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLLangDetectorSetting | Configurations for language detection service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the language code on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLLangDetector detector = new MLLangDetector();
MLLangDetectorSetting setting = new MLLangDetectorSetting();

setting.sourceText = "source text";
setting.isRemote = true;

String result = await detector.firstBestDetect(setting: setting);
```

### syncFirstBestDetect(MLLangDetectorSetting setting)

Synchronously returns the language detection result with the highest confidence based on the supplied text.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLLangDetectorSetting | Configurations for language detection service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the language code on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLLangDetector detector = new MLLangDetector();
MLLangDetectorSetting setting = new MLLangDetectorSetting();

setting.sourceText = "source text";
setting.isRemote = true;

String result = await detector.syncFirstBestDetect(setting: setting);
```

### probabilityDetect(MLLangDetectorSetting setting)

Returns multi-language detection results based on the supplied text.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLLangDetectorSetting | Configurations for language detection service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLDetectedLang\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLLangDetector detector = new MLLangDetector();
MLLangDetectorSetting setting = new MLLangDetectorSetting();

setting.sourceText = "source text";
setting.isRemote = true;

List<MLDetectedLang> list = await detector.probabilityDetect(setting: setting);
```

### syncProbabilityDetect(MLLangDetectorSetting setting)

Synchronously returns multi-language detection results based on the supplied text.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLLangDetectorSetting | Configurations for language detection service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLDetectedLang\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLLangDetector detector = new MLLangDetector();
MLLangDetectorSetting setting = new MLLangDetectorSetting();

setting.sourceText = "source text";
setting.isRemote = true;

List<MLDetectedLang> list = await detector.syncProbabilityDetect(setting: setting);
```

### <a name="stop-lang"></a> stop()

Releases resources, including input and output streams.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await detector.stop();
```

# LensEngine

A class with the camera initialization, frame obtaining, and logic control functions encapsulated.

## Constructor Summary

| Constructor | Description |
| ----------- | ----------- |
| LensEngine(LensViewController controller) | Requires a controller to initialize a texture for camera preview and build the lens engine with required parameters. |

## Constructors

### LensEngine(LensViewController controller)

Requires a controller to initialize a texture for camera preview and build the lens engine with required parameters.

## Method Summary

| Return Type  | Method    | Description  |
| ------------ | --------- | ------------ |
| Future\<void\> | [initLens()](#initlens) | Initializes the surface texture for camera to be previewed. |
| Future\<void\> | [run()](#run) | Runs the lens engine and starts live detection. |
| Future\<bool\> | [release()](#release) | Releases resources occupied by LensEngine. |
| Future\<String\> | [photograph()](#photograph) | Captures an image during live detection. |
| Future\<void\> | [zoom(double z)](#zoomdouble-z) | Adjusts the focal length of the camera based on the scaling coefficient (digital zoom). |
| Future\<bool\> | [getLens()](#getlens) | Checks if the engine has a usable camera instance. |
| Future\<int\> | [getLensType()](#getlenstype) | Obtains the lens type that being used during live detection. |
| Future\<Size\> | [getDisplayDimension()](#getdisplaydimension) | Obtains the size of the preview image of a camera. |
| Future\<void\> | [switchCamera()](#switchcamera) | Switches between front and back lenses. |
| void | [setTransactor(LensTransactor transactor)](#settransactorlenstransactor-transactor) | Sets a listener for detection events. |

## Methods

### initLens()

Initializes the surface texture for camera to be previewed.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
final LensViewController controller = new LensViewController(
    lensType: LensViewController.BACK_LENS,
    analyzerType: LensEngineAnalyzerOptions.FACE
);

LensEngine lensEngine = new LensEngine(controller: controller);

await lensEngine.initLens();
setState(() {});
```

### run()

Starts the LensEngine and uses SurfaceTexture as the frame preview panel. A frame preview panel is used to preview images and display detection results.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await lensEngine.run();
```

### release()

Releases resources occupied by LensEngine.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await lensEngine.release();
```

### photograph()

Captures an image during live detection.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the captured image path on success. |

**Call Example**

```dart
String result = await lensEngine.photograph();
```

### zoom(double z)

Adjusts the focal length of the camera based on the scaling coefficient (digital zoom).

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| z    | double | Scaling coefficient. If the scaling coefficient is greater than 1.0, the focal length is calculated as follows: Maximum focal length supported by the camera x 1/10 x Scaling coefficient. If the scaling coefficient is 1.0, the focal length does not change. If the scaling coefficient is less than 1.0, the focal length equals the current focal length multiplied by the scaling coefficient. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await lensEngine.zoom(1.5);
```

### getLens()

Checks if the engine has a usable camera instance.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true or false depending on the obtained camera instance. |

**Call Example**

```dart
bool result = await lensEngine.getLens();
```

### getLensType()

Obtains the lens type that being used during live detection.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<int\> | Returns the lens type on success, throws PlatformException otherwise. |

**Call Example**

```dart
int type = await lensEngine.getLensType();
```

### getDisplayDimension()

Obtains the size of the preview image of a camera.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<Size\> | Returns the display dimension on success, throws PlatformException otherwise. |

**Call Example**

```dart
Size size = await lensEngine.getDisplayDimension();
```

### switchCamera()

Switches between front and back lenses.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await lensEngine.switchCamera();
```

### setTransactor(LensTransactor transactor)

Sets a listener for detection events.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| transactor | [LensTransactor](#lenstransactor) | Listener for live detections. |

**Call Example**

```dart
lensEngine.setTransactor(({isAnalyzerAvailable, result}) {
    // Your implementation here
});
```

## Data Types

### LensViewController

Configuration class for live detections.

#### Constants

| Constant | Type   | Description |
| -------- | ------ | ----------- |
| BACK_LENS   | int    | Back lens. |
| FRONT_LENS  | int    | Front lens. |
| FLASH_MODE_OFF  | String | Turns off the flash. |
| FLASH_MODE_AUTO  | String | Automatically determine whether to turn on the flash. |
| FLASH_MODE_ON  | String | Turns on the flash. |
| FOCUS_MODE_CONTINUOUS_VIDEO   | String | continuous video focus mode. |
| FOCUS_MODE_CONTINUOUS_PICTURE | String | continuous image focus mode. |

#### Properties

| Name  | Type | Description |
| ----- | ---- | ----------- |
| lensType   | int   | Sets the lens type. **0** by default. |
| analyzerType  | LensEngineAnalyzerOptions | Sets the analyzer type will be used during live detection. |
| applyFps    | double  | Sets the preview frame rate (FPS) of a camera. The preview frame rate of a camera depends on the firmware capability of the camera. **30.0** by default. |
| dimensionWidth  | int | Sets the width of size of the preview image of a camera. **1440** by default. |
| dimensionHeight | int | Sets the height of size of the preview image of a camera. **1080** by default. |
| flashMode  | String  | Sets the flash mode for a camera. "**auto**" by default. |
| focusMode  | String  | Sets the focus mode for a camera. "**continuous-video**" by default. |
| automaticFocus  | bool  | Enables or disables the automatic focus function for a camera. **true** by default. |
| maxFrameLostCount | int  | Sets the maximum number of frames for determining that a face disappears. This option is only used with **LensEngineAnalyzerOptions.MAX_SIZE_FACE**. |

### LensTransactor

A function type defined for listening live detection events.

| Definition   | Description |
| ------------ | ----------- |
| void LensTransactor({dynamic result, bool isAnalyzerAvailable}) | Live detection event listener. |

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | dynamic | Live detection result. Varies with different types of analysis. |
| isAnalyzerAvailable | dynamic | Obtains the status of the given analyzer type.                  |

### enum LensEngineAnalyzerOptions

Enumerated object that represents the analyzer type will be used during live detection.

| Value  | Description |
| ------ | ----------- |
| FACE  | Lens engine will detect with face analyzer. |
| FACE_3D  | Lens engine will detect with 3D face analyzer.  |
| MAX_SIZE_FACE  | Lens engine will detect with max size face transactor. |
| HAND  | Lens engine will detect with hand keypoint analyzer. |
| SKELETON   | Lens engine will detect with skeleton analyzer.   |
| CLASSIFICATION | Lens engine will detect with classification analyzer.  |
| TEXT  | Lens engine will detect with text analyzer.   |
| OBJECT  | Lens engine will detect with object analyzer.  |
| SCENE  | Lens engine will detect with scene analyzer.  |

### LensView

Special widget that allows to carry out the live detections.

#### Constructor Summary

| Constructor | Description  |
| ----------- | ------------ |
| LensView(LensViewController controller, double with, double height) | Requires a controller which has a texture id that will be used for camera preview. |

#### Constructors

##### LensView(LensViewController controller, double with, double height)

Requires a controller which has a texture id that will be used for camera preview. Also takes a width and a height to have a configurable size.

# MLLivenessCapture

## Constants

| Constant | Type | Description |
| -------- | ---- | ----------- |
| CAMERA_NO_PERMISSION | int | The camera permission is not obtained. |
| CAMERA_START_FAILED | int | Failed to start the camera. |
| DETECT_FACE_TIME_OUT | int | The face detection module times out. (The duration does not exceed 2 minutes.) |
| USER_CANCEL | int | The operation is canceled by the user. |
| DETECT_MASK | int | Sets whether to detect the mask. |
| MASK_WAS_DETECTED | int | A mask is detected. |
| NO_FACE_WAS_DETECTED | int | No face is detected. |

## Method Summary

| Return Type | Method | Description |
| ----------- | ------ | ----------- |
| Future\<MLLivenessCaptureResult\> | [startLivenessDetection(bool detectMask)](#startlivenessdetectionbool-detectmask) | Starts a liveness detection activity. |

## Methods

### startLivenessDetection(bool detectMask)

Starts a liveness detection activity.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| detectMask | bool | An optional parameter. **true** by default. The service considers the mask in detection when true. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLLivenessCaptureResult\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLLivenessCapture livenessCapture = new MLLivenessCapture();

MLLivenessCaptureResult result = await livenessCapture.startLivenessDetection(detectMask: true);
```

# MLApplication

An app information class used to store basic information about apps with the HMS Core ML SDK integrated and complete the initialization of ML Kit. When using cloud services of the ML Kit, you need to set the apiKey of your app.

## Method Summary

| Return Type       | Method  | Description   |
| ----------------- | ------- | ------------- |
| Future\<void\> | [setApiKey(String apiKey)](#setapikeystring-apikey) | Sets the api key for on cloud services. |
| Future\<void\> | [setAccessToken(String accessToken)](#setaccesstokenstring-accesstoken) | Sets the access token for on cloud services. |
| Future\<void\> | [enableLogger()](#enablelogger) | Enables the HMS plugin method analytics. |
| Future\<void\> | [disableLogger()](#disablelogger) | Disables the HMS plugin method analytics. |

## Methods

### setApiKey(String apiKey)

Sets the api key for on cloud services.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| apiKey | String | apiKey of an app. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await MLApplication().setApiKey(apiKey: "your api key");
```

### setAccessToken(String accessToken)

Sets the access token for on cloud services.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| accessToken | String | access token of an app. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await MLApplication().setAccessToken(accessToken: "your access token");
```

### enableLogger()

Enables HMS Plugin Method Analytics which is used for sending usage analytics of Health Kit SDK's methods to improve the service quality.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await MLApplication().enableLogger();
```

### disableLogger()

Disables HMS Plugin Method Analytics which is used for sending usage analytics of Health Kit SDK's methods to improve the service quality.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
await MLApplication().disableLogger();
```

# MLFrame

A class that encapsulates video frame or static image data sourced from a camera as well as related data processing logic.

## Constants

| Constant | Type | Description |
| -------- | ---- | ----------- |
| SCREEN_FIRST_QUADRANT | int | Landscape. |
| SCREEN_SECOND_QUADRANT | int | Portrait, which is 90 degrees clockwise from **SCREEN_FIRST_QUADRANT**. |
| SCREEN_THIRD_QUADRANT | int | Reverse landscape, which is 90 degrees clockwise from **SCREEN_SECOND_QUADRANT**. |
| SCREEN_FOURTH_QUADRANT | int | Reverse portrait, which is 90 degrees clockwise from **SCREEN_THIRD_QUADRANT**. |

## Constructor Summary

| Constructor | Description |
| ----------- | ----------- |
| MLFrame(MLFrameProperty property) | Configures the request for image related API's. |

## Constructors

### MLFrame(MLFrameProperty property)

Property object has some configurable request options that can be used with image related services. By default this object is null in the image related analyzer setting classes. You are adviced **not** to use MLProperty in image related requests.

## Method Summary

| Return Type       | Method  | Description   |
| ----------------- | ------- | ------------- |
| Future\<String\> | [getPreviewBitmap()](#getpreviewbitmap) | Obtains the image from last image related analysis. |
| Future\<String\> | [readBitmap()](#readbitmap) | Obtains the image from last image related analysis. |
| Future\<String\> | [rotate(String path, int quadrant)](#rotatestring-path-int-quadrant) | Rotates given image and returns the result. |

## Methods

### getPreviewBitmap()

Obtains the image from last image related analysis.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the image path on success, throws PlatformException otherwise. |

**Call Example**

```dart
String result = await MLFrame().getPreviewBitmap();
```

### readBitmap()

Obtains the image from last image related analysis.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the image path on success, throws PlatformException otherwise. |

**Call Example**

```dart
String result = await MLFrame().readBitmap();
```

### rotate(String path, int quadrant)

Rotates given image and returns the result.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | String | Local image path |
| quadrant | int | Indicates rotation degree |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns rotated image path on success, throws PlatformException otherwise. |

**Call Example**

```dart
String result = await MLFrame().rotate("local image path", MLFrame.SCREEN_SECOND_QUADRANT);
```

# MLObjectAnalyzer

This package implements object detection and tracking of HUAWEI ML Kit.

## Method Summary

| Return Type | Method | Description   |
| ----------- | ------ | ------------- |
| Future\<List\<MLObject\>\> | [asyncAnalyzeFrame(MLObjectAnalyzerSetting setting)](#asyncanalyzeframemlobjectanalyzersetting-setting) | Analyzes the object asynchronously. |
| Future\<List\<MLObject\>\> | [analyzeFrame(MLObjectAnalyzerSetting setting)](#analyzeframemlobjectanalyzersetting-setting) | Analyzes the object synchronously. |
| Future\<bool\> | [stopObjectDetection()](#stopobjectdetection) | Stops object detection. |

## Methods

### asyncAnalyzeFrame(MLObjectAnalyzerSetting setting)

Analyzes the object asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLObjectAnalyzerSetting | Configurations for object recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLObject\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLObjectAnalyzer analyzer = new MLObjectAnalyzer();
MLObjectAnalyzerSetting setting = new MLObjectAnalyzerSetting();

setting.path = "local image path";

List<MLObject> list = await analyzer.asyncAnalyzeFrame(setting);
```

### analyzeFrame(MLObjectAnalyzerSetting setting)

Analyzes the object synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLObjectAnalyzerSetting | Configurations for object recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLObject\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLObjectAnalyzer analyzer = new MLObjectAnalyzer();
MLObjectAnalyzerSetting setting = new MLObjectAnalyzerSetting();

setting.path = "local image path";

List<MLObject> list = await analyzer.analyzeFrame(setting);
```

### stopObjectDetection()

Stops object detection.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopObjectDetection();
```

# MLProductVisionSearchAnalyzer

Represents the image-based product detection API of HUAWEI ML Kit.

## Method Summary

| Return Type | Method  | Description |
| ----------- | ------- | ----------- |
| Future\<List\<MlProductVisualSearch\>\> | [searchProduct(MLProductVisionSearchAnalyzerSetting setting)](#searchproductmlproductvisionsearchanalyzersetting-setting) | Recognizes the product. |
| Future\<List\<MLProductCaptureResult\>\> | [searchProductWithPlugin(MLProductVisionSearchAnalyzerSetting setting)](#searchproductwithpluginmlproductvisionsearchanalyzersetting-setting) | Recognizes the product with the plugin. |
| Future\<bool\> | [stopProductAnalyzer()](#stopproductanalyzer) | Stops the product analyzer. |

## Methods

### searchProduct(MLProductVisionSearchAnalyzerSetting setting)

Recognizes the product with a local image.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLProductVisionSearchAnalyzerSetting](#mlproductvisionsearchanalyzersetting) | Configuration for product search service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MlProductVisualSearch\>\> | Returns the product list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLProductVisionSearchAnalyzer analyzer = new MLProductVisionSearchAnalyzer();
MLProductVisionSearchAnalyzerSetting setting = new MLProductVisionSearchAnalyzerSetting();

setting.path = "local image path";
setting.largestNumberOfReturns = 10;
setting.productSetId = "bags";
setting.region = MLProductVisionSearchAnalyzerSetting.REGION_DR_CHINA;

List<MlProductVisualSearch> visionSearch = await analyzer.searchProduct(setting);
```

### searchProductWithPlugin(MLProductVisionSearchAnalyzerSetting setting)

Recognizes the product with the plugin.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | [MLProductVisionSearchAnalyzerSetting](#mlproductvisionsearchanalyzersetting) | Configuration for product search service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLProductCaptureResult\>\> | Returns the product list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLProductVisionSearchAnalyzer analyzer = new MLProductVisionSearchAnalyzer();
MLProductVisionSearchAnalyzerSetting setting = new MLProductVisionSearchAnalyzerSetting();

setting.largestNumberOfReturns = 10;
setting.productSetId = "bags";
setting.region = MLProductVisionSearchAnalyzerSetting.REGION_DR_CHINA;

<List<MLProductCaptureResult> list = await analyzer.searchProductWithPlugin(setting);
```

### stopProductAnalyzer()

Stops the product analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool result = await analyzer.stopProductAnalyzer();
```

## Data Types

### MLProductVisionSearchAnalyzerSetting

#### Constants

| Constant | Type | Description |
| -------- | ---- | ----------- |
| REGION_DR_SINGAPORE | int | Singapore |
| REGION_DR_CHINA | int | China |
| REGION_DR_GERMAN | int | Germany |
| REGION_DR_RUSSIA | int | Russia |
| REGION_DR_EUROPE | int | Europe |
| REGION_DR_AFILA | int | Asia, America |
| REGION_DR_UNKNOWN | int | Unknown region |

#### Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | String | Local image path. **null** by default. |
| productSetId | String | Sets the product set id. "**vmall**" by default. |
| largestNumberOfReturns | int | Set max result count. **20** by default. |
| region | int | Sets the region. **1002** by default. |

# MLSpeechRealTimeTranscription

Converts speech into text in real time.

## Method Summary

| Return Type       | Method | Description  |
| ----------------- | ------ | ------------ |
| Future\<void\> | [startRecognizing(MLSpeechRealTimeTranscriptionConfig config)](#startrecognizingmlspeechrealtimetranscriptionconfig-config) | Starts the real time transcription service. |
| Future\<bool\> | [destroyRealTimeTranscription()](#destroyrealtimetranscription) | Stops the real time transcription service. |
| void | [setListener(RttListener listener)](#setlistenerrttlistener-listener) | Sets a listener for real time transcription service. |

## Methods

### startRecognizing(MLSpeechRealTimeTranscriptionConfig config)

Starts the real time transcription service.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| config | [MLSpeechRealTimeTranscriptionConfig](#mlspeechrealtimetranscriptionconfig) | Configurations for real time transcription. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | No return value. |

**Call Example**

```dart
MLSpeechRealTimeTranscription client = new MLSpeechRealTimeTranscription();
MLSpeechRealTimeTranscriptionConfig config = new MLSpeechRealTimeTranscriptionConfig();

config.language = MLSpeechRealTimeTranscriptionConfig.LAN_EN_US;

await client.startRecognizing(config: config);
```

### destroyRealTimeTranscription()

Stops the real time transcription service.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await client.destroyRealTimeTranscription();
```

### setListener(RttListener listener)

Sets a listener for real time transcription service.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| listener | [RttListener](#rttlistener) | Listens transcription events. |

**Call Example**

```dart
client.setListener((partialResult, {recognizedResult}) {
    // Your implementation here
});
```

## Data Types

### RttListener

A function type defined for listening real time transcription events.

| Definition   | Description  |
| ------------ | ------------ |
| void RttListener(dynamic partialResult, {String recognizedResult}) | Transcription event listener. |

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| partialResult | dynamic | Transcription information. |
| recognizedResult | String | Obtained text from speech. |

### MLSpeechRealTimeTranscriptionConfig

#### Constants

| Constant | Type | Description |
| -------- | ---- | ----------- |
| LAN_ZH_CN | String | Chinese. |
| LAN_EN_US | String | English. |
| LAN_FR_FR | String | French. |
| SCENES_SHOPPING | String | Shopping scenario. |

#### Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| language | String | Sets the language. "**en-US**" by default. |
| scene | String | Sets the scenario. Only available with chinese. |
| punctuationEnabled | bool | Indicates whether punctuation is required in the transcription result. By default, punctuation is required. |
| sentenceTimeOffsetEnabled | bool | Sets whether the sentence offset is required in the transcription result. By default, the sentence offset is not required. |
| wordTimeOffsetEnabled | bool | Sets whether the word offset is required in the transcription result. By default, the word offset is not required. |

# MLSceneDetectionAnalyzer

Detects scenes.

## Method Summary

| Return Type | Method  | Description  |
| ----------- | ------- | ------------ |
| Future\<List\<MLSceneDetection\>\> | [asyncSceneDetection(MLSceneDetectionAnalyzerSetting setting)](#asyncscenedetectionmlscenedetectionanalyzersetting-setting) | Analyzes the scene asynchronously. |
| Future\<List\<MLSceneDetection\>\> | [syncSceneDetection(MLSceneDetectionAnalyzerSetting setting)](#syncscenedetectionmlscenedetectionanalyzersetting-setting) | Analyzes the scene synchronously. |
| Future\<bool\> | [stopSceneDetection()](#stopscenedetection) | Stops the scene detection. |

## Methods

### asyncSceneDetection(MLSceneDetectionAnalyzerSetting setting)

Analyzes the scene asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLSceneDetectionAnalyzerSetting | Configurations for scene detection. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLSceneDetection\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLSceneDetectionAnalyzer analyzer = new MLSceneDetectionAnalyzer();
MLSceneDetectionAnalyzerSetting setting = new MLSceneDetectionAnalyzerSetting();

setting.path = "local image path";

List<MLSceneDetection> list = await analyzer.asyncSceneDetection(setting);
```

### syncSceneDetection(MLSceneDetectionAnalyzerSetting setting)

Analyzes the scene synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLSceneDetectionAnalyzerSetting | Configurations for scene detection. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLSceneDetection\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLSceneDetectionAnalyzer analyzer = new MLSceneDetectionAnalyzer();
MLSceneDetectionAnalyzerSetting setting = new MLSceneDetectionAnalyzerSetting();

setting.path = "local image path";

List<MLSceneDetection> list = await analyzer.syncSceneDetection(setting);
```

### stopSceneDetection()

Stops the scene detection.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await analyzer.stopSceneDetection();
```

# MLSkeletonAnalyzer

Detects skeleton points.

## Method Summary

| Return Type       | Method  | Description   |
| ----------------- | ------- | ------------- |
| Future\<List\<MLSkeleton\>\> | [asyncSkeletonDetection(MLSkeletonAnalyzerSetting setting)](#asyncskeletondetectionmlskeletonanalyzersetting-setting) | Recognizes the skeleton points asynchronously. |
| Future\<List\<MLSkeleton\>\> | [syncSkeletonDetection(MLSkeletonAnalyzerSetting setting)](#syncskeletondetectionmlskeletonanalyzersetting-setting)] | Recognizes the skeleton points synchronously. |
| Future\<double\> | [calculateSimilarity(List\<MLSkeleton\> list1, List\<MLSkeleton\> list2)](#calculatesimilaritylistmlskeleton-list1-listmlskeleton-list2) | Calculates the similarity between two lists of MLSkeleton objects. |
| Future\<bool\> | [stopSkeletonDetection()](#stopskeletondetection) | Stops the skeleton detection. |

## Methods

### asyncSkeletonDetection(MLSkeletonAnalyzerSetting setting)

Recognizes the skeleton points asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLSkeletonAnalyzerSetting | Configurations for skeleton detection. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLSkeleton\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLSkeletonAnalyzer analyzer = new MLSkeletonAnalyzer();
MLSkeletonAnalyzerSetting setting = new MLSkeletonAnalyzerSetting();

setting.path = "local image path";

List<MLSkeleton> list = await analyzer.asyncSkeletonDetection(setting);
```

### syncSkeletonDetection(MLSkeletonAnalyzerSetting setting)

Recognizes the skeleton points synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLSkeletonAnalyzerSetting | Configurations for skeleton detection. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLSkeleton\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLSkeletonAnalyzer analyzer = new MLSkeletonAnalyzer();
MLSkeletonAnalyzerSetting setting = new MLSkeletonAnalyzerSetting();

setting.path = "local image path";

List<MLSkeleton> list = await analyzer.syncSkeletonDetection(setting);
```

### calculateSimilarity(List\<MLSkeleton\> list1, List\<MLSkeleton\> list2)

Calculates the similarity between two lists of MLSkeleton objects.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| list1 | List\<MLSkeleton\> | A list of MLSkeleton objects. |
| list2 | List\<MLSkeleton\> | A list of MLSkeleton objects. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<double\> | Returns the similarity on success, throws PlatformException otherwise. |

**Call Example**

```dart
final List<MLSkeleton> list1 = [MLSkeleton(..), MLSkeleton(..)];

final List<MLSkeleton> list2 = [MLSkeleton(..), MLSkeleton(..)];

double res = await analyzer.calculateSimilarity(list1, list2);
```

### stopSkeletonDetection

Stops the skeleton detection.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await analyzer.stopSkeletonDetection();
```

# MLSoundDetector

Automatically detects sound.

## Method Summary

| Return Type  | Method  | Description  |
| ------------ | ------- | ------------ |
| Future\<int\> | [startSoundDetector()](#startsounddetector) | Starts listening the sound. |
| Future\<bool\> | [stopSoundDetector()](#stopsounddetector) | Stops the sound detector. |
| Future\<bool\> | [destroySoundDetector()](#destroysounddetector) | Destroys the sound detector. |

## Methods

### startSoundDetector()

Starts listening the sound.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<int\> | Returns the sound detection result on success. |

**Call Example**

```dart
MLSoundDetector detector = new MLSoundDetector();

int res = await detector.startSoundDetector();
```

### stopSoundDetector()

Stops the sound detector.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await detector.stopSoundDetector();
```

### destroySoundDetector()

Destroys the sound detector.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await detector.destroySoundDetector();
```

# MLTextAnalyzer

Serves as a text recognition component that recognizes text in images.

## Method Summary

| Return Type   | Method  | Description |
| ------------- | ------- | ----------- |
| Future\<MLText\>  | [asyncAnalyzeFrame(MLTextAnalyzerSetting setting)](#asyncanalyzeframemltextanalyzersetting-setting) | Recognizes the texts in image asynchronously. |
| Future\<List\<Blocks\>\> | [analyzeFrame(MLTextAnalyzerSetting setting)](#analyzeframemltextanalyzersetting-setting) | Recognizes the text blocks in image synchronously. |
| Future\<int\> | [getAnalyzeType()](#getanalyzetype) | Obtains the analyze type. |
| Future\<bool\> | [isTextAnalyzerAvailable()](#istextanalyzeravailable) | Checks whether the analyzer is available. |
| Future\<bool\> | [stopTextAnalyzer()](#stoptextanalyzer) | Stops the text analyzer. |

## Methods

### asyncAnalyzeFrame(MLTextAnalyzerSetting setting)

Recognizes the texts in image asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLTextAnalyzerSetting | Configurations for text recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLText\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTextAnalyzer analyzer = new MLTextAnalyzer();
MLTextAnalyzerSetting setting = new MLTextAnalyzerSetting();

setting.path = "local image path";
setting.isRemote = true;
setting.language = "en";

MLText text = await analyzer.asyncAnalyzeFrame(setting);
```

### analyzeFrame(MLTextAnalyzerSetting setting)

Recognizes the text blocks in image synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLTextAnalyzerSetting | Configurations for text recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<Blocks\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTextAnalyzer analyzer = new MLTextAnalyzer();
MLTextAnalyzerSetting setting = new MLTextAnalyzerSetting();

setting.path = "local image path";
setting.isRemote = true;
setting.language = "en";

List<Blocks> list = await analyzer.analyzeFrame(setting);
```

### getAnalyzeType()

Obtains the analyze type.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<int\> | Returns the type success, throws PlatformException otherwise. |

**Call Example**

```dart
int res = await analyzer.getAnalyzeType();
```

### isTextAnalyzerAvailable()

Checks whether the analyzer is available.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await analyzer.isTextAnalyzerAvailable();
```

### stopTextAnalyzer()

Stops the text analyzer.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await analyzer.stopTextAnalyzer();
```

# MLTextEmbeddingAnalyzer

Text embedding component.

## Method Summary

| Return Type | Method | Description  |
| ----------- | ------ | ------------ |
| Future\<bool\> | [createTextEmbeddingAnalyzer(MLTextEmbeddingAnalyzerSetting setting)](#createtextembeddinganalyzermltextembeddinganalyzersetting-setting) | Creates the text embedding analyzer. |
| Future\<List\<dynamic\>\> | [analyzeSentenceVector(String sentence)](#analyzesentencevectorstring-sentence) | Queries the sentence vector asynchronously. |
| Future\<double\> | [analyseSentencesSimilarity(String sentence1, String sentence2)](#analysesentencessimilaritystring-sentence1-string-sentence2) | Asynchronously queries the similarity between two sentences. The similarity range is -1, 1. |
| Future\<List\<dynamic\>\> | [analyseWordVector(String word)](#analysewordvectorstring-word) | Queries the word vector asynchronously. |
| Future\<double\> | [analyseWordsSimilarity(String word1, String word2)](#analysewordssimilaritystring-word1-string-word2) | Asynchronously queries the similarity between two words. The similarity range is -1, 1. |
| Future\<List\<dynamic\>\> | [analyseSimilarWords(String word, int number)](#analysesimilarwordsstring-word-int-number) | Asynchronously queries a specified number of similar words. |
| Future\<MlVocabularyVersion\> | [getVocabularyVersion()](#getvocabularyversion) | Asynchronously queries dictionary version information. |
| Future\<dynamic\> | [analyseWordVectorBatch(List\<String\> words)](#analysewordvectorbatchliststring-words) | Asynchronously queries word vectors in batches. (The number of words ranges from 1 to 500.) |

## Methods

### createTextEmbeddingAnalyzer(MLTextEmbeddingAnalyzerSetting setting)

Creates the text embedding analyzer.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLTextEmbeddingAnalyzerSetting | Configurations for text embedding service. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTextEmbeddingAnalyzer analyzer = new MLTextEmbeddingAnalyzer();
MLTextEmbeddingAnalyzerSetting setting = new MLTextEmbeddingAnalyzerSetting();

setting.language = MLTextEmbeddingAnalyzerSetting.LANGUAGE_EN;

bool res = await analyzer.createTextEmbeddingAnalyzer(setting: setting);
```

### analyzeSentenceVector(String sentence)

Queries the sentence vector asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| sentence | String | Sentence. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<dynamic> list = await analyzer.analyzeSentenceVector(sentence: "your sentence");
```

### analyseSentencesSimilarity(String sentence1, String sentence2)

Asynchronously queries the similarity between two sentences. The similarity range is -1, 1.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| sentence1 | String | Sentence. |
| sentence2 | String | Sentence. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<double\> | Returns the result on success, throws PlatformException otherwise. |

**Call Example**

```dart
double res = await analyzer.analyseSentencesSimilarity(sentence1: "sentence 1", sentence2: "sentence 2");
```

### analyseWordVector(String word)

Queries the word vector asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| word | String | Word. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<dynamic> list = await analyzer.analyseWordVector(word: "your word");
```

### analyseWordsSimilarity(String word1, String word2)

Asynchronously queries the similarity between two words. The similarity range is -1, 1.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| word1 | String | Word. |
| word2 | String | Word. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<double\> | Returns the result on success, throws PlatformException otherwise. |

**Call Example**

```dart
double res = await analyzer.analyseWordsSimilarity(word1: "word 1", word2: "word 2");
```

### analyseSimilarWords(String word, int number)

Asynchronously queries a specified number of similar words.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| word | String | Word. |
| number | int | Result count. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<dynamic> list = await analyzer.analyseSimilarWords(word: "word", number: 8);
```

### getVocabularyVersion()

Asynchronously queries dictionary version information.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MlVocabularyVersion\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLVocabularyVersion version = await analyzer.getVocabularyVersion();
```

### analyseWordVectorBatch(List\<String\> words)

Asynchronously queries word vectors in batches. (The number of words ranges from 1 to 500.)

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| words | List\<String\> | Words list. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<dynamic\> | Returns the result on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<dynamic> list = await analyzer.analyseWordVectorBatch(["one", "two", "three"]);
```

# MLTextImageSuperResolutionAnalyzer

This package represents the text image super-resolution SDK. It contains text image super-resolution classes and APIs.

## Method Summary

| Return Type       | Method | Description  |
| ----------------- | ------ | ------------ |
| Future\<MLTextImageSuperResolution\> | [asyncAnalyzeFrame(String imagePath)](#asyncanalyzeframestring-imagepath) | Does the text resolution asynchronously. |
| Future\<List<MLTextImageSuperResolution\>\> | [analyzeFrame(String imagePath)](#analyzeframestring-imagepath) | Does the text resolution synchronously. |
| Future\<bool\> | [stopTextResolution()](#stoptextresolution) | Stops the text resolution service. |

## Methods

### asyncAnalyzeFrame(String imagePath)

Does the text resolution asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath | String | Local image path. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<MLTextImageSuperResolution\> | Returns the object on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTextImageSuperResolutionAnalyzer analyzer = new MLTextImageSuperResolutionAnalyzer();

MLTextImageSuperResolution result = await analyzer.asyncAnalyzeFrame("image path");
```

### analyzeFrame(String imagePath)

Does the text resolution synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| imagePath | String | Local image path. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List<MLTextImageSuperResolution\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTextImageSuperResolutionAnalyzer analyzer = new MLTextImageSuperResolutionAnalyzer();

List<MLTextImageSuperResolution> list = await analyzer.analyzeFrame("image path");
```

### stopTextResolution()

Stops the text resolution service.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await analyzer.stopTextResolution();
```

# MLLocalTranslator

Translates text on the device.

## Method Summary

| Return Type | Method | Description  |
| ----------- | ------ | ------------ |
| Future\<List\<dynamic\>\> | [getLocalAllLanguages()](#getlocalalllanguages) | Obtains supported languages by local translation asynchronously. |
| Future\<List\<dynamic\>\> | [syncGetLocalAllLanguages()](#syncgetlocalalllanguages) | Obtains supported languages by local translation synchronously. |
| Future\<bool\> | [prepareModel(MLTranslateSetting setting)](#preparemodelmltranslatesetting-setting) | Prepares the local model for translation. |
| Future\<bool\> | [deleteModel(String langCode)](#deletemodelstring-langcode) | Deletes the model downloaded for local translation. |
| Future\<String\> | [asyncTranslate(String sourceText)](#asynctranslatestring-sourcetext) | Translates on device asynchronously. |
| Future\<String\> | [syncTranslate(String sourceText)](#synctranslatestring-sourcetext) | Translates on device synchronously. |
| Future\<bool\> | [stopTranslate()](#stoptranslate) | Stops the local translator. |

## Methods

### getLocalAllLanguages()

Obtains supported languages by local translation asynchronously.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list of supported languages. |

**Call Example**

```dart
MLLocalTranslator translator = new MLLocalTranslator();

List<dynamic> list = await translator.getLocalAllLanguages();
```

### syncGetLocalAllLanguages()

Obtains supported languages by local translation synchronously.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list of supported languages. |

**Call Example**

```dart
MLLocalTranslator translator = new MLLocalTranslator();

List<dynamic> list = await translator.syncGetLocalAllLanguages();
```

### prepareModel(MLTranslateSetting setting)

Prepares the local model for translation.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLTranslateSetting | Configurations for translation. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on successful model download, throws PlatformException otherwise. |

**Call Example**

```dart
MLTranslateSetting setting = new MLTranslateSetting();

setting.sourceLangCode = "es";
setting.targetLangCode = "en";

bool res = await translator.prepareModel(setting: setting);
```

### deleteModel(String langCode)

Deletes the model downloaded for local translation.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| langCode | String | Language code. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await translator.deleteModel("es");
```

### asyncTranslate(String sourceText)

Translates on device asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| sourceText | String | Source text. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns translation result on success, throws PlatformException otherwise. |

**Call Example**

```dart
String res = await translator.asyncTranslate(sourceText: "Cómo te sientes hoy");
```

### syncTranslate(String sourceText)

Translates on device synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| sourceText | String | Source text. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns translation result on success, throws PlatformException otherwise. |

**Call Example**

```dart
String res = await translator.syncTranslate(sourceText: "Cómo te sientes hoy");
```

### stopTranslate()

Stops on device translation.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await translator.stopTranslate();
```

# MLRemoteTranslator

Translates text on the cloud.

## Method Summary

| Return Type       | Method   | Description   |
| ----------------- | -------- | ------------- |
| Future\<List<dynamic\>\> | [getCloudAllLanguages()](#getcloudalllanguages) | Obtains supported languages by on cloud translation asynchronously. |
| Future\<List<dynamic\>\> | [syncGetCloudAllLanguages()](#syncgetcloudalllanguages) | Obtains supported languages by on cloud translation synchronously. |
| Future\<String\> | [asyncTranslate(MLTranslateSetting setting)](#asynctranslatemltranslatesetting-setting) | Translates on cloud asynchronously. |
| Future\<String\> | [syncTranslate(MLTranslateSetting setting)](#synctranslatemltranslatesetting-setting) | Translates on cloud synchronously. |
| Future\<bool\> | [stopTranslate()](#stop-translate) | Stops on cloud translation. |

## Methods

### getCloudAllLanguages()

Obtains supported languages by on cloud translation asynchronously.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list of supported languages. |

**Call Example**

```dart
MLRemoteTranslator translator = new MLRemoteTranslator();

List<dynamic> list = await translator.getCloudAllLanguages();
```

### syncGetCloudAllLanguages()

Obtains supported languages by on cloud translation synchronously.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list of supported languages. |

**Call Example**

```dart
MLRemoteTranslator translator = new MLRemoteTranslator();

List<dynamic> list = await translator.syncGetCloudAllLanguages();
```

### asyncTranslate(MLTranslateSetting setting)

Translates on cloud asynchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLTranslateSetting | Configurations for translation. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the translation result on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTranslateSetting setting = new MLTranslateSetting();

setting.sourceLangCode = "en";
setting.targetLangCode = "es";
setting.sourceTextOnRemote = "how are you feeling today";

String res = await translator.asyncTranslate(setting: setting);
```

### syncTranslate(MLTranslateSetting setting)

Translates on cloud synchronously.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| setting | MLTranslateSetting | Configurations for translation. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<String\> | Returns the translation result on success, throws PlatformException otherwise. |

**Call Example**

```dart
MLTranslateSetting setting = new MLTranslateSetting();

setting.sourceLangCode = "en";
setting.targetLangCode = "es";
setting.sourceTextOnRemote = "how are you feeling today";

String res = await translator.syncTranslate(setting: setting);
```

### <a name="stop-translate"></a> stopTranslate()

Stops on cloud translation.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
await translator.stopTranslate();
```

# MLTtsEngine

Provides the text to speech (TTS) service of ML Kit.

## Method Summary

| Return Type | Method   | Description   |
| ----------- | -------- | ------------- |
| Future\<bool\> | [init()](#init) | Initializes the tts engine. |
| Future\<List\<dynamic\>\> | [getLanguages()](#getlanguages) | Obtains the supported languages. |
| Future\<int\> | [isLanguageAvailable(String lang)](#islanguageavailablestring-lang) | Checks whether the language is available. |
| Future\<List\<MLTtsSpeaker\>\> | [getSpeaker(String language)](#getspeakerstring-language) | Obtaines speakers for a specific language. |
| Future\<List\<MLTtsSpeaker\>\> | [getSpeakers()](#getspeakers) | Obtains all speakers. |
| Future\<void\> | [speakOnCloud(MLTtsConfig config)](#speakoncloudmlttsconfig-config) | Starts speech on cloud. |
| Future\<void\> | [speakOnDevice(MLTtsConfig config)](#speakondevicemlttsconfig-config) | Starts speech on device. |
| Future\<bool\> | [pauseSpeech()](#pausespeech) | Pauses the speech. |
| Future\<bool\> | [resumeSpeech()](#resumespeech) | Resumes the speech. |
| Future\<bool\> | [stopTextToSpeech()](#stoptexttospeech) | Stops the speech. |
| Future\<bool\> | [shutdownTextToSpeech()](#shutdowntexttospeech) | Destroys the tts engine. |
| void | [setTtsCallback(TtsCallback callback)](#setttscallbackttscallback-callback) | Sets a listener for tts events. |

## Methods

### init()

Initializes the tts engine.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on a successful operation. |

**Call Example**

```dart
MLTtsEngine engine = new MLTtsEngine();

bool res = await engine.init();
```

### getLanguages()

Obtains the supported languages.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<dynamic\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<dynamic> list = await engine.getLanguages();
```

### isLanguageAvailable(String lang)

Checks whether the language is available.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await engine.isLanguageAvailable("en-US");
```

### getSpeaker(String language)

Obtains speakers for a specific language.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLTtsSpeaker\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<MLTtsSpeaker> list = await engine.getSpeaker("en-US");
```

### getSpeakers()

Obtains all speakers for text to speech recognition.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<List\<MLTtsSpeaker\>\> | Returns the list on success, throws PlatformException otherwise. |

**Call Example**

```dart
List<MLTtsSpeaker> list = await engine.getSpeakers();
```

### speakOnCloud(MLTtsConfig config)

Starts speech on cloud.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| config | MLTtsConfig | Configurations for text to speech recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
MLTtsConfig config = new MLTtsConfig();

config.text = text;
config.person = MLTtsConfig.TTS_SPEAKER_FEMALE_EN;
config.language = MLTtsConfig.TTS_EN_US;
config.synthesizeMode = MLTtsConfig.TTS_ONLINE_MODE;

await engine.speakOnCloud(config);
```

### speakOnDevice(MLTtsConfig config)

Starts speech on device.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| config | MLTtsConfig | Configurations for text to speech recognition. |

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<void\> | Future result of an execution that returns no value. |

**Call Example**

```dart
MLTtsConfig config = new MLTtsConfig();

config.text = text;
config.person = MLTtsConfig.TTS_SPEAKER_OFFLINE_EN_US_FEMALE_BOLT;
config.language = MLTtsConfig.TTS_EN_US;
config.synthesizeMode = MLTtsConfig.TTS_OFFLINE_MODE;

await engine.speakOnDevice(config);
```

### pauseSpeech()

Pauses the speech.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await engine.pauseSpeech();
```

### resumeSpeech()

Resumes the speech.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await engine.resumeSpeech();
```

### stopTextToSpeech()

Stops the speech.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await engine.stopTextToSpeech();
```

### shutdownTextToSpeech()

Destroys the tts engine.

**Return Type**

| Type | Description |
| ---- | ----------- |
| Future\<bool\> | Returns true on success, throws PlatformException otherwise. |

**Call Example**

```dart
bool res = await engine.shutdownTextToSpeech();
```

### setTtsCallback(TtsCallback callback)

Sets a listener for text to speech events.

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| callback | [TtsCallback](#ttscallback) | Listener for tts events. |

**Call Example**

```dart
engine.setTtsCallback((event, details, {errorCode}) {
    // Your implementation here
});
```

## Data Types

### TtsCallback

| Definition | Description |
| ---------- | ----------- |
| void TtsCallback(MLTtsEvent event, dynamic details, {int errorCode}) | Tts event listener. |

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| event | [MLTtsEvent](#mlttsevent) | Text to speech event. |
| details | dynamic | All event information. |
| errorCode | int | Error code on failure. |

### enum MLTtsEvent

Enumerated object that represents the events of audio file transcription.

| Value | Description  |
| ----- | ------------ |
| onError | Error event callback function. This method is used to listen to error events when an error occurs in an audio synthesis task. |
| onWarn | Alarm event callback function. |
| onRangeStart | The TTS engine splits the text input by the audio synthesis task. This callback function can be used to listen to the playback start event of the split text. |
| onAudioAvailable | Audio stream callback API, which is used to return the synthesized audio data to the app. |
| onEvent | Audio synthesis task callback extension method. |

# 4. Configuration Description

No.

# 5. Preparing For Release

Before building a release version of your app you may need to customize the <span>**proguard-rules</span>.pro** obfuscation configuration file to prevent the HMS Core SDK from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

**<flutter_project>/android/app/proguard-rules&#46;pro**

```
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.hms.flutter.** { *; }

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-repackageclasses
```

**<flutter_project>/android/app/build.gradle**

```gradle
buildTypes {
    debug {
        signingConfig signingConfigs.config
    }
    release {
        signingConfig signingConfigs.config
        // Enables code shrinking, obfuscation and optimization for release builds
        minifyEnabled true
        // Unused resources will be removed.
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
   }
}
```


# 6. Sample Project

This plugin includes a demo project in the [example](example) folder, there you can find more usage examples.

# 7. Questions or Issues

If you have questions about how to use HMS samples, try the following options:
- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with
**huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

# 8. Licensing and Terms

Huawei ML Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)