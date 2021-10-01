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

import 'package:flutter/material.dart';
import 'package:huawei_modeling3d/huawei_modeling3d.dart';

import '../widgets/progress_detail.dart';

class MaterialEngineScreen extends StatefulWidget {
  const MaterialEngineScreen(this.filesPath);

  final String filesPath;

  @override
  _MaterialEngineScreenState createState() => _MaterialEngineScreenState();
}

class _MaterialEngineScreenState extends State<MaterialEngineScreen> {
  late Modeling3dTextureEngine _engine;

  late String _taskId;

  double _uploadProgress = 0.0;
  double _downloadProgress = 0.0;

  List<String> _logs = ["Material Engine Logs"];

  @override
  void initState() {
    _setApiKey();
    _engine = Modeling3dTextureEngine();
    super.initState();
  }

  void _setApiKey() {
    MaterialGenApplication.getInstance.setApiKey("<your_api_key>");
  }

  void restartProgress() {
    setState(() {
      _uploadProgress = 0.0;
      _downloadProgress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Material Generation")),
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
                                onPressed: downloadTexture,
                                child: Text("Download Texture"))),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                                onPressed: previewTexture,
                                child: Text("Preview Texture"))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _addToLogs(String value) {
    setState(() => _logs.add(value));
  }

  void cancelUpload() async {
    final res = await _engine.cancelUpload(_taskId);
    _addToLogs("cancel upload: $res");
  }

  void cancelDownload() async {
    final res = await _engine.cancelDownload(_taskId);
    _addToLogs("cancel download: $res");
  }

  void initTask() async {
    final setting = Modeling3dTextureSetting.create(textureMode: 1);
    final result = await _engine.initTask(setting);

    if (result.taskId != null) {
      setState(() => _taskId = result.taskId!);
      setState(() => _logs.add("Task initialized: " + result.taskId!));
    }
  }

  void uploadFiles() async {
    _engine.setTextureUploadListener(Modeling3dTextureUploadListener(
        _onUploadResult, _onUploadError, _onUploadProgress));
    _engine.asyncUploadFile(_taskId, widget.filesPath);
  }

  _onUploadResult(String taskId, Modeling3dTextureUploadResult result) {
    _addToLogs("Upload completed: " + result.isComplete.toString());
  }

  _onUploadError(String taskId, int errCode, String errMsg) {
    _addToLogs("Upload error: $errCode, $errMsg");
  }

  _onUploadProgress(String taskId, double progress) {
    setState(() => _uploadProgress = progress / 100);
  }

  void queryTask() async {
    final res = await Modeling3dTextureTaskUtils().queryTask(_taskId);
    _addToLogs("from query task: " + res.retMsg!);
  }

  void downloadTexture() async {
    _engine.setTextureDownloadListener(Modeling3dTextureDownloadListener(
        _onDownloadResult, _onDownloadError, _onDownloadProgress));
    _engine.asyncDownloadTexture(_taskId, "${widget.filesPath}/downloads");
  }

  _onDownloadResult(String taskId, Modeling3dTextureDownloadResult result) {
    _addToLogs("Download complete: ${result.isComplete}");
  }

  _onDownloadError(String taskId, int errCode, String errMsg) {
    _addToLogs("Download error: $errCode, $errMsg");
  }

  _onDownloadProgress(String taskId, double progress) {
    setState(() => _downloadProgress = progress / 100);
  }

  void previewTexture() async {
    _engine.previewTexture(_taskId,
        listener: Modeling3dTexturePreviewListener(
            _onPreviewError, _onPreviewResult));
  }

  _onPreviewError(String taskId, int errCode, String errMsg) {
    _addToLogs("Preview error: $errCode, $errMsg");
  }

  _onPreviewResult(String taskId) {
    _addToLogs("Preview result: $taskId");
  }
}
