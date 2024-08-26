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

class Locale {
  String language;
  String? country;

  Locale({
    required this.language,
    this.country,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'country': country,
    };
  }

  factory Locale.fromMap(Map<dynamic, dynamic>? map) {
    return Locale(
      language: map?['language'],
      country: map?['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Locale.fromJson(String source) => Locale.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LogConfig('
        'language: $language, '
        'country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Locale &&
        other.language == language &&
        other.country == country;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        language,
        country,
      ],
    );
  }
}
