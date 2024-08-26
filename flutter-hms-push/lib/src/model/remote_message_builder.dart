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

part of '../../huawei_push.dart';

class RemoteMessageBuilder {
  String? collapseKey;
  Map<String, String> data;
  String? messageId;
  String? messageType;
  int? ttl;
  String? to;
  int sendMode;
  int receiptMode;

  RemoteMessageBuilder({
    this.to,
    this.collapseKey,
    this.data = const <String, String>{},
    this.messageId,
    this.messageType,
    this.ttl,
    this.sendMode = 1,
    this.receiptMode = 1,
  });

  /// Adds key-value pair data to a message.
  RemoteMessageBuilder addData(String key, String value) {
    data[key] = value;
    return this;
  }

  /// Sets Map data to a message.
  RemoteMessageBuilder setData(Map<String, String> dataMap) {
    data = dataMap;
    return this;
  }

  /// Deletes message data.
  RemoteMessageBuilder clearData() {
    data.clear();
    return this;
  }

  /// Sets the ID of a message.
  RemoteMessageBuilder setMessageId(String messageId) {
    this.messageId = messageId;
    return this;
  }

  /// Sets the type of a message.
  RemoteMessageBuilder setMessageType(String messageType) {
    this.messageType = messageType;
    return this;
  }

  /// Sets the maximum cache duration of a message, in seconds.
  ///
  /// The duration can be set to 15 days at most.
  RemoteMessageBuilder setTtl(int ttl) {
    this.ttl = ttl;
    return this;
  }

  /// Sets the classification identifier of a message.
  ///
  /// If you set [collapse_key] to `-1`, all offline messages of the app are sent to
  /// the user after the user's device goes online.
  ///
  /// If you set [collapse_key] to `0`, offline messages of the app sent to the
  /// user are determined by the default policy of Huawei Push Kit. Generally,
  /// only the latest offline message is sent to the user after the user's device goes online.
  ///
  /// You can set [collapse_key] to a value ranging from 1 to 100 to group messages.
  /// For example, if you send 10 messages and set collapse_key to 1 for the first
  /// five messages and to 2 for the rest, the latest offline message whose value
  /// of collapse_key is 1 and the latest offline message whose value of collapse_key
  /// is 2 are sent to the user after the user's device goes online.
  RemoteMessageBuilder setCollapseKey(String collapseKey) {
    this.collapseKey = collapseKey;
    return this;
  }

  /// Sets whether to enable the message cache and resending capability of
  /// the Push Kit client.
  ///
  /// The value can be `0` or `1`. The value `1` indicates that the
  /// cache and resending capability is enabled.
  RemoteMessageBuilder setSendMode(int sendMode) {
    this.sendMode = sendMode;
    return this;
  }

  /// Sets the receipt capability after an uplink message is sent to the app server.
  ///
  /// The value can be `0` or `1`. The value `1` indicates that the receipt capability
  /// is enabled after messages are sent.
  RemoteMessageBuilder setReceiptMode(int receiptMode) {
    this.receiptMode = receiptMode;
    return this;
  }

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      RemoteMessage.TO: to,
      RemoteMessage.COLLAPSE_KEY: collapseKey,
      RemoteMessage.DATA: data,
      RemoteMessage.MESSAGE_ID: messageId,
      RemoteMessage.MESSAGE_TYPE: messageType,
      RemoteMessage.TTL: ttl,
      RemoteMessage.SEND_MODE: sendMode,
      RemoteMessage.RECEIPT_MODE: receiptMode,
    };
  }
}
