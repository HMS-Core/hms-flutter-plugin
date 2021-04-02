/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:convert' show json;
import 'dart:ui' show hashValues;

class LinkUrl {
  LinkUrl({this.linkvalue, this.theme});

  String linkvalue;
  String theme;

  factory LinkUrl.fromJson(String str) => LinkUrl.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LinkUrl.fromMap(Map<String, dynamic> json) => LinkUrl(
        linkvalue: json["linkvalue"] == null ? null : json["linkvalue"],
        theme: json["theme"] == null ? null : json["theme"],
      );

  Map<String, dynamic> toMap() => {
        "linkvalue": linkvalue == null ? null : linkvalue,
        "theme": theme == null ? null : theme
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final LinkUrl check = o;
    return o is LinkUrl && check.linkvalue == linkvalue && check.theme == theme;
  }

  @override
  int get hashCode => hashValues(
        linkvalue,
        theme,
      );
}
