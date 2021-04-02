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

import 'package:huawei_nearbyservice/src/discovery/classes.dart';

class WifiOnFoundResponse {
  final String endpointId;
  final ScanEndpointInfo scanEndpointInfo;

  WifiOnFoundResponse({this.endpointId, this.scanEndpointInfo});

  factory WifiOnFoundResponse.fromMap(Map<dynamic, dynamic> map) =>
      WifiOnFoundResponse(
        endpointId: map['endpointId'],
        scanEndpointInfo: map['scanEndpointInfo'] != null
            ? ScanEndpointInfo.fromMap(map['scanEndpointInfo'])
            : null,
      );

  Map<String, dynamic> toMap() => {
        'endpointId': endpointId,
        'scanEndpointInfo': scanEndpointInfo?.toMap(),
      };
}

class WifiOnFetchAuthCodeResponse {
  final String endpointId;
  final String authCode;

  WifiOnFetchAuthCodeResponse({this.endpointId, this.authCode});

  factory WifiOnFetchAuthCodeResponse.fromMap(Map<dynamic, dynamic> map) =>
      WifiOnFetchAuthCodeResponse(
        endpointId: map['endpointId'],
        authCode: map['authCode'],
      );

  Map<String, dynamic> toMap() => {
        'endpointId': endpointId,
        'authCode': authCode,
      };
}

class WifiShareResultResponse {
  final String endpointId;
  final int statusCode;

  WifiShareResultResponse({this.endpointId, this.statusCode});

  factory WifiShareResultResponse.fromMap(Map<dynamic, dynamic> map) =>
      WifiShareResultResponse(
        endpointId: map['endpointId'],
        statusCode: map['statusCode'],
      );

  Map<String, dynamic> toMap() => {
        'endpointId': endpointId,
        'statusCode': statusCode,
      };
}
