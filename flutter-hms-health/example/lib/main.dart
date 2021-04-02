/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_health/huawei_health.dart';

void main() => runApp(HealthKitDemo());

/// Options for logging.
enum LogOptions { call, success, error, custom }

class HealthKitDemo extends StatefulWidget {
  @override
  _HealthKitDemoState createState() => _HealthKitDemoState();
}

class _HealthKitDemoState extends State<HealthKitDemo> {
  /// Styles
  static const TextStyle cardTitleTextStyle =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  static const EdgeInsets componentPadding = EdgeInsets.all(8.0);

  /// Text Controllers for showing the logs of different modules
  TextEditingController _activityTextController = TextEditingController();
  TextEditingController _dataTextController = TextEditingController();
  TextEditingController _settingTextController = TextEditingController();
  TextEditingController _autoRecorderTextController = TextEditingController();
  TextEditingController _consentTextController = TextEditingController();

  /// Data controller reference to initialize at startup.
  DataController _dataController;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (!mounted) return;
    // Initialize Event Callbacks
    AutoRecorderController.autoRecorderStream.listen(_onAutoRecorderEvent);
    // Initialize a DataController
    initDataController();
  }

  /// Prints the specified text on both the console and the specified text controller.
  void log(
      String methodName, TextEditingController controller, LogOptions logOption,
      {String result = "", String error = ""}) {
    String log = "";
    switch (logOption) {
      case LogOptions.call:
        log = methodName + " called";
        break;
      case LogOptions.success:
        log = methodName + " [Success: $result] ";
        break;
      case LogOptions.error:
        log = methodName +
            "[Error: $error] [Error Description: ${HiHealthStatusCodes.getStatusCodeMessage(error)}]";
        break;
      case LogOptions.custom:
        log = methodName; // Custom text
        break;
    }
    print(log);
    setState(() {
      controller.text = log + '\n' + controller.text;
    });
  }

  /// Authorizes Huawei Health Kit for the user, with defined scopes.
  void signIn(BuildContext context) async {
    // List of scopes to ask for authorization.
    //
    // Note: These scopes should also be authorized on the Huawei Developer Console.
    List<Scope> scopes = [
      Scope.HEALTHKIT_HEIGHTWEIGHT_READ,
      Scope.HEALTHKIT_HEIGHTWEIGHT_WRITE,
      Scope.HEALTHKIT_ACTIVITY_WRITE,
      Scope.HEALTHKIT_ACTIVITY_READ,
      Scope.HEALTHKIT_HEARTRATE_READ,
      Scope.HEALTHKIT_HEARTRATE_WRITE,
      Scope.HEALTHKIT_STEP_WRITE,
      Scope.HEALTHKIT_STEP_READ,
      Scope.HEALTHKIT_STEP_REALTIME,
      Scope.HEALTHKIT_DISTANCE_WRITE,
      Scope.HEALTHKIT_DISTANCE_READ,
      Scope.HEALTHKIT_SPEED_WRITE,
      Scope.HEALTHKIT_SPEED_READ,
      Scope.HEALTHKIT_LOCATION_WRITE,
      Scope.HEALTHKIT_LOCATION_READ,
      Scope.HEALTHKIT_ACTIVITY_RECORD_WRITE,
      Scope.HEALTHKIT_ACTIVITY_RECORD_READ,
      Scope.HEALTHKIT_CALORIES_READ,
      Scope.HEALTHKIT_CALORIES_WRITE
    ];
    try {
      AuthHuaweiId result = await HealthAuth.signIn(scopes);
      print("Granted Scopes for User(${result.displayName}): " +
          result.grantedScopes.toString());
      showSnackBar('Authorization Success.', context, color: Colors.green);
    } on PlatformException catch (e) {
      print("Error on authorization, Error:${e.toString()}");
      showSnackBar(
          "Error on authorization, Error:${e.toString()}, Error Description: " +
              "${HiHealthStatusCodes.getStatusCodeMessage(e.message)}",
          context);
    }
  }

  // ActivityRecordsController
  //
  /// Adds an ActivityRecord with an ActivitySummary, time range is 2 hours from now.
  Future<void> addActivityRecord() async {
    log("addActivityRecord", _activityTextController, LogOptions.call);
    // Create start time that will be used to add activity record.
    DateTime startTime = DateTime.now();

    // Create end time that will be used to add activity record.
    DateTime endTime = DateTime.now().add(Duration(hours: 2));

    // Build an ActivityRecord object
    ActivityRecord activityRecord = ActivityRecord(
      startTime: startTime,
      endTime: endTime,
      id: 'ActivityRecordRun1923',
      name: 'BeginActivityRecordSteps',
      description: 'This is a test for ActivityRecord',
      // Optional Activity Summary
      activitySummary: ActivitySummary(
          paceSummary:
              PaceSummary(avgPace: 247.27626, bestPace: 212, britishPaceMap: {
            "50001893": 365.0,
          }, britishPartTimeMap: {
            "1.0": 263.0
          }, partTimeMap: {
            "1.0": 456.0
          }, paceMap: {
            "1.0": 263
          }, sportHealthPaceMap: {
            "102802480": 535.0
          }),
          dataSummary: <SamplePoint>[
            SamplePoint(
                startTime: startTime,
                endTime: endTime,
                fieldValueOptions: FieldInt(Field.FIELD_STEPS_DELTA, 100),
                dataCollector: DataCollector(
                    dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
                    dataGenerateType: DataGenerateType.DATA_TYPE_RAW))
          ]),
    );

    // Build the dataCollector object
    DataCollector dataCollector = DataCollector(
        dataGenerateType: DataGenerateType.DATA_TYPE_RAW,
        dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
        name: 'AddActivityRecord1923');

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

    try {
      String result = await ActivityRecordsController.addActivityRecord(
        ActivityRecordInsertOptions(
            activityRecord: activityRecord, sampleSets: [sampleSet]),
      );
      log("addActivityRecord", _activityTextController, LogOptions.success,
          result: result);
    } on PlatformException catch (e) {
      log("addActivityRecord", _activityTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Obtains saved ActivityRecords between yesterday and now,
  /// with the DT_CONTINUOUS_STEPS_DELTA data type
  void getActivityRecord() async {
    log('getActivityRecord', _activityTextController, LogOptions.call);
    // Create start time that will be used to read activity record.
    DateTime startTime = DateTime.now().subtract(Duration(days: 1));

    // Create end time that will be used to read activity record.
    DateTime endTime = DateTime.now().add(Duration(hours: 3));

    ActivityRecordReadOptions activityRecordReadOptions =
        ActivityRecordReadOptions(
      activityRecordId: null,
      activityRecordName: null,
      startTime: startTime,
      endTime: endTime,
      timeUnit: TimeUnit.MILLISECONDS,
      dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
    );
    try {
      List<ActivityRecord> result =
          await ActivityRecordsController.getActivityRecord(
              activityRecordReadOptions);
      log('getActivityRecord', _activityTextController, LogOptions.success,
          result: '[IDs: ' + result.map((e) => e.id).toList().toString() + ']');
    } on PlatformException catch (e) {
      log('getActivityRecord', _activityTextController, LogOptions.error,
          result: e.message);
    }
  }

  /// Starts the ActivityRecord with the id:`ActivityRecordRun1`
  void beginActivityRecord() async {
    try {
      log('beginActivityRecord', _activityTextController, LogOptions.call);
      // Build an ActivityRecord object
      ActivityRecord activityRecord = ActivityRecord(
        id: 'ActivityRecordRun0',
        name: 'BeginActivityRecord',
        description: 'This is ActivityRecord begin test!',
        activityTypeId: HiHealthActivities.running,
        startTime: DateTime.now().subtract(Duration(hours: 1)),
      );
      await ActivityRecordsController.beginActivityRecord(activityRecord);
      log('beginActivityRecord', _activityTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('beginActivityRecord', _activityTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Stops the ActivityRecord with the id:`ActivityRecordRun1`
  void endActivityRecord() async {
    try {
      log('endActivityRecord', _activityTextController, LogOptions.call);
      final List<ActivityRecord> result =
          await ActivityRecordsController.endActivityRecord(
        'ActivityRecordRun0',
      );
      // Return the list of activity records that have stopped
      log('endActivityRecord', _activityTextController, LogOptions.success,
          result: result.toString());
    } on PlatformException catch (e) {
      log('endActivityRecord', _activityTextController, LogOptions.error,
          result: e.message);
    }
  }

  /// Ends all the ongoing activity records.
  ///
  /// Result list will be null if there is no ongoing activity record.
  void endAllActivityRecords() async {
    try {
      log('endAllActivityRecords', _activityTextController, LogOptions.call);
      // Return the list of activity records that have stopped
      List<ActivityRecord> result =
          await ActivityRecordsController.endAllActivityRecords();
      log('endAllActivityRecords', _activityTextController, LogOptions.success,
          result: '[IDs: ' + result.map((e) => e.id).toList().toString() + ']');
    } on PlatformException catch (e) {
      log('endAllActivityRecords', _activityTextController, LogOptions.error,
          result: e.message);
    }
  }
  //
  //
  // End of ActivityRecordsController Methods

  // DataController Methods
  //
  //
  /// Initializes a DataController instance with a list of HiHealtOptions.
  void initDataController() async {
    if (!mounted) return;
    log('init', _dataTextController, LogOptions.call);
    try {
      _dataController = await DataController.init(<HiHealthOption>[
        HiHealthOption(DataType.DT_CONTINUOUS_STEPS_DELTA, AccessType.read),
        HiHealthOption(DataType.DT_CONTINUOUS_STEPS_DELTA, AccessType.write),
        HiHealthOption(DataType.DT_INSTANTANEOUS_HEIGHT, AccessType.read),
        HiHealthOption(DataType.DT_INSTANTANEOUS_HEIGHT, AccessType.write)
      ]);
      log('init', _dataTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('init', _dataTextController, LogOptions.error, error: e.message);
    }
  }

  /// Clears all the data inserted by the app.
  void clearAll() async {
    log('clearAll', _dataTextController, LogOptions.call);
    try {
      await _dataController.clearAll();
      log('clearAll', _dataTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('clearAll', _dataTextController, LogOptions.error, error: e.message);
    }
  }

  /// Deletes DT_CONTINUOUS_STEPS_DELTA type data by the specified time range.
  void delete() async {
    log('delete', _dataTextController, LogOptions.call);
    // Build the dataCollector object
    DataCollector dataCollector = DataCollector(
        dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
        dataGenerateType: DataGenerateType.DATA_TYPE_RAW,
        dataStreamName: 'STEPS_DELTA');

    // Build the time range for the deletion: start time and end time.
    DeleteOptions deleteOptions = DeleteOptions(
        dataCollectors: <DataCollector>[dataCollector],
        startTime: DateTime.parse('2020-10-10 08:00:00'),
        endTime: DateTime.parse('2020-10-10 12:30:00'));

    // Call the api with the constructed DeleteOptions instance.
    try {
      _dataController.delete(deleteOptions);
      log('delete', _dataTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('delete', _dataTextController, LogOptions.error, error: e.message);
    }
  }

  /// Inserts a sampling set with the DT_CONTINUOUS_STEPS_DELTA data type at the
  /// specified start and end dates.
  void insert() async {
    log('insert', _dataTextController, LogOptions.call);
    // Build the dataCollector object
    DataCollector dataCollector = DataCollector(
        dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
        dataStreamName: 'STEPS_DELTA',
        dataGenerateType: DataGenerateType.DATA_TYPE_RAW);
    // You can use sampleSets to add more sampling points to the sampling dataset.
    SampleSet sampleSet = SampleSet(dataCollector, <SamplePoint>[
      SamplePoint(
          startTime: DateTime.parse('2020-10-10 12:00:00'),
          endTime: DateTime.parse('2020-10-10 12:12:00'),
          fieldValueOptions: FieldInt(Field.FIELD_STEPS_DELTA, 100))
    ]);
    // Call the api with the constructed sample set.
    try {
      _dataController.insert(sampleSet);
      log('insert', _dataTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('insert', _dataTextController, LogOptions.error, error: e.message);
    }
  }

  // Reads the user data between the specified start and end dates.
  void read() async {
    log('read', _dataTextController, LogOptions.call);
    // Build the dataCollector object
    DataCollector dataCollector = DataCollector(
        dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
        dataGenerateType: DataGenerateType.DATA_TYPE_RAW,
        dataStreamName: 'STEPS_DELTA');

    // Build the time range for the query: start time and end time.
    ReadOptions readOptions = ReadOptions(
      dataCollectors: [dataCollector],
      startTime: DateTime.parse('2020-10-10 12:00:00'),
      endTime: DateTime.parse('2020-10-10 12:12:00'),
    )..groupByTime(10000);

    // Call the api with the constructed ReadOptions instance.
    try {
      ReadReply readReply = await _dataController.read(readOptions);
      log('read', _dataTextController, LogOptions.success,
          result: readReply.toString());
    } on PlatformException catch (e) {
      log('read', _dataTextController, LogOptions.error, error: e.message);
    }
  }

  /// Reads the daily summation between the dates: `2020.10.02` to `2020.12.15`
  /// Note that the time format is different for this method.
  void readDailySummation() async {
    log('readDailySummation', _dataTextController, LogOptions.call);
    try {
      SampleSet sampleSet = await _dataController.readDailySummation(
          DataType.DT_CONTINUOUS_STEPS_DELTA, 20201002, 20201215);
      log('readDailySummation', _dataTextController, LogOptions.success,
          result: sampleSet.toString());
    } on PlatformException catch (e) {
      log('readDailySummation', _dataTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Reads the steps summation for today.
  void readTodaySummation() async {
    log('readTodaySummation', _dataTextController, LogOptions.call);
    try {
      SampleSet sampleSet = await _dataController
          .readTodaySummation(DataType.DT_CONTINUOUS_STEPS_DELTA);
      log('readTodaySummation', _dataTextController, LogOptions.success,
          result: sampleSet.toString());
    } on PlatformException catch (e) {
      log('readTodaySummation', _dataTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Updates DT_CONTINUOUS_STEPS_DELTA for the specified dates.
  void update() async {
    log('update', _dataTextController, LogOptions.call);

    // Build the dataCollector object
    DataCollector dataCollector = DataCollector(
        dataType: DataType.DT_CONTINUOUS_STEPS_DELTA,
        dataStreamName: 'STEPS_DELTA',
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
    try {
      await _dataController.update(updateOptions);
      log('update', _dataTextController, LogOptions.success,
          result: sampleSet.toString());
    } on PlatformException catch (e) {
      log('update', _dataTextController, LogOptions.error, error: e.message);
    }
  }
  //
  //
  // End of DataController Methods

  // SettingController Methods
  //
  /// Adds a custom DataType with the FIELD_ALTITUDE.
  void addDataType() async {
    log('addDataType', _settingTextController, LogOptions.call);
    try {
      // The name of the created data type must be prefixed with the package name
      // of the app. Otherwise, the creation fails. If the same data type is tried to
      // be added again an exception will be thrown.
      DataTypeAddOptions options = DataTypeAddOptions(
          "com.huawei.hms.flutter.health_example.myCustomDataType",
          [Field.newIntField("myIntField"), Field.FIELD_ALTITUDE]);
      final DataType dataTypeResult =
          await SettingController.addDataType(options);
      log('addDataType', _settingTextController, LogOptions.success,
          result: dataTypeResult.toString());
    } on PlatformException catch (e) {
      log('addDataType', _settingTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Reads the inserted data type on the [addDataType] method.
  void readDataType() async {
    log('readDataType', _settingTextController, LogOptions.call);
    try {
      final DataType dataTypeResult = await SettingController.readDataType(
        "com.huawei.hms.flutter.health_example.myCustomDataType",
      );
      log('readDataType', _settingTextController, LogOptions.success,
          result: dataTypeResult.toString());
    } on PlatformException catch (e) {
      log('readDataType', _settingTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Disables the Health Kit function, cancels user authorization, and cancels
  /// all data records. (The task takes effect in 24 hours.)
  void disableHiHealth() async {
    log('disableHiHealth', _settingTextController, LogOptions.call);
    try {
      await SettingController.disableHiHealth();
      log(
        'disableHiHealth',
        _settingTextController,
        LogOptions.success,
      );
    } on PlatformException catch (e) {
      log('disableHiHealth', _settingTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Checks the user privacy authorization to Health Kit. Redirects the user to
  /// the Authorization screen if the permissions are not given.
  void checkHealthAppAuthorization() async {
    log('checkHealthAppAuthorization', _settingTextController, LogOptions.call);
    try {
      await SettingController.checkHealthAppAuthorization();
      log(
        'checkHealthAppAuthorization',
        _settingTextController,
        LogOptions.success,
      );
    } on PlatformException catch (e) {
      log('checkHealthAppAuthorization', _settingTextController,
          LogOptions.error,
          error: e.message);
    }
  }

  /// Checks the user privacy authorization to Health Kit. If authorized `true`
  /// value would be returned.
  void getHealthAppAuthorization() async {
    log('getHealthAppAuthorization', _settingTextController, LogOptions.call);
    try {
      final bool result = await SettingController.getHealthAppAuthorization();
      log('getHealthAppAuthorization', _settingTextController,
          LogOptions.success,
          result: result.toString());
    } on PlatformException catch (e) {
      log('getHealthAppAuthorization', _settingTextController, LogOptions.error,
          error: e.message);
    }
  }
  //
  //
  // End of SettingController Methods

  // AutoRecorderController Methods
  //
  //
  // Callback function for AutoRecorderStream event.
  void _onAutoRecorderEvent(SamplePoint res) {
    log(
        "[AutoRecorderEvent] obtained, SamplePoint Field Value is " +
            res.fieldValues.toString(),
        _autoRecorderTextController,
        LogOptions.custom);
  }

  /// Starts an Android Foreground Service to count the steps of the user.
  /// The steps will be emitted to the AutoRecorderStream.
  void startRecord() async {
    log('startRecord', _autoRecorderTextController, LogOptions.call);
    try {
      await AutoRecorderController.startRecord(
        DataType.DT_CONTINUOUS_STEPS_TOTAL,
        NotificationProperties(
            title: "HMS Flutter Health Demo",
            text: "Counting steps",
            subText: "this is a subtext",
            ticker: "this is a ticker",
            showChronometer: true),
      );
      log('startRecord', _autoRecorderTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('startRecord', _autoRecorderTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Ends the Foreground service and stops the step count events.
  void stopRecord() async {
    log('endRecord', _autoRecorderTextController, LogOptions.call);
    try {
      await AutoRecorderController.stopRecord(
          DataType.DT_CONTINUOUS_STEPS_TOTAL);
      log('endRecord', _autoRecorderTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('endRecord', _autoRecorderTextController, LogOptions.error,
          error: e.message);
    }
  }
  //
  //
  // End of AutoRecorderController Methods

  // ConsentController Methods
  //
  /// Obtains the application id from the agconnect-services.json file.
  void getAppId() async {
    log('getAppId', _consentTextController, LogOptions.call);
    try {
      final String appId = await ConsentsController.getAppId();
      log('getAppId', _consentTextController, LogOptions.success,
          result: appId);
    } on PlatformException catch (e) {
      log('getAppId', _consentTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Gets the granted permission scopes for the app.
  void getScopes() async {
    log('getScopes', _consentTextController, LogOptions.call);
    try {
      final String appId = await ConsentsController.getAppId();
      final ScopeLangItem scopeLangItem =
          await ConsentsController.getScopes('en-gb', appId);
      log('getScopes', _consentTextController, LogOptions.success,
          result: scopeLangItem.toString());
    } on PlatformException catch (e) {
      log('getScopes', _consentTextController, LogOptions.error,
          error: e.message);
    }
  }

  /// Revokes all the permissions that authorized for this app.
  void revoke() async {
    log('revoke', _consentTextController, LogOptions.call);
    try {
      final String appId = await ConsentsController.getAppId();
      await ConsentsController.revoke(appId);
      log('revoke', _consentTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('revoke', _consentTextController, LogOptions.error, error: e.message);
    }
  }

  /// Revokes the distance read/write permissions for the app.
  void revokeWithScopes() async {
    log('revokeWithScopes', _consentTextController, LogOptions.call);
    try {
      // Obtain the application id.
      final String appId = await ConsentsController.getAppId();
      // Call the revokeWithScopes method with desired scopes.
      await ConsentsController.revokeWithScopes(appId, [
        Scope.HEALTHKIT_DISTANCE_WRITE,
        Scope.HEALTHKIT_DISTANCE_READ,
      ]);
      log('revokeWithScopes', _consentTextController, LogOptions.success);
    } on PlatformException catch (e) {
      log('revokeWithScopes', _consentTextController, LogOptions.error,
          error: e.message);
    }
  }
  //
  //
  // End of ConsentController Methods

  // App's widgets.
  //
  //
  Widget expansionCard({String titleText, List<Widget> children}) {
    return Card(
      margin: componentPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        title: Text(
          titleText,
          style: cardTitleTextStyle,
        ),
        children: children,
      ),
    );
  }

  Widget loggingArea(TextEditingController moduleTextController) {
    return Column(children: [
      Container(
        margin: componentPadding,
        padding: const EdgeInsets.all(8.0),
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black12)),
        child: TextField(
          readOnly: true,
          maxLines: 15,
          controller: moduleTextController,
          decoration: InputDecoration(enabledBorder: InputBorder.none),
        ),
      ),
      OutlineButton(
        child: Text('Clear Log'),
        onPressed: () => setState(
          () {
            moduleTextController.text = "";
          },
        ),
      )
    ]);
  }

  showSnackBar(String text, BuildContext context, {Color color = Colors.blue}) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color,
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          Scaffold.of(context).removeCurrentSnackBar();
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Huawei Health Kit for Flutter',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              Icon(
                Icons.local_hospital,
                color: Colors.blue,
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Builder(builder: (BuildContext context) {
          return ListView(children: [
            // Sign In Widgets
            Card(
              margin: componentPadding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: componentPadding,
                    child: const Text(
                        "Tap to SignIn button to obtain the HMS Account to complete " +
                            "login and authorization, and then use other buttons " +
                            "to try the related API functions.",
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: componentPadding,
                    child: Text(
                      "Note: If the login page is not displayed, change the package " +
                          "name, AppID, and configure the signature file by referring " +
                          "to the developer guide on the official website.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Container(
                    padding: componentPadding,
                    width: double.infinity,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        'SignIn',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => signIn(context),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            // ActivityRecordsController
            expansionCard(
              titleText: "ActivityRecords Controller",
              children: [
                loggingArea(_activityTextController),
                ListTile(
                  title: Text('AddActivityRecord'),
                  onTap: () => addActivityRecord(),
                ),
                ListTile(
                  title: Text('GetActivityRecord'),
                  onTap: () => getActivityRecord(),
                ),
                ListTile(
                  title: Text('beginActivityRecord'),
                  onTap: () => beginActivityRecord(),
                ),
                ListTile(
                  title: Text('endActivityRecord'),
                  onTap: () => endActivityRecord(),
                ),
                ListTile(
                  title: Text('endAllActivityRecords'),
                  onTap: () => endAllActivityRecords(),
                ),
              ],
            ),
            // DataController Widgets
            expansionCard(
              titleText: 'DataController',
              children: [
                loggingArea(_dataTextController),
                ListTile(
                  title: Text('readTodaySummation'),
                  onTap: () => readTodaySummation(),
                ),
                ListTile(
                  title: Text('readDailySummation'),
                  onTap: () => readDailySummation(),
                ),
                ListTile(
                  title: Text('insert'),
                  onTap: () => insert(),
                ),
                ListTile(
                  title: Text('read'),
                  onTap: () => read(),
                ),
                ListTile(
                  title: Text('update'),
                  onTap: () => update(),
                ),
                ListTile(
                  title: Text('delete'),
                  onTap: () => delete(),
                ),
                ListTile(
                  title: Text('clearAll'),
                  onTap: () => clearAll(),
                ),
              ],
            ),
            // SettingController Widgets.
            expansionCard(
              titleText: 'SettingController',
              children: [
                loggingArea(_settingTextController),
                ListTile(
                  title: Text('addDataType'),
                  onTap: () => addDataType(),
                ),
                ListTile(
                  title: Text('readDataType'),
                  onTap: () => readDataType(),
                ),
                ListTile(
                  title: Text('disableHiHealth'),
                  onTap: () => disableHiHealth(),
                ),
                ListTile(
                  title: Text('checkHealthAppAuthorization'),
                  onTap: () => checkHealthAppAuthorization(),
                ),
                ListTile(
                  title: Text('getHealthAppAuthorization'),
                  onTap: () => getHealthAppAuthorization(),
                ),
              ],
            ),
            // AutoRecorderController Widgets
            expansionCard(
              titleText: 'AutoRecorderController',
              children: [
                loggingArea(_autoRecorderTextController),
                ListTile(
                  title: Text('startRecord'),
                  onTap: () => startRecord(),
                ),
                ListTile(
                  title: Text('stopRecord'),
                  onTap: () => stopRecord(),
                ),
              ],
            ),
            // Consent Controller Widgets
            expansionCard(
              titleText: 'ConsentController',
              children: [
                loggingArea(_consentTextController),
                ListTile(
                  title: Text('getAppId'),
                  onTap: () => getAppId(),
                ),
                ListTile(
                  title: Text('getScopes'),
                  onTap: () => getScopes(),
                ),
                ListTile(
                  title: Text('revoke'),
                  onTap: () => revoke(),
                ),
                ListTile(
                  title: Text('revokeWithScopes'),
                  onTap: () => revokeWithScopes(),
                ),
              ],
            ),
          ]);
        }),
      ),
    );
  }
}
