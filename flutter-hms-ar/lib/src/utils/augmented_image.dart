/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ar;

class AugmentedImage {
  String imgFileFromAsset;
  double widthInMeters;
  String imgName;

  AugmentedImage({
    required this.imgFileFromAsset,
    required this.widthInMeters,
    required this.imgName,
  });

  factory AugmentedImage.fromMap(Map<String, dynamic> jsonMap) {
    return AugmentedImage(
      imgFileFromAsset: jsonMap['imgFileFromAsset'],
      widthInMeters: jsonMap['widthInMeters'].toDouble(),
      imgName: jsonMap['imgName'],
    );
  }

  factory AugmentedImage.fromJSON(String json) {
    return AugmentedImage.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imgFileFromAsset': imgFileFromAsset,
      'widthInMeters': widthInMeters,
      'imgName': imgName,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
