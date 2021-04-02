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

import 'package:huawei_nearbyservice/src/transfer/classes.dart';

class DataOnReceivedResponse {
  final String endpointId;
  final TransferData data;
  final String errorCode;

  DataOnReceivedResponse({this.endpointId, this.data, this.errorCode});

  factory DataOnReceivedResponse.fromMap(Map<dynamic, dynamic> map) =>
      DataOnReceivedResponse(
          endpointId: map['endpointId'],
          data: map['data'] != null ? TransferData.fromMap(map['data']) : null,
          errorCode: map['errorCode']);

  Map<dynamic, dynamic> toMap() =>
      {'endpointId': endpointId, 'data': data?.toMap(), 'errorCode': errorCode};
}

class DataOnTransferUpdateResponse {
  final String endpointId;
  final TransferStateUpdate transferStateUpdate;

  DataOnTransferUpdateResponse({this.endpointId, this.transferStateUpdate});

  factory DataOnTransferUpdateResponse.fromMap(Map<dynamic, dynamic> map) =>
      DataOnTransferUpdateResponse(
          endpointId: map['endpointId'],
          transferStateUpdate: map['transferStateUpdate'] != null
              ? TransferStateUpdate.fromMap(map['transferStateUpdate'])
              : map['transferStateUpdate']);

  Map<dynamic, dynamic> toMap() => {
        'endpointId': endpointId,
        'transferStateUpdate': transferStateUpdate?.toMap()
      };
}
