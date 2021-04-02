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

class MessagePolicy {
  static const int findingModeBroadcast = 1;
  static const int findingModeScan = 2;
  static const int findingModeDefault = 0;
  static const int distanceTypeDefault = 0;
  static const int distanceTypeEarshot = 1;
  static const int ttlSecondsDefault = 240;
  static const int ttlSecondsInfinite = 0x7FFFFFFF;
  static const int ttlSecondsMax = 86400;

  final int findingMode;
  final int distanceType;
  final int ttlSeconds;

  static final MessagePolicy bleOnly = MessagePolicyBuilder()
      .setTtlSeconds(MessagePolicy.ttlSecondsInfinite)
      .build();

  MessagePolicy._builder(MessagePolicyBuilder builder)
      : this.findingMode = builder._findingMode,
        this.distanceType = builder._distanceType,
        this.ttlSeconds = builder._ttlSeconds;

  bool equals(object) =>
      identical(object, this) ||
      (object is MessagePolicy &&
          object.findingMode == this.findingMode &&
          object.ttlSeconds == this.ttlSeconds &&
          object.distanceType == this.distanceType);

  Map<String, dynamic> toMap() => {
        'findingMode': findingMode,
        'ttlSeconds': ttlSeconds,
        'distanceType': distanceType,
      };
}

class MessagePolicyBuilder {
  final List<int> _findingModes = [
    MessagePolicy.findingModeBroadcast,
    MessagePolicy.findingModeDefault,
    MessagePolicy.findingModeScan
  ];

  final List<int> _distanceTypes = [
    MessagePolicy.distanceTypeEarshot,
    MessagePolicy.distanceTypeDefault
  ];

  int _findingMode = MessagePolicy.findingModeDefault;
  int _distanceType = MessagePolicy.distanceTypeDefault;
  int _ttlSeconds = MessagePolicy.ttlSecondsDefault;

  MessagePolicyBuilder();

  MessagePolicyBuilder setFindingMode(int findingMode) {
    if (!_findingModes.contains(findingMode))
      throw ArgumentError(
          'Finding mode must be one of the [MessagePolicy.findingMode*] values');
    else
      this._findingMode = findingMode;
    return this;
  }

  MessagePolicyBuilder setDistanceType(int distanceType) {
    if (!_distanceTypes.contains(distanceType))
      throw ArgumentError(
          'Distance type must be one of the [MessagePolicy.distanceType*] values');
    else
      this._distanceType = distanceType;
    return this;
  }

  MessagePolicyBuilder setTtlSeconds(int ttlSeconds) {
    if (ttlSeconds == MessagePolicy.ttlSecondsInfinite ||
        (ttlSeconds > 1 && ttlSeconds <= MessagePolicy.ttlSecondsMax))
      this._ttlSeconds = ttlSeconds;
    else
      throw ArgumentError(
          'Ttl seconds can be either equal to [MessagePolicy.ttlSecondsInfinite] or range from 1 to [MessagePolicy.ttlSecondsMax]');
    return this;
  }

  MessagePolicy build() {
    return MessagePolicy._builder(this);
  }
}
