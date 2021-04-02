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
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:huawei_ml/huawei_ml.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class AftExample extends StatefulWidget {
  @override
  _AftExampleState createState() => _AftExampleState();
}

class _AftExampleState extends State<AftExample> {
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  FileType _pickingType = FileType.audio;

  String _pathResult = "";
  String _response = "Transcription result will be shown here.";
  String _taskId;

  MLAftEngine aftEngine;

  @override
  void initState() {
    _setApiKey();
    _initEngine();
    _init();
    super.initState();
  }

  _initEngine() {
    aftEngine = new MLAftEngine();
    aftEngine.setAftListener((event, taskId,
        {errorCode, eventId, result, uploadProgress}) {
      _taskId = taskId;
      switch (event) {
        case MLAftEvent.onEvent:
          _setResponse("eventId: $eventId");
          break;
        case MLAftEvent.onResult:
          _setResponse(result.text);
          break;
        case MLAftEvent.onError:
          _setResponse("errorCode: $errorCode");
          break;
        case MLAftEvent.onInitComplete:
          _setResponse("Init completed. You can start the task $taskId");
          break;
        case MLAftEvent.onUploadProgress:
          _setResponse("upload progress: $uploadProgress");
          break;
      }
    });
  }

  _setResponse(String s) {
    setState(() => _response = _response + "\n " + s);
  }

  _startTranscription() async {
    final aftSetting = MLAftSetting();
    aftSetting.path = _pathResult;
    try {
      aftEngine.startRecognition(setting: aftSetting);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _startTask() async {
    try {
      await aftEngine.startTask(taskId: _taskId);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _pauseTask() async {
    try {
      await aftEngine.pauseTask(taskId: _taskId);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _getLongAftResult() async {
    try {
      await aftEngine.getLongAftResult(taskId: _taskId);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _destroyTask() async {
    try {
      await aftEngine.destroyTask(taskId: _taskId);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _closeAftEngine() async {
    try {
      await aftEngine.closeAftEngine();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("AFT"), actions: [
          IconButton(icon: Icon(Icons.close), onPressed: _closeAftEngine),
          IconButton(icon: Icon(Icons.pause), onPressed: _pauseTask),
        ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Record Audio",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      FlatButton(
                        onPressed: () {
                          switch (_currentStatus) {
                            case RecordingStatus.Initialized:
                              {
                                _start();
                                break;
                              }
                            case RecordingStatus.Recording:
                              {
                                _pause();
                                break;
                              }
                            case RecordingStatus.Paused:
                              {
                                _resume();
                                break;
                              }
                            case RecordingStatus.Stopped:
                              {
                                _init();
                                break;
                              }
                            default:
                              break;
                          }
                        },
                        child: _buildText(_currentStatus),
                        color: Colors.lightBlue,
                      ),
                      SizedBox(width: 20),
                      FlatButton(
                        onPressed: _currentStatus != RecordingStatus.Unset
                            ? _stop
                            : null,
                        child: new Text("Stop",
                            style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pick Audio File",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                        onPressed: () async {
                          final String audioPath = await FilePicker.getFilePath(
                              type: _pickingType, allowedExtensions: null);
                          setState(() {
                            _pathResult = audioPath;
                          });
                        },
                        child: Text("Browse Audio Files"),
                        color: Colors.lightBlue,
                        textColor: Colors.white),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Transcription Result",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text(_response),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("START RECOGNITION"),
                  textColor: Colors.white,
                  onPressed: _pathResult == "" ? null : _startTranscription,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("START TASK"),
                  textColor: Colors.white,
                  onPressed: _pathResult == "" ? null : _startTask,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("GET LONG AFT RESULT"),
                  textColor: Colors.white,
                  onPressed: _pathResult == "" ? null : _getLongAftResult,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("DESTROY TASK"),
                  textColor: Colors.white,
                  onPressed: _pathResult == "" ? null : _destroyTask,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory = await getExternalStorageDirectory();
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine.
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        MLPermissionClient().requestPermission([MLPermission.audio]);
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
      _pathResult = _current.path;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Start';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Init';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(color: Colors.white));
  }
}
