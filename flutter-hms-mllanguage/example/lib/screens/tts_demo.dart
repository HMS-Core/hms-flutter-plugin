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
import 'package:huawei_ml_language/huawei_ml_language.dart';
import 'package:huawei_ml_language_example/utils/demo_utils.dart';

class TtsDemo extends StatefulWidget {
  const TtsDemo({Key? key}) : super(key: key);

  @override
  State<TtsDemo> createState() => _TtsDemoState();
}

class _TtsDemoState extends State<TtsDemo> {
  final MLTtsEngine engine = MLTtsEngine();
  final List<String?> _events = <String?>[
    'Initial event',
  ];
  final String text = ''
      'We use essential cookies for the website to function, '
      'as well as analytics cookies for analyzing and creating '
      'statistics of the website performance.';

  @override
  void initState() {
    super.initState();
    engine.setTtsCallback(
      MLTtsCallback(
        onError: _onError,
        onEvent: _onEvent,
        onAudioAvailable: _onAudioAvailable,
        onRangeStart: _onRangeStart,
        onWarn: _onWarn,
      ),
    );
  }

  Widget _customTextWidget(String text) {
    return InkWell(
      onTap: () => speak(text),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: .5,
            color: Colors.blueAccent.withOpacity(.5),
            style: BorderStyle.solid,
          ),
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tts Demo'),
      ),
      body: Column(
        children: <Widget>[
          _customTextWidget(
            'Hi, how are you',
          ),
          _customTextWidget(
            'Dave watched as the forest burned up on the hill, only a few miles from her house.',
          ),
          _customTextWidget(
            "The computer wouldn't start. She banged on the side and tried again. Nothing. She lifted it up and dropped it to the table. Still nothing.",
          ),
          const Divider(height: 5, color: Colors.grey),
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${_events[index]}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: pause,
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: resume,
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: stop,
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: shutdown,
            ),
          ],
        ),
      ),
    );
  }

  // Methods
  void getLangs() async {
    try {
      final List<String> list = await engine.getLanguages();
      setState(() => _events.addAll(list));
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void getSpeaker() async {
    try {
      final List<MLTtsSpeaker> list = await engine.getSpeaker(
        MLTtsConstants.TTS_EN_US,
      );
      for (MLTtsSpeaker item in list) {
        setState(() => _events.add(item.name));
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void getSpeakers() async {
    try {
      final List<MLTtsSpeaker> list = await engine.getSpeakers();
      for (MLTtsSpeaker item in list) {
        setState(() => _events.add(item.name));
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void isLangAvailable() async {
    try {
      final int res = await engine.isLanguageAvailable(
        MLTtsConstants.TTS_EN_US,
      );
      setState(() => _events.add(res.toString()));
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void pause() {
    try {
      engine.pause();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void resume() {
    try {
      engine.resume();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void stop() {
    try {
      engine.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void shutdown() {
    try {
      engine.shutdown();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void speak(String text) async {
    final MLTtsConfig config = MLTtsConfig(
      language: MLTtsConstants.TTS_EN_US,
      synthesizeMode: MLTtsConstants.TTS_ONLINE_MODE,
      text: text,
    );
    try {
      final String res = await engine.speak(config);
      setState(() => _events.add('speak result: $res'));
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  // Listeners
  void _onError(String taskId, MLTtsError err) {
    setState(() {
      _events.add(
        'onError: $taskId  ${err.errorMsg}  ${err.errorId}',
      );
    });
  }

  void _onEvent(String taskId, int eventId) {
    setState(() {
      _events.add(
        'onEvent: $taskId  $taskId  $eventId',
      );
    });
  }

  void _onAudioAvailable(
    String taskId,
    MLTtsAudioFragment audioFragment,
    int offset,
  ) {
    setState(() {
      _events.add(
        'audio available: ${audioFragment.audioFormat}  offset: $offset',
      );
    });
  }

  void _onRangeStart(String taskId, int start, int end) {
    setState(() {
      _events.add(
        'range start & end: $start  $end',
      );
    });
  }

  void _onWarn(String taskId, MLTtsWarn warn) {
    setState(() {
      _events.add(
        'onWarn: ${warn.warnMsg}',
      );
    });
  }
}
