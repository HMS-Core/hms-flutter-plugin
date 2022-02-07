import 'package:flutter/material.dart';
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class SceneExample extends StatefulWidget {
  @override
  _SceneExampleState createState() => _SceneExampleState();
}

class _SceneExampleState extends State<SceneExample> with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();

  late MLSceneDetectionAnalyzer _analyzer;

  List _results = [];
  List _confidences = [];

  @override
  void initState() {
    _analyzer = MLSceneDetectionAnalyzer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar("Scene Detection Demo"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultBox(sceneDetectionResults, _results, context),
            Container(
              color: kGrayColor,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: context.width * 0.3,
              height: context.width * 0.3,
              child: Image.asset(
                sceneImage,
              ),
            ),
            resultBox(confidences, _confidences, context),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () => pickerDialog(_key, context, analyseFrame),
                  child: Text(startSceneDetection),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () =>
                      pickerDialog(_key, context, asyncAnalyseFrame),
                  child: Text(startAsyncSceneDetection),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: dangerbuttonStyle,
                  onPressed: stop,
                  child: Text(stopText),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void analyseFrame(String? path) async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      final setting =
          MLSceneDetectionAnalyzerSetting.create(path: pickedImagePath);
      try {
        List<MLSceneDetection> list = await _analyzer.analyseFrame(setting);
        list.forEach((element) {
          setState(() {
            _results.add(element.result);
            _confidences.add(element.confidence);
          });
        });
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  @override
  void asyncAnalyseFrame(String? path) async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      final setting =
          MLSceneDetectionAnalyzerSetting.create(path: pickedImagePath);
      try {
        List<MLSceneDetection> list =
            await _analyzer.asyncAnalyseFrame(setting);
        list.forEach((element) {
          setState(() {
            _results.add(element.result);
            _confidences.add(element.confidence);
          });
        });
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  @override
  void stop() async {
    try {
      await _analyzer.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
