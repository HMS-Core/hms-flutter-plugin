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

class ARAugmentdImage implements ARTrackableBase {
  @override
  final List<ARAnchor>? anchors;
  @override
  final TrackingState? trackingState;
  final ARPose? centerPose;
  final double? extentX;
  final double? extentZ;
  final int index;
  final String name;

  ARAugmentdImage._({
    required this.name,
    required this.index,
    this.anchors,
    this.trackingState,
    this.centerPose,
    this.extentX,
    this.extentZ, 
  });

  factory ARAugmentdImage.fromMap(Map<String, dynamic> jsonMap) {
    return ARAugmentdImage._(
      anchors: jsonMap['anchors'] != null
          ? List<ARAnchor>.from(
              jsonMap['anchors'].map((dynamic x) => ARAnchor.fromMap(x)),
            )
          : null,
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
      centerPose: jsonMap['centerPose'] != null
          ? ARPose.fromMap(jsonMap['centerPose'])
          : null,
      extentX: jsonMap['extentX'],
      extentZ: jsonMap['extentZ'],
      index: jsonMap['index'],
      name: jsonMap['name'],
    );
  }

  factory ARAugmentdImage.fromJSON(String json) {
    return ARAugmentdImage.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trackingState': trackingState,
      'anchors': anchors,
      'centerPose': centerPose?.toMap(),
      'extentX': extentX,
      'extentZ': extentZ,
      'index': index,
      'name': name,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
