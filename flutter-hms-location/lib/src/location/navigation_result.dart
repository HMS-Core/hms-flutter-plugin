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

class NavigationResult {
  ///  Obtains the confidence of the status information.
  ///
  ///  The value ranges from 0 to 100. A larger value indicates more reliable
  ///  result authenticity.
  int possibility;

  /// Status information.
  ///
  /// If the navigation type is [IS_SUPPORT_EX], the return values are
  /// described as follows:
  /// * 11: The user device supports high-precision location.
  /// * 12: The user device does not support high-precision location.
  int state;

  NavigationResult({
    required this.possibility,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'possibility': possibility,
    };
  }

  factory NavigationResult.fromMap(Map<dynamic, dynamic> map) {
    return NavigationResult(
      state: map['state'],
      possibility: map['possibility'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NavigationResult.fromJson(String source) =>
      NavigationResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NavigationResult('
        'state: $state, '
        'possibility: $possibility)';
  }
}
