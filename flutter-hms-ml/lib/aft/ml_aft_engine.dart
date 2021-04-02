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
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/aft/ml_aft_setting.dart';
import 'package:huawei_ml/models/ml_aft_result.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLAftEngine {
  static const int INITED = 1;
  static const int UPLOADING = 2;
  static const int TRANSCRIPTING = 3;
  static const int RESULTED = 4;
  static const int TRANSCRIPT_FAILED = 5;

  static const String REMOTE_TASK_ID = "remoteTaskId";
  static const String TASK_STATUS = "taskStatus";

  static const int ERR_AUDIO_FILE_NOT_SUPPORTED = 11101;
  static const int ERR_AUDIO_FILE_SIZE_OVERFLOW = 11103;
  static const int ERR_AUDIO_INIT_FAILED = 11112;
  static const int ERR_AUDIO_LENGTH_OVERFLOW = 11104;
  static const int ERR_AUDIO_TRANSCRIPT_FAILED = 11111;
  static const int ERR_AUDIO_UPLOAD_FAILED = 11113;
  static const int ERR_AUTHORIZE_FAILED = 11119;
  static const int ERR_ENGINE_BUSY = 11107;
  static const int ERR_FILE_NOT_FOUND = 11105;
  static const int ERR_ILLEGAL_PARAMETER = 11106;
  static const int ERR_INTERNAL = 11198;
  static const int ERR_LANGUAGE_CODE_NOT_SUPPORTED = 11102;
  static const int ERR_NET_CONNECT_FAILED = 11108;
  static const int ERR_NO_ENOUGH_STORAGE = 11115;
  static const int ERR_RESULT_WHEN_UPLOADING = 11109;
  static const int ERR_SERVICE_CREDIT = 11122;
  static const int ERR_TASK_ALREADY_IN_PROGRESS = 11114;
  static const int ERR_TASK_NOT_EXISTED = 11110;
  static const int ERR_UNKNOWN = 11199;

  static const int UPLOADED_EVENT = 1;
  static const int PAUSE_EVENT = 2;
  static const int STOP_EVENT = 3;

  final MethodChannel _channel = Channels.aftMethodChannel;
  MLAftListener _listener;
  StreamSubscription _subscription;

  void startRecognition({@required MLAftSetting setting}) async {
    File file = new File(setting.path);
    int i = await file.length();
    double kb = i / 1024;
    double mb = kb / 1024;
    if (mb > 4) {
      await _longRecognize(setting: setting);
    } else {
      await _shortRecognize(setting: setting);
    }
  }

  Future<void> _shortRecognize({@required MLAftSetting setting}) async {
    _getAftEvents();
    await _channel.invokeMethod("shortRecognize", setting.toMap());
  }

  Future<void> _longRecognize({@required MLAftSetting setting}) async {
    _getAftEvents();
    await _channel.invokeMethod("longRecognize", setting.toMap());
  }

  Future<void> startTask({@required String taskId}) async {
    await _channel
        .invokeMethod("startTask", <String, dynamic>{'taskId': taskId});
  }

  Future<void> pauseTask({@required String taskId}) async {
    return await _channel
        .invokeMethod("pauseTask", <String, dynamic>{'taskId': taskId});
  }

  Future<void> destroyTask({@required String taskId}) async {
    await _channel
        .invokeMethod("destroyTask", <String, dynamic>{'taskId': taskId});
  }

  Future<void> getLongAftResult({@required String taskId}) async {
    await _channel
        .invokeMethod("getLongAftResult", <String, dynamic>{'taskId': taskId});
  }

  Future<bool> closeAftEngine() async {
    _subscription?.cancel();
    return await _channel.invokeMethod("closeAftEngine");
  }

  void setAftListener(MLAftListener listener) {
    _listener = listener;
  }

  _getAftEvents() {
    _subscription?.cancel();
    _subscription =
        Channels.aftEventChannel.receiveBroadcastStream().listen((event) {
      Map<dynamic, dynamic> map = event;
      String taskId = map['taskId'];
      switch (map['event']) {
        case "onResult":
          final MLAftResult aftResult =
              MLAftResult.fromJson(json.decode(map['result']));
          _listener?.call(MLAftEvent.onResult, taskId, result: aftResult);
          break;
        case "onError":
          String message = map['message'];
          int errorCode = map['errorCode'];
          print("onError: $message");
          _listener?.call(MLAftEvent.onError, taskId, errorCode: errorCode);
          break;
        case "onInitComplete":
          _listener?.call(MLAftEvent.onInitComplete, taskId);
          break;
        case "onUploadProgress":
          double progress = map['progress'];
          _listener?.call(MLAftEvent.onUploadProgress, taskId,
              uploadProgress: progress);
          break;
        case "onEvent":
          int eventId = map['eventId'];
          _listener?.call(MLAftEvent.onEvent, taskId, eventId: eventId);
          break;
      }
    });
  }
}

typedef void MLAftListener(MLAftEvent event, String taskId,
    {int eventId, MLAftResult result, int errorCode, double uploadProgress});

enum MLAftEvent { onResult, onError, onInitComplete, onUploadProgress, onEvent }
