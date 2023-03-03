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

import 'dart:convert';
import 'dart:typed_data';

class ExecuteResponse {
  Int8List? content;
  String? contentEncoding;
  int? contentLoggingLimit;
  String? contentType;

  ExecuteResponse({
    this.content,
    this.contentEncoding,
    this.contentLoggingLimit,
    this.contentType,
  });

  factory ExecuteResponse.fromMap(Map<String, dynamic> map) {
    return ExecuteResponse(
      content: map['content'] == null
          ? null
          : Int8List.fromList(List<int>.from(map['content'])),
      contentEncoding: map['contentEncoding'],
      contentLoggingLimit: map['contentLoggingLimit'],
      contentType: map['contentType'],
    );
  }

  factory ExecuteResponse.fromJson(String source) =>
      ExecuteResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content?.toList(),
      'contentEncoding': contentEncoding,
      'contentLoggingLimit': contentLoggingLimit,
      'contentType': contentType,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ExecuteResponse(content: $content, contentEncoding: $contentEncoding, contentLoggingLimit: $contentLoggingLimit, contentType: $contentType)';
  }
}
