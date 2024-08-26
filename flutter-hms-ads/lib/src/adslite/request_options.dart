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

part of '../../huawei_ads.dart';

class RequestOptions {
  /// Maximum ad content rating.
  ContentClassification? adContentClassification;

  /// Whether to process ad requests as directed to users under the age of consent.
  UnderAge? tagForUnderAgeOfPromise;

  /// Whether to process ad requests according to the COPPA.
  TagForChild? tagForChildProtection;

  /// Whether to request non-personalized ads.
  ///
  /// * 0: NON_PERSONALIZED
  /// * 1: PERSONALIZED
  /// * 2: UNKNOWN
  int? nonPersonalizedAd;

  /// Country/region code corresponding to the language in which an ad needs to be returned for an app.
  String? appCountry;

  /// Language in which an ad needs to be returned for an app.
  String? appLang;

  /// User consent string, which complies with Consent String Format in TCF v2.0.
  String? consent;

  /// Whether location information is requested.
  bool? requestLocation;

  int? tMax;

  /// Sets the parameters for a real-time bidding ad unit.
  Map<String, dynamic>? _setBiddingParamMap;

  /// Sets the parameters for a real-time bidding ad unit.
  Map<String, dynamic>? _addBiddingParamMap;

  RequestOptions({
    this.adContentClassification,
    this.tagForUnderAgeOfPromise,
    this.tagForChildProtection,
    this.nonPersonalizedAd,
    this.appCountry,
    this.appLang,
    this.consent,
    this.tMax,
    this.requestLocation = true,
  }) {}

  int get id => hashCode;

  RequestOptions addBiddingParamMap(String slotId, BiddingParam param) {
    _addBiddingParamMap = {'slotId': slotId, 'biddingParam': param.toJson()};
    return this;
  }

  RequestOptions setBiddingParamMap(Map<String, BiddingParam> biddingParamMap) {
    Map<String, dynamic> paramMap = {};

    biddingParamMap.forEach((key, value) {
      paramMap[key] = value.toJson();
    });

    this._setBiddingParamMap = paramMap;
    return this;
  }

  static RequestOptions _fromMap(Map<dynamic, dynamic> map) {
    return RequestOptions(
      adContentClassification: map['adContentClassification'] != null
          ? ContentClassification._(map['adContentClassification'])
          : null,
      tagForUnderAgeOfPromise: map['tagForUnderAgeOfPromise'] != null
          ? UnderAge._(map['tagForUnderAgeOfPromise'])
          : null,
      tagForChildProtection: map['tagForChildProtection'] != null
          ? TagForChild._(map['tagForChildProtection'])
          : null,
      nonPersonalizedAd: map['nonPersonalizedAd'],
      appCountry: map['appCountry'],
      appLang: map['appLang'],
      consent: map['consent'],
      requestLocation: map['requestLocation'],
    );
  }

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'adContentClassification': adContentClassification?.value,
      'tagForUnderAgeOfPromise': tagForUnderAgeOfPromise?.value,
      'tagForChildProtection': tagForChildProtection?.value,
      'nonPersonalizedAd': nonPersonalizedAd,
      'appCountry': appCountry,
      'appLang': appLang,
      'consent': consent,
      'tMax': tMax,
      'requestLocation': requestLocation,
      'addBiddingParamMap': _addBiddingParamMap,
      'setBiddingParamMap': _setBiddingParamMap,
    }..removeWhere((_, dynamic v) => v == null);
  }
}
