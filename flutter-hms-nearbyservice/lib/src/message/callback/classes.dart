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

import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice/src/message/classes/message.dart';

class MessageGetCallback {
  static final Map<int, MessageGetCallback> getCbs =
      Map<int, MessageGetCallback>();
  int get id => hashCode;

  OnTimeout onTimeout;

  MessageGetCallback({this.onTimeout}) {
    getCbs[id] = this;
  }
}

class MessagePutCallback {
  static final Map<int, MessagePutCallback> putCbs =
      Map<int, MessagePutCallback>();
  int get id => hashCode;

  OnTimeout onTimeout;

  MessagePutCallback({this.onTimeout}) {
    putCbs[id] = this;
  }
}

class MessageStatusCallback {
  static final Map<int, MessageStatusCallback> statusCbs =
      Map<int, MessageStatusCallback>();
  int get id => hashCode;

  OnPermissionChanged onPermissionChanged;

  MessageStatusCallback({this.onPermissionChanged}) {
    statusCbs[id] = this;
  }
}

class NearbyMessageHandler {
  static final Map<int, NearbyMessageHandler> msgHandlerCbs =
      Map<int, NearbyMessageHandler>();
  int get id => hashCode;

  OnBleSignalChanged onBleSignalChanged;
  OnDistanceChanged onDistanceChanged;
  OnFound onFound;
  OnLost onLost;

  NearbyMessageHandler(
      {this.onBleSignalChanged,
      this.onDistanceChanged,
      this.onFound,
      this.onLost}) {
    msgHandlerCbs[id] = this;
  }
}

/// GetCallback & PutCallback
typedef void OnTimeout();

/// StatusCallback
typedef void OnPermissionChanged(bool granted);

/// MessageHandler
typedef void OnBleSignalChanged(Message message, BleSignal signal);
typedef void OnDistanceChanged(Message message, Distance distance);
typedef void OnFound(Message message);
typedef void OnLost(Message message);
