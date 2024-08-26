/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class NavigationRequest {
  /// Used to request the device navigation status.
  static const int OVERPASS = 1;

  /// Used to check whether the device supports high-precision location.
  static const int IS_SUPPORT_EX = 2;

  /// Requested navigation type.
  int type;

  NavigationRequest({required this.type});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
    };
  }

  factory NavigationRequest.fromMap(Map<dynamic, dynamic> map) {
    return NavigationRequest(
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NavigationRequest.fromJson(String source) =>
      NavigationRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NavigationRequest(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is NavigationRequest && other.type == type;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        type,
      ],
    );
  }
}
