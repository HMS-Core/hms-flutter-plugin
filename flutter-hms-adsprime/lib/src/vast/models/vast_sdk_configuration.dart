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

part of '../../../huawei_adsprime.dart';

class VastSdkConfiguration {
  /// Metwork request timeout.
  int httpCallTimeoutMs;

  /// Network connection timeout.
  int httpConnectTimeoutMs;

  /// Keepalive time for connections between asset download and VAST ad event reporting.
  int httpKeepAliveDurationMs;

  /// Network response read timeout.
  int httpReadTimeoutMs;

  /// Maximum number of connections allowed between asset download and VAST ad event reporting.
  int maxHttpConnections;

  /// Maximum number of redirections allowed for a VAST wrapper.
  int maxRedirectWrapperLimit;

  /// Whether an ad is a test ad.
  bool isTest;

  /// Number of tracking URLs used for each attempt made to report a VAST ad event.
  int vastEventRetryBatchSize;

  /// Interval between two attempts made to report a VAST ad event.
  int vastEventRetryIntervalSeconds;

  /// Maximum number of attempts allowed for reporting a VAST ad event.
  int vastEventRetryUploadTimes;

  VastSdkConfiguration({
    this.httpCallTimeoutMs = 30000,
    this.httpConnectTimeoutMs = 30000,
    this.httpKeepAliveDurationMs = 5000,
    this.httpReadTimeoutMs = 30000,
    this.maxHttpConnections = 8,
    this.maxRedirectWrapperLimit = 4,
    this.isTest = false,
    this.vastEventRetryBatchSize = 50,
    this.vastEventRetryIntervalSeconds = 300,
    this.vastEventRetryUploadTimes = 3,
  });

  factory VastSdkConfiguration._fromMap(Map<dynamic, dynamic> map) {
    return VastSdkConfiguration(
      httpCallTimeoutMs: map['httpCallTimeoutMs'],
      httpConnectTimeoutMs: map['httpConnectTimeoutMs'],
      httpKeepAliveDurationMs: map['httpKeepAliveDurationMs'],
      httpReadTimeoutMs: map['httpReadTimeoutMs'],
      maxHttpConnections: map['maxHttpConnections'],
      maxRedirectWrapperLimit: map['maxRedirectWrapperLimit'],
      isTest: map['isTest'],
      vastEventRetryBatchSize: map['vastEventRetryBatchSize'],
      vastEventRetryIntervalSeconds: map['vastEventRetryIntervalSeconds'],
      vastEventRetryUploadTimes: map['vastEventRetryUploadTimes'],
    );
  }

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'httpCallTimeoutMs': httpCallTimeoutMs,
      'httpConnectTimeoutMs': httpConnectTimeoutMs,
      'httpKeepAliveDurationMs': httpKeepAliveDurationMs,
      'httpReadTimeoutMs': httpReadTimeoutMs,
      'maxHttpConnections': maxHttpConnections,
      'maxRedirectWrapperLimit': maxRedirectWrapperLimit,
      'isTest': isTest,
      'vastEventRetryBatchSize': vastEventRetryBatchSize,
      'vastEventRetryIntervalSeconds': vastEventRetryIntervalSeconds,
      'vastEventRetryUploadTimes': vastEventRetryUploadTimes,
    };
  }
}
