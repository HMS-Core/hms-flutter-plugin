/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class LocationRequest {
  /// Used to request the most accurate location.
  static const int PRIORITY_HIGH_ACCURACY = 100;

  /// Used to request the block-level location.
  static const int PRIORITY_BALANCED_POWER_ACCURACY = 102;

  /// Used to request the city-level location.
  static const int PRIORITY_LOW_POWER = 104;

  /// Used to request the location with the optimal accuracy without additional
  /// power consumption.
  static const int PRIORITY_NO_POWER = 105;

  /// Used to request indoor location.
  static const int PRIORITY_INDOOR = 300;

  /// Used to request the high-precision location information.
  ///
  /// Currently, this parameter is available only for the
  /// [requestLocationUpdatesEx] method.
  static const int PRIORITY_HD_ACCURACY = 200;
  static const double _FASTEST_INTERVAL_FACTOR = 6.0;

  /// Used to request the indoor location and fused location.
  static const int PRIORITY_HIGH_ACCURACY_AND_INDOOR = 400;

  /// Used to request locations of the WGS84 coordinate type.
  static const int COORDINATE_TYPE_WGS84 = 0;

  /// Used to request locations of the GCJ02 coordinate type.
  static const int COORDINATE_TYPE_GCJ02 = 1;

  /// Request priority.
  ///
  /// The default value is `100`.
  late int _priority;

  /// Callback interval, in milliseconds.
  ///
  /// The default value is `3600000`.
  late int _interval;

  /// Shortest request interval, in milliseconds.
  ///
  /// The default value is `600000`. If another app initiates a location
  /// request, the location is also reported to that app at the interval
  /// specified in [fastestInterval].
  late int _fastestInterval;

  /// Indicates whether to use the shortest interval.
  ///
  /// The options are `true` (yes) and `false` (no).
  late bool _isFastestIntervalExplicitlySet;

  /// Request expiration time, in milliseconds.
  ///
  /// The default value is `9223372036854775807`.
  late int _expirationTime;

  /// Number of requested location updates.
  ///
  /// The default value is `2147483647`.
  late int _numUpdates;

  /// Minimum displacement between location updates, in meters.
  ///
  /// The default value is `0`.
  late double _smallestDisplacement;

  /// Maximum waiting time, in milliseconds.
  ///
  /// The default value is `0`.
  late int _maxWaitTime;

  /// Indicates whether to return the address information.
  ///
  /// The default value is `false`.
  late bool needAddress;

  /// Language.
  ///
  /// The value is a two-letter code complying with the **ISO 639-1 standard**.
  /// By default, the value is empty.
  late String language;

  /// Country code.
  ///
  /// The value is a two-letter code complying with the **ISO 3166-1 standard**.
  /// By default, the value is empty.
  late String countryCode;
  Map<String, String>? extras;

  /// The coordinate type of the current location.
  late int coordinateType;

  LocationRequest() {
    _priority = PRIORITY_BALANCED_POWER_ACCURACY;
    _interval = 3600000;
    _fastestInterval = (_interval ~/ _FASTEST_INTERVAL_FACTOR);
    _isFastestIntervalExplicitlySet = false;
    _expirationTime = 9223372036854775807;
    _numUpdates = 2147483647;
    _smallestDisplacement = 0.0;
    _maxWaitTime = 0;
    needAddress = false;
    language = '';
    countryCode = '';
    coordinateType = COORDINATE_TYPE_WGS84;
  }

  LocationRequest._create(
    this._priority,
    this._interval,
    this._fastestInterval,
    this._isFastestIntervalExplicitlySet,
    this._expirationTime,
    this._numUpdates,
    this._smallestDisplacement,
    this._maxWaitTime,
    this.needAddress,
    this.language,
    this.countryCode,
    this.extras,
    this.coordinateType,
  );

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

  /// Indicates whether the fastest interval explicitly set or default value is
  /// being used.
  bool? get isFastestIntervalExplicitlySet => _isFastestIntervalExplicitlySet;

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

  void putExtras(String key, String value) {
    extras ??= <String, String>{};
    extras!.putIfAbsent(key, () => value);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priority': _priority,
      'interval': _interval,
      'fastestInterval': _fastestInterval,
      'isFastestIntervalExplicitlySet': _isFastestIntervalExplicitlySet,
      'expirationTime': _expirationTime,
      'numUpdates': _numUpdates,
      'smallestDisplacement': _smallestDisplacement,
      'maxWaitTime': _maxWaitTime,
      'needAddress': needAddress,
      'language': language,
      'countryCode': countryCode,
      'extras': extras,
      'coordinateType': coordinateType,
    };
  }

  factory LocationRequest.fromMap(Map<dynamic, dynamic> map) {
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
      map['coordinateType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationRequest.fromJson(String source) =>
      LocationRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationRequest('
        '_priority: $_priority, '
        '_interval: $_interval, '
        '_fastestInterval: $_fastestInterval, '
        '_isFastestIntervalExplicitlySet: $_isFastestIntervalExplicitlySet,'
        ' _expirationTime: $_expirationTime, '
        '_numUpdates: $_numUpdates, '
        '_smallestDisplacement: $_smallestDisplacement, '
        '_maxWaitTime: $_maxWaitTime,'
        ' _needAddress: $needAddress,'
        ' _language: $language, '
        '_countryCode: $countryCode, '
        '_extras: $extras, '
        '_coordinateType: $coordinateType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocationRequest &&
        other._priority == _priority &&
        other._interval == _interval &&
        other._fastestInterval == _fastestInterval &&
        other._isFastestIntervalExplicitlySet ==
            _isFastestIntervalExplicitlySet &&
        other._expirationTime == _expirationTime &&
        other._numUpdates == _numUpdates &&
        other._smallestDisplacement == _smallestDisplacement &&
        other._maxWaitTime == _maxWaitTime &&
        other.needAddress == needAddress &&
        other.language == language &&
        other.countryCode == countryCode &&
        other.coordinateType == coordinateType &&
        mapEquals(other.extras, extras);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        _priority,
        _interval,
        _fastestInterval,
        _isFastestIntervalExplicitlySet,
        _expirationTime,
        _numUpdates,
        _smallestDisplacement,
        _maxWaitTime,
        needAddress,
        language,
        countryCode,
        extras,
        coordinateType,
      ],
    );
  }
}
