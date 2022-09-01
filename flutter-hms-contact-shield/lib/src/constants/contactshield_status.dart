/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_contactshield;

@immutable
class ContactShieldStatus {
  static const ContactShieldStatus RUNNING =
      ContactShieldStatus._(1, 'RUNNING');
  static const ContactShieldStatus NOT_RUNNING =
      ContactShieldStatus._(2, 'NOT_RUNNING');
  static const ContactShieldStatus BLUETOOTH_OFF =
      ContactShieldStatus._(4, 'BLUETOOTH_OFF');
  static const ContactShieldStatus LOCATION_OFF =
      ContactShieldStatus._(8, 'LOCATION_OFF');
  static const ContactShieldStatus NO_LOCATION_PERMISSION =
      ContactShieldStatus._(16, 'NO_LOCATION_PERMISSION');
  static const ContactShieldStatus HARDWARE_NOT_SUPPORT =
      ContactShieldStatus._(32, 'HARDWARE_NOT_SUPPORT');
  static const ContactShieldStatus STORAGE_LIMITED =
      ContactShieldStatus._(64, 'STORAGE_LIMITED');
  static const ContactShieldStatus RUNNING_FOR_ANOTHER_APP =
      ContactShieldStatus._(128, 'RUNNING_FOR_ANOTHER_APP');
  static const ContactShieldStatus UNKNOWN =
      ContactShieldStatus._(1024, 'UNKNOWN');

  final int _value;
  final String _text;

  const ContactShieldStatus._(this._value, this._text);

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
        return UNKNOWN;
    }
  }

  factory ContactShieldStatus.fromText(String text) {
    switch (text) {
      case 'RUNNING':
        return RUNNING;
      case 'NOT_RUNNING':
        return NOT_RUNNING;
      case 'BLUETOOTH_OFF':
        return BLUETOOTH_OFF;
      case 'LOCATION_OFF':
        return LOCATION_OFF;
      case 'NO_LOCATION_PERMISSION':
        return NO_LOCATION_PERMISSION;
      case 'HARDWARE_NOT_SUPPORT':
        return HARDWARE_NOT_SUPPORT;
      case 'STORAGE_LIMITED':
        return STORAGE_LIMITED;
      case 'RUNNING_FOR_ANOTHER_APP':
        return RUNNING_FOR_ANOTHER_APP;
      case 'UNKNOWN':
        return UNKNOWN;
      default:
        return UNKNOWN;
    }
  }

  int getStatusValue() => _value;

  String getStatusText() => _text;

  static int getStatusValues(Set<ContactShieldStatus> statusSet) {
    int value = 0;
    for (ContactShieldStatus contactShieldStatus in statusSet) {
      value |= contactShieldStatus.getStatusValue();
    }
    return value;
  }

  static Set<ContactShieldStatus> getStatusSet(int value) {
    final Set<ContactShieldStatus> result = <ContactShieldStatus>{};

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

  @override
  String toString() {
    return '$ContactShieldStatus('
        'value: $_value, '
        'text: $_text)';
  }
}
