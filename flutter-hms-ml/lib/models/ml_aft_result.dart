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

class MLAftResult {
  List<Segment> segments;
  List<Segment> sentences;
  List<Segment> words;
  String text;
  String taskId;
  bool isComplete;

  MLAftResult(
      {this.taskId,
      this.text,
      this.isComplete,
      this.segments,
      this.sentences,
      this.words});

  MLAftResult.fromJson(Map<String, dynamic> json) {
    if (json['segments'] != null) {
      segments = new List<Segment>();
      json['segments'].forEach((v) {
        segments.add(new Segment.fromJson(v));
      });
    }
    if (json['sentences'] != null) {
      segments = new List<Segment>();
      json['sentences'].forEach((v) {
        segments.add(new Segment.fromJson(v));
      });
    }
    if (json['words'] != null) {
      segments = new List<Segment>();
      json['words'].forEach((v) {
        segments.add(new Segment.fromJson(v));
      });
    }
    text = json['text'] ?? null;
    taskId = json['taskId'] ?? null;
    isComplete = json['isComplete'] ?? null;
  }
}

class Segment {
  String text;
  int startTime;
  int endTime;

  Segment({this.text, this.startTime, this.endTime});

  Segment.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? null;
    startTime = json['startTime'] ?? null;
    endTime = json['endTime'] ?? null;
  }
}
