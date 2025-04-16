/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_language.dart';

class MLRemoteAftEngine {
  late MethodChannel _c;
  MLRemoteAftListener? _listener;

  MLRemoteAftEngine() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('hms_lang_aft');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  /// Sets the audio transcription listener on the cloud.
  void setAftListener(MLRemoteAftListener listener) {
    _listener = listener;
  }

  /// Obtains languages supported for short audio file transcription.
  Future<List<String>?> getShortAftLanguages() async {
    final List<dynamic>? res = await _c.invokeMethod(
      'shortAftLang',
    );
    return res != null ? List<String>.from(res) : null;
  }

  /// Obtains languages supported for long audio file transcription.
  Future<List<String>?> getLongAftLanguages() async {
    final List<dynamic>? res = await _c.invokeMethod(
      'longAftLang',
    );
    return res != null ? List<String>.from(res) : null;
  }

  /// Disables the audio transcription engine to release engine resources.
  void close() {
    _c.invokeMethod(
      'close',
    );
  }

  /// Resumes a long audio transcription task on the cloud.
  void startTask(String taskId) {
    _c.invokeMethod(
      'startTask',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Pauses a long audio transcription task on the cloud.
  void pauseTask(String taskId) {
    _c.invokeMethod(
      'pauseTask',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Resumes a long audio transcription task on the cloud.
  void destroyTask(String taskId) {
    _c.invokeMethod(
      'destroyTask',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Obtains the long audio transcription result from the cloud.
  void getLongAftResult(String taskId) {
    _c.invokeMethod(
      'getLongAftResult',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Converts a short audio file on the cloud.
  void shortRecognize(MLRemoteAftSetting setting) {
    _c.invokeMethod(
      'shortRecognize',
      setting.toMap(),
    );
  }

  /// Converts a long audio file on the cloud.
  void longRecognize(MLRemoteAftSetting setting) {
    _c.invokeMethod(
      'longRecognize',
      setting.toMap(),
    );
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final String taskId = call.arguments['taskId'];
    final String event = call.arguments['event'];

    switch (event) {
      case 'onResult':
        final MLRemoteAftResult res = MLRemoteAftResult.fromMap(
          call.arguments['result'],
        );
        _listener!.onResult.call(taskId, res);
        break;
      case 'onError':
        _listener!.onError.call(
          taskId,
          call.arguments['errorCode'],
          call.arguments['message'],
        );
        break;
      case 'onInitComplete':
        _listener!.onInitComplete.call(taskId);
        break;
      case 'onUploadProgress':
        _listener!.onUploadProgress.call(
          taskId,
          call.arguments['progress'],
        );
        break;
      case 'onEvent':
        _listener!.onEvent.call(
          taskId,
          call.arguments['eventId'],
        );
        break;
      default:
        throw 'Unexpected event!';
    }
    return Future<dynamic>.value(null);
  }
}
