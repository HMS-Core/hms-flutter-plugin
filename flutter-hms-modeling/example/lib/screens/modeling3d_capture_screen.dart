/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:huawei_modeling3d/huawei_modeling3d.dart';
import 'package:path_provider/path_provider.dart';

class Modeling3dCaptureScreen extends StatefulWidget {
  const Modeling3dCaptureScreen({Key? key}) : super(key: key);

  @override
  State<Modeling3dCaptureScreen> createState() =>
      _Modeling3dCaptureScreenState();
}

class _Modeling3dCaptureScreenState extends State<Modeling3dCaptureScreen> {
  final List<String> _logs = <String>[
    'Double tap to clear logs.',
  ];

  Modeling3dCaptureImageListener? _captureImageListener;

  /// Set relevant parameters for real-time guide.
  Future<dynamic> setCaptureConfig() async {
    const Modeling3dCaptureSetting setting = Modeling3dCaptureSetting(
      azimuthNum: 30,
      latitudeNum: 3,
      radius: 3.0,
    );
    await Modeling3dCaptureImageEngine.setCaptureConfig(
      setting,
    );
  }

  /// Start capturing image collection.
  Future<dynamic> captureImage() async {
    final Directory? extDir = await getExternalStorageDirectory();
    final String fileSavePath = extDir!.path;

    _captureImageListener ??= Modeling3dCaptureImageListener(
      onProgress: (int progress) {
        setState(() {
          _logs.insert(
            0,
            'CaptureImageListener.onProgress: progress: $progress',
          );
        });
      },
      onResult: () {
        setState(() {
          _logs.insert(
            0,
            'CaptureImageListener.onResult',
          );
        });
      },
      onError: (int errorCode, String message) {
        setState(() {
          _logs.insert(
            0,
            'CaptureImageListener.onError: errorCode: $errorCode, message: $message',
          );
        });
      },
    );
    await Modeling3dCaptureImageEngine.captureImage(
      fileSavePath,
      listener: _captureImageListener,
    );
    return '';
  }

  Widget _buildButton(String text, Future<dynamic> Function() onPressed) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final dynamic result = await onPressed();
          setState(() {
            _logs.insert(0, '$text: ${result ?? 'SUCCESS'}');
          });
        } catch (e) {
          setState(() {
            _logs.insert(0, '$text: $e');
          });
        }
      },
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modeling 3D Capture'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                _buildButton('setCaptureConfig', setCaptureConfig),
                const Divider(),
                _buildButton('captureImage', captureImage),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: GestureDetector(
              onDoubleTap: () => setState(() => _logs.clear()),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _logs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(_logs[index]);
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
