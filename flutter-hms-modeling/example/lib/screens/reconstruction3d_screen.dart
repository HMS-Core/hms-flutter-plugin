/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_modeling3d_example/widgets/progress_detail.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:huawei_modeling3d/huawei_modeling3d.dart';

class Reconstruction3dScreen extends StatefulWidget {
  const Reconstruction3dScreen({Key? key}) : super(key: key);

  @override
  _Reconstruction3dScreenState createState() => _Reconstruction3dScreenState();
}

class _Reconstruction3dScreenState extends State<Reconstruction3dScreen> {
  late String _path;
  late String _taskId;
  late Modeling3dReconstructEngine _engine;
  late Modeling3dReconstructTaskUtils taskUtils;
  double _uploadProgress = 0.0;
  double _downloadProgress = 0.0;

  List<String> _logs = ["3D Reconstruction Engine Logs"];

  @override
  void initState() {
    super.initState();
    initEngine();
  }

  Future<void> initEngine() async {
    if (!mounted) return;
    _engine = await Modeling3dReconstructEngine.instance;
    taskUtils = await Modeling3dReconstructTaskUtils.instance;
  }

  void _addToLogs(String value) {
    setState(() => _logs.add(value));
  }

  /// To run the 3D Reconstruction add your images to the `assets/3D_reconstruction_images`
  /// folder, name them as incrementing numbers (0.jpg,1.jpg...) and enter the image count to the variable below.
  late int imageCount;
  FutureOr<void> saveAssetImageToFolder() async {
    DateTime _date = DateTime.now();

    final extDir = await getExternalStorageDirectory();
    final myImagePath =
        '${extDir!.path}/${_date.millisecondsSinceEpoch.toString()}';
    await new Directory(myImagePath).create();
    setState(() => _path = myImagePath);
    try {
      for (var i = 1; i < imageCount + 1; i++) {
        final byteData = await rootBundle
            .load('assets/3D_reconstruction_images/' + i.toString() + '.jpg');
        final file = await File(
                '${(await getApplicationDocumentsDirectory()).path}/$i.jpg')
            .create(recursive: true);

        final image = await file.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

        final imgName = DateTime.now();

        File newImage = await image.copy(
            "$myImagePath/${basename('${imgName.millisecondsSinceEpoch.toString()}.jpg')}");
        print(newImage.path);
      }
    } catch (e) {
      throw ("Error while reading images, Please check if the images are in the assets/3D_reconstruction_images folder and add your images if the folder is empty.");
    }
  }

  void initTask() async {
    try {
      Modeling3dReconstructInitResult initResult = await _engine
          .initTask(Modeling3dReconstructSetting(reconstructMode: 0));
      print(" RetCode: " +
          initResult.retCode.toString() +
          " RetMsg: " +
          initResult.retMessage +
          initResult.retMessage);

      setState(() {
        _taskId = initResult.taskId;
      });
      _addToLogs("init task, ${initResult.taskId}");
    } on PlatformException {
      print('Failed to init engine.');
    }
  }

  void cancelUpload() async {
    final res = await _engine.cancelUpload(_taskId);
    _addToLogs("cancel upload: $res");
  }

  void cancelDownload() async {
    final res = await _engine.cancelDownload(_taskId);
    _addToLogs("cancel download: $res");
  }

  void uploadFiles() async {
    await saveAssetImageToFolder();
    _engine.setReconstructUploadListener(Modeling3dReconstructUploadListener(
        _onUploadResult, _onUploadError, _onUploadProgress));
    _engine.uploadFile(_taskId, _path);
  }

  void _onUploadResult(
      String taskId, Modeling3dReconstructUploadResult result) {
    _addToLogs("Upload completed: " + result.isComplete.toString());
  }

  void _onUploadError(String taskId, int errCode, String errMsg) {
    _addToLogs("Upload error: $errCode, $errMsg");
  }

  void _onUploadProgress(String taskId, double progress) {
    setState(() => _uploadProgress = progress / 100);
  }

  void downloadModel() async {
    _engine.setReconstructDownloadListener(
        Modeling3dReconstructDownloadListener(
            _onDownloadResult, _onDownloadError, _onDownloadProgress));
    _engine.downloadModel(_taskId, "$_path/downloads");
  }

  void _onDownloadResult(
      String taskId, Modeling3dReconstructDownloadResult result) {
    _addToLogs("Download complete: ${result.isComplete}");
  }

  void _onDownloadError(String taskId, int errCode, String errMsg) {
    _addToLogs("Download error: $errCode, $errMsg");
  }

  void _onDownloadProgress(String taskId, double progress) {
    setState(() => _downloadProgress = progress / 100);
  }

  void previewModel() async {
    _engine.previewModel(_taskId,
        previewListener: Modeling3dReconstructPreviewListener(
            _onPreviewResult, _onPreviewError));
  }

  void _onPreviewError(String taskId, int errCode, String errMsg) {
    _addToLogs("Preview error: $errCode, $errMsg");
  }

  void _onPreviewResult(String taskId) {
    _addToLogs("Preview result: $taskId");
  }

  void queryTask() async {
    Modeling3dReconstructQueryResult queryResult =
        await taskUtils.queryTask(_taskId);
    _addToLogs(
        "Query Task Status: ${ReconstructProgressStatusType.values[queryResult.status]}");
  }

  void restartProgress() async {
    setState(() {
      _uploadProgress = 0.0;
      _downloadProgress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("3D Reconstruction")),
      body: Column(
        children: [
          ProgressDetail(
              "Upload", _uploadProgress, cancelUpload, restartProgress),
          ProgressDetail(
              "Download", _downloadProgress, cancelDownload, restartProgress),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: _logs.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(_logs[index]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                                onPressed: initTask,
                                child: Text("Init Task"))),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                                onPressed: uploadFiles,
                                child: Text("Upload Files"))),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                                onPressed: downloadModel,
                                child: Text("Download Model"))),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                                onPressed: previewModel,
                                child: Text("Preview Model"))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 5),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15)),
                          onPressed: queryTask,
                          child: Text("Query Task"))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
