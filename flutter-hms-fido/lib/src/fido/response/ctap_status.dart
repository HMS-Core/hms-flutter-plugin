/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_fido;

class CtapStatus {
  /// Success.
  static const int CTAP2_OK = 0x00;

  /// Invalid CTAP command.
  /// Verify that the authenticator is correctly used.
  static const int CTAP1_ERR_INVALID_COMMAND = 0x01;

  /// Invalid parameters are included in the command.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP1_ERR_INVALID_PARAMETER = 0x02;

  /// Invalid message or attribute length.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP1_ERR_INVALID_LENGTH = 0x03;

  /// Invalid message sequence number.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP1_ERR_INVALID_SEQ = 0x04;

  /// The message timed out.
  /// Verify that the authenticator is correctly used.
  static const int CTAP1_ERR_TIMEOUT = 0x05;

  /// The channel is busy.
  /// Verify that the authenticator is correctly used.
  static const int CTAP1_ERR_CHANNEL_BUSY = 0x06;

  /// The channel needs to be locked.
  /// Verify that the authenticator is correctly used.
  static const int CTAP1_ERR_LOCK_REQUIRED = 0x0A;

  /// The channel is unavailable.
  /// Verify that the authenticator is correctly used.
  static const int CTAP1_ERR_INVALID_CHANNEL = 0x0B;

  /// CBOR parsing error. Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_CBOR_PARSING = 0x10;

  /// Invalid CBOR or unexpected error.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_CBOR_UNEXPECTED_TYPE = 0x11;

  /// CBOR parsing error. Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_INVALID_CBOR = 0x12;

  /// Invalid CBOR type. Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_INVALID_CBOR_TYPE = 0x13;

  /// Mandatory parameters are missing.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_MISSING_PARAMETER = 0x14;

  /// The upper limit has been exceeded.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_LIMIT_EXCEEDED = 0x15;

  /// Unsupported extension item.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_UNSUPPORTED_EXTENSION = 0x16;

  /// Valid credential excluded.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_CREDENTIAL_EXCLUDED = 0x19;

  /// The operation is in progress. (The operation is time-consuming.)
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_PROCESSING = 0x21;

  /// Invalid credential of the authenticator.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_INVALID_CREDENTIAL = 0x22;

  /// The user interaction is being awaited during authentication.
  static const int CTAP2_ERR_USER_ACTION_PENDING = 0x23;

  /// The operation is in progress. (The operation is time-consuming.)
  static const int CTAP2_ERR_OPERATION_PENDING = 0x24;

  /// No request to be processed.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_NO_OPERATIONS = 0x25;

  /// The authenticator does not support the algorithm.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_UNSUPPORTED_ALGORITHM = 0x26;

  /// Unauthorized operation.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_OPERATION_DENIED = 0x27;

  /// The internal key storage is full.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_KEY_STORE_FULL = 0x28;

  /// No pending operation.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_NO_OPERATION_PENDING = 0x2A;

  /// Unsupported option.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_UNSUPPORTED_OPTION = 0x2B;

  /// Invalid option for the current operation.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_INVALID_OPTION = 0x2C;

  /// The keepalive operation was canceled.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_KEEPALIVE_CANCEL = 0x2D;

  /// No valid credential is available.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_NO_CREDENTIALS = 0x2E;

  /// User interaction timed out.
  static const int CTAP2_ERR_USER_ACTION_TIMEOUT = 0x2F;

  /// The continuation command, such as authenticatorGetNextAssertion, is not
  /// allowed.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_NOT_ALLOWED = 0x30;

  /// Invalid PIN.
  static const int CTAP2_ERR_PIN_INVALID = 0x31;

  /// The PIN has been locked.
  static const int CTAP2_ERR_PIN_BLOCKED = 0x32;

  /// PIN authentication failed.
  static const int CTAP2_ERR_PIN_AUTH_INVALID = 0x33;

  /// PIN authentication blocked.
  static const int CTAP2_ERR_PIN_AUTH_BLOCKED = 0x34;

  /// The PIN has not been set.
  static const int CTAP2_ERR_PIN_NOT_SET = 0x35;

  /// The PIN is mandatory for the selected operation.
  static const int CTAP2_ERR_PIN_REQUIRED = 0x36;

  /// The PIN policy was violated. Currently, PINs are limited only by minimum
  /// length.
  static const int CTAP2_ERR_PIN_POLICY_VIOLATION = 0x37;

  /// The PIN token of the authenticator has expired.
  static const int CTAP2_ERR_PIN_TOKEN_EXPIRED = 0x38;

  /// The authenticator cannot process the request due to the memory usage
  /// restriction.
  /// Verify that the authenticator is correctly used.
  static const int CTAP2_ERR_REQUEST_TOO_LARGE = 0x39;

  /// Undefined error. Contact Huawei technical support.
  static const int CTAP1_ERR_OTHER = 0x7F;

  /// Vendor-defined errors (start).
  static const int CTAP2_ERR_VENDOR_FIRST = 0xF0;

  /// The operation is canceled by the user.
  static const int CTAP2_ERR_USER_CANCEL = 0xF4;

  /// No credential is registered.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CTAP2_ERR_NO_CREDENTIALS_REGIST = 0xF5;

  /// Vendor-defined errors (end).
  static const int CTAP2_ERR_VENDOR_LAST = 0xFF;
}
