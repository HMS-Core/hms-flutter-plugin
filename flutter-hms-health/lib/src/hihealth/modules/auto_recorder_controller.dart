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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_health/huawei_health.dart';

/// Provides the capabilities to read data in real time and cancels the reading.
///
/// AutoRecorderController supports real-time data reading only for `DT_CONTINUOUS_STEPS_TOTAL`.
class AutoRecorderController {
  static const MethodChannel _methodChannel =
      health_auto_recorder_method_channel;
  static const EventChannel _eventChannel = health_auto_recorder_event_channel;

  /// Stream that emits [SamplePoint]s after [startRecord] is activated.
  static Stream<SamplePoint> get autoRecorderStream => _eventChannel
      .receiveBroadcastStream()
      .map((event) => event = SamplePoint.fromMap(jsonDecode(event)))
      .cast<SamplePoint>();

  /// Starts real-time data reading by specifying the data type.
  ///
  /// This method will trigger a foreground service that has an ongoing(sticky)
  /// notification. The notification properties can be customized by specifying a
  /// [NotificationProperties] instance.
  /// The [SamplePoint] results that include the count of steps are emitted to the
  /// [autoRecorderStream].
  ///
  /// If there is an ongoing AutoRecorder service present, an exception will be thrown.
  static Future<void> startRecord(
      DataType dataType, NotificationProperties notificationProperties) async {
    _methodChannel.invokeMethod('startRecord', {
      "dataType": dataType.toMap(),
      "notification": notificationProperties.toMap()
    });
  }

  /// Stops the ongoing AutoRecorder service.
  static Future<void> stopRecord(DataType dataType) async {
    _methodChannel.invokeMethod('stopRecord', dataType.toMap());
  }
}

class NotificationProperties {
  final String title;
  final String text;
  final String subText;
  final String ticker;
  final bool showChronometer;

  NotificationProperties(
      {this.title, this.text, this.subText, this.ticker, this.showChronometer});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "text": text,
      "subText": subText,
      "ticker": ticker,
      "chronometer": showChronometer
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return super.toString();
  }
}
