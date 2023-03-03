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

import 'package:flutter/material.dart';
import 'package:huawei_modeling3d/huawei_modeling3d.dart';

class MotionCaptureScreen extends StatefulWidget {
  const MotionCaptureScreen({Key? key}) : super(key: key);

  @override
  State<MotionCaptureScreen> createState() => _MotionCaptureScreenState();
}

class _MotionCaptureScreenState extends State<MotionCaptureScreen> {
  late MotionCaptureViewController controller;
  final List<String> _logs = <String>[
    'Double tap to clear logs.',
  ];

  Future<dynamic> analyseFrame() async {
    // TODO: After get necessary permissions, you can use a third-party package to get input image path from your gallery.
    const String path = '<image_path>';
    final List<Modeling3dMotionCaptureSkeleton> result =
        await controller.analyseFrame(
      path,
    );
    return result;
  }

  Future<dynamic> asyncAnalyseFrame() async {
    // TODO: After get necessary permissions, you can use a third-party package to get input image path from your gallery.
    const String path = '<image_path>';
    final List<Modeling3dMotionCaptureSkeleton> result =
        await controller.asyncAnalyseFrame(
      path,
    );
    return result;
  }

  Future<dynamic> stop() async {
    await controller.stop();
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
        title: const Text('Motion Capture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: MotionCaptureView(
                onViewCreated: (MotionCaptureViewController controller) {
                  this.controller = controller;
                },
                // If using video frames, set isPhoto to false.
                // isPhoto: false,
              ),
            ),
            const Divider(),
            Flexible(
              child: Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  _buildButton('analyseFrame', analyseFrame),
                  _buildButton('asyncAnalyseFrame', asyncAnalyseFrame),
                  _buildButton('stop', stop),
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
      ),
    );
  }
}
