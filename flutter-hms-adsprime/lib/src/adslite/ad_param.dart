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

part of huawei_adsprime;

class AdParam {
  int? gender;
  String? countryCode;
  List<DetailedCreativeType>? detailedCreativeTypeList;
  String? contentBundle;
  Location? location;
  late RequestOptions requestOptions;

  AdParam({
    this.gender,
    this.countryCode,
    this.detailedCreativeTypeList,
    this.contentBundle,
    this.location,
    RequestOptions? options,
  }) : requestOptions = options ?? RequestOptions();

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'gender': gender,
      'countryCode': countryCode,
      'detailedCreativeTypeList': detailedCreativeTypeList
          ?.map((DetailedCreativeType e) => e.value)
          .toList(growable: false),
      'contentBundle': contentBundle,
      'locationProvider': location?.provider,
      'locationLatitude': location?.latitude,
      'locationLongitude': location?.longitude,
      ...requestOptions._toMap(),
    };
  }
}

class Location {
  final String provider;
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
    this.provider = '',
  });
}
