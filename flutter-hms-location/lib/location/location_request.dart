/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class LocationRequest {
  static const int PRIORITY_HIGH_ACCURACY = 100;
  static const int PRIORITY_BALANCED_POWER_ACCURACY = 102;
  static const int PRIORITY_LOW_POWER = 104;
  static const int PRIORITY_NO_POWER = 105;
  static const int PRIORITY_HD_ACCURACY = 200;
  static const double _FASTEST_INTERVAL_FACTOR = 6.0;

  int _priority;
  int _interval;
  int _fastestInterval;
  bool _isFastestIntervalExplicitlySet;
  int _expirationTime;
  int _numUpdates;
  double _smallestDisplacement;
  int _maxWaitTime;
  bool _needAddress;
  String _language;
  String _countryCode;
  Map<String, String> _extras;

  LocationRequest._create(
    this._priority,
    this._interval,
    this._fastestInterval,
    this._isFastestIntervalExplicitlySet,
    this._expirationTime,
    this._numUpdates,
    this._smallestDisplacement,
    this._maxWaitTime,
    this._needAddress,
    this._language,
    this._countryCode,
    this._extras,
  );

  LocationRequest() {
    _priority = PRIORITY_BALANCED_POWER_ACCURACY;
    _interval = 3600000;
    _fastestInterval = (_interval ~/ _FASTEST_INTERVAL_FACTOR);
    _isFastestIntervalExplicitlySet = false;
    _expirationTime = 9223372036854775807;
    _numUpdates = 2147483647;
    _smallestDisplacement = 0.0;
    _maxWaitTime = 0;
    _needAddress = false;
    _language = '';
    _countryCode = '';
  }

  int get priority => _priority;

  set priority(int value) {
    if (value == PRIORITY_HIGH_ACCURACY ||
        value == PRIORITY_BALANCED_POWER_ACCURACY ||
        value == PRIORITY_LOW_POWER ||
        value == PRIORITY_NO_POWER ||
        value == PRIORITY_HD_ACCURACY) {
      _priority = value;
    } else {
      throw ArgumentError('Priority is not a known constant');
    }
  }

  int get interval => _interval;

  set interval(int value) {
    if (value.isNegative) {
      throw ArgumentError('Interval is invalid');
    } else {
      _interval = value;
      _fastestInterval = _isFastestIntervalExplicitlySet
          ? _fastestInterval
          : (_interval ~/ _FASTEST_INTERVAL_FACTOR);
    }
  }

  int get fastestInterval => _fastestInterval;

  set fastestInterval(int value) {
    if (value.isNegative) {
      throw ArgumentError('FastestInterval is invalid');
    } else {
      _isFastestIntervalExplicitlySet = true;
      _fastestInterval = value;
    }
  }

  bool get isFastestIntervalExplicitlySet => _isFastestIntervalExplicitlySet;

  int get expirationTime => _expirationTime;

  set expirationTime(int value) {
    _expirationTime = value.isNegative ? 0 : value;
  }

  int get numUpdates => _numUpdates;

  set numUpdates(int value) {
    if (value <= 0) {
      throw ArgumentError('numUpdates is invalid');
    } else {
      _numUpdates = value;
    }
  }

  double get smallestDisplacement => _smallestDisplacement;

  set smallestDisplacement(double value) {
    if (value.isNegative) {
      throw ArgumentError('smallestDisplacement param invalid');
    } else {
      _smallestDisplacement = value;
    }
  }

  int get maxWaitTime => _maxWaitTime < _interval ? _interval : _maxWaitTime;

  set maxWaitTime(int value) => _maxWaitTime = value;

  bool get needAddress => _needAddress;

  set needAddress(bool value) => _needAddress = value;

  String get language => _language;

  set language(String value) => _language = value;

  String get countryCode => _countryCode;

  set countryCode(String value) => _countryCode = value;

  Map<String, String> get extras => _extras;

  set extras(Map<String, String> value) => _extras = value;

  void putExtras(String key, String value) {
    if (_extras == null) {
      _extras = Map<String, String>();
    }
    _extras.putIfAbsent(key, () => value);
  }

  Map<String, dynamic> toMap() {
    return {
      'priority': _priority,
      'interval': _interval,
      'fastestInterval': _fastestInterval,
      'isFastestIntervalExplicitlySet': _isFastestIntervalExplicitlySet,
      'expirationTime': _expirationTime,
      'numUpdates': _numUpdates,
      'smallestDisplacement': _smallestDisplacement,
      'maxWaitTime': _maxWaitTime,
      'needAddress': _needAddress,
      'language': _language,
      'countryCode': _countryCode,
      'extras': _extras,
    };
  }

  factory LocationRequest.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return LocationRequest._create(
      map['priority'],
      map['interval'],
      map['fastestInterval'],
      map['isFastestIntervalExplicitlySet'],
      map['expirationTime'],
      map['numUpdates'],
      map['smallestDisplacement'],
      map['maxWaitTime'],
      map['needAddress'],
      map['language'],
      map['countryCode'],
      Map<String, String>.from(map['extras']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationRequest.fromJson(String source) =>
      LocationRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationRequest(_priority: $_priority, _interval: $_interval, _fastestInterval: $_fastestInterval, _isFastestIntervalExplicitlySet: $_isFastestIntervalExplicitlySet, _expirationTime: $_expirationTime, _numUpdates: $_numUpdates, _smallestDisplacement: $_smallestDisplacement, _maxWaitTime: $_maxWaitTime, _needAddress: $_needAddress, _language: $_language, _countryCode: $_countryCode, _extras: $_extras)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocationRequest &&
        o._priority == _priority &&
        o._interval == _interval &&
        o._fastestInterval == _fastestInterval &&
        o._isFastestIntervalExplicitlySet == _isFastestIntervalExplicitlySet &&
        o._expirationTime == _expirationTime &&
        o._numUpdates == _numUpdates &&
        o._smallestDisplacement == _smallestDisplacement &&
        o._maxWaitTime == _maxWaitTime &&
        o._needAddress == _needAddress &&
        o._language == _language &&
        o._countryCode == _countryCode &&
        mapEquals(o._extras, _extras);
  }

  @override
  int get hashCode {
    return hashList([
      _priority,
      _interval,
      _fastestInterval,
      _isFastestIntervalExplicitlySet,
      _expirationTime,
      _numUpdates,
      _smallestDisplacement,
      _maxWaitTime,
      _needAddress,
      _language,
      _countryCode,
      _extras,
    ]);
  }
}
