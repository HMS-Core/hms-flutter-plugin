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

class MLTtsEngine {
  /// The audio synthesized by the TTS engine is not automatically played by the internal player.
  static const int EXTERNAL_PLAYBACK = 2;

  /// The audio synthesized by the TTS engine is returned to the app through onAudioAvailable.
  static const int OPEN_STREAM = 4;

  /// Serial queuing mode.
  /// In this mode, multiple audio synthesis tasks are executed in the call sequence.
  static const int QUEUE_APPEND = 0;

  /// Queue clear mode.
  /// In this mode, the audio synthesis tasks to be executed are cleared,
  /// the audio synthesis task being executed is stopped,
  /// and a specified audio synthesis task is executed.
  static const int QUEUE_FLUSH = 1;

  late MethodChannel _c;
  MLTtsCallback? _callback;
  LanguageDownloadListener? _downloadListener;

  MLTtsEngine() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('hms_lang_tts');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  Future<List<String>> getLanguages() async {
    return await _c.invokeMethod(
      'getLanguages',
    );
  }

  Future<List<MLTtsSpeaker>> getSpeaker(String language) async {
    final List<dynamic> res = await _c.invokeMethod(
      'getSpeaker',
      <String, dynamic>{
        'language': language,
      },
    );
    return res.map((dynamic e) => MLTtsSpeaker.fromMap(e)).toList();
  }

  Future<List<MLTtsSpeaker>> getSpeakers() async {
    final List<dynamic> res = await _c.invokeMethod(
      'getSpeakers',
    );
    return res.map((dynamic e) => MLTtsSpeaker.fromMap(e)).toList();
  }

  Future<int> isLanguageAvailable(String language) async {
    return await _c.invokeMethod(
      'isLanguageAvailable',
      <String, dynamic>{
        'language': language,
      },
    );
  }

  void pause() {
    _c.invokeMethod(
      'pause',
    );
  }

  void resume() {
    _c.invokeMethod(
      'resume',
    );
  }

  void stop() {
    _c.invokeMethod(
      'stop',
    );
  }

  void shutdown() {
    _c.invokeMethod(
      'shutdown',
    );
  }

  void setPlayerVolume(int volume) {
    _c.invokeMethod(
      'setPlayerVolume',
      <String, dynamic>{
        'volume': volume,
      },
    );
  }

  void setTtsCallback(MLTtsCallback callback) {
    _callback = callback;
  }

  Future<String> speak(MLTtsConfig config) async {
    return await _c.invokeMethod(
      'speak',
      config.toMap(),
    );
  }

  Future<bool> isModelExist(String model) async {
    return await _c.invokeMethod(
      'isModelExist',
      <String, dynamic>{
        'model': model,
      },
    );
  }

  Future<bool> downloadModel(
    LanguageDownloadListener listener,
    String model, [
    LanguageModelDownloadStrategy? strategy,
  ]) async {
    _downloadListener = listener;
    return await _c.invokeMethod(
      'downloadModel',
      <String, dynamic>{
        'model': model,
        'strategy': strategy != null
            ? strategy.toMap()
            : LanguageModelDownloadStrategy().toMap(),
      },
    );
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    if (call.method == 'modelDownload') {
      _downloadListener?.call(
        all: call.arguments['all'],
        downloaded: call.arguments['downloaded'],
      );
    } else {
      final String event = call.arguments['event'];
      final String taskId = call.arguments['taskId'];
      switch (event) {
        case 'onError':
          final MLTtsError errObj = MLTtsError.fromMap(call.arguments);
          _callback?.onError.call(taskId, errObj);
          break;
        case 'onWarn':
          final MLTtsWarn warnObj = MLTtsWarn.fromMap(call.arguments);
          _callback?.onWarn?.call(taskId, warnObj);
          break;
        case 'onRangeStart':
          _callback?.onRangeStart?.call(
            taskId,
            call.arguments['start'],
            call.arguments['end'],
          );
          break;
        case 'onAudioAvailable':
          final MLTtsAudioFragment fragment =
              MLTtsAudioFragment.fromMap(call.arguments);
          _callback?.onAudioAvailable?.call(
            taskId,
            fragment,
            call.arguments['offset'],
          );
          break;
        case 'onEvent':
          _callback?.onEvent?.call(
            taskId,
            call.arguments['eventId'],
          );
          break;
        default:
          throw 'Unexpected event!';
      }
    }
    return Future<dynamic>.value(null);
  }
}
