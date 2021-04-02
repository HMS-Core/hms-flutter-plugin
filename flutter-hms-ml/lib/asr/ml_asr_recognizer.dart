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

import 'package:flutter/services.dart';
import 'package:huawei_ml/utils/channels.dart';
import 'ml_asr_setting.dart';

class MLAsrRecognizer {
  static const int ERR_NO_NETWORK = 11202;
  static const int ERR_NO_UNDERSTAND = 11204;
  static const int ERR_SERVICE_UNAVAILABLE = 11203;
  static const int ERR_INVALIDATE_TOKEN = 11219;

  static const int STATE_LISTENING = 1;
  static const int STATE_NO_SOUND = 2;
  static const int STATE_NO_SOUND_TIMES_EXCEED = 3;
  static const int STATE_NO_UNDERSTAND = 6;
  static const int STATE_NO_NETWORK = 7;
  static const int STATE_WAITING = 9;

  final MethodChannel _channel = Channels.asrMethodChannel;
  MLAsrListener _listener;
  StreamSubscription _subscription;

  Future<String> startRecognizing(MLAsrSetting setting) async {
    _listenEvents();
    return await _channel.invokeMethod("startRecognizing", setting.toMap());
  }

  Future<String> startRecognizingWithUi(MLAsrSetting setting) async {
    _listenEvents();
    return await _channel.invokeMethod("recognizeWithUi");
  }

  Future<bool> stopRecognition() async {
    _subscription?.cancel();
    return await _channel.invokeMethod("stopRecognition");
  }

  void setListener(MLAsrListener listener) {
    _listener = listener;
  }

  _listenEvents() {
    _subscription?.cancel();
    _subscription =
        Channels.asrEventChannel.receiveBroadcastStream().listen((event) {
      Map<dynamic, dynamic> map = event;
      MLAsrEvent asrEvent = _toAsrEvent(map['event']);
      _listener?.call(asrEvent, map);
    });
  }

  static MLAsrEvent _toAsrEvent(String event) => _eventMap[event];
  static const Map<String, MLAsrEvent> _eventMap = {
    'onStartListening': MLAsrEvent.onStartListening,
    'onStartingOfSpeech': MLAsrEvent.onStartingOfSpeech,
    'onVoiceDataReceived': MLAsrEvent.onVoiceDataReceived,
    'onRecognizingResults': MLAsrEvent.onRecognizingResults,
    'onState': MLAsrEvent.onState
  };
}

typedef void MLAsrListener(MLAsrEvent event, dynamic info);

enum MLAsrEvent {
  onState,
  onStartListening,
  onStartingOfSpeech,
  onVoiceDataReceived,
  onRecognizingResults,
}
