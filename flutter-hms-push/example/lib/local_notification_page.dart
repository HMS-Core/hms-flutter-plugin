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
import 'package:huawei_push/huawei_push.dart';

class LocalNotificationPage extends StatefulWidget {
  LocalNotificationPage({Key? key}) : super(key: key);

  @override
  _LocalNotificationPageState createState() => _LocalNotificationPageState();
}

class _LocalNotificationPageState extends State<LocalNotificationPage> {
  final padding = EdgeInsets.symmetric(vertical: 1.0, horizontal: 10);
  final TextStyle _textStyle = TextStyle(fontSize: 16);

  TextEditingController titleTextController =
      TextEditingController(text: 'HMS PUSH');
  TextEditingController msgTextController =
      TextEditingController(text: 'This is local notification');
  TextEditingController bigTextController =
      TextEditingController(text: 'This is a big text');
  TextEditingController subTextController =
      TextEditingController(text: 'This is a sub text');
  TextEditingController tagTextController = TextEditingController();
  TextEditingController logTextController = TextEditingController();

  late Map<String, dynamic> receivedNotification;
  Map<String, dynamic> defaultNotification = {
    HMSLocalNotificationAttr.TITLE: 'Notification Title',
    HMSLocalNotificationAttr.MESSAGE: 'Notification Message',
    HMSLocalNotificationAttr.TICKER: 'Optional Ticker',
    HMSLocalNotificationAttr.SHOW_WHEN: true,
    // HMSLocalNotificationAttr.LARGE_ICON_URL: 'https://developer.huawei.com/Enexport/sites/default/images/en/Develop/hms/push/push2-tuidedao.png',
    HMSLocalNotificationAttr.LARGE_ICON: 'ic_launcher',
    // The notification small icon should be put under `android/app/res/mipmap` directory.
    HMSLocalNotificationAttr.SMALL_ICON: 'ic_notification',
    HMSLocalNotificationAttr.BIG_TEXT: 'This is a bigText',
    HMSLocalNotificationAttr.SUB_TEXT: 'This is a subText',
    HMSLocalNotificationAttr.COLOR: 'white',
    HMSLocalNotificationAttr.VIBRATE: false,
    HMSLocalNotificationAttr.VIBRATE_DURATION: 1000,
    HMSLocalNotificationAttr.TAG: 'hms_tag',
    HMSLocalNotificationAttr.GROUP_SUMMARY: false,
    HMSLocalNotificationAttr.ONGOING: false,
    HMSLocalNotificationAttr.IMPORTANCE: Importance.MAX,
    HMSLocalNotificationAttr.DONT_NOTIFY_IN_FOREGROUND: false,
    HMSLocalNotificationAttr.AUTO_CANCEL: false,
    HMSLocalNotificationAttr.ACTIONS: ["Yes", "No"],
    HMSLocalNotificationAttr.INVOKE_APP: false,
    HMSLocalNotificationAttr.DATA:
        Map<String, dynamic>.from({"string_val": "pushkit", "int_val": 15}),
    // HMSLocalNotificationAttr.CHANNEL_ID: 'huawei-hms-flutter-push-channel-id', // Please read the Android Documentation before using this param
  };

  Map<String, dynamic> _constructNotificationMap() {
    Map<String, dynamic> notification =
        Map<String, dynamic>.from(defaultNotification);
    notification[HMSLocalNotificationAttr.TAG] = tagTextController.text;
    notification[HMSLocalNotificationAttr.TITLE] = titleTextController.text;
    notification[HMSLocalNotificationAttr.BIG_TEXT] = bigTextController.text;
    notification[HMSLocalNotificationAttr.SUB_TEXT] = subTextController.text;
    notification[HMSLocalNotificationAttr.MESSAGE] = msgTextController.text;
    return notification;
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    Push.onLocalNotificationClick.listen(_onLocalNotificationClickEvent,
        onError: _onLocalNotificationClickErr);
  }

  void _onLocalNotificationClickEvent(Map<String, dynamic> event) {
    receivedNotification = event;
    if (mounted) {
      // Check if widget is still mounted to call setState
      showResult(
          "onLocalNotificationClickEvent", receivedNotification.toString());
    }
    Push.showToast("Clicked: " + receivedNotification['action']);
    if (receivedNotification[HMSLocalNotificationAttr.ACTION] == "Yes") {
      int id = int.parse(receivedNotification[HMSLocalNotificationAttr.ID]);
      String? tag = receivedNotification[HMSLocalNotificationAttr.TAG];
      if (tag != null) {
        Push.cancelNotificationsWithIdTag({id: tag}).then((_) => showResult(
            "cancelNotificationsWithIdTag",
            "Cancelled, Notification with id: $id, and tag: $tag"));
      } else {
        Push.cancelNotificationsWithId([id]).then((_) => showResult(
            "cancelNotificationsWithId",
            "Cancelled, Notification with id: $id"));
      }
    }
  }

  void _onLocalNotificationClickErr(dynamic err) =>
      showResult("onLocalNotificationClickError", err.toString());

  void _clearLog() {
    setState(() {
      logTextController.text = "";
    });
  }

  void _localNotification() async {
    try {
      Map<String, dynamic> notification = _constructNotificationMap();
      Map<String, dynamic> response =
          await Push.localNotification(notification);
      showResult("localNotification", response.toString());
    } catch (e) {
      showResult("localNotificationError", e.toString());
    }
  }

  void _localNotificationOngoing() async {
    try {
      Map<String, dynamic> ongoingNotification = _constructNotificationMap();
      ongoingNotification[HMSLocalNotificationAttr.ONGOING] = true;
      Map<String, dynamic> response =
          await Push.localNotification(ongoingNotification);
      showResult("localNotificationOngoing", response.toString());
    } catch (e) {
      showResult("localNotificationOngoingError", e.toString());
    }
  }

  void _localNotificationSound() async {
    try {
      Map<String, dynamic> soundNotification = _constructNotificationMap();
      soundNotification[HMSLocalNotificationAttr.PLAY_SOUND] = true;
      soundNotification[HMSLocalNotificationAttr.SOUND_NAME] =
          'huawei_bounce.mp3';
      Map<String, dynamic> response =
          await Push.localNotification(soundNotification);
      showResult("localNotificationSound", response.toString());
    } catch (e) {
      showResult("localNotificationSoundError", e.toString());
    }
  }

  void _localNotificationVibrate() async {
    try {
      Map<String, dynamic> vibrateNotification = _constructNotificationMap();
      vibrateNotification[HMSLocalNotificationAttr.VIBRATE] = true;
      vibrateNotification[HMSLocalNotificationAttr.VIBRATE_DURATION] = 5000.0;
      Map<String, dynamic> response =
          await Push.localNotification(vibrateNotification);
      showResult("localNotificationVibrate", response.toString());
    } catch (e) {
      showResult("localNotificationVibrateError", e.toString());
    }
  }

  void _localNotificationBigImage() async {
    try {
      Map<String, dynamic> bigImgNotification = _constructNotificationMap();
      bigImgNotification[HMSLocalNotificationAttr.BIG_PICTURE_URL] =
          'https://www-file.huawei.com/-/media/corp/home/image/logo_400x200.png';
      Map<String, dynamic> response =
          await Push.localNotification(bigImgNotification);
      showResult("localNotificationBigImage", response.toString());
    } catch (e) {
      showResult("localNotificationBigImageError", e.toString());
    }
  }

  void _localNotificationRepeat() async {
    try {
      Map<String, dynamic> repeatedNotification = _constructNotificationMap();
      repeatedNotification[HMSLocalNotificationAttr.REPEAT_TYPE] =
          RepeatType.MINUTE;
      Map<String, dynamic> response =
          await Push.localNotification(repeatedNotification);
      showResult("localNotificationRepeat", response.toString());
    } catch (e) {
      showResult("localNotificationRepeatError", e.toString());
    }
  }

  void _localNotificationScheduled() async {
    try {
      Map<String, dynamic> scheduledNotification = _constructNotificationMap();
      scheduledNotification[HMSLocalNotificationAttr.FIRE_DATE] =
          DateTime.now().add(Duration(minutes: 2)).millisecondsSinceEpoch;
      scheduledNotification[HMSLocalNotificationAttr.ALLOW_WHILE_IDLE] = true;
      Map<String, dynamic> response =
          await Push.localNotificationSchedule(scheduledNotification);
      showResult("localNotificationScheduled", response.toString());
    } catch (e) {
      showResult("localNotificationScheduledError", e.toString());
    }
  }

  void _channelBlocked() async {
    bool blocked = await Push.channelBlocked(
        'huawei-hms-flutter-push-channel-id-4-default');
    showResult("channelBlocked", blocked.toString());
  }

  void _channelExists() async {
    bool exists = await Push.channelExists(
        'huawei-hms-flutter-push-channel-id-4-default');
    showResult("channelExists", exists.toString());
  }

  void _getChannels() async {
    List<String> channels = await Push.getChannels();
    showResult("getChannels", channels.toString());
  }

  void _deleteChannel() async {
    String result = await Push.deleteChannel(
        "huawei-hms-flutter-push-channel-id-4-default");
    showResult("deleteChannel", result);
  }

  void _getNotifications() async {
    List notifications = await Push.getNotifications();
    showResult(
        "getNotifications",
        "Active Notifications: " +
            notifications.length.toString() +
            " notifications");
    print("getNotification result: " + notifications.toString());
  }

  void _getScheduledNotifications() async {
    List scheduledNotifications = await Push.getScheduledNotifications();
    showResult("getScheduledNotifications",
        scheduledNotifications.length.toString() + " scheduled notifications");
    print("getScheduledNotification result: " +
        scheduledNotifications.toString());
  }

  void showResult(String name, [String msg = "Button pressed."]) {
    appendLog("[" + name + "]" + ": " + msg);
    print("[" + name + "]" + ": " + msg);
    if (msg.isNotEmpty) Push.showToast(msg);
  }

  void appendLog([String msg = "Button pressed."]) {
    setState(() {
      logTextController.text = msg + "\n" + logTextController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Widget customTextField(TextEditingController controller, String hintText,
      {EdgeInsets? customPadding}) {
    return Padding(
      padding: customPadding ?? padding,
      child: Container(
        child: TextField(
          controller: controller,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            ),
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Widget labelText(String text) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: _textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget customButton(String label, Function() callback, {Color? color}) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: padding.copyWith(top: 0.0, bottom: 0.0),
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.grey.shade300,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Push Kit Demo - LocalNotification',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              labelText('Title: '),
              Expanded(
                flex: 5,
                child: customTextField(titleTextController, 'Title',
                    customPadding: EdgeInsets.fromLTRB(0.0, 1.0, 1.0, 1.0)),
              ),
              Expanded(
                flex: 5,
                child: customTextField(
                  tagTextController,
                  'Tag',
                  customPadding: EdgeInsets.fromLTRB(0.0, 1.0, 10.0, 1.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              labelText('Message: '),
              Expanded(
                  flex: 5,
                  child: customTextField(msgTextController, 'Message')),
            ],
          ),
          Row(
            children: [
              labelText('BigText: '),
              Expanded(
                  flex: 5,
                  child: customTextField(bigTextController, 'Big Text')),
            ],
          ),
          Row(
            children: [
              labelText('SubText: '),
              Expanded(
                  flex: 5,
                  child: customTextField(subTextController, 'Sub Text')),
            ],
          ),
          Row(
            children: [
              customButton(
                  'Local Notification (Default)', () => _localNotification(),
                  color: Colors.blue),
            ],
          ),
          Row(
            children: [
              customButton('+ Ongoing', () => _localNotificationOngoing(),
                  color: Colors.blue),
              customButton('+ Sound', () => _localNotificationSound(),
                  color: Colors.blue),
              customButton('+ Vibrate', () => _localNotificationVibrate(),
                  color: Colors.blue),
            ],
          ),
          Row(
            children: [
              customButton('+ BigImage', () => _localNotificationBigImage(),
                  color: Colors.blue),
              customButton('+ Repeat', () => _localNotificationRepeat(),
                  color: Colors.blue),
              customButton('+ Scheduled', () => _localNotificationScheduled(),
                  color: Colors.blue),
            ],
          ),
          Row(
            children: [
              customButton(
                  'cancelAllNotifications',
                  () => Push.cancelAllNotifications().then(
                      (_) => showResult("cancelAllNotifications", "Success"))),
              customButton('getNotifications', () => _getNotifications()),
            ],
          ),
          Row(
            children: [
              customButton(
                  'cancelScheduledNotifications',
                  () => Push.cancelScheduledNotifications().then((_) =>
                      showResult("cancelScheduledNotifications", "Success"))),
              customButton('getScheduledNotifications',
                  () => _getScheduledNotifications()),
            ],
          ),
          Row(
            children: [
              customButton(
                  'cancelNotificationsWithTag',
                  () => Push.cancelNotificationsWithTag('hms_tag').then((_) =>
                      showResult("cancelNotificationsWithTag", "Success"))),
              customButton('getChannels', () => _getChannels()),
            ],
          ),
          Row(
            children: [
              customButton(
                  'cancelNotifications',
                  () => Push.cancelNotifications().then(
                      (_) => showResult("cancelNotifications", "Success"))),
              customButton('deleteChannel', () => _deleteChannel()),
            ],
          ),
          Row(
            children: [
              customButton('channelBlocked', () => _channelBlocked()),
              customButton('channelExists', () => _channelExists()),
            ],
          ),
          Row(
            children: [customButton('clearLog', () => _clearLog())],
          ),
          Padding(
            padding: padding.copyWith(top: 10.0, bottom: 10.0),
            child: Divider(
              height: 1.0,
              thickness: 2.0,
            ),
          ),
          Padding(
            padding: padding,
            child: TextField(
              controller: logTextController,
              keyboardType: TextInputType.multiline,
              maxLines: 15,
              readOnly: true,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
