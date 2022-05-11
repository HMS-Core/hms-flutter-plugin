# Huawei Health Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Applying for the HUAWEI ID Service](#applying-for-the-huawei-id-service) 
    - [Applying for the HUAWEI Health Kit](#applying-for-the-health-kit) 
    - [Creating a Project in App Gallery Connect](#creating-a-project-in-appgallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating the Flutter Health Kit Plugin](#integrating-the-flutter-health-kit-plugin)
  - [3. API Reference](#3-api-reference)
    - [Modules](#modules)
    - [Option Classes](#option-classes)
    - [Data Classes](#data-classes)
    - [Result Classes](#result-classes)
    - [Constants](#plugin-constants)
  - [4. Configuration and Description](#4-configuration-and-description)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

HUAWEI Health Kit (Health Kit for short) allows ecosystem apps to access fitness and health data of users based on their HUAWEI ID and authorization. For consumers, Health Kit provides a mechanism for fitness and health data storage and sharing based on flexible authorization. For developers and partners, Health Kit provides a data platform and fitness and health open capabilities, so that they can build related apps and services based on a multitude of data types. Health Kit connects the hardware devices and ecosystem apps to provide consumers with health care, workout guidance, and ultimate service experience.

## 2. Installation Guide

Before you get started, you must register as a HUAWEI Developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).
 
### Creating a Project in AppGallery Connect
Creating an app in the AppGallery Connect is required in order to communicate with the Huawei services. To create an app, perform the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)  and select **My projects**.

**Step 2.** Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 4.** On the **Add app** page, enter the app information, and click **OK**.

### Configuring the Signing Certificate Fingerprint

A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in the **AppGallery Connect**. You can refer to 3rd and 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Setting** > **General information**. In the **App information** field, click the add icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA-256 certificate fingerprint**.

**Step 2:**  After completing the configuration, click **OK** (Check mark icon) to save the changes.

### Applying for the HUAWEI ID Service

HUAWEI Health Kit uses the HUAWEI ID Service in order the obtain the Health Kit permissions from the user. Head over to [Huawei Developer Console](https://developer.huawei.com/consumer/en/console) and select the HUAWEI ID service from **App Services** under the **Development Section**. Click Apply for HUAWEI ID, agree to the agreement, and fill the information about your application for the required fields on the opened page. For details please visit [Applying for the HUAWEI ID Service](https://developer.huawei.com/consumer/en/doc/apply-id-0000001050069756-V5). 

> Note If the HUAWEI ID card can't be found, click Customize console in the upper right corner to add it.
### Applying for the Health Kit

In order to successfully activate the Health Kit Service for your application you need to complete the steps in the [Applying for Health Kit](https://developer.huawei.com/consumer/en/doc/apply-kitservice-0000001050071707-V5) document. After the Health Kit Service is authorized and enabled for your application on the [Huawei Developer Console](https://developer.huawei.com/consumer/en/console) you can continue with the integration process.
### Integrating the Flutter Health Kit Plugin

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects** then navigate to **Project Setting > General information** page, under the **App information** field, click **agconnect-services.json** to download the configuration file.

**Step 2:** Copy the **agconnect-services.json** file to the **android/app** directory of your project.

**Step 3:** Open the **build.gradle** file in the **android** directory of your project.

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

**Step 5:** Open the **build.gradle** file in the **android/app/** directory.

- Add `apply plugin: 'com.huawei.agconnect'` line after other `apply` entries.
  ```gradle
  apply plugin: 'com.android.application'
  apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
  apply plugin: 'com.huawei.agconnect'
  ```

- Set your package name in **defaultConfig > applicationId** and set **minSdkVersion** to **21** or higher. Package name must match with the **package_name** entry in the **agconnect-services.json** file. 

  ```gradle
  defaultConfig {
      applicationId "<package_name>"
      minSdkVersion 21
      /*
      * <Other configurations>
      */
  }
  ```

**Step 6:** Create a file **<app_dir>/android/key.properties** that contains a reference to your **keystore** which you generated on the previous step ([Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2)). Add the following lines to the **key.properties** file and change the values regarding to the **keystore** you've generated.  

```
storePassword=<your_keystore_password>
keyPassword=<your_key_password>
keyAlias=<your_key_alias>
storeFile=<location of the keystore file, for example: D:\\Users\\<user_name>\\key.jks>
```
> Warning: Keep this file private and don't include it on the public source control.

**Step 7:** Add the following code to the first line of **android/app/build.gradle** for reading the **key.properties** file:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

**Step 8:**  Edit **buildTypes** as follows and add the **signingConfigs** below:

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

**Step 9:** On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_health** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

  - To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

    ```yaml
      dependencies:
        huawei_health: {library version}
    ```

    **or**

    If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

    ```yaml
      dependencies:
        huawei_health:
            # Replace {library path} with actual library path of Huawei Health Kit Plugin for Flutter.
            path: {library path}
    ```

    - Replace {library path} with the actual library path of the Flutter Health Kit Plugin. The following are examples:
      - Relative path example: `path: ../huawei_health`
      - Absolute path example: `path: D:\Projects\Libraries\huawei_health`

**Step 10:** Run the following command to update the package info.

```
[project_path]> flutter pub get
```

**Step 11:** Import the library to access the methods.

```dart
import 'package:huawei_health/huawei_health.dart';
```

**Step 12:** Run the following command to start the app.

```
[project_path]> flutter run
```

---

## 3. API Reference
### Overview
Detailed information about modules, classes and constants provided by this plugin is explained in this section. The summary is described in the table below.

| Name | Description | 
| ---- | ----------- |
| [Modules](#modules) | Function classes that provide interaction with the HUAWEI Health Kit SDK methods. |
| [Option Classes](#option-classes) | Request object classes for CRUD operations. |
| [Data Classes](#data-classes) | Dataset classes for interacting with the data provided by Health Kit. |
| [Result Classes](#result-classes) | Result classes for utilizing the Health Kit API results. |
| [Constants](#plugin-constants) | Constants provided by the plugin. |

### Modules
Huawei Health Kit Plugin for Flutter provides a set of function classes as described in the table below.

| Name | Description | 
| ---- | ----------- |
| [HealthAuth](#healthauth) | Provides sign in method for obtaining the Health Kit Authorization from the user. |
| [ActivityRecordsController](#activityrecordscontroller) | Provides methods to create and manage user activity records. |
| [AutoRecorderController](#autorecordercontroller) | Provides real-time data reading functions. |
| [DataController](#datacontroller) | Provides methods to add, delete, modify, and query the platform data. |
| [SettingController](#settingscontroller) | Provides setting related functions. |
| [ConsentsController](#consentscontroller) | Provides authorization management APIs that can be used to view and revoke the granted permissions.|
| [HMSLogger](#hmslogger) | Enable/Disable functions for the HMSLogger.|

### HealthAuth

Provides signIn method for obtaining the Health Kit Authorization from the user.
#### Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [signIn](#futureauthhuaweiid-signinlistscope-scopes-async) | Future\<[AuthHuaweiId](#authhuaweiid)> | Obtains the Health Kit permissions from the user by the defined List of [Scope](#scope)s.|
#### Methods
##### Future\<AuthHuaweiId> signIn(List\<Scope> scopes) *async*
Obtains the Health Kit permissions from the user by the defined List of [Scope](#scope)s.
The scopes that are asked to the user for authorization should already be authorized for the app on Huawei Developer Console. Please see the [Applying for the Health Kit](#applying-for-the-health-kit) section.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| scopes  | List\<[Scope](#scope)>  | List of Scopes to ask for authorization from the user. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<AuthHuaweiId>   | [AuthHuaweiId](#authhuaweiid) object that contains the information about the user and granted Health Kit permissions. |

###### Call Example

```dart
    // List of scopes to ask for authorization.
    //
    // Note: These scopes should also be authorized on the Huawei Developer Console.
    List<Scope> scopes = [
      Scope.HEALTHKIT_HEIGHTWEIGHT_READ,
      Scope.HEALTHKIT_HEIGHTWEIGHT_WRITE,
      Scope.HEALTHKIT_ACTIVITY_WRITE,
      Scope.HEALTHKIT_ACTIVITY_READ,
      Scope.HEALTHKIT_ACTIVITY_RECORD_WRITE,
      Scope.HEALTHKIT_ACTIVITY_RECORD_READ,
      Scope.HEALTHKIT_STEP_WRITE,
      Scope.HEALTHKIT_STEP_READ,
      Scope.HEALTHKIT_STEP_REALTIME,
      Scope.HEALTHKIT_CALORIES_READ,
      Scope.HEALTHKIT_CALORIES_WRITE
    ];
    
    AuthHuaweiId result = await HealthAuth.signIn(scopes);
```

### ActivityRecordsController

Provides functions to create and manage user activities.

#### Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [addActivityRecord](#futurestring-addactivityrecordactivityrecordinsertoptions-activityrecordinsertoptions-async)     | Future\<String>                | Inserts a specified activity record and corresponding data to the HUAWEI Health platform. |
| [getActivityRecord](#futurelistactivityrecord-getactivityrecordactivityrecordreadoptions-activityrecordreadoptions-async)     | Future\<List\<ActivityRecord>> | Reads [ActivityRecord](#activityrecord) data from the HUAWEI Health platform.                           |
| [beginActivityRecord](#futurevoid-beginactivityrecordactivityrecord-activityrecord-async)   | Future\<void>                  | Starts a new [ActivityRecord](#activityrecord) for the current app.|
| [endActivityRecord](#futurelistactivityrecord-endactivityrecordstring-activityrecordid-async)| Future\<List\<ActivityRecord>> | Stops the [ActivityRecord](#activityrecord) of a specific ID.|
| [endAllActivityRecords](#futurelistactivityrecord-endallactivityrecords-async) | Future\<List\<ActivityRecord>> | Stops all the ongoing [ActivityRecord](#activityrecord)s.|

#### Methods

##### Future\<String> addActivityRecord(ActivityRecordInsertOptions activityRecordInsertOptions) *async*

Inserts a specified activity record and corresponding data to the HUAWEI Health platform.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| activityRecordInsertOptions | [ActivityRecordInsertOptions](#activityrecordinsertoptions) |Request parameter class for inserting an activity record, including the associated sampling dataset and sampling points to the platform.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<String> | Result message. |

###### Call Example

```dart
// Create start time that will be used to add activity record.
DateTime startTime = DateTime.now();

// Create end time that will be used to add activity record.
DateTime endTime = DateTime.now().add(Duration(hours: 2));

// Build an ActivityRecord object
ActivityRecord activityRecord = ActivityRecord(
  startTime: startTime,
  endTime: endTime,
  id: 'ActivityRecordRun1',
  name: 'BeginActivityRecordSteps',
  description: 'This is a test for ActivityRecord',
);
// Build the dataCollector object
DataCollector dataCollector = DataCollector(
dataGenerateType: DataGenerateType.DATA_TYPE_RAW,
  dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
  name: 'AddActivityRecord1');

// You can use sampleSets to add more sample points to the sampling dataset.
// Build a list of sampling point objects and add it to the sampling dataSet
List<SamplePoint> samplePoints = [
  SamplePoint(
    startTime: startTime,
    endTime: endTime,
    fieldValueOptions: FieldInt(Field.FIELD_STEPS_DELTA, 1024),
    timeUnit: TimeUnit.MILLISECONDS)
  ];
SampleSet sampleSet = SampleSet(dataCollector, samplePoints);

String result = await ActivityRecordsController.addActivityRecord(
  ActivityRecordInsertOptions(
    activityRecord: activityRecord, sampleSets: [sampleSet]),
  );
```

##### Future\<List\<ActivityRecord>> getActivityRecord(ActivityRecordReadOptions activityRecordReadOptions) *async*

Reads [ActivityRecord](#activityrecord) data from the HUAWEI Health platform.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| activityRecordReadOptions | [ActivityRecordReadOptions](#activityrecordreadoptions) | Defines the activity record read options for an ActivityRecord read process.|

###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<List\<ActivityRecord>> | Obtained ActivityRecord objects |

###### Call Example

```dart
// Create start time that will be used to read activity record.
DateTime startTime = DateTime.now().subtract(Duration(days: 1));

// Create end time that will be used to read activity record.
DateTime endTime = DateTime.now().add(Duration(hours: 3));

ActivityRecordReadOptions activityRecordReadOptions =
  ActivityRecordReadOptions(
    startTime: startTime,
    endTime: endTime,
    timeUnit: TimeUnit.MILLISECONDS,
    dataType: DataType.DT_CONTINUOUS_STEPS_DELTA);

List<ActivityRecord> result =
  await ActivityRecordsController.getActivityRecord(activityRecordReadOptions);
```

##### Future\<void> beginActivityRecord(ActivityRecord activityRecord) *async*
Starts a new activity record for the current app.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| activityRecord | [ActivityRecord](#activityrecord) | ActivityRecord object to be started. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example
```dart
// Build an ActivityRecord object
ActivityRecord activityRecord = ActivityRecord(
  id: 'ActivityRecordRun0',
  name: 'BeginActivityRecord',
  description: 'This is ActivityRecord begin test!',
  activityTypeId: HiHealthActivities.running,
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  );
await ActivityRecordsController.beginActivityRecord(activityRecord);
```

##### Future\<List\<ActivityRecord>> endActivityRecord(String activityRecordId) *async*
Stops the [ActivityRecord](#activityrecord) with the specified id.

###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| activityRecordId | String | Id of the ActivityRecord to be stopped. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<List\<ActivityRecord>> | List of ActivityRecord objects that stopped. |

###### Call Example

```dart
List<ActivityRecord> result =
  await ActivityRecordsController.endActivityRecord(
    'ActivityRecordRun0');
```

##### Future\<List\<ActivityRecord>> endAllActivityRecords() *async*
Ends all the ongoing activity records.
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<List\<ActivityRecord>> | List of ActivityRecord objects that stopped. |

###### Call Example

```dart
// Return the list of activity records that have stopped
List<ActivityRecord> result =
  await ActivityRecordsController.endAllActivityRecords();
```

### AutoRecorderController

Provides the capabilities to read data in real time and cancel the reading.

> **Note:** AutoRecorderController supports real-time data reading only for DataType.DT_CONTINUOUS_STEPS_TOTAL.

#### Method Summary

| Method                | Return Type                    | Description                                                                               |
| --------------------- | ------------------------------ | ----------------------------------------------------------------------------------------- |
| [startRecord](#futurevoid-startrecorddatatype-datatype-notificationproperties-notificationproperties-async) | Future\<void> | Starts real-time data reading by specifying the data type.|
| [stopRecord](#futurevoid-stoprecorddatatype-datatype-async) | Future\<void> |Stops the ongoing AutoRecorder service.|
| [autoRecorderStream](#streamsamplepoint-get-autorecorderstream) | Stream\<SamplePoint> | Stream that emits [SamplePoints](#samplepoint) objects after startRecord is activated.|

#### Methods

##### Future\<void> startRecord(DataType dataType, NotificationProperties notificationProperties) *async*
Starts real-time data reading by specifying the data type.

This method will trigger a foreground service that has an ongoing(sticky) notification. The notification properties can be customized by specifying a NotificationProperties instance. The [SamplePoint](#samplepoint) results that include the count of steps are emitted to the [autoRecorderStream](#streamsamplepoint-get-autorecorderstream).

If there is an ongoing AutoRecorder service present, an exception will be thrown.

###### Parameters

| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| dataType  | [DataType](#datatype)  | Data type specified for starting the real-time data reading. |
| notificationProperties  | NotificationProperties  | The customization properties for the ongoing notification. Including but not limited to notification title, text, subtext. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example

```dart
await AutoRecorderController.startRecord(
  DataType.DT_CONTINUOUS_STEPS_TOTAL,
    NotificationProperties(
      title: "HMS Flutter Health Demo",
      text: "Counting steps",
      subText: "this is a subtext",
      showChronometer: true),
);
```

##### Future\<void> stopRecord(DataType dataType) *async*
Stops the ongoing AutoRecorder service. If there is no ongoing AutoRecorder service this method will throw an exception.

###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| dataType  | [DataType](#datatype)  | Data type specified for stopping the real-time data reading. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example

```dart
await AutoRecorderController.stopRecord(
  DataType.DT_CONTINUOUS_STEPS_TOTAL);
```

##### Stream\<SamplePoint> *get* autoRecorderStream
Stream that emits [SamplePoint](#samplepoint) objects after [startRecord](#futurevoid-startrecorddatatype-datatype-notificationproperties-notificationproperties-async) is activated.
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Stream\<SamplePoint> | Listenable stream that emits SamplePoint objects. |

###### Call Example

```dart
AutoRecorderController.autoRecorderStream.listen(_onAutoRecorderEvent);

void _onAutoRecorderEvent(SamplePoint res) {
  // Obtain the step values
  Map<String, dynamic> = res.fieldValues;
}
```

### DataController
Determines the API for data management. The user can use this API to insert, delete, update, and read data, as well as query the data statistics of the current day and past days.
#### Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [init](#futuredatacontroller-initlisthihealthoption-hihealthoptions-async) | Future\<[DataController](#datacontroller)> | Initializes a DataController instance by a list of [HiHealthOption](#hihealthoption) objects that define data types and read/write permissions.|
| [clearAll](#futurevoid-clearall-async) | Future\<void>| Clears all data inserted by the app from the device and the cloud.|
| [delete](#futurevoid-deletedeleteoptions-options-async)   | Future\<void>| Deletes inserted sampling datasets by specifying a time range or deletes them all. It can also be used to delete workout records.|
| [insert](#futurevoid-insertsampleset-sampleset-async)   | Future\<void> | Inserts a sampling dataset into the Health platform.|
| [read](#futurereadreply-readreadoptions-readoptions-async)     | Future\<[ReadReply](#readreply)>| Reads user data. |
| [readTodaySummation](#futuresampleset-readtodaysummationdatatype-datatype-async) | Future\<[SampleSet](#sampleset)> | Reads the summary data of a specified data type of the current day.|
| [readDailySummation](#futuresampleset-readdailysummationdatatype-datatype-int-starttime-int-endtime-async) | Future\<[SampleSet](#sampleset)> | Reads the daily statistics of a specified data type.|
| [update](#futurevoid-updateupdateoptions-options-async)   | Future\<void>| Updates existing data. |


#### Methods

##### Future\<DataController> init(List\<HiHealthOption> hiHealthOptions) *async*
Initializes a DataController instance by a list of [HiHealthOption](#hihealthoption) objects that define data types and read/write permissions.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| hiHealthOptions | List\<HiHealthOption>  | List of HiHealthOption objects for specifying data types and permissions regarding those data types. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<DataController> | a DataController instance. |

###### Call Example

```dart
DataController dataController = await DataController.init(<HiHealthOption>[
  HiHealthOption(DataType.DT_CONTINUOUS_STEPS_DELTA, AccessType.read),
  HiHealthOption(DataType.DT_CONTINUOUS_STEPS_DELTA, AccessType.write),
]);
```

##### Future\<void> clearAll() *async*
Clears all data inserted by the app from the device and the cloud.
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example

```dart
await dataController.clearAll();
```

##### Future\<void> delete(DeleteOptions options) *async*
Deletes inserted sampling datasets by specifying a time range or deletes them all. It can also be used to delete workout records.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| options   | [DeleteOptions](#deleteoptions) | DeleteOptions object, used to specify the data collector, data type, and time range of data to be deleted.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example

```dart
// Build the dataCollector object
DataCollector dataCollector = DataCollector(
  dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
  dataGenerateType: DataGenerateType.DATA_TYPE_RAW,
  dataStreamName: 'my_data_stream');

// Build the time range for the deletion: start time and end time.
DeleteOptions deleteOptions = DeleteOptions(
  dataCollectors: <DataCollector>[dataCollector],
  startTime: DateTime.parse('2020-10-10 08:00:00'),
  endTime: DateTime.parse('2020-10-10 12:30:00'));

// Call the method with the constructed DeleteOptions instance.
dataController.delete(deleteOptions);
```

##### Future\<void> insert(SampleSet sampleSet) *async*
Inserts a sampling dataset into the Health platform.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| sampleSet | [SampleSet](#sampleset) | Sampling dataset to be inserted to the HUAWEI Health platform. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example

```dart
// Build the dataCollector object
DataCollector dataCollector = DataCollector(
  dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
  dataStreamName: 'my_data_stream',
  dataGenerateType: DataGenerateType.DATA_TYPE_RAW);

// You can use sampleSets to add more sampling points to the sampling dataset.
SampleSet sampleSet = SampleSet(dataCollector, <SamplePoint>[
  SamplePoint(
    startTime: DateTime.parse('2020-10-10 12:00:00'),
    endTime: DateTime.parse('2020-10-10 12:12:00'),
    fieldValueOptions: FieldInt(Field.FIELD_STEPS_DELTA, 100))
]);

// Call the method with the constructed sample set.
dataController.insert(sampleSet);
```

##### Future\<ReadReply> read(ReadOptions readOptions) *async*
Reads user data. You can read data by time, device, data collector, and more by specifying the related parameters in ReadOptions.
###### Parameters
| Parameter   | Type        | Description |
| ----------- | ----------- | ----------- |
| readOptions | [ReadOptions](#readoptions) | ReadOptions object, for specifying parameters in the data reading request. It is used to specify the data collector, data type, the time range for the requested data, and more. |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<[ReadReply](#readreply)>   | Read data. The start time or end time of the returned data points is within the specified time range. |

###### Call Example

```dart
// Build the dataCollector object
DataCollector dataCollector = DataCollector(
  dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
  dataGenerateType: DataGenerateType.DATA_TYPE_RAW,
  dataStreamName: 'my_data_stream');

// Build the time range for the query: start time and end time.
ReadOptions readOptions = ReadOptions(
  dataCollectors: [dataCollector],
  startTime: DateTime.parse('2020-10-10 12:00:00'),
  endTime: DateTime.parse('2020-10-10 12:12:00'),
)..groupByTime(10000);

// Call the method with the constructed ReadOptions instance.
ReadReply readReply = await dataController.read(readOptions);
```

##### Future\<SampleSet> readTodaySummation(DataType dataType) *async*
Reads the summary data of a specified data type of the current day. If the related data type does not support aggregation statistics, an exception will be thrown.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| dataType  | [DataType](#datatype) | Data type to be read.Currently, only the following data types are supported: <br  /> **Calories:** DataType.DT_CONTINUOUS_CALORIES_BURNT <br  /> **Distance:** DataType.DT_CONTINUOUS_DISTANCE_DELTA <br  /> **Heart rate:** DataType.DT_INSTANTANEOUS_HEART_RATE <br  /> **Incremental step count:** DataType.DT_CONTINUOUS_STEPS_DELTA <br  />  **Weight:** DataType.DT_INSTANTANEOUS_BODY_WEIGHT <br  />  **Sleep:** DataType.DT_CONTINUOUS_SLEEP <br  /> **Stress:** DataType.DT_INSTANTANEOUS_STRESS |
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<[SampleSet](#sampleset)>  | The statistical value of the data type. Calculation will be performed on all the queried data points with the start time or end time being in the specified time range, and the statistical results will be returned. |

###### Call Example

```dart
SampleSet sampleSet = await _dataController
  .readTodaySummation(DataType.DT_CONTINUOUS_STEPS_DELTA);
```

##### Future\<SampleSet> readDailySummation(DataType dataType, int startTime, int endTime) *async*
Reads the daily statistics of a specified data type. You can set the data type, start time, and end time to read the daily statistics in the specified period. If the related data type does not support aggregation statistics, an exception will be thrown.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| dataType  | [DataType](#datatype)  | Data type to be read. Currently, only the following data types are supported:<br  /> **Calories:** DataType.DT_CONTINUOUS_CALORIES_BURNT <br  /> **Distance:** DataType.DT_CONTINUOUS_DISTANCE_DELTA <br  /> **Heart rate:** DataType.DT_INSTANTANEOUS_HEART_RATE <br  /> **Incremental step count:** DataType.DT_CONTINUOUS_STEPS_DELTA <br  /> **Weight:** DataType.DT_INSTANTANEOUS_BODY_WEIGHT <br  /> **Sleep:** DataType.DT_CONTINUOUS_SLEEP <br  /> **Stress:** DataType.DT_INSTANTANEOUS_STRESS|
| startTime | int       | An 8-digit integer in the format of YYYYMMDD, for example, `20200803`.|
| endTime   | int       | An 8-digit integer in the format of YYYYMMDD, for example, `20200903`.|

###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<[SampleSet](#sampleset)>   | All data points with the start time or end time being in the specified time range will be queried. The sum value of the queried data points will be returned. Different from the readTodaySummation method, the readDailySummation method can be used to query the data of multiple days, with a statistical value provided for each day. |

###### Call Example

```dart
SampleSet sampleSet = await dataController.readDailySummation(
  DataType.DT_CONTINUOUS_STEPS_DELTA, 20201002, 20201215);
```
##### Future\<void> update(UpdateOptions options) *async*
Updates existing data. If the update target does not exist, a new entry of data will be inserted.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| options   | [UpdateOptions](#updateoptions) | UpdateOptions object, used to specify the time range of the data to be updated and the updated values.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example

```dart
// Build the dataCollector object
DataCollector dataCollector = DataCollector(
  dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
  dataStreamName: 'my_data_stream_name',
  dataGenerateType: DataGenerateType.DATA_TYPE_RAW);

// You can use sampleSets to add more sampling points to the sampling dataset.
SampleSet sampleSet = SampleSet(dataCollector, <SamplePoint>[
  SamplePoint(
    startTime: DateTime.parse('2020-12-12 09:00:00'),
    endTime: DateTime.parse('2020-12-12 09:05:00'),
    fieldValueOptions: FieldInt(Field.FIELD_STEPS_DELTA, 120))
  ]);

// Build a parameter object for the update.
// Note: (1) The start time of the modified object updateOptions can not be greater than the minimum
// value of the start time of all sample data points in the modified data sample set
// (2) The end time of the modified object updateOptions can not be less than the maximum value of the
// end time of all sample data points in the modified data sample set
UpdateOptions updateOptions = UpdateOptions(
  startTime: DateTime.parse('2020-12-12 08:00:00'),
  endTime: DateTime.parse('2020-12-12 09:25:00'),
  sampleSet: sampleSet);

await _dataController.update(updateOptions);
```

### SettingsController
Provides the setting-related functions.
#### Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [addDataType](#futuredatatype-adddatatypedatatypeaddoptions-options-async) | Future\<[DataType](#datatype)> | Creates and adds a customized data type.|
| [readDataType](#futuredatatype-readdatatypestring-datatypename-async) | Future\<[DataType](#datatype)> | Reads the data type based on the data type name.|
| [disableHiHealth](#futurevoid-disablehihealth-async) | Future\<void> | Disables the Health Kit function, cancels user authorization, and cancels all data records. (The task takes effect in 24 hours.)|
| [checkHealthAppAuthorization](#futurevoid-checkhealthappauthorization-async) | Future\<void> | Checks the user privacy authorization to Health Kit. If the authorization has not been granted, the user will be redirected to the authorization screen where they can authorize the Huawei Health app to open data to Health Kit.|
| [getHealthAppAuthorization](#futurebool-gethealthappauthorization-async) | Future\<bool> | Checks the user privacy authorization to Health Kit.|
#### Methods

##### Future\<DataType> addDataType(DataTypeAddOptions options) *async*
Creates and adds a customized data type. The name of the created data type must be prefixed with the package name of the app Otherwise, the creation fails. The same data type can't be added more than once otherwise an exception will be thrown.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| options   | [DataTypeAddOptions](#datatypeaddoptions) | Request options for creating the data type.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<DataType> | Created data type. |

###### Call Example
```dart
DataTypeAddOptions options = DataTypeAddOptions(
  "com.huawei.hms.flutter.health_example.myCustomDataType",
  [Field.newIntField("myIntField"), Field.FIELD_ALTITUDE]);
final DataType dataTypeResult =
  await SettingController.addDataType(options);
```
##### Future\<DataType> readDataType(String dataTypeName) *async*
Reads the data type based on the data type name.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| dataTypeName | String | Name of the custom data type to read.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<DataType> | Obtained data type. |

###### Call Example
```dart
final DataType dataTypeResult = await SettingController.readDataType(
  "com.huawei.hms.flutter.health_example.myCustomDataType",
);
```
##### Future\<void> disableHiHealth() *async*
Disables the Health Kit function, cancels user authorization, and cancels all data records. 
> Note: The task takes effect in 24 hours.
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example
```dart
await SettingController.disableHiHealth();
```

##### Future\<void> checkHealthAppAuthorization() *async*
Checks the user privacy authorization to Health Kit. If the authorization has not been granted, the user will be redirected to the authorization screen where they can authorize the Huawei Health app to open data to Health Kit.
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<void>   | Future result of an execution that returns no value. |

###### Call Example
```dart
await SettingController.checkHealthAppAuthorization();
```

##### Future\<bool> getHealthAppAuthorization() *async*
Checks the user privacy authorization to Health Kit.
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<bool>   | Whether the user privacy authorization has been granted to Health Kit. Returns `true` if Authorized, `false` otherwise. |

###### Call Example
```dart
bool result = await SettingController.getHealthAppAuthorization();
```

### ConsentsController
Provides authorization management APIs that can be used to view and revoke the granted permissions.
#### Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [getAppId](#futurestring-getappid-async) | Future\<String>| Obtains the application id from the agconnect-services.json file.|
| [getScopes](#futurescopelangitem-getscopesstring-lang-string-appid-async)| Future\<ScopeLangItem>| Queries the list of permissions granted to your app.|
| [revoke](#futurevoid-revokestring-appid-async)| Future\<void>| Revokes all permissions granted to your app.|
| [revokeWithScopes](#futurevoid-revokewithscopesstring-appid-listscope-scopes-async)| Future\<void>| Revokes certain Health Kit related permissions granted to your app.|

#### Methods
##### Future\<String> getAppId() *async*
Obtains the application id from the agconnect-services.json file.

###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<String> | Application ID. |
###### Call Example
```dart
final String appId = await ConsentsController.getAppId();
```
##### Future\<ScopeLangItem> getScopes(String lang, String appId) *async*
Queries the list of permissions granted to your app.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| lang | String | Language code. If the specified value is invalid, en-us will be used.|
| appId | String | ID of your app.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
| Future\<[ScopeLangItem](#scopelangitem)> | List of permissions that have been granted to your app.|

###### Call Example
```dart
final String appId = await ConsentsController.getAppId();
ScopeLangItem scopeLangItem =
  await ConsentsController.getScopes('en-gb', appId);
```
##### Future\<void> revoke(String appId) *async*
Revokes all permissions granted to your app.
###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| appId | String | ID of your app.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
|Future\<void>|Future result of an execution that returns no value.|

###### Call Example
```dart
final String appId = await ConsentsController.getAppId();
await ConsentsController.revoke(appId);
```
##### Future\<void> revokeWithScopes(String appId, List\<Scope> scopes) *async*
Revokes certain Health Kit related permissions granted to your app.

###### Parameters
| Parameter | Type      | Description |
| --------- | --------- | ----------- |
| appId | String | ID of your app.|
| scopes | List\<Scope> | Scopes to be revoked.|
###### Return Type
| Type            | Description |
| --------------- | ----------- |
|Future\<void>|Future result of an execution that returns no value.|

###### Call Example
```dart
final String appId = await ConsentsController.getAppId();
await ConsentsController.revokeWithScopes(appId, [
  Scope.HEALTHKIT_DISTANCE_WRITE,
  Scope.HEALTHKIT_DISTANCE_READ,
]);
```
### HMSLogger
HMSLogger is used for sending usage analytics of Health Kit SDK's methods to improve the service quality.

> HMSLogger service is enabled by default.
#### Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [enableLogger](#futurevoid-enablelogger-async) | Future\<void>| Enables HMSLogger service.|
| [disableLogger](#futurevoid-disablelogger-async) |Future\<void>| Disables HMSLogger service.|
#### Methods
##### Future\<void> enableLogger() *async*

Enables HMS Plugin Method Analytics which is used for sending usage analytics of Health Kit SDK's methods to improve the service quality.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
await HMSLogger.enableLogger();
```

##### Future\<void> disableLogger() *async*
Disables HMS Plugin Method Analytics which is used for sending usage analytics of Health Kit SDK's methods to improve the service quality.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void> |Future result of an execution that returns no value.|

###### Call Example
```dart
await HMSLogger.disableLogger();
```

### Option Classes
Request object classes for CRUD operations. The summary of classes is described in the table below.

| Name | Description | 
| ---- | ----------- |
| [ActivityRecordInsertOptions](#activityrecordinsertoptions) | Request parameter class for inserting an activity record, including the associated sampling dataset and sampling points to the platform. |
| [ActivityRecordReadOptions](#activityrecordreadoptions) | Defines the activity record read options for an [ActivityRecord](#activityrecord) read process |
| [DataTypeAddOptions](#datatypeaddoptions) | Defines the options for adding a customized data type to Health Kit. |
| [DeleteOptions](#deleteoptions) | Defines the delete options for an [ActivityRecord](#activityrecord) delete process. |
| [ReadOptions](#readoptions) |Request class for reading data. |
| [UpdateOptions](#updateoptions) | Request parameter class for updating data. |
| [HiHealthOption](#hihealthoption) | Defines the request permissions. |

### ActivityRecordInsertOptions
Request parameter class for inserting an activity record, including the associated sampling dataset and sampling points to the platform.
#### Properties
| Name           | Type        | Description |
|----------------|-------------|-------------|
| activityRecord | [ActivityRecord](#activityrecord) | ActivityRecord to be inserted. |   
| sampleSets     | List\<[SampleSet](#sampleset)> | Sampling datasets for the request. |   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[ActivityRecordInsertOptions({ActivityRecord activityRecord, List\<SampleSet> sampleSets})](#activity-rec-insert-opt-constructor)| Default constructor. |   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#mapstring-dynamic-tomap)    | Map\<String, dynamic>     | Returns a map representation of the object.|   
| [toString](#string-tostring) |   String   | Returns a string representation of the object. |   
| [==(equals operator)](#bool-object-other) |   bool   | Checks whether two ActivityRecordInsertOptions objects are the same.|   
| [hashCode](#int-get-hashcode)  |   int   | Returns the hash code of the current object. |   
#### Constructors
##### <a name="activity-rec-insert-opt-constructor"></a> ActivityRecordInsertOptions({ActivityRecord activityRecord, List\<SampleSets> sampleSets})
Default constructor.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
| activityRecord | [ActivityRecord](#activityrecord) | ActivityRecord to be inserted. |   
| sampleSets     | List\<[SampleSets](#sampleset)> | Sampling datasets for the request. | 
#### Methods
##### Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### bool ==(Object other)
Checks whether two ActivityRecordInsertOptions objects are the same.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  other      |  Object     |  Object to compare.   |   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### ActivityRecordReadOptions
Defines the activity record read options for an [ActivityRecord](#activityrecord) read process.
#### <a name="act-read-opt-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|activityRecordId | String | ID of the activity record to be read.|   
|activityRecordName | String | Name of the activity record to be read. |   
|startTime | DateTime | Start time.|   
|endTime   | DateTime | End time.  |   
|timeUnit  | [TimeUnit](#enum-timeunit) | Time unit. |   
|dataType  | [DataType](#datatype) | DataType of the ActivityRecord to be read. |   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [ActivityRecordReadOptions({String activityRecordId, String activityRecordName, DateTime startTime, DateTime endTime, TimeUnit timeUnit, DataType dataType})](#act-read-opt-constructor) | Default constructor.|
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#act-read-opt-toMap)       | Map\<String, dynamic> | Returns a map representation of the object. |

#### Constructors
<a name="act-read-opt-constructor"></a> 
<details>
  <summary>ActivityRecordsReadOptions</summary>

##### ActivityRecordReadOptions({String activityRecordId, String activityRecordName, DateTime startTime, DateTime endTime, TimeUnit timeUnit, DataType dataType})
</details>

Default constructor.
###### Parameters
The same fields apply as in the [properties](#act-read-opt-props) table.   
#### Methods
##### <a name="act-read-opt-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |

### DataTypeAddOptions
Defines the options for adding a customized data type to Health Kit.
#### <a name="data-type-add-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
| name   | String | Name of the DataType. It Must be prefixed with the package name.|   
| fields | List\<Field> | [Field](#field) to be added to DataType.|   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [DataTypeAddOptions(String name, List\<Field> fields)](#data-type-add-constructor) | Default constructor.|   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#data-type-add-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#data-type-add-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#data-type-add-equals) | bool | Checks whether two DataTypeAddOptions objects are the same.|   
| [hashCode](#data-type-add-hashCode)  | int | Returns the hash code of the current object.|
#### Constructors
##### <a name="data-type-add-constructor"></a> DataTypeAddOptions(String name, List\<Field> fields)
Default Constructor.
###### Parameters
The same fields apply as in the [properties](#data-type-add-props) table.
#### Methods
##### <a name="data-type-add-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="data-type-add-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="data-type-add-equals"></a> bool ==(Object other)
Checks whether two DataTypeAddOptions objects are the same.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  other      |  Object     |  Object to compare.   |   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="data-type-add-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### DeleteOptions
Defines the delete options for an [ActivityRecord](#activityrecord) delete process.

#### <a name="delete-opt-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|deleteAllData| bool | Should be set to `true` if all the data types are marked for deletion.   |   
|deleteAllActivityRecords | bool | Should be set to `true` if all the activity records are marked for deletion.|   
|activityRecords | List\<[ActivityRecord](#activityrecord)> | List of activity records to be deleted. |   
|dataCollectors   | List\<[DataCollector](#datacollector)> | List of data collectors whose data is to be deleted. |   
|dataTypes   | List\<[DataType](#datatype)> | List of data types whose data is to be deleted. |
|startTime | DateTime | Start time for data to be deleted. |   
|endTime | DateTime | End time for data to be deleted. |   
|timeUnit   | [TimeUnit](#enum-timeunit) | TimeUnit for data to be deleted. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [DeleteOptions({DateTime startTime, DateTime endTime, List\<DataType> dataTypes, List\<DataCollector> dataCollectors, List\<ActivityRecord> activityRecords, bool deleteAllActivityRecords, bool deleteAllData, TimeUnit timeUnit})](#delete-opt-constructor) |   Default constructor.   |   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [setTimeInterval](#delete-opt-set-time) | void | Sets the start time and end time for data to be deleted.|
| [toMap](#delete-opt-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#delete-opt-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#delete-opt-equals) | bool | Checks whether two DeleteOptions objects are the same.|   
| [hashCode](#delete-opt-hashCode)  | int | Returns the hash code of the current object.| 
#### Constructors
<a name="delete-opt-constructor"></a>
<details>
<summary>DeleteOptions</summary>

#####  DeleteOptions({DateTime startTime, DateTime endTime, List\<DataType> dataTypes, List\<DataCollector> dataCollectors, List\<ActivityRecord> activityRecords, bool deleteAllActivityRecords, bool deleteAllData, TimeUnit timeUnit})

</details>

Default constructor.
###### Parameters
The same parameters apply as in the [properties](#delete-opt-props) table.
#### Methods
##### <a name="delete-opt-set-time"></a> void setTimeInterval(DateTime startTime, DateTime endTime)
Sets the start time and end time for data to be deleted. The start time must be greater than 0, and the end time must not be earlier than the start time.
###### Parameters
| Parameter   | Type     | Description |
|-------------|----------|-------------|
|  startTime  | DateTime | Start Time.  |   
|  endTime    | DateTime | End Time.  |   

##### <a name="delete-opt-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="delete-opt-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="delete-opt-equals"></a> bool ==(Object other)
Checks whether two DeleteOptions objects are the same.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  other      |  Object     |  Object to compare.   |   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="delete-opt-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### ReadOptions
Request class for reading data. The request can be used to specify the type of data to be read and grouped parameters. The read request requires the setting of a time range and allows data to be read in detail or summary mode.

#### Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|startTime    | DateTime |   Start time of the read request.   |   
|endTime      | DateTime |  End time of the read request.   |   
|timeUnit     | TimeUnit | Time unit of the read request. |   
|duration     | int      | Duration for grouped data. |   
|dataCollectors | List\<[DataCollector](#datacollector)> | Data collectors for reading data.|   
|dataTypes  | List\<[DataType](#datatype)> | Data types for reading data.|   
|pageSize   | int |   The maximum number of pages for the paginated query results. |   
|allowRemoteInquiry | bool | Allows for query on the cloud. |   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [ReadOptions({DateTime startTime, DateTime endTime, TimeUnit timeUnit, int pageSize, bool allowRemoteInquiry, List\<DataCollector> dataCollectors, List\<DataType> dataTypes})](#read-opt-constructor) | Default Constructor. |   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[groupByTime](#group-by-time)  | void | Sets the group type to TYPE_TIME and sets the duration for each group. |   
|[polymerizeByDataType](#void-polymerizebydatatypedatatype-inputdatatype-datatype-outputdatatype)    | void | Adds a new data type to the grouped data and sets the type of the grouped data to be returned. |   
|[polymerizeByDataCollector](#void-polymerizebydatacollectordatacollector-datacollector-datatype-outputdatatype) | void |Adds a new data collector to the grouped data and sets the type of the grouped data to be returned.|   
|[toMap](#read-opt-toMap) | Map\<String, dynamic> |  Returns a map representation of the object. |   
#### Constructors
<a name="read-opt-constructor"></a>
<details>
<summary>ReadOptions</summary>

##### ReadOptions({DateTime startTime, DateTime endTime, TimeUnit timeUnit, int pageSize, bool allowRemoteInquiry, List\<DataCollector> dataCollectors, List\<DataType> dataTypes})
</details>

Default constructor.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|startTime    | DateTime |  Start time of the read request. |   
|endTime      | DateTime |  End time of the read request.   |   
|timeUnit     | TimeUnit | Time unit of the read request.   |   
|dataCollectors | List\<[DataCollector](#datacollector)> | Data collectors for reading data.|   
|dataTypes  | List\<[DataType](#datatype)> | Data types for reading data.|   
|pageSize   | int |   The maximum number of pages for the paginated query results. |   
|allowRemoteInquiry | bool | Allows for query on the cloud. |    
#### Methods
##### <a name="group-by-time"></a> void groupByTime(int duration, \{TimeUnit timeUnit = TimeUnit.MILLISECONDS\})
Sets the group type to TYPE_TIME and sets the duration for each group.
###### Parameters
| Parameter  | Type          | Description |
|------------|---------------|-------------|
|  duration  |  int          | Duration.   |   
|  timeUnit  | [TimeUnit](#enum-timeunit) | Time Unit.  |   
##### void polymerizeByDataType(DataType inputDataType, DataType outputDataType)
Adds a new data type to the grouped data and sets the type of the grouped data to be returned.
###### Parameters
| Parameter      | Type        | Description |
|----------------|-------------|-------------|
| inputDataType  | [DataType](#datatype) | Type of data to be grouped.|   
| outputDataType | [DataType](#datatype) | Type of the grouped data to be returned.|   
##### void polymerizeByDataCollector(DataCollector dataCollector, DataType outputDataType)
Adds a data collector for reading data.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  dataCollector | [DataCollector](#datacollector) | Data collector to add.|   
|  outputDataType | [DataType](#datatype) | Type of the grouped data to be returned.|   

##### <a name="read-opt-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |

### UpdateOptions
Request parameter class for updating data for a specified period of time to the HUAWEI Health platform.
#### <a name="update-opt-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|startTime | DateTime  | Start time for update request.|
|endTime   | DateTime  | End time for update request.|   
|timeUnit  | [TimeUnit](#enum-timeunit)  | Time unit of the update request. |  
|sampleSet | [SampleSet](#sampleset) | Sampling dataset for updating data.|   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[UpdateOptions({DateTime startTime, DateTime endTime,TimeUnit timeUnit=TimeUnit.MILLISECONDS, SampleSet sampleSet})](#update-opt-constructor) | Default constructor.|   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[toMap](#update-opt-toMap) | Map\<String, dynamic> |  Returns a map representation of the object. |
#### Constructors
##### <a name="update-opt-constructor"></a> UpdateOptions({DateTime startTime, DateTime endTime,TimeUnit timeUnit=TimeUnit.MILLISECONDS, SampleSet sampleSet})
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#update-opt-props) table.
#### Methods
##### <a name="update-opt-toMap"></a>  Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |

### HiHealthOption
Defines the request permissions. Permissions are defined by [DataType](#datatype), which determines the Health Kit scopes authorized to the signed-in HUAWEI ID.
#### <a name="hihealth-opt-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|dataType | [DataType](#datatype) | Data type that the developer needs to access.   |   
|accessType | AccessType | AccessType option for data type. Values are `AccessType.read` and `AccessType.write`.|   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [HiHealthOption(DataType dataType, AccessType accessType)](#hihealth-opt-constructor) | Default constructor.|
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#hihealth-opt-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [==(equals operator)](#hihealth-opt-equals) | bool | Checks whether two HiHealthOption objects are the same.|   
| [hashCode](#hihealth-opt-hashCode)  | int | Returns the hash code of the current object.| 
#### Constructors
##### <a name="hihealth-opt-constructor"></a> HiHealthOption(DataType dataType, AccessType accessType)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#hihealth-opt-props) table.  
#### Methods
##### <a name="hihealth-opt-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="hihealth-opt-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="hihealth-opt-equals"></a> bool ==(Object other)
Checks whether two HiHealthOption objects are the same.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  other      |  Object     |  Object to compare.   |   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="hihealth-opt-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### Data Classes
Dataset classes for interacting with the data provided by Health Kit. The summary of classes is described in the table below.

| Name | Description | 
| ---- | ----------- |
| [ActivityRecord](#activityrecord) | Activity record class, which records the basic information about an activity of the user.|
| [ActivitySummary](#activitysummary) | Activity summary class. |
| [PaceSummary](#pacesummary) | Pace summary class.|
|[DataCollector](#datacollector)|Defines a unique data collector.|
|[DataType](#datatype)|Data types defined by HUAWEI Health Kit.|
|[Field](#field)|Fields for common data types.|
|[SamplePoint](#samplepoint)|Sampling point class, which presents the sampled data of a specific type collected by a specific data collector at a given time or within a time range.|
|[FieldValueOptions](#fieldvalueoptions)|Abstract base class for [FieldInt](#fieldint), [FieldLong](#fieldlong), [FieldFloat](#fieldfloat), [FieldMap](#fieldmap), [FieldString](#fieldstring), FieldValueOptions types.|
|[SampleSet](#sampleset)|The sampling dataset class represents the container for storing sampling points.|
|[ScopeLangItem](#scopelangitem)|List of permissions that have been granted to your app.|
|[Scope](#scope)|Scope constant class, which is used to apply for scopes to access Health Kit data from users.|

### ActivityRecord
Activity record class, which records the basic information about an activity of the user. For example, for an outdoor running activity, information including the start time, end time, activity record name, identifier, description, activity type (as defined in HiHealthActivities, and activity duration will be recorded.

#### <a name="activity-rec-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|startTime        | DateTime | The start time of the activity record.|   
|endTime          | DateTime | The end time of the activity record.|   
|activeTimeMillis | int | Activity duration in milliseconds.|   
|name             | String | Name of the activity record.|   
|id               | String | Identifier of the activity record.|   
|description      | String | Description of the activity record.|
|timeZone         | String | Time Zone. |   
|activityTypeId   | String | Activity type corresponding to the activity record.|
|activitySummary  | [ActivitySummary](#activitysummary) | Activity summary.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[ActivityRecord({DateTime startTime, DateTime endTime, String id, String name, String description, String activityTypeId, String timeZone, int activeTimeMillis, ActivitySummary activitySummary})](#activity-rec-constructor)| Default constructor.|   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[isKeepGoing](#bool-get-iskeepgoing)   | bool | Indicates whether an activity record is in progress. If the activity record has ended, the value `false` will be returned.  |   
|[hasDurationTime](#bool-get-hasdurationtime)   | bool | Indicates whether the activity record has durations. |   
| [toMap](#activity-rec-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#activity-rec-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#activity-rec-equals) | bool | Checks whether two ActivityRecord objects are the same.|   
| [hashCode](#activity-rec-hashCode)  | int | Returns the hash code of the current object.| 
#### Constructors
<a name="activity-rec-constructor"></a>
<details>
<summary>ActivityRecord</summary>

##### ActivityRecord({DateTime startTime, DateTime endTime,String id, String name, String description, String activityTypeId, String timeZone, int activeTimeMillis, ActivitySummary activitySummary})
</details>

Default constructor.
###### Parameters
The same parameters apply as in the [properties](#activity-rec-props) table.
#### Methods
##### bool *get* isKeepGoing
Indicates whether an activity record is in progress. If the activity record has ended, the value `false` will be returned.

###### Return Type
| Type  | Description |
|-------|-------------|
| bool  | `true` if activity record is in progress, `false` otherwise.|
##### bool *get* hasDurationTime
Indicates whether the activity record has durations.
###### Return Type
| Type  | Description |
|-------|-------------|
|bool   | `true` if activity record has durations `false` otherwise.|
##### <a name="activity-rec-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="activity-rec-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="activity-rec-equals"></a> bool ==(Object other)
Checks whether two ActivityRecord objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="activity-rec-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### ActivitySummary
Activity summary class.

#### <a name="activity-summary-props"></a> Properties
| Name       | Type        | Description |
|------------|-------------|-------------|
|paceSummary |   [PaceSummary](#pacesummary)      | PaceSummary instance.|   
|dataSummary | List\<[SamplePoint](#samplepoint)> | Statistical data points that consist from SamplePoints.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[ActivitySummary({PaceSummary paceSummary, @required List\<SamplePoint> dataSummary})](#activity-summary-constructor)| Default constructor.|   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#activity-summary-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#activity-summary-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#activity-summary-equals) | bool | Checks whether two ActivitySummary objects are the same.|   
| [hashCode](#activity-summary-hashCode)  | int | Returns the hash code of the current object.| 
#### Constructors
##### <a name="activity-summary-constructor"></a> ActivitySummary({PaceSummary paceSummary, @required List\<SamplePoint> dataSummary})
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#activity-summary-props) table.
#### Methods
##### <a name="activity-summary-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="activity-summary-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="activity-summary-equals"></a> bool ==(Object other)
Checks whether two ActivitySummary objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="activity-summary-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### PaceSummary
Pace summary class.
#### <a name="pace-summary-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|britishPaceMap | Map\<String, double> |Pace per mile. |   
|britishPartTimeMap | Map\<String, double> |Segment data table in the imperial system.|
|paceMap   | Map\<String, double> | Pace per kilometer.|
|partTimeMap   | Map\<String, double> | Segment data table in the metric system.|
|sportHealthPaceMap   | Map\<String, double> | Health pace records.|   
|avgPace  | double | Average pace.|
|bestPace | double | Optimal pace.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [PaceSummary({Map\<String, double> britishPaceMap, Map\<String, double> britishPartTimeMap, Map\<String, double> paceMap, Map\<String, double> partTimeMap, Map\<String, double> sportHealthPaceMap, double avgPace, double bestPace})](#pace-summary-constructor)| Default constructor. |
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#pace-summary-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#pace-summary-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#pace-summary-equals) | bool | Checks whether two PaceSummary objects are the same.|   
| [hashCode](#pace-summary-hashCode)  | int | Returns the hash code of the current object.|   
#### Constructors
<a name="pace-summary-constructor"></a>
<details>
<summary>PaceSummary</summary>

##### PaceSummary({Map\<String, double> britishPaceMap, Map\<String, double> britishPartTimeMap, Map\<String, double> paceMap, Map\<String, double> partTimeMap, Map\<String, double> sportHealthPaceMap, double avgPace, double bestPace})
</details>

Default constructor.
###### Parameters
The same parameters apply as in the [properties](#pace-summary-props) table.  
#### Methods
##### <a name="pace-summary-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="pace-summary-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="pace-summary-equals"></a> bool ==(Object other)
Checks whether two PaceSummary objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="pace-summary-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### DataCollector
Defines a unique data collector. A data collector provides the raw data collected from a phone or external device. Data from multiple data collectors can be converted or combined and therefore becomes derived data. Each sampling point must have a corresponding data collector. When a data collector is created, a unique identifier will be generated for it. The identifier consists of the data collector type, device information, package
name of the app, and more.

#### Constants
##### enum DataGenerateType
DataGenerateType options.

| Value    | Description        |
| -------- | ------------------ |
| DATA_TYPE_RAW  | Raw data type. |
| DATA_TYPE_DERIVED | Derived data type.|
| DATA_TYPE_CLEAN | Clean data type.|
| DATA_TYPE_CONVERTED | Converted data type.|
| DATA_TYPE_MERGED | Merged data type.|
| DATA_TYPE_POLYMERIZED | Grouped data type.|

#### <a name="data-collector-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|name   |   String   | The name of the data collector. The input parameter can be null or a string of **1** to **300** characters.|   
|dataGenerateType | [DataGenerateType](#enum-datageneratetype) |The type of the data collector, such as raw and derived.|
|dataStreamName   |   String   |The name of the data stream. The input parameter can be empty or a string of **1** to **300** characters.|
|dataStreamId   |   String   | The unique identifier of the data collector.|
|dataType   |   [DataType](#datatype)   | The data type.|
|deviceId   |   String   | The identifier of the device.|   
|deviceInfo   |   DeviceInfo   |The Device information.|
|isLocalized   |   bool   | Whether the data collector is originated from the local device. The default value is `false` (non-local device).|   
|packageName   |   String   |The package name of the app. The input parameter can be an empty string or a string of **1** to **300** characters.|   
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[DataCollector({String name, String dataStreamName, String dataStreamId, @required DataType dataType, @required DataGenerateType dataGenerateType, String deviceId, DeviceInfo deviceInfo, bool isLocalized, String packageName})](#data-collector-constructor) | Default constructor.|   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[getStandardByType](#string-getstandardbytypeint-type) | String | Obtains the standard type.|   
|[getDataGenerateType](#datageneratetype-getdatageneratetypeint-value)   | [DataGenerateType](#enum-datageneratetype) |Obtains the type of the data collector.|
| [toMap](#data-collector-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#data-collector-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#data-collector-equals) | bool | Checks whether two DataCollector objects are the same.|   
| [hashCode](#data-collector-hashCode)  | int | Returns the hash code of the current object.| 
#### Constructors
<a name="data-collector-constructor"></a> 
<details>
<summary>DataCollector</summary>

##### DataCollector({String name, String dataStreamName, String dataStreamId, @required DataType dataType, @required DataGenerateType dataGenerateType, String deviceId, DeviceInfo deviceInfo, bool isLocalized, String packageName})
</details>

Default constructor.
###### Parameters
The same parameters apply as in the [properties](#data-collector-props) table.
#### Methods
##### String getStandardByType(int type)
Obtains the standard type.
###### Parameters
| Parameter | Type  | Description |
|-----------|-------|-------------|
|  type     |  int  | Integer value of the standard.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
|String | Standard name.  |
##### DataGenerateType getDataGenerateType(int value)
Obtains the type of the data collector.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  value      |  int        | Value of the DataGenerateType. The value should be in **[0-5]** range|   
###### Return Type
| Type        | Description |
|-------------|-------------|
|DataGenerateType | DataGenerateType that corresponds to integer value.|

##### <a name="data-collector-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="data-collector-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="data-collector-equals"></a> bool ==(Object other)
Checks whether two DataCollector objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="data-collector-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### DataType
Data types defined by HUAWEI Health Kit. Each data type has a unique name for the identification purpose and each data type has its own meaning. For example, DT_CONTINUOUS_STEPS_DELTA indicates the number of steps taken since the last reading. You can also create you own data types with the [addDataType](#futuredatatype-adddatatypedatatypeaddoptions-options-async) API from the [SettingController](#settingscontroller) module.

#### Constants
| Constant | Type | Description |
|------|------|-------------|
| DT_UNUSED_DATA_TYPE | DataType | Default data type.|
| DT_CONTINUOUS_STEPS_DELTA | DataType | Steps taken since the last reading. The value range over 1 second is (0, 10], that over 1 minute is (0,600], and that over 1 hour is (0, 36000]|
| DT_CONTINUOUS_STEPS_TOTAL | DataType | Total number of steps. This data   type applies only to data query scenarios.|
| DT_INSTANTANEOUS_STEPS_RATE | DataType | Number of steps per minute.|
| DT_CONTINUOUS_STEPS_RATE_STATISTIC | DataType | Step cadence statistics.|
| DT_CONTINUOUS_ACTIVITY_SEGMENT | DataType | Activity type within a period of  time.|
| DT_CONTINUOUS_CALORIES_CONSUMED | DataType | Calories consumed within a period of time (unit: kcal).|
| DT_CONTINUOUS_CALORIES_BURNT | DataType | Total calories burnt within a   period of time. This field is mandatory, and the unit is kcal. The value   range over 1 second is (0, 0.555555555555556), that over 1 minute is (0,33.333333333333333), and that over 1 hour is (0, 2000].|
| DT_INSTANTANEOUS_CALORIES_BMR | DataType | Basic metabolic rate per day   (unit: kcal).|
| DT_INSTANTANEOUS_POWER_SAMPLE | DataType | Instantaneous sampling of power.|
| DT_INSTANTANEOUS_ACTIVITY_SAMPLE | DataType | A single activity type within a period of time.|
| DT_INSTANTANEOUS_HEART_RATE | DataType | Heart rate (unit: heartbeats per   minute). This field is mandatory. The value range is (0, 255).|
| DT_INSTANTANEOUS_LOCATION_SAMPLE | DataType | Location at a given time.|
| DT_INSTANTANEOUS_LOCATION_TRACE | DataType | A point on the trajectory.|
| DT_CONTINUOUS_DISTANCE_DELTA | DataType | Distance covered since the last   reading (unit: meter). This field is mandatory. The value range over 1 second   is (0, 100], that over 1 minute is (0, 6000], and that over 1 hour is (0,   360000].|
| DT_CONTINUOUS_DISTANCE_TOTAL | DataType | Accumulated distance covered   (unit: meter).|
| DT_CONTINUOUS_CALORIES_BURNT_TOTAL | DataType | Total calories.|
| DT_INSTANTANEOUS_SPEED | DataType | Instantaneous speed on the ground   (unit: m/s).|
| DT_CONTINUOUS_BIKING_WHEEL_ROTATION_TOTAL | DataType | Number of rotations of the bicycle wheel within a period of time.|
| DT_INSTANTANEOUS_BIKING_WHEEL_ROTATION | DataType | Instantaneous measurement of the rotational speed of the bicycle wheel per minute.|
| DT_CONTINUOUS_BIKING_PEDALING_TOTAL | DataType | Total mileage of the bicycle since the start of the count (unit: meter).|
| DT_INSTANTANEOUS_BIKING_PEDALING_RATE | DataType | Cycling speed at a time point (unit: m/s).|
| DT_INSTANTANEOUS_HEIGHT | DataType | Height (unit: meter). This field is mandatory. The value range is (0.4, 2.6).|
| DT_INSTANTANEOUS_BODY_WEIGHT | DataType | Weight (unit: kg). This field is   mandatory. The value range is (1, 560).|
| DT_INSTANTANEOUS_BODY_FAT_RATE | DataType | Body fat rate.|
| DT_INSTANTANEOUS_NUTRITION_FACTS | DataType | Nutrient intake over a meal.|
| DT_INSTANTANEOUS_HYDRATE | DataType | Water taken over a single drink   (unit: liter).|
| DT_CONTINUOUS_WORKOUT_DURATION | DataType | Workout duration (unit: minute).|
| DT_CONTINUOUS_EXERCISE_INTENSITY | DataType | Workout intensity.|
| DT_STATISTICS_SLEEP| DataType | Sleep statistics type.|
| DT_CONTINUOUS_SLEEP | DataType | Sleep details.|
| DT_INSTANTANEOUS_STRESS | DataType | Pressure details.|
| DT_INSTANTANEOUS_STRESS_STATISTICS | DataType | Pressure statistics type.|
| POLYMERIZE_CONTINUOUS_WORKOUT_DURATION | DataType | Workout duration over a period of time (unit: minute).|
| POLYMERIZE_CONTINUOUS_ACTIVITY_STATISTICS | DataType | Summarized statistics of a specific activity type within a period of time.|
| POLYMERIZE_CONTINUOUS_CALORIES_BMR_STATISTICS | DataType | Average, maximum, and minimum basic metabolic rates over a period of time (unit: kcal).|
| POLYMERIZE_STEP_COUNT_DELTA | DataType | Step increment within a period of   time.|
| POLYMERIZE_DISTANCE_DELTA | DataType | Distance increment within a period   of time.|
| POLYMERIZE_CALORIES_CONSUMED | DataType | Total calories consumed.|
| POLYMERIZE_CALORIES_EXPENDED | DataType | Total calories consumed within a   period of time (unit: kcal).|
| POLYMERIZE_CONTINUOUS_EXERCISE_INTENSITY_STATISTICS | DataType | Heartbeat intensity statistics.|
| POLYMERIZE_CONTINUOUS_HEART_RATE_STATISTICS | DataType | Average, maximum, and minimum   heartbeats per minute within a period of time.|
| POLYMERIZE_CONTINUOUS_LOCATION_BOUNDARY_RANGE | DataType | Activity boundaries within a period of time.|
| POLYMERIZE_CONTINUOUS_POWER_STATISTICS | DataType | Power within a period of time (including the maximum, minimum, and average power in the unit of watt).|
| POLYMERIZE_CONTINUOUS_SPEED_STATISTICS | DataType | Ground speed (including the maximum, minimum, and average speed in the unit of m/s).|
| POLYMERIZE_CONTINUOUS_BODY_FAT_RATE_STATISTICS | DataType | Body fat rate over a period of time (including the maximum, minimum, and average values).|
| POLYMERIZE_CONTINUOUS_BODY_WEIGHT_STATISTICS | DataType | Weight over a period of time   (including maximum, minimum, and average values in the unit of kg).|
| POLYMERIZE_CONTINUOUS_HEIGHT_STATISTICS | DataType | Height over a period of time (including maximum, minimum, and average values in the unit of meter).|
| POLYMERIZE_CONTINUOUS_NUTRITION_FACTS_STATISTICS | DataType | Sum of nutrient intake over a period of time.|
| POLYMERIZE_HYDRATION | DataType | Water intake over a period of time (unit: liter).|

#### <a name="data-type-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|name | String | Name. The value must be a string of **1** to **300** characters.|
|packageName | String | App package name.|
|scopeNameRead | String | Read permission of the data type. The value can be an empty string or a string of **1** to **1000** characters.|
|scopeNameWrite | String | Write permission of the data type. The value can be an empty string or a string of **1** to **1000** characters.|
|fields | List\<Field> | Attribute list.|
|isPolymerizedFlag | bool |Indicates whether it is a grouped data type.|   
|isSelfDefined | bool | Whether the data type is a customized one.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[const DataType(String name, String scopeNameRead, String scopeNameWrite, List\<Field> fields, {bool isPolymerizedFlag = false, bool isSelfDefined = false, String packageName = ""})](#data-type-constructor)| Default constructor.|
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [getMimeType](#string-getmimetypedatatype-datatype) | String | Adds a header name to the type. |   
| [toMap](#data-type-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|
| [toString](#data-type-toStr) | String | Returns a string representation of the object. |

#### Constructors
<a name="data-type-constructor"></a>
<details>
<summary>const DataType</summary>

##### const DataType(String name, String scopeNameRead, String scopeNameWrite, List\<Field> fields, \{bool isPolymerizedFlag = false, bool isSelfDefined = false, String packageName = ""})
</details>

Default constructor.
###### Parameters
The same parameters apply as in the [properties](#data-type-props) table.  

#### Methods
##### String getMimeType(DataType dataType)
Adds a header name to the type. 
###### Parameters
| Parameter | Type     | Description |
|-----------|----------|-------------|
| dataType  | DataType | Data Type.  |   
###### Return Type
| Type        | Description |
|-------------|-------------|
| String      | Header name.|

##### <a name="data-type-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="data-type-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|

### Field
Fields for common data types.
#### Constants
For all the Field Constants please visit the document for the HUAWEI Health Kit Flutter Plugin on the Huawei Developer website.
#### <a name="field-props"></a> Properties
| Name      | Type   | Description |
|-----------|--------|-------------|
|format     | int    | Attribute type.|   
|name       | String | Field Name.|   
|isOptional | bool   | Indicates whether it is optional.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[const Field(String name, int format, {bool isOptional = false})](#field-default-constructor)| Default constructor. |   
|[const Field.newFloatField(String name)](#const-fieldnewfloatfieldstring-name)|Creates an attribute that contains float values.|   
|[const Field.newIntField(String name)](#const-fieldnewintfieldstring-name)|Creates an attribute that contains integer values.|
|[const Field.newMapField(String name)](#const-fieldnewmapfieldstring-name)|Creates an attribute that contains mapped values.|   
|[const Field.newStringField(String name)](#const-fieldnewstringfieldstring-name)|Creates an attribute that contains string values.|   
|[const Field.newLongField(String name)](#const-fieldnewlongfieldstring-name) |Creates an attribute that contains long values. (Note: this type matches with `long` on Java which can contain 64 bits. Dart's integer values are already 64 bits instead of Java's 32 bits.) |
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#field-toMap)  | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#field-toStr) | String | Returns a string representation of the object. |   
| [==(equals operator)](#field-equals) | bool | Checks whether two Field objects are the same.|   
| [hashCode](#field-hashCode)  | int | Returns the hash code of the current object.|
#### Constructors
##### <a name="field-default-constructor"></a> const Field(String name, int format, \{bool isOptional \= false})
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-props) table. 
##### const Field.newFloatField(String name)
Creates an attribute that contains float values.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  name       |  String     | Field name. |
##### const Field.newIntField(String name)
Creates an attribute that contains integer values.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  name       |  String     | Field name. |  
##### const Field.newMapField(String name)
Creates an attribute that contains mapped values.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  name       |  String     | Field name. |
##### const Field.newStringField(String name)
Creates an attribute that contains string values.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  name       |  String     | Field name. |
##### const Field.newLongField(String name)
Creates an attribute that contains long values. 
>Note: this type matches with **long** on java which can contain 64 bits. Dart's integer values are already 64 bits instead of Java's 32 bits.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  name       |  String     | Field name. | 
#### Methods
##### <a name="field-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="field-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="field-equals"></a> bool ==(Object other)
Checks whether two Field objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="field-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|


### SamplePoint
Sampling point class, which presents the sampled data of a specific type collected by a specific data collector at a given time or within a time range. It stores the values of each dimension of the data type at the given time (or within the time range) and the start time and end time of the sampling operation.

The sampling modes of sampling points are classified into instantaneous sampling and continuous sampling based on the definition of data types.

When setting the sampling point time, you are advised to call **setSamplingTime()** for instantaneous sampling data and **setTimeInterval()** for continuous sampling data (make sure to set a valid time duration). In addition, you can also call **setTimeInterval()** to set the time for instantaneous sampling data. Make sure that the passed start time and end time are the same. Otherwise, the creation will fail. The **setSamplingTime()** API can not be used when creating the continuous sampling point. Otherwise, the creation will fail. This API can be used to update the end time of a created continuous sampling point. After the API is called, only the end time will be updated.

#### <a name="sample-point-props"></a> Properties
| Name             | Type        | Description |
|------------------|-------------|-------------|
|id                | int |ID of the sampling point.|
|startTime         | DateTime |Start time.|
|endTime           | DateTime |End Time.|
|samplingTime      | DateTime |Sampling timestamp.|
|timeUnit          | [TimeUnit](#enum-timeunit) |Time unit.|
|fieldValueOptions | [FieldValueOptions](#fieldvalueoptions) | FieldValueOptions object that contains the field values that will be used for SamplePoint creation.|
|dataCollector     | [DataCollector](#datacollector) |Data collector.|

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[SamplePoint({int id, DateTime startTime,DateTime endTime,DateTime samplingTime, FieldValueOptions fieldValueOptions, TimeUnit timeUnit = TimeUnit.MILLISECONDS, DataCollector dataCollector})](#sample-point-constructor) | Default constructor. |   

#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[getInsertionTime](#datetime-get-getinsertiontime) | DateTime | Obtains the insertion time of the sample point.|
|[setTimeInterval](#void-set-settimeintervaldatetime-starttime-datetime-endtime-timeunit-timeunit)  | void |Sets the sampling timestamp of data within an interval.|   
|[setSamplingTime](#void-set-setsamplingtimedatetime-timestamp-timeunit-timeuni)  | void |Sets the sampling timestamp of instantaneous data.|   
|[fieldValues](#mapstring-dynamic-get-fieldvalues)      | Map\<String, dynamic> | Obtains the field values that are returned from the native platform. |   
|[getDataTypeId](#int-get-getdatatypeid)    | int | Obtains DataTypeId. |   
|[getDataType](#sample-point-get-data-type)      | DataType |Obtains the data type of the sampling point.|
| [toMap](#sample-point-toMap)     | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#sample-point-toStr)  | String | Returns a string representation of the object. |   
| [==(equals operator)](#sample-point-equals) | bool | Checks whether two SamplePoint objects are the same.|   
| [hashCode](#sample-point-hashCode) | int | Returns the hash code of the current object.|

#### Constructors
<a name="sample-point-constructor"></a>
<details>
<summary>SamplePoint</summary>

##### SamplePoint({int id, DateTime startTime,DateTime endTime,DateTime samplingTime, FieldValueOptions fieldValueOptions, TimeUnit timeUnit = TimeUnit.MILLISECONDS, DataCollector dataCollector})
</details>

Default constructor.
###### Parameters
The same parameters apply as in the [properties](#sample-point-props) table.  

#### Methods

##### DateTime *get* getInsertionTime
Obtains the insertion time of the sample point.
###### Return Type
| Type        | Description |
|-------------|-------------|
|DateTime     |Insertion time of the sample point|

##### void *set* setTimeInterval(DateTime startTime, DateTime endTime, TimeUnit timeUnit)
Sets the sampling timestamp of data within an interval.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  startTime  | DateTime      | Start time.|   
|  endTime    | DateTime      | End time.|   
|  timeUnit   | [TimeUnit](#enum-timeunit) | Time unit.|   

##### void *set* setSamplingTime(DateTime timestamp, TimeUnit timeUni)
Sets the sampling timestamp of instantaneous data.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  timeStamp  |  DateTime   | Timestamp.  |   
|  timeUnit   | [TimeUnit](#enum-timeunit) | Time unit.|

##### Map\<String, dynamic> *get* fieldValues
Obtains the field values that are returned from the native platform. For example, while using the [AutoRecorderController](#autorecordercontroller) API, the resulting step count data can be obtained from this field.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Map\<String, dynamic> | Map that contains field values.|

##### int *get* getDataTypeId
Obtains DataTypeId.
###### Return Type
| Type        | Description |
|-------------|-------------|
|int          | Id of the data type.|

##### <a name="sample-point-get-data-type"></a> DataType *get* getDataType
Obtains DataType.
###### Return Type
| Type        | Description |
|-------------|-------------|
|[DataType](#datatype)|DataType.|

##### <a name="sample-point-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="sample-point-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="sample-point-equals"></a> bool ==(Object other)
Checks whether two SamplePoint objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="sample-point-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### FieldValueOptions
Abstract base class for [FieldInt](#fieldint), [FieldLong](#fieldlong), [FieldFloat](#fieldfloat), [FieldMap](#fieldmap), [FieldString](#fieldstring), FieldValueOptions types. This class contain the specified [Field](#field) and the corresponding value for that field. It can be used to specify field and value that can have different types for a [SamplePoint](#samplepoint) object.

#### <a name="field-value-options-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|field   |   [Field](#field)   | Field type. |   
|value   |   dynamic   |   Field value.   |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [FieldValueOptions(Field field, dynamic value)](#fieldvalueoptionsfield-field-dynamic-value) | Default constructor. |   

#### <a name="field-value-options-method-summary"></a> Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#field-value-options-toMap)|Map\<String, dynamic> | Returns a map representation of the object.|
| [==(equals operator)](#field-value-options-equals) | bool | Checks whether two FieldValueOptions objects are the same.|
| [hashCode](#field-value-options-hashCode) |int |Returns the hash code of the current object.|
#### Constructors
##### FieldValueOptions(Field field, dynamic value)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-value-options-props) table.
#### Methods
##### <a name="field-value-options-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object.|

##### <a name="field-value-options-equals"></a> bool ==(Object other)
Checks whether two FieldValueOptions objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|

##### <a name="field-value-options-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### FieldInt
Derived from the [FieldValuesOptions](#fieldvalueoptions) class. Sets the integer attribute value of a sampling point.

#### <a name="field-int-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|field |[Field](#field) |Field type.|
|value |int |Integer field value.|

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [FieldInt(Field field, int value)](#fieldintfield-field-int-value) | Default constructor. |

#### Method Summary
The inherited methods from the [FieldValueOptions](#fieldvalueoptions) base class.
#### Constructors
##### FieldInt(Field field, int value)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-int-props) table.
#### Methods
The inherited methods from the [FieldValueOptions](#fieldvalueoptions) base class.

### FieldLong
Derived from the [FieldValuesOptions](#fieldvalueoptions) class. Sets the long integer attribute value of a sampling point. Different from [FieldInt](#fieldint), this option's value will be set as long integer in Android Platfom.
#### <a name="field-long-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|field   |   [Field](#field)   | Field type. |   
|value   |   int   |  Integer field value to be converted as long on Android Platform.|

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [FieldLong(Field field, int value)](#fieldlongfield-field-int-value) | Default constructor. |

#### Method Summary
The inherited methods from the [FieldValueOptions](#fieldvalueoptions) base class.
#### Constructors
##### FieldLong(Field field, int value)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-long-props) table.
#### Methods
Please refer to methods of [FieldValueOptions](#field-value-options-method-summary)

### FieldFloat
Derived from the [FieldValuesOptions](#fieldvalueoptions) class. Sets the double-precision floating-point attribute value of a sampling point.
#### <a name="field-float-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|field   |   [Field](#field)   | Field type. |   
|value   |   double   |  Floating field value.|

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [FieldFloat(Field field, double value)](#fieldfloatfield-field-double-value) | Default constructor. |

#### Method Summary
The inherited methods from the [FieldValueOptions](#fieldvalueoptions) base class.
#### Constructors
##### FieldFloat(Field field, double value)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-float-props) table.
#### Methods
Please refer to methods of [FieldValueOptions](#field-value-options-method-summary)

### FieldMap
Derived from the [FieldValuesOptions](#fieldvalueoptions) class. Sets the mapped attribute value of a sampling point.
#### <a name="field-map-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|field   |   [Field](#field)   | Field type. |   
|value   |   Map\<String, dynamic> | Mapped field value.|

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [FieldMap(Field field, Map\<String, dynamic> value)](#fieldmapfield-field-mapstring-dynamic-value) | Default constructor. |

#### Method Summary
The inherited methods from the [FieldValueOptions](#fieldvalueoptions) base class.
#### Constructors
##### FieldMap(Field field, Map\<String, dynamic> value)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-map-props) table.
#### Methods
Please refer to methods of [FieldValueOptions](#field-value-options-method-summary)

### FieldString
Derived from the [FieldValuesOptions](#fieldvalueoptions) class. Sets the string attribute value of a sampling point.
#### <a name="field-string-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|field   |   [Field](#field)   | Field type. |
|value   |   String   |  String field value. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| [FieldString(Field field, String value)](#fieldstringfield-field-string-value) | Default constructor. |

#### Method Summary
The inherited methods from the [FieldValueOptions](#fieldvalueoptions) base class.
#### Constructors
##### FieldString(Field field, String value)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#field-string-props) table.
#### Methods
Please refer to methods of [FieldValueOptions](#field-value-options-method-summary)

### SampleSet
The sampling dataset class represents the container for storing sampling points.
The sampling points stored in a sampling dataset must be from the same data collector (but their raw data collectors can be different). This class is usually used to insert or read sampling data in batches.

#### <a name="sample-set-props"></a> Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|dataCollector | [DataCollector](#datacollector) | Data collector.|
|samplePoints  | List\<[SamplePoint](#samplepoint)> |	A list of sampling points.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[SampleSet(DataCollector dataCollector, List\<SamplePoint> samplePoints)](#samplesetdatacollector-datacollector-listsamplepoint-samplepoints) |Default constructor.|

#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[getDataType](#sample-set-get-data-type)   |   [DataType](#datatype)   | Obtains the data type from the data collector of the SampleSet. |   
| [toMap](#sample-set-toMap)     | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#sample-set-toStr)  | String | Returns a string representation of the object. |   
| [==(equals operator)](#sample-set-equals) | bool | Checks whether two SampleSet objects are the same.|   
| [hashCode](#sample-set-hashCode) | int | Returns the hash code of the current object.|

#### Constructors
##### SampleSet(DataCollector dataCollector, List\<SamplePoint> samplePoints)
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#sample-set-props) table.
#### Methods
##### <a name="sample-set-get-data-type"></a> DataType *get* getDataType
Obtains the data type from the data collector of the SampleSet. 
###### Return Type
| Type        | Description |
|-------------|-------------|
|DataType     | Data Type.  |

##### <a name="sample-set-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="sample-set-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="sample-set-equals"></a> bool ==(Object other)
Checks whether two SampleSet objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="sample-set-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### ScopeLangItem
List of permissions that have been granted to your app.

#### <a name="scope-lang-item-props"></a> Properties 
| Name        | Type        | Description |
|-------------|-------------|-------------|
|url2Desc | Map\<String, String> | Mapping between the permission scope URL and description.|
|authTime | String | Time when the permission is granted.|
|appName | String  | Application name.|
|appIconPath |String | Path to the app icon image.|
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
|[ScopeLangItem({Map<String, String> url2Desc, String authTime, String appName, String appIconPath})](#scopelangitemmapstring-string-url2desc-string-authtime-string-appname-string-appiconpath) |Default constructor.|   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#scope-lang-item-toMap)     | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#scope-lang-item-toStr)  | String | Returns a string representation of the object. |   
| [==(equals operator)](#scope-lang-item-equals) | bool | Checks whether two ScopeLangItem objects are the same.|   
| [hashCode](#scope-lang-item-hashCode) | int | Returns the hash code of the current object.| 
#### Constructors
##### ScopeLangItem({Map<String, String> url2Desc, String authTime, String appName, String appIconPath})
Default constructor.
###### Parameters
The same parameters apply as in the [properties](#scope-lang-item-props) table.
#### Methods
##### <a name="scope-lang-item-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="scope-lang-item-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|
##### <a name="scope-lang-item-equals"></a> bool ==(Object other)
Checks whether two ScopeLangItem objects are the same.
###### Parameters
| Parameter | Type    | Description |
|-----------|---------|-------------|
|  other    |  Object | Object to compare.|   
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool        | Comparison result: `true` if equals, `false` otherwise.|
##### <a name="scope-lang-item-hashCode"></a> int *get* hashCode
Returns the hash code of the current object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| int         | Calculated hash value.|

### Scope
Scope constant class, which is used to apply for scopes to access Health Kit data from users.
#### Constants
| Constant | Type | Description |
| ---- | ---- | ----------- |
| HEALTHKIT_ACTIVITY_READ | String |Views the activity data (such as activity points, workout, strength, running posture, cycling, and activity duration) in HUAWEI Health Kit.|
| HEALTHKIT_ACTIVITY_WRITE | String |Stores the activity data (such as activity points, workout, strength, running posture, cycling, and activity duration) in HUAWEI Health Kit.|
| HEALTHKIT_BLOODGLUCOSE_READ | String |Views the blood glucose data in HUAWEI Health Kit.|
| HEALTHKIT_BLOODGLUCOSE_WRITE | String |Stores the blood glucose data in HUAWEI Health Kit.|
| HEALTHKIT_CALORIES_READ | String |Views the calories (including the BMR) in HUAWEI Health Kit.|
| HEALTHKIT_CALORIES_WRITE | String |Stores calories (including the BMR) in HUAWEI Health Kit.|
| HEALTHKIT_DISTANCE_READ | String |Views the distance and climbing height in HUAWEI Health Kit.|
| HEALTHKIT_DISTANCE_WRITE | String |Stores the distance and climbing height in HUAWEI Health Kit.|
| HEALTHKIT_HEARTRATE_READ | String |Views the heart rate data in HUAWEI Health Kit.|
| HEALTHKIT_HEARTRATE_WRITE | String |Stores the heart rate data in HUAWEI Health Kit.|
| HEALTHKIT_HEIGHTWEIGHT_READ | String |Views the height and weight in HUAWEI Health Kit.|
| HEALTHKIT_HEIGHTWEIGHT_WRITE | String |Stores the height and weight in HUAWEI Health Kit.|
| HEALTHKIT_LOCATION_READ | String |Views the location data (including the trajectory) in HUAWEI Health Kit.|
| HEALTHKIT_LOCATION_WRITE | String |Stores the location data (including the trajectory) in HUAWEI Health Kit.|
| HEALTHKIT_PULMONARY_READ | String |Views the pulmonary function data (e.g. VO2 Max) in HUAWEI Health Kit.|
| HEALTHKIT_PULMONARY_WRITE | String |Stores the pulmonary function data (e.g. VO2 Max) in HUAWEI Health Kit.|
| HEALTHKIT_SLEEP_READ | String |Views the sleep data in HUAWEI Health Kit.|
| HEALTHKIT_SLEEP_WRITE | String |Stores the sleep data in HUAWEI Health Kit.|
| HEALTHKIT_SPEED_READ | String |Views the speed in HUAWEI Health Kit.|
| HEALTHKIT_SPEED_WRITE | String |Stores the speed in HUAWEI Health Kit.|
| HEALTHKIT_STEP_READ | String |Views the step count in HUAWEI Health Kit.|
| HEALTHKIT_STEP_WRITE | String |Stores the step count in HUAWEI Health Kit.|
| HEALTHKIT_STRENGTH_READ | String |Views medium- and high-intensity data in HUAWEI Health Kit.|
| HEALTHKIT_STRENGTH_WRITE | String |Stores medium- and high-intensity data in HUAWEI Health Kit.|
| HEALTHKIT_BODYFAT_READ | String |Views the body fat data (such as body fat rate, BMI, muscle mass, moisture rate, visceral fat, bone salt, protein ratio, and skeletal muscle mass) in HUAWEI Health Kit.|
| HEALTHKIT_BODYFAT_WRITE | String |Stores the body fat data (such as body fat rate, BMI, muscle mass, moisture rate, visceral fat, bone salt, protein ratio, and skeletal muscle mass) in HUAWEI Health Kit.|
| HEALTHKIT_NUTRITION_READ | String |Views the nutrition data in HUAWEI Health Kit.|
| HEALTHKIT_NUTRITION_WRITE | String |Stores the nutrition data in HUAWEI Health Kit.|
| HEALTHKIT_BLOODPRESSURE_READ | String |Views the blood pressure data in HUAWEI Health Kit.|
| HEALTHKIT_BLOODPRESSURE_WRITE | String |Stores the blood pressure data in HUAWEI Health Kit.|
| HEALTHKIT_BODYTEMPERATURE_READ | String |Views the body temperature data in HUAWEI Health Kit.|
| HEALTHKIT_BODYTEMPERATURE_WRITE | String |Stores the body temperature data in HUAWEI Health Kit.|
| HEALTHKIT_OXYGENSTATURATION_READ | String |Views the blood oxygen data in HUAWEI Health Kit.|
| HEALTHKIT_OXYGENSTATURATION_WRITE | String |Stores the blood oxygen data in HUAWEI Health Kit.|
| HEALTHKIT_REPRODUCTIVE_READ | String |Views the reproductive data in HUAWEI Health Kit.|
| HEALTHKIT_REPRODUCTIVE_WRITE | String |Stores the reproductive data in HUAWEI Health Kit.|
| HEALTHKIT_ACTIVITY_RECORD_READ | String |Views the activity data (such as activity points, workout, strength, running posture, cycling, and activity duration) in HUAWEI Health Kit.|
| HEALTHKIT_ACTIVITY_RECORD_WRITE | String |Stores the activity data (such as activity points, workout, strength, running posture, cycling, and activity duration) in HUAWEI Health Kit.|
| HEALTHKIT_STRESS_READ | String |Views the stress data in HUAWEI Health Kit.|
| HEALTHKIT_STRESS_WRITE | String |Stores the stress data in HUAWEI Health Kit.|

#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|getAllScopes | List\<Scope> | Obtains all the scopes defined for the Health Kit.|
#### Methods
##### List\<Scope> *get* getAllScopes
Obtains all the scopes defined for the Health Kit.
###### Return Type
| Type        | Description |
|-------------|-------------|
|List\<Scope> | List of all scopes.|

### Result Classes
Data reading response class. Result classes are for utilizing the Health Kit API results. The summary of classes is described in the table below.

| Name |Description|
|---|---|
|[ReadReply](#readreply)|Data reading response class that defines the Read results of the [DataController.read](#futurereadreply-readreadoptions-readoptions-async) method.|
| [AuthHuaweiId](#authhuaweiid) | Result class that defines a HuaweiID for the [HealthAuth.signIn](#futureauthhuaweiid-signinlistscope-scopes-async) method.|

### ReadReply
Data reading response class that defines the Read results of the [DataController.read](#futurereadreply-readreadoptions-readoptions-async) method.
#### Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|groups | List\<Group> | All data groups.|   
|sampleSets | List\<SampleSet> | All sampling datasets.  |   
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#read-reply-toMap)     | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#read-reply-toStr)  | String | Returns a string representation of the object. |   
#### Methods
##### <a name="read-reply-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="read-reply-toStr"></a> String toString()
Returns a string representation of the object.  
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|

### AuthHuaweiId
Result class that defines a HuaweiID for the [HealthAuth.signIn](#futureauthhuaweiid-signinlistscope-scopes-async) method.

#### Properties
| Name        | Type        | Description |
|-------------|-------------|-------------|
|openId | String |OpenID. The value differs for the same user in different apps. The value is unique in a single app.|   
|photoUriString | String |Profile picture URI.|   
|accessToken | String | Access token.|   
|displayName | String | Nickname.|   
|status | int | User status. **1**: normal, **2**: Dbank suspended, **3**: deregistered, **4**: All services are suspended.|
|gender | int | User gender. **-1:** unknown, **0:** male, **1:** female, **2:** secret|   
|unionId | String |UnionID. The value is the same for the same user across all your apps.|   
|idToken | String | ID token from AppTouch ID information. |   
|expirationTimeSecs | int | Expiration time in seconds. |   
|givenName | String | Given name.|
|familyName | String | Family name. |
|grantedScopes | int | Authorized scopes. |  
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [toMap](#auth-toMap)     | Map\<String, dynamic> | Returns a map representation of the object.|   
| [toString](#auth-toStr)  | String | Returns a string representation of the object. |   
#### Methods
##### <a name="auth-toMap"></a> Map\<String, dynamic> toMap()
Returns a map representation of the object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | Map representation of the current object. |
##### <a name="auth-toStr"></a> String toString()
Returns a string representation of the object.
###### Return Type
| Type   | Description |
|--------|-------------|
| String |String representation of the current object.|

### <a name="plugin-constants"></a> Constants
Constants provided by the plugin. The summary of the constants are described in the table below. For other constant types please refer to the HUAWEI Health Kit Flutter Plugin document on the HUAWEI Developer website.

| Name |Description|
|---|---|
|[TimeUnit](#timeunit)|Options for specifying the time unit.|
| HiHealthStatusCodes |For error status codes you can refer to [HiHealthStatusCodes](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/hihealthstatuscodes-0000001050089560-V5#EN-US_TOPIC_0000001053487071__section10673269124).|

### enum TimeUnit
Options for specifying the time unit.

| Value    | Description        |
| -------- | ------------------ |
| NANOSECONDS  | Nanoseconds time unit.|
| MICROSECONDS | Microseconds time unit.|
| MILLISECONDS | Milliseconds time unit.|
| SECONDS | Seconds time unit.|
| MINUTES | Minutes time unit.|
| HOURS | Hours time unit.|
| DAYS | Days time unit.|

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
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
-keep class com.huawei.hms.flutter.** { *; }

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
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

In order to successfully run the demo application the HUAWEI ID Service and the Health Kit API should be authorized for your app as described in the [Applying for HUAWEI ID Service](#applying-for-the-huawei-id-service) and [Applying for the HUAWEI Health Kit](#applying-for-the-health-kit) sections. The required Health Kit permission scopes for the demo application are as follows:

- Read/Write Body height and weight data
- Read/Write Step count data
- Read/Write Distance and floor change data
- Read/Write Speed data
- Read/Write Calories data
- Read/Write Activity data
- Read/Write Location data
- Read/Write Heart rate data
- Read/Write User activity records data

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-health/example/.docs/screenshot1.jpg" width = 40% height = 40% style="margin:1.5em">

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

Huawei Safety Detect Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
