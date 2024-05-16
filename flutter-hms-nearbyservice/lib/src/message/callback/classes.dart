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

part of huawei_nearbyservice;

class MessageGetCallback {
  static final Map<int, MessageGetCallback> getCbs =
      <int, MessageGetCallback>{};
  int get id => hashCode;

  OnTimeout? onTimeout;

  MessageGetCallback({this.onTimeout}) {
    getCbs[id] = this;
  }
}

class MessagePutCallback {
  static final Map<int, MessagePutCallback> putCbs =
      <int, MessagePutCallback>{};
  int get id => hashCode;

  OnTimeout? onTimeout;

  MessagePutCallback({this.onTimeout}) {
    putCbs[id] = this;
  }
}

class MessageStatusCallback {
  static final Map<int, MessageStatusCallback> statusCbs =
      <int, MessageStatusCallback>{};
  int get id => hashCode;

  OnPermissionChanged? onPermissionChanged;

  MessageStatusCallback({this.onPermissionChanged}) {
    statusCbs[id] = this;
  }
}

class NearbyMessageHandler {
  static final Map<int, NearbyMessageHandler> msgHandlerCbs =
      <int, NearbyMessageHandler>{};
  int get id => hashCode;

  OnBleSignalChanged? onBleSignalChanged;
  OnDistanceChanged? onDistanceChanged;
  OnFound? onFound;
  OnLost? onLost;

  NearbyMessageHandler({
    this.onBleSignalChanged,
    this.onDistanceChanged,
    this.onFound,
    this.onLost,
  }) {
    msgHandlerCbs[id] = this;
  }
}

/// GetCallback & PutCallback
typedef OnTimeout = void Function();

/// StatusCallback
typedef OnPermissionChanged = void Function(bool? granted);

/// MessageHandler
typedef OnBleSignalChanged = void Function(Message message, BleSignal signal);
typedef OnDistanceChanged = void Function(Message message, Distance distance);
typedef OnFound = void Function(Message message);
typedef OnLost = void Function(Message message);
