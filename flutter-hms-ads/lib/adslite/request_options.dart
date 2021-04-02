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
class RequestOptions {
  String adContentClassification;
  int tagForUnderAgeOfPromise;
  int tagForChildProtection;
  int nonPersonalizedAd;
  String appCountry;
  String appLang;
  String consent;

  RequestOptions({
    this.adContentClassification,
    this.tagForUnderAgeOfPromise,
    this.tagForChildProtection,
    this.nonPersonalizedAd,
    this.appCountry,
    this.appLang,
    this.consent,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (adContentClassification != null)
      json['adContentClassification'] = adContentClassification;
    if (tagForUnderAgeOfPromise != null)
      json['tagForUnderAgeOfPromise'] = tagForUnderAgeOfPromise;
    if (tagForChildProtection != null)
      json['tagForChildProtection'] = tagForChildProtection;
    if (nonPersonalizedAd != null)
      json['nonPersonalizedAd'] = nonPersonalizedAd;
    if (appCountry != null) json['appCountry'] = appCountry;
    if (appLang != null) json['appLang'] = appLang;
    if (consent != null) json['consent'] = consent;

    return json;
  }

  static RequestOptions fromJson(Map<dynamic, dynamic> args) {
    RequestOptions options = new RequestOptions();
    options.adContentClassification = args['adContentClassification'] ?? null;
    options.tagForUnderAgeOfPromise = args['tagForUnderAgeOfPromise'] ?? null;
    options.tagForChildProtection = args['tagForChildProtection'] ?? null;
    options.nonPersonalizedAd = args['nonPersonalizedAd'] ?? null;
    options.appCountry = args['appCountry'] ?? null;
    options.appLang = args['appLang'] ?? null;
    options.consent = args['consent'] ?? null;

    return options;
  }
}
