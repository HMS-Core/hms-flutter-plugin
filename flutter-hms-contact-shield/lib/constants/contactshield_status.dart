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

import 'package:flutter/foundation.dart';

@immutable
class ContactShieldStatus {
  final int _value;
  final String _text;

  const ContactShieldStatus._create(this._value, this._text);

  factory ContactShieldStatus.fromValue(int value) {
    switch (value) {
      case 1:
        return RUNNING;
      case 2:
        return NOT_RUNNING;
      case 4:
        return BLUETOOTH_OFF;
      case 8:
        return LOCATION_OFF;
      case 16:
        return NO_LOCATION_PERMISSION;
      case 32:
        return HARDWARE_NOT_SUPPORT;
      case 64:
        return STORAGE_LIMITED;
      case 128:
        return RUNNING_FOR_ANOTHER_APP;
      case 1024:
        return UNKNOWN;
      default:
        return null;
    }
  }

  factory ContactShieldStatus.fromText(String text) {
    switch (text) {
      case "RUNNING":
        return RUNNING;
      case "NOT_RUNNING":
        return NOT_RUNNING;
      case "BLUETOOTH_OFF":
        return BLUETOOTH_OFF;
      case "LOCATION_OFF":
        return LOCATION_OFF;
      case "NO_LOCATION_PERMISSION":
        return NO_LOCATION_PERMISSION;
      case "HARDWARE_NOT_SUPPORT":
        return HARDWARE_NOT_SUPPORT;
      case "STORAGE_LIMITED":
        return STORAGE_LIMITED;
      case "RUNNING_FOR_ANOTHER_APP":
        return RUNNING_FOR_ANOTHER_APP;
      case "UNKNOWN":
        return UNKNOWN;
      default:
        return null;
    }
  }

  int getStatusValue() => _value;

  String getStatusText() => _text;

  static int getStatusValues(Set<ContactShieldStatus> statusSet) {
    int value = 0;
    statusSet.forEach((contactShieldStatus) {
      value |= contactShieldStatus.getStatusValue();
    });
    return value;
  }

  static Set<ContactShieldStatus> getStatusSet(int value) {
    final Set<ContactShieldStatus> result = Set();
    int tmpValue = value;
    int base = 1;

    while (tmpValue > 0) {
      if (tmpValue % 2 != 0) {
        result.add(ContactShieldStatus.fromValue(base));
      }
      tmpValue ~/= 2;
      base *= 2;
    }
    return result;
  }

  static const RUNNING = const ContactShieldStatus._create(1, "RUNNING");
  static const NOT_RUNNING =
      const ContactShieldStatus._create(2, "NOT_RUNNING");
  static const BLUETOOTH_OFF =
      const ContactShieldStatus._create(4, "BLUETOOTH_OFF");
  static const LOCATION_OFF =
      const ContactShieldStatus._create(8, "LOCATION_OFF");
  static const NO_LOCATION_PERMISSION =
      const ContactShieldStatus._create(16, "NO_LOCATION_PERMISSION");
  static const HARDWARE_NOT_SUPPORT =
      const ContactShieldStatus._create(32, "HARDWARE_NOT_SUPPORT");
  static const STORAGE_LIMITED =
      const ContactShieldStatus._create(64, "STORAGE_LIMITED");
  static const RUNNING_FOR_ANOTHER_APP =
      const ContactShieldStatus._create(128, "RUNNING_FOR_ANOTHER_APP");
  static const UNKNOWN = const ContactShieldStatus._create(1024, "UNKNOWN");

  @override
  String toString() => "ContactShieldStatus[value: $_value, text: $_text]";
}
