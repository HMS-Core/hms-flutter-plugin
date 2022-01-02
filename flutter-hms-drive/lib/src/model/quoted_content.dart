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

import 'dart:convert';

/// Class of file content quoted in comments.
class QuotedContent {
  /// MIME type of the file.
  String? mimeType;

  /// Quoted content.
  String? quotedContent;

  QuotedContent({
    this.mimeType,
    this.quotedContent,
  });

  QuotedContent clone({
    String? mimetype,
    String? quotedContent,
  }) {
    return QuotedContent(
      mimeType: mimeType ?? this.mimeType,
      quotedContent: quotedContent ?? this.quotedContent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mimeType': mimeType,
      'quotedContent': quotedContent,
    };
  }

  factory QuotedContent.fromMap(Map<String, dynamic>? map) {
    if (map == null) return QuotedContent();

    return QuotedContent(
      mimeType: map['mimeType'],
      quotedContent: map['quotedContent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuotedContent.fromJson(String source) =>
      QuotedContent.fromMap(json.decode(source));

  @override
  String toString() =>
      'QuotedContent(mimeType: $mimeType, quotedContent: $quotedContent)';
}
