/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class TextOptions {
  //Text options
  Color? textColor;
  double? textSize;

  //if true text will auto size itself
  bool? autoSizeText;

  //Auto size text options
  int? minTextSize;
  int? maxTextSize;
  int? granularity;

  TextOptions({
    this.textColor = Colors.black,
    this.textSize = 20.0,
    this.autoSizeText = false,
    this.minTextSize = 18,
    this.maxTextSize = 34,
    this.granularity = 2,
  });

  factory TextOptions.fromJson(String str) {
    return TextOptions.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory TextOptions.fromMap(Map<String, dynamic> json) {
    return TextOptions(
      textColor: json['textColor'] == null ? null : Color(json['textColor']),
      textSize: json['textSize'],
      autoSizeText: json['autoSizeText'],
      minTextSize: json['minTextSize'],
      maxTextSize: json['maxTextSize'],
      granularity: json['granularity'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'textColor': textColor?.value,
      'textSize': textSize,
      'autoSizeText': autoSizeText,
      'minTextSize': minTextSize,
      'maxTextSize': maxTextSize,
      'granularity': granularity,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is TextOptions &&
        other.textColor == textColor &&
        other.textSize == textSize &&
        other.autoSizeText == autoSizeText &&
        other.minTextSize == minTextSize &&
        other.maxTextSize == maxTextSize &&
        other.granularity == granularity;
  }
}
