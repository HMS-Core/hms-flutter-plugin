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
import 'package:huawei_ml_body/huawei_ml_body.dart';
import 'package:huawei_ml_body_example/utils/demo_util.dart';

class SkeletonExample extends StatefulWidget {
  const SkeletonExample({Key? key}) : super(key: key);

  @override
  State<SkeletonExample> createState() => _SkeletonExampleState();
}

class _SkeletonExampleState extends State<SkeletonExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLSkeletonAnalyzer _analyzer;
  final List<int?> types = <int?>[];
  late List<MLSkeleton> listt = <MLSkeleton>[];

  @override
  void initState() {
    super.initState();
    _analyzer = MLSkeletonAnalyzer();
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final MLSkeletonAnalyzerSetting setting = MLSkeletonAnalyzerSetting(
      path: path,
    );
    final List<MLSkeleton> skeletons = await _analyzer.analyseFrame(setting);
    setState(() => listt.addAll(skeletons));
    for (MLJoint element in skeletons.first.joints) {
      setState(() => types.add(element.type));
    }
  }

  @override
  void destroy() async {
    try {
      _analyzer.destroy();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void isAvailable() async {
    try {
      final bool res = await _analyzer.isAvailable();
      debugPrint(res.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void stop() async {
    try {
      _analyzer.stop();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Skeleton Example'),
      body: Column(
        children: <Widget>[
          resultBox('Joint types detected', types),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: () => pickerDialog(_key, context, analyze),
              child: const Text('Start Recognition'),
            ),
          ),
        ],
      ),
    );
  }
}
