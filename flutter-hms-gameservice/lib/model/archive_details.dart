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

import 'dart:typed_data';

/// Operates an archive file.
class ArchiveDetails {
  /// Byte data of an archive file.
  Uint8List content;

  ArchiveDetails(
    this.content,
  );

  Map<String, dynamic> toMap() {
    return {
      'content': content,
    };
  }

  factory ArchiveDetails.fromUint8List(Uint8List bytes) {
    if (bytes == null) return null;

    return ArchiveDetails(Uint8List.fromList(bytes));
  }

  /// Modifies an archive file.
  ///
  /// The modified archive file is saved in the local cache and is not uploaded to Huawei game server
  /// until the archive is submitted.
  bool update(
      int dstOffset, Uint8List updateContent, int srcOffset, int count) {
    List<int> update = List<int>.from(updateContent);
    update.replaceRange(
        dstOffset, dstOffset + count, updateContent.sublist(srcOffset));
    if (content.length == update.length) {
      this.content = Uint8List.fromList(update);
      return true;
    }
    throw "Invalid value: Not in range: src.length=${updateContent.length} srcPos=$srcOffset dst.length=${content.length} dstPos=$dstOffset length=$count";
  }

  @override
  String toString() => 'ArchiveDetails(content: $content)';
}
