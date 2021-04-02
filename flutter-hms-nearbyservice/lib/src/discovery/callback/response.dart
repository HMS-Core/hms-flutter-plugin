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

class ConnectOnEstablishResponse {
  final String endpointId;
  final ConnectInfo connectInfo;

  ConnectOnEstablishResponse({this.endpointId, this.connectInfo});

  factory ConnectOnEstablishResponse.fromMap(Map<dynamic, dynamic> map) =>
      ConnectOnEstablishResponse(
        endpointId: map['endpointId'],
        connectInfo: map['connectInfo'] != null
            ? ConnectInfo.fromMap(map['connectInfo'])
            : null,
      );

  Map<String, dynamic> toMap() => {
        'endpointId': endpointId,
        'connectInfo': connectInfo?.toMap(),
      };
}

class ConnectOnResultResponse {
  final String endpointId;
  final ConnectResult connectResult;

  ConnectOnResultResponse({this.endpointId, this.connectResult});

  factory ConnectOnResultResponse.fromMap(Map<dynamic, dynamic> map) =>
      ConnectOnResultResponse(
        endpointId: map['endpointId'],
        connectResult: map['connectResult'] != null
            ? ConnectResult.fromMap(map['connectResult'])
            : null,
      );

  Map<String, dynamic> toMap() => {
        'endpointId': endpointId,
        'connectResult': connectResult?.toMap(),
      };
}

class ScanOnFoundResponse {
  final String endpointId;
  final ScanEndpointInfo scanEndpointInfo;

  ScanOnFoundResponse({this.endpointId, this.scanEndpointInfo});

  factory ScanOnFoundResponse.fromMap(Map<dynamic, dynamic> map) =>
      ScanOnFoundResponse(
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
