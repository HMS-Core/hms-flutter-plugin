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

class BiddingParam {
  /// Floor bid for an ad unit.
  double? bidFloor;

  /// Currency used by the ad unit floor bid.
  String? bidFloorCur;

  /// App packages that are prohibited from delivering ads through real-time bidding ad units.
  List<String>? bpkgName;

  BiddingParam({
    this.bidFloor,
    this.bidFloorCur,
    this.bpkgName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bidFloor': bidFloor,
      'bidFloorCur': bidFloorCur,
      'bpkgName': bpkgName,
    };
  }

  static BiddingParam fromJson(Map<String, dynamic> json) {
    return BiddingParam(
      bidFloor: json['bidFloor'],
      bidFloorCur: json['bidFloorCur'],
      bpkgName:
          json['bpkgName'] != null ? List<String>.from(json['bpkgName']) : null,
    );
  }
}
