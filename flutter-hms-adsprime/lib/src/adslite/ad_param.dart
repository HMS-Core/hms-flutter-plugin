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

part of '../../huawei_adsprime.dart';

class AdParam {
  /// User gender.
  ///
  /// `Constant value: 0` Unknown
  ///
  /// `Constant value: 1` Male
  ///
  /// `Constant value: 2` Female
  int? gender;

  /// The maximum transaction timeout interval (including the network delay), in milliseconds.
  int? tMax;

  /// Code of the country/region to which an app belongs.
  String? countryCode;

  /// Creative type of a native ad.
  List<DetailedCreativeType>? detailedCreativeTypeList;

  /// Content bundle.
  String? contentBundle;

  /// Location
  Location? location;

  /// Child-directed setting, setting directed to users under the age of consent, and ad content rating.
  ///
  /// The [RequestOptions] object has its own properties which provide additional settings.
  late RequestOptions requestOptions;

  Map<String, dynamic>? _setBiddingParamMap;

  Map<String, dynamic>? _addBiddingParamMap;

  AdParam({
    this.gender,
    this.tMax,
    this.countryCode,
    this.detailedCreativeTypeList,
    this.contentBundle,
    this.location,
    RequestOptions? options,
  }) {
    requestOptions = options ?? RequestOptions();
  }

  int get id => hashCode;

  AdParam addBiddingParamMap(String slotId, BiddingParam biddingParam) {
    _addBiddingParamMap = {
      "slotId": slotId,
      "biddingParam": biddingParam.toJson()
    };
    return this;
  }

  AdParam setBiddingParamMap(Map<String, BiddingParam> biddingParamMap) {
    Map<String, dynamic> paramMap = {};

    biddingParamMap.forEach((key, value) {
      paramMap[key] = value.toJson();
    });

    this._setBiddingParamMap = paramMap;
    return this;
  }

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'gender': gender,
      'tMax': tMax,
      'countryCode': countryCode,
      'detailedCreativeTypeList': detailedCreativeTypeList
          ?.map((DetailedCreativeType e) => e.value)
          .toList(growable: false),
      'contentBundle': contentBundle,
      'locationProvider': location?.provider,
      'locationLatitude': location?.latitude,
      'locationLongitude': location?.longitude,
      'addBiddingParamMap': _addBiddingParamMap,
      'setBiddingParamMap': _setBiddingParamMap,
      ...requestOptions._toMap(),
    };
  }
}

class Location {
  /// Provider. Default value is empty string.
  final String provider;
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
    this.provider = '',
  });
}
