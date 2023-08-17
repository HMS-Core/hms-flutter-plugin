/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

/// Provides the capabilities to read data in real time and cancels the reading.
///
/// AutoRecorderController supports real-time data reading only for `DT_CONTINUOUS_STEPS_TOTAL`.
class AutoRecorderController {
  static const MethodChannel _methodChannel = _healthAutoRecorderMethodChannel;
  static const EventChannel _eventChannel = _healthAutoRecorderEventChannel;

  /// Stream that emits [SamplePoint]s after [startRecord] is activated.
  static Stream<SamplePoint?> get autoRecorderStream =>
      _eventChannel.receiveBroadcastStream().map((dynamic e) {
        if (e != null) {
          return SamplePoint.fromMap(jsonDecode(e));
        }
      }).cast<SamplePoint?>();

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
    DataType dataType,
    NotificationProperties? notificationProperties,
  ) async {
    await _methodChannel.invokeMethod<void>(
      'startRecord',
      <String, dynamic>{
        'dataType': dataType.toMap(),
        'notification': notificationProperties?.toMap(),
      },
    );
  }

  /// Stops the ongoing AutoRecorder service.
  static Future<void> stopRecord(
    DataType dataType,
  ) async {
    await _methodChannel.invokeMethod<void>(
      'stopRecord',
      dataType.toMap(),
    );
  }
}

class NotificationProperties {
  final String title;
  final String text;
  final String subText;
  final String ticker;
  final bool showChronometer;

  NotificationProperties({
    required this.title,
    required this.text,
    required this.subText,
    required this.ticker,
    required this.showChronometer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'text': text,
      'subText': subText,
      'ticker': ticker,
      'chronometer': showChronometer,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
