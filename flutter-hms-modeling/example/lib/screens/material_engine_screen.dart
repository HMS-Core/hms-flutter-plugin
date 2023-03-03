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
import 'package:huawei_modeling3d_example/main.dart';

class MaterialEngineScreen extends StatefulWidget {
  const MaterialEngineScreen(this.filesPath, {Key? key}) : super(key: key);

  final String filesPath;

  @override
  State<MaterialEngineScreen> createState() => _MaterialEngineScreenState();
}

class _MaterialEngineScreenState extends State<MaterialEngineScreen> {
  final List<String> _logs = <String>[
    'Double tap to clear logs.',
  ];
  Modeling3dTextureUploadListener? _uploadListener;
  Modeling3dTextureDownloadListener? _downloadListener;
  Modeling3dTexturePreviewListener? _previewListener;
  late String _taskId;

  Future<dynamic> setApiKey() async {
    await MaterialGenApplication.setApiKey(apiKey);
  }

  Future<dynamic> initTask() async {
    const Modeling3dTextureSetting setting = Modeling3dTextureSetting();
    final Modeling3dTextureInitResult result =
        await Modeling3dTextureEngine.initTask(setting);

    setState(() => _taskId = result.taskId);
    return result;
  }

  Future<dynamic> uploadFiles() async {
    _uploadListener ??= Modeling3dTextureUploadListener(
      onUploadProgress: (String taskId, double progress) {
        setState(() {
          _logs.insert(
            0,
            'UploadListener.onUploadProgress: taskId: $taskId, progress: $progress',
          );
        });
      },
      onResult: (String taskId, Modeling3dTextureUploadResult result) {
        setState(() {
          _logs.insert(
            0,
            'UploadListener.onResult: taskId: $taskId, result: $result',
          );
        });
      },
      onError: (String taskId, int errorCode, String message) {
        setState(() {
          _logs.insert(
            0,
            'UploadListener.onError: taskId: $taskId, errorCode: $errorCode, message: $message',
          );
        });
      },
    );
    Modeling3dTextureEngine.setTextureUploadListener(_uploadListener);
    await Modeling3dTextureEngine.asyncUploadFile(_taskId, widget.filesPath);
    return '';
  }

  Future<dynamic> cancelUpload() async {
    final int result = await Modeling3dTextureEngine.cancelUpload(
      _taskId,
    );
    return result;
  }

  Future<dynamic> downloadTexture() async {
    _downloadListener ??= Modeling3dTextureDownloadListener(
      onDownloadProgress: (String taskId, double progress) {
        setState(() {
          _logs.insert(
            0,
            'DownloadListener.onDownloadProgress: taskId: $taskId, progress: $progress',
          );
        });
      },
      onResult: (String taskId, Modeling3dTextureDownloadResult result) {
        setState(() {
          _logs.insert(
            0,
            'DownloadListener.onResult: taskId: $taskId, result: $result',
          );
        });
      },
      onError: (String taskId, int errorCode, String message) {
        setState(() {
          _logs.insert(
            0,
            'DownloadListener.onError: taskId: $taskId, errorCode: $errorCode, message: $message',
          );
        });
      },
    );

    Modeling3dTextureEngine.setTextureDownloadListener(_downloadListener);
    await Modeling3dTextureEngine.asyncDownloadTexture(
      _taskId,
      '${widget.filesPath}/downloads',
    );
    return '';
  }

  Future<dynamic> cancelDownload() async {
    final int result = await Modeling3dTextureEngine.cancelDownload(
      _taskId,
    );
    return result;
  }

  Future<dynamic> previewTexture() async {
    _previewListener ??= Modeling3dTexturePreviewListener(
      onResult: (String taskId) {
        setState(() {
          _logs.insert(
            0,
            'PreviewListener.onResult: taskId: $taskId',
          );
        });
      },
      onError: (String taskId, int errorCode, String message) {
        setState(() {
          _logs.insert(
            0,
            'PreviewListener.onError: taskId: $taskId, errorCode: $errorCode, message: $message',
          );
        });
      },
    );
    await Modeling3dTextureEngine.previewTexture(
      _taskId,
      listener: _previewListener,
    );
    return '';
  }

  Future<dynamic> queryTask() async {
    final Modeling3dTextureQueryResult queryResult =
        await Modeling3dTextureTaskUtils.queryTask(_taskId);
    return queryResult;
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
        title: const Text('Material Generation'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                _buildButton('setApiKey', setApiKey),
                const Divider(),
                _buildButton('initTask', initTask),
                const Divider(),
                _buildButton('uploadFiles', uploadFiles),
                _buildButton('cancelUpload', cancelUpload),
                const Divider(),
                _buildButton('downloadTexture', downloadTexture),
                _buildButton('cancelDownload', cancelDownload),
                const Divider(),
                _buildButton('previewTexture', previewTexture),
                const Divider(),
                _buildButton('queryTask', queryTask),
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
