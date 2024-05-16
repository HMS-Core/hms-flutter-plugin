/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_site;

class SearchStatus {
  String? errorCode;
  String? errorMessage;

  SearchStatus({
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  factory SearchStatus.fromMap(Map<dynamic, dynamic> map) {
    return SearchStatus(
      errorCode: map['errorCode'],
      errorMessage: map['errorMessage'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory SearchStatus.fromJson(String source) {
    return SearchStatus.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$SearchStatus('
        'errorCode: $errorCode, '
        'errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchStatus &&
        other.errorCode == errorCode &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return errorCode.hashCode ^ errorMessage.hashCode;
  }
}
