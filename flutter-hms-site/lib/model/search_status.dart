/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class SearchStatus {
  String? errorCode;
  String? errorMessage;

  SearchStatus({
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  factory SearchStatus.fromMap(Map<String, dynamic> map) {
    return SearchStatus(
      errorCode: map['errorCode'] == null ? null : map['errorCode'],
      errorMessage: map['errorMessage'] == null ? null : map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchStatus.fromJson(String source) =>
      SearchStatus.fromMap(json.decode(source));

  @override
  String toString() =>
      'SearchStatus(errorCode: $errorCode, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchStatus &&
        o.errorCode == errorCode &&
        o.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorCode.hashCode ^ errorMessage.hashCode;
}
