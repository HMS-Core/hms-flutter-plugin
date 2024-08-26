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

part of '../huawei_iap.dart';

/// Represents a result class for [HmsIapResults].
class HmsIapResult {
  /// Result code.
  final String resultCode;

  /// Result message.
  final String? resultMessage;

  /// Creates a [HmsIapResult] object.
  const HmsIapResult({
    required this.resultCode,
    this.resultMessage,
  });
}

class HmsIapResults {
  // Results from Plugin
  static const HmsIapResult LOG_IN_ERROR = const HmsIapResult(
    resultCode: 'ERR_CAN_NOT_LOG_IN',
    resultMessage: 'Can not log in.',
  );

  static const HmsIapResult UNKNOWN_REQUEST_CODE = HmsIapResult(
    resultCode: 'UNKNOWN_REQUEST_CODE',
    resultMessage:
        'This request code does not match with any available request codes.',
  );

  static const HmsIapResult ACTIVITY_RESULT = HmsIapResult(
    resultCode: 'ACTIVITY_RESULT_ERROR',
    resultMessage: 'Result is not OK.',
  );

  static const HmsIapResult IS_SANDBOX_READY_ERROR = HmsIapResult(
    resultCode: 'IS_SANDBOX_READY_ERROR',
    resultMessage: null,
  );

  static const HmsIapResult OBTAIN_PRODUCT_INFO_ERROR = HmsIapResult(
    resultCode: 'OBTAIN_PRODUCT_INFO_ERROR',
    resultMessage: null,
  );

  static const HmsIapResult PURCHASE_INTENT_EXCEPTION = HmsIapResult(
    resultCode: 'PURCHASE_INTENT_EXCEPTION',
    resultMessage: null,
  );

  static const HmsIapResult CONSUME_OWNED_PURCHASE_ERROR = HmsIapResult(
    resultCode: 'CONSUME_OWNED_PURCHASE_ERROR',
    resultMessage: null,
  );

  static const HmsIapResult OBTAIN_OWNED_PURCHASES_ERROR = HmsIapResult(
    resultCode: 'OBTAIN_OWNED_PURCHASES_ERROR',
    resultMessage: null,
  );

  static const HmsIapResult START_IAP_ACTIVITY_ERROR = HmsIapResult(
    resultCode: 'START_IAP_ACTIVITY_ERROR',
    resultMessage: null,
  );

  static const HmsIapResult PURCHASE_INTENT_RESOLUTION = HmsIapResult(
    resultCode: 'PURCHASE_INTENT_RESOLUTION_ERROR',
    resultMessage: null,
  );

  static const HmsIapResult NO_RESOLUTION = HmsIapResult(
    resultCode: 'NO_RESOLUTION',
    resultMessage: 'There is no resolution for error.',
  );

  // OrderStatusCodes from Huawei IAP
  static const HmsIapResult ORDER_STATE_SUCCESS = const HmsIapResult(
    resultCode: '0',
    resultMessage: 'Success',
  );

  static const HmsIapResult ORDER_STATE_FAILED = const HmsIapResult(
    resultCode: '-1',
    resultMessage: 'Common failure result code.',
  );

  static const HmsIapResult ORDER_STATE_CANCEL = const HmsIapResult(
    resultCode: '60000',
    resultMessage: 'The user cancels the payment.',
  );

  static const HmsIapResult ORDER_STATE_PARAM_ERROR = const HmsIapResult(
    resultCode: '60001',
    resultMessage: 'Parameter error (including no parameter).',
  );

  static const HmsIapResult ORDER_STATE_IAP_NOT_ACTIVATED = const HmsIapResult(
    resultCode: '60002',
    resultMessage: 'Huawei IAP is not enabled.',
  );

  static const HmsIapResult ORDER_STATE_PRODUCT_INVALID = const HmsIapResult(
    resultCode: '60003',
    resultMessage: 'Incorrect product information.',
  );

  static const HmsIapResult ORDER_STATE_CALLS_FREQUENT = const HmsIapResult(
    resultCode: '60004',
    resultMessage: 'Too frequent API calls.',
  );

  static const HmsIapResult ORDER_STATE_NET_ERROR = const HmsIapResult(
    resultCode: '60005',
    resultMessage: 'Network connection exception.',
  );

  static const HmsIapResult ORDER_STATE_PMS_TYPE_NOT_MATCH = const HmsIapResult(
    resultCode: '60006',
    resultMessage: 'Inconsistent product.',
  );

  static const HmsIapResult ORDER_STATE_PRODUCT_COUNTRY_NOT_SUPPORTED =
      const HmsIapResult(
    resultCode: '60007',
    resultMessage: 'Country not supported.',
  );

  static const HmsIapResult ORDER_VR_UNINSTALL_ERROR = const HmsIapResult(
    resultCode: '60020',
    resultMessage: 'VR APK is not installed.',
  );

  static const HmsIapResult ORDER_HWID_NOT_LOGIN = const HmsIapResult(
    resultCode: '60050',
    resultMessage: 'Huawei ID is not signed in.',
  );

  static const HmsIapResult ORDER_PRODUCT_OWNED = const HmsIapResult(
    resultCode: '60051',
    resultMessage: 'User already owns the product.',
  );

  static const HmsIapResult ORDER_PRODUCT_NOT_OWNED = const HmsIapResult(
    resultCode: '60052',
    resultMessage: 'User does not owns the product.',
  );

  static const HmsIapResult ORDER_PRODUCT_CONSUMED = const HmsIapResult(
    resultCode: '60053',
    resultMessage: 'Product already consumed.',
  );

  static const HmsIapResult ORDER_ACCOUNT_AREA_NOT_SUPPORTED =
      const HmsIapResult(
    resultCode: '60054',
    resultMessage: 'Huawei IAP does not support country/region.',
  );

  static const HmsIapResult ORDER_NOT_ACCEPT_AGREEMENT = const HmsIapResult(
    resultCode: '60055',
    resultMessage: 'Agreement error.',
  );

  static const HmsIapResult ORDER_HIGH_RISK_OPERATIONS = const HmsIapResult(
    resultCode: '60056',
    resultMessage: 'User triggers risk control.',
  );

  static const HmsIapResult ORDER_STATE_PENDING = const HmsIapResult(
    resultCode: '60057',
    resultMessage: 'Order is in pending state.',
  );
}
