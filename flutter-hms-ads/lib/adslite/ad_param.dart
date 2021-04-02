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
import 'package:huawei_ads/adslite/request_options.dart';

class AdParam {
  int gender;
  String countryCode;
  RequestOptions requestOptions;

  AdParam({this.gender, this.countryCode, RequestOptions options}) {
    requestOptions = options ?? RequestOptions();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = requestOptions.toJson();
    if (gender != null) json['gender'] = gender;
    if (countryCode != null) json['countryCode'] = countryCode;

    return json;
  }
}
