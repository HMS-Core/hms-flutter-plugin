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

part of huawei_ml_image;

class MLImageSegmentation {
  final Uint8List? foreground;
  final Uint8List? grayscale;
  final Uint8List? original;
  final Uint8List? masks;

  const MLImageSegmentation._({
    this.foreground,
    this.grayscale,
    this.original,
    this.masks,
  });

  factory MLImageSegmentation.fromMap(Map<dynamic, dynamic> map) {
    return MLImageSegmentation._(
      foreground: map['foreground'],
      grayscale: map['grayscale'],
      original: map['original'],
      masks: map['masks'],
    );
  }
}
