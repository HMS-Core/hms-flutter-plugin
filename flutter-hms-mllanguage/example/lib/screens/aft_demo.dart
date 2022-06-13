/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:huawei_ml_language/huawei_ml_language.dart';
import 'package:huawei_ml_language_example/utils/demo_utils.dart';

class AftDemo extends StatefulWidget {
  const AftDemo({Key? key}) : super(key: key);

  @override
  _AftDemoState createState() => _AftDemoState();
}

class _AftDemoState extends State<AftDemo> {
  late MLRemoteAftEngine engine;
  late FlutterAudioRecorder2 recorder;
  late Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  String _pathResult = "";
  int? _duration;
  String _taskId = '';

  List _events = ["Initial event"];

  @override
  void initState() {
    engine = MLRemoteAftEngine();
    engine.setAftListener(MLRemoteAftListener(
      onError,
      onEvent,
      onInitComplete,
      onResult,
      onUploadProgress,
    ));
    super.initState();
  }

  initRecorder() async {
    String customPath = '/myAudioPath';

    final p = await MLLanguageApp().getAppDirectory();
    print('path is   $p');

    final dir = io.Directory('$p$customPath');
    dir.create().then((dir) async {
      print("dir path:  " + dir.path);

      setState(() {
        customPath = dir.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
      });
      print('custom path:   $customPath');

      recorder = FlutterAudioRecorder2(
        customPath,
        audioFormat: AudioFormat.WAV,
      );

      await recorder.initialized;

      var current = await recorder.current(channel: 0);

      print('current path:  ' + current!.path.toString());

      setState(() {
        _current = current;
        _currentStatus = current.status!;
        _events.add('recorder status: $_currentStatus');
      });
    });
  }

  startRecording() async {
    try {
      await recorder.start();
      var recording = await recorder.current(channel: 0);

      setState(() {
        _current = recording!;
      });

      const tick = const Duration(milliseconds: 50);

      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await recorder.current(channel: 0);
        setState(() {
          _current = current!;
          _currentStatus = current.status!;
          if (!_events
              .contains('recorder status: ${RecordingStatus.Recording}')) {
            _events.add('recorder status: $_currentStatus');
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  stopRecording() async {
    var result = await recorder.stop();
    print("Stop recording: ${result!.path}");
    print("Stop recording: ${result.duration}");
    setState(() {
      _current = result;
      _currentStatus = _current.status!;
      _pathResult = _current.path!;
      _duration = result.duration!.inSeconds;
      _events.add('recorder status: $_currentStatus');
    });
    print("recording duration:  $_duration");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aft Demo')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_events[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              children: [
                Text('Recorder'),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: initRecorder,
                        child: Text('Init recorder'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: startRecording,
                        child: Text('Start Recording'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: stopRecording,
                        child: Text('Stop Recording'),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Text('AFT Engine'),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: recognize,
                        child: Text('recognize'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => startTask(_taskId),
                        child: Text('start task'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () => getLongResult(_taskId),
                      child: Text('get long result'),
                    )),
                    SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => destroyTask(_taskId),
                        child: Text('Destroy task'),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // AFT ENGINE METHODS
  void recognize() {
    final setting = MLRemoteAftSetting(path: _pathResult);
    if (_duration != null && _duration! >= 60) {
      engine.longRecognize(setting);
    } else {
      engine.shortRecognize(setting);
    }
  }

  void startTask(String taskId) {
    try {
      engine.startTask(taskId);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void getLongResult(String taskId) {
    try {
      engine.getLongAftResult(taskId);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  destroyTask(String taskId) {
    try {
      engine.destroyTask(taskId);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  // AFT LISTENERS

  void onError(String taskId, int errCode, String errMsg) {
    setState(() => _events.add('onError: $errCode: $errMsg'));
  }

  void onEvent(String taskId, int eventId) {
    setState(() => _events.add('onEvent: $eventId'));
  }

  void onInitComplete(String taskId) {
    setState(() {
      _taskId = taskId;
      _events.add('onInitComplete: $taskId');
    });
  }

  onUploadProgress(String taskId, double progress) {
    setState(() => _events.add('uploadProgress: $progress'));
  }

  void onResult(String taskId, MLRemoteAftResult result) {
    setState(() => _events.add('onResult: ${result.text}'));
  }
}
