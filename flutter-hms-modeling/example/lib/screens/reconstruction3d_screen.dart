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
import 'package:flutter/services.dart';
import 'package:huawei_modeling3d/huawei_modeling3d.dart';
import 'package:huawei_modeling3d_example/main.dart';
import 'package:path_provider/path_provider.dart';

class Reconstruction3dScreen extends StatefulWidget {
  const Reconstruction3dScreen({Key? key}) : super(key: key);

  @override
  State<Reconstruction3dScreen> createState() => _Reconstruction3dScreenState();
}

class _Reconstruction3dScreenState extends State<Reconstruction3dScreen> {
  final List<String> _logs = <String>[
    'Double tap to clear logs.',
  ];
  Modeling3dReconstructUploadListener? _uploadListener;
  Modeling3dReconstructDownloadListener? _downloadListener;
  Modeling3dReconstructPreviewListener? _previewListener;
  late String _path;
  late String _taskId;

  Future<dynamic> setApiKey() async {
    await ReconstructApplication.setApiKey(apiKey);
  }

  Future<dynamic> initTask() async {
    const Modeling3dReconstructSetting setting = Modeling3dReconstructSetting();
    final Modeling3dReconstructInitResult result =
        await Modeling3dReconstructEngine.initTask(setting);

    setState(() => _taskId = result.taskId);
    return result;
  }

  /// To run the 3D Reconstruction add your images to the `assets/3D_reconstruction_images`
  /// folder, name them as incrementing numbers (0.jpg,1.jpg...) and enter the image count to the variable below.
  late int imageCount;
  FutureOr<void> saveAssetImageToFolder() async {
    final DateTime date = DateTime.now();

    final Directory? extDir = await getExternalStorageDirectory();
    final String myImagePath = '${extDir!.path}/${date.millisecondsSinceEpoch}';
    await Directory(myImagePath).create();
    setState(() => _path = myImagePath);

    try {
      for (int i = 0; i < imageCount; i++) {
        final ByteData byteData = await rootBundle.load(
          'assets/3D_reconstruction_images/$i.jpg',
        );
        final File file = await File(
          '${(await getApplicationDocumentsDirectory()).path}/$i.jpg',
        ).create(recursive: true);

        final File image = await file.writeAsBytes(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
        );
        final File newImage = await image.copy(
          '$myImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        debugPrint(newImage.path);
      }
    } catch (_) {
      throw ('Error while reading images, Please check if the images are in the assets/3D_reconstruction_images folder and add your images if the folder is empty.');
    }
  }

  Future<dynamic> uploadFiles() async {
    await saveAssetImageToFolder();

    _uploadListener ??= Modeling3dReconstructUploadListener(
      onUploadProgress: (String taskId, double progress) {
        setState(() {
          _logs.insert(
            0,
            'UploadListener.onUploadProgress: taskId: $taskId, progress: $progress',
          );
        });
      },
      onResult: (String taskId, Modeling3dReconstructUploadResult result) {
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

    await Modeling3dReconstructEngine.setReconstructUploadListener(
      _uploadListener,
    );
    await Modeling3dReconstructEngine.uploadFile(_taskId, _path);
    return '';
  }

  Future<dynamic> cancelUpload() async {
    final int result = await Modeling3dReconstructEngine.cancelUpload(
      _taskId,
    );
    return result;
  }

  Future<dynamic> downloadModelWithConfig() async {
    _downloadListener ??= Modeling3dReconstructDownloadListener(
      onDownloadProgress: (String taskId, double progress) {
        setState(() {
          _logs.insert(
            0,
            'DownloadListener.onDownloadProgress: taskId: $taskId, progress: $progress',
          );
        });
      },
      onResult: (String taskId, Modeling3dReconstructDownloadResult result) {
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
    await Modeling3dReconstructEngine.setReconstructDownloadListener(
      _downloadListener,
    );
    await Modeling3dReconstructEngine.downloadModelWithConfig(
      _taskId,
      '$_path/downloads',
      const Modeling3dReconstructDownloadConfig(),
    );
    return '';
  }

  Future<dynamic> cancelDownload() async {
    final int result = await Modeling3dReconstructEngine.cancelDownload(
      _taskId,
    );
    return result;
  }

  Future<dynamic> previewModel() async {
    _previewListener ??= Modeling3dReconstructPreviewListener(
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
    await Modeling3dReconstructEngine.previewModel(
      _taskId,
      previewListener: _previewListener,
    );
    return '';
  }

  Future<dynamic> queryTask() async {
    final Modeling3dReconstructQueryResult queryResult =
        await Modeling3dReconstructTaskUtils.queryTask(_taskId);
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
        title: const Text('3D Reconstruction'),
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
                _buildButton('downloadModel', downloadModelWithConfig),
                _buildButton('cancelDownload', cancelDownload),
                const Divider(),
                _buildButton('previewModel', previewModel),
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
