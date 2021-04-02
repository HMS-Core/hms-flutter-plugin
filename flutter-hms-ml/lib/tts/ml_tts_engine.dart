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

import 'dart:async';

import 'package:huawei_ml/tts/ml_tts_config.dart';
import 'package:huawei_ml/utils/channels.dart';

import 'ml_tts_speaker.dart';

class MLTtsEngine {
  static const String EVENT_PLAY_STOP_INTERRUPTED = "interrupted";
  static const String EVENT_SYNTHESIS_INTERRUPTED = "interrupted";
  static const int EVENT_PLAY_START = 1;
  static const int EVENT_PLAY_RESUME = 2;
  static const int EVENT_PLAY_PAUSE = 3;
  static const int EVENT_PLAY_STOP = 4;
  static const int EVENT_SYNTHESIS_START = 5;
  static const int EVENT_SYNTHESIS_END = 6;
  static const int EVENT_SYNTHESIS_COMPLETE = 7;
  static const int LANGUAGE_AVAILABLE = 0;
  static const int LANGUAGE_NOT_SUPPORT = 1;
  static const int LANGUAGE_UPDATING = 2;
  static const int FORMAT_PCM_8BIT = 1;
  static const int FORMAT_PCM_16BIT = 2;
  static const int SAMPLE_RATE_16K = 16000;
  static const int CHANNEL_OUT_MONO = 4;
  static const int EXTERNAL_PLAYBACK = 2;
  static const int OPEN_STREAM = 4;
  static const int QUEUE_APPEND = 0;
  static const int QUEUE_FLUSH = 1;
  static const int ERR_ILLEGAL_PARAMETER = 11301;
  static const int ERR_NET_CONNECT_FAILED = 11302;
  static const int ERR_INSUFFICIENT_BALANCE = 11303;
  static const int ERR_SPEECH_SYNTHESIS_FAILED = 11304;
  static const int ERR_AUDIO_PLAYER_FAILED = 11305;
  static const int ERR_AUTHORIZE_FAILED = 11306;
  static const int ERR_AUTHORIZE_TOKEN_INVALIDE = 11307;
  static const int ERR_INTERNAL = 11398;
  static const int ERR_UNKNOWN = 11399;
  static const int WARN_INSUFFICIENT_BANDWIDTH = 113001;

  TtsCallback _callback;
  StreamSubscription _subscription;

  MLTtsEngine({TtsCallback callback}) {
    _callback = callback;
  }

  Future<bool> init() async {
    return await Channels.ttsMethodChannel
        .invokeMethod("initEngine", new MLTtsConfig().toMap());
  }

  Future<List<dynamic>> getLanguages() async {
    return await Channels.ttsMethodChannel.invokeMethod("getLanguages");
  }

  Future<int> isLanguageAvailable(String lang) async {
    return await Channels.ttsMethodChannel
        .invokeMethod("isLangAvailable", <String, dynamic>{'lang': lang});
  }

  Future<List<MLTtsSpeaker>> getSpeaker(String language) async {
    List<MLTtsSpeaker> speakers = [];
    final Map response = await Channels.ttsMethodChannel
        .invokeMethod("getSpeaker", <String, dynamic>{'language': language});
    for (int i = 0; i < response.length; i++) {
      speakers.add(new MLTtsSpeaker.fromMap(response['$i']));
    }
    return speakers;
  }

  Future<List<MLTtsSpeaker>> getSpeakers() async {
    List<MLTtsSpeaker> speakers = [];
    final Map response =
        await Channels.ttsMethodChannel.invokeMethod("getSpeakers");
    for (int i = 0; i < response.length; i++) {
      speakers.add(new MLTtsSpeaker.fromMap(response['$i']));
    }
    return speakers;
  }

  Future<void> speakOnCloud(MLTtsConfig config) async {
    _listenEvents();
    await Channels.ttsMethodChannel
        .invokeMethod("getSpeechWithCloud", config.toMap());
  }

  Future<void> speakOnDevice(MLTtsConfig config) async {
    _listenEvents();
    await Channels.ttsMethodChannel
        .invokeMethod("getSpeechOnDevice", config.toMap());
  }

  Future<bool> pauseSpeech() async {
    return await Channels.ttsMethodChannel.invokeMethod("pauseSpeech");
  }

  Future<bool> resumeSpeech() async {
    return await Channels.ttsMethodChannel.invokeMethod("resumeSpeech");
  }

  Future<bool> stopTextToSpeech() async {
    return await Channels.ttsMethodChannel.invokeMethod("stopTextToSpeech");
  }

  Future<bool> shutdownTextToSpeech() async {
    final res =
        await Channels.ttsMethodChannel.invokeMethod("shutdownTextToSpeech");
    if (res) {
      _subscription?.cancel();
    }
    return true;
  }

  void setTtsCallback(TtsCallback callback) {
    _callback = callback;
  }

  _listenEvents() {
    _subscription?.cancel();
    _subscription =
        Channels.ttsEventChannel.receiveBroadcastStream().listen((event) {
      Map<dynamic, dynamic> map = event;
      MLTtsEvent ttsEvent = _toTtsEvent(map['event']);
      if (ttsEvent == MLTtsEvent.onError) {
        _callback?.call(ttsEvent, map, errorCode: map['errorId']);
      } else {
        _callback?.call(ttsEvent, map);
      }
    });
  }

  static MLTtsEvent _toTtsEvent(String event) => _eventMap[event];
  static const Map<String, MLTtsEvent> _eventMap = {
    'onError': MLTtsEvent.onError,
    'onWarn': MLTtsEvent.onWarn,
    'onRangeStart': MLTtsEvent.onRangeStart,
    'onAudioAvailable': MLTtsEvent.onAudioAvailable,
    'onEvent': MLTtsEvent.onEvent
  };
}

typedef void TtsCallback(MLTtsEvent event, dynamic details, {int errorCode});

enum MLTtsEvent { onError, onWarn, onRangeStart, onAudioAvailable, onEvent }
