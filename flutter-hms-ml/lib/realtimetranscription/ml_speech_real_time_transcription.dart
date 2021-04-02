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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/realtimetranscription/ml_speech_real_time_transcription_config.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLSpeechRealTimeTranscription {
  static const int ERR_SERVICE_CREDIT = 13222;
  static const int ERR_INVALID_TOKEN = 13219;
  static const int ERR_NO_NETWORK = 13202;
  static const int ERR_SERVICE_UNAVAILABLE = 13203;
  static const int STATE_LISTENING = 1;
  static const int STATE_NO_UNDERSTAND = 6;
  static const int STATE_NO_NETWORK = 7;
  static const int STATE_SERVICE_RECONNECTING = 42;
  static const int STATE_SERVICE_RECONNECTED = 43;
  static const String WAVE_PAINE_ENCODING = "ENCODING";
  static const String WAVE_PAINE_SAMPLE_RATE = "SAMPLE_RATE";
  static const String WAVE_PAINE_BIT_WIDTH = "BIT_WIDTH";
  static const String WAVE_PAINE_CHANNEL_COUNT = "CHANNEL_COUNT";

  final MethodChannel _channel = Channels.rttMethodChannel;

  RttListener _listener;
  StreamSubscription _subscription;

  Future<void> startRecognizing(
      {@required MLSpeechRealTimeTranscriptionConfig config}) async {
    _listenEvents();
    return await _channel.invokeMethod("startRecognizing", config.toMap());
  }

  Future<bool> destroyRealTimeTranscription() async {
    final bool result = await _channel.invokeMethod("destroy");
    if (result) {
      _subscription?.cancel();
    }
    return true;
  }

  void setListener(RttListener listener) {
    _listener = listener;
  }

  _listenEvents() {
    _subscription?.cancel();
    _subscription =
        Channels.rttEventChannel.receiveBroadcastStream().listen((event) {
      final Map<dynamic, dynamic> map = event;
      if (map.containsKey("onRecognizingResults")) {
        _listener?.call(map,
            recognizedResult: map['onRecognizingResults']['result']);
      } else {
        _listener?.call(map);
      }
    });
  }
}

typedef void RttListener(dynamic partialResult, {String recognizedResult});
