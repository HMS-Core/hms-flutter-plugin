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

class Period {
  TimeOfWeek? open;
  TimeOfWeek? close;

  Period({
    this.open,
    this.close,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'open': open?.toMap(),
      'close': close?.toMap(),
    };
  }

  factory Period.fromMap(Map<dynamic, dynamic> map) {
    return Period(
      open: map['open'] != null ? TimeOfWeek.fromMap(map['open']) : null,
      close: map['close'] != null ? TimeOfWeek.fromMap(map['close']) : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Period.fromJson(String source) {
    return Period.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$Period('
        'open: $open, '
        'close: $close)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Period && other.open == open && other.close == close;
  }

  @override
  int get hashCode {
    return open.hashCode ^ close.hashCode;
  }
}
