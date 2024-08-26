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

part of '../../../huawei_adsprime.dart';

class DetailedCreativeType {
  /// Large image with text.
  static const DetailedCreativeType BIG_IMG = DetailedCreativeType._(901);

  /// Video.
  static const DetailedCreativeType VIDEO = DetailedCreativeType._(903);

  /// Three small images with text.
  static const DetailedCreativeType THREE_IMG = DetailedCreativeType._(904);

  /// Small image with text.
  static const DetailedCreativeType SMALL_IMG = DetailedCreativeType._(905);

  /// Single image.
  static const DetailedCreativeType SINGLE_IMG = DetailedCreativeType._(909);

  /// Short text.
  static const DetailedCreativeType SHORT_TEXT = DetailedCreativeType._(913);

  /// Long text.
  static const DetailedCreativeType LONG_TEXT = DetailedCreativeType._(914);

  final int value;
  const DetailedCreativeType._(this.value);
}
