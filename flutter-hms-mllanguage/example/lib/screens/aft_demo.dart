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

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:huawei_ml_language/huawei_ml_language.dart';
import 'package:huawei_ml_language_example/utils/demo_utils.dart';

class AftDemo extends StatefulWidget {
  const AftDemo({Key? key}) : super(key: key);

  @override
  State<AftDemo> createState() => _AftDemoState();
}

class _AftDemoState extends State<AftDemo> {
  late MLRemoteAftEngine engine;
  String _taskId = '';
  final List<String> _events = <String>['Initial event'];

  @override
  void initState() {
    super.initState();
    engine = MLRemoteAftEngine();
    engine.setAftListener(
      MLRemoteAftListener(
        onError,
        onEvent,
        onInitComplete,
        onResult,
        onUploadProgress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aft Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (_, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_events[index]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                const Text(
                  'For short audio files with a duration of 1 minute or shorter',
                ),
                ElevatedButton(
                  onPressed: pickAndRecognizeShortAudio,
                  child: const Text('recognize'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'For audio files with a duration longer than 1 minute',
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: pickAndRecognizeLongAudio,
                      child: const Text('recognize'),
                    ),
                    ElevatedButton(
                      onPressed: () => startTask(_taskId),
                      child: const Text('start task'),
                    ),
                    ElevatedButton(
                      onPressed: () => getLongResult(_taskId),
                      child: const Text('get long result'),
                    ),
                    ElevatedButton(
                      onPressed: () => destroyTask(_taskId),
                      child: const Text('Destroy task'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> pickAudioFile() async {
    final FilePickerResult? pickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.audio,
    );
    return pickerResult?.paths.first;
  }

  void pickAndRecognizeShortAudio() async {
    try {
      final String? path = await pickAudioFile();
      if (path != null) {
        engine.shortRecognize(
          MLRemoteAftSetting(
            path: path,
          ),
        );
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void pickAndRecognizeLongAudio() async {
    try {
      final String? path = await pickAudioFile();
      if (path != null) {
        engine.longRecognize(
          MLRemoteAftSetting(
            path: path,
          ),
        );
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
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

  void destroyTask(String taskId) {
    try {
      engine.destroyTask(taskId);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  // AFT LISTENERS
  void onError(String taskId, int errCode, String errMsg) {
    setState(() {
      _events.add('onError: $errCode: $errMsg');
    });
  }

  void onEvent(String taskId, int eventId) {
    setState(() {
      _events.add('onEvent: $eventId');
    });
  }

  void onInitComplete(String taskId) {
    setState(() {
      _taskId = taskId;
      _events.add('onInitComplete: $taskId');
    });
  }

  void onUploadProgress(String taskId, double progress) {
    setState(() {
      _events.add('uploadProgress: $progress');
    });
  }

  void onResult(String taskId, MLRemoteAftResult result) {
    setState(() {
      _events.add('onResult: ${result.text}');
    });
  }
}
