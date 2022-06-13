/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class MLRemoteAftResult {
  List<Segment?> segments;
  List<Segment?> sentences;
  List<Segment?> words;
  String? text;
  String? taskId;
  bool? isComplete;

  MLRemoteAftResult({
    this.taskId,
    this.text,
    this.isComplete,
    required this.segments,
    required this.sentences,
    required this.words,
  });

  factory MLRemoteAftResult.fromMap(Map<dynamic, dynamic> map) {
    var segments = List<Segment>.empty(growable: true);
    var sentences = List<Segment>.empty(growable: true);
    var words = List<Segment>.empty(growable: true);

    if (map['segments'] != null) {
      map['segments'].forEach((v) {
        segments.add(Segment.fromMap(v));
      });
    }

    if (map['sentences'] != null) {
      map['sentences'].forEach((v) {
        sentences.add(Segment.fromMap(v));
      });
    }

    if (map['words'] != null) {
      map['words'].forEach((v) {
        words.add(Segment.fromMap(v));
      });
    }

    return MLRemoteAftResult(
      isComplete: map['isComplete'] ?? null,
      text: map['text'] ?? null,
      taskId: map['taskId'] ?? null,
      segments: segments,
      sentences: sentences,
      words: words,
    );
  }
}

class Segment {
  String? text;
  int? startTime;
  int? endTime;

  Segment({
    this.text,
    this.startTime,
    this.endTime,
  });

  factory Segment.fromMap(Map<dynamic, dynamic> map) {
    return Segment(
      text: map['text'] ?? null,
      startTime: map['startTime'] ?? null,
      endTime: map['endTime'] ?? null,
    );
  }
}
