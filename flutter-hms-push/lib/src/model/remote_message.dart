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

class RemoteMessage {
  static const String INSTANCE_ID_SCOPE = 'HCM';

  static const int PRIORITY_UNKNOWN = 0;
  static const int PRIORITY_HIGH = 1;
  static const int PRIORITY_NORMAL = 2;

  // Constant Json Field names
  static const String COLLAPSE_KEY = 'collapseKey';
  static const String DATA = 'data';
  static const String DATA_OF_MAP = 'dataOfMap';
  static const String MESSAGE_ID = 'messageId';
  static const String MESSAGE_TYPE = 'messageType';
  static const String ORIGINAL_URGENCY = 'originalUrgency';
  static const String URGENCY = 'urgency';
  static const String TTL = 'ttl';
  static const String SENT_TIME = 'sentTime';
  static const String TO = 'to';
  static const String FROM = 'from';
  static const String TOKEN = 'token';
  static const String NOTIFICATION = 'notification';
  static const String SEND_MODE = 'sendMode';
  static const String RECEIPT_MODE = 'receiptMode';
  static const String ANALYTICS_INFO = 'analyticInfo';
  static const String ANALYTIC_INFO_MAP = 'analyticInfoMap';

  final String? messageId;
  final String? to;
  final String? from;
  final String? type;
  final String? token;
  final int? ttl;
  final String? collapseKey;
  final int? urgency;
  final int? originalUrgency;
  final int? sentTime;
  final String? data;
  final Map<String, String>? dataOfMap;
  final RemoteMessageNotification? notification;
  final int? sendMode;
  final int? receiptMode;
  final String? analyticInfo;
  final Map<String, String>? analyticInfoMap;

  const RemoteMessage._({
    this.collapseKey,
    this.data,
    this.dataOfMap,
    this.messageId,
    this.type,
    this.notification,
    this.originalUrgency,
    this.urgency,
    this.ttl,
    this.sentTime,
    this.to,
    this.from,
    this.token,
    this.sendMode,
    this.receiptMode,
    this.analyticInfo,
    this.analyticInfoMap,
  });

  /// Obtains the classification identifier (collapse key) of a message.
  String? get getCollapseKey => collapseKey;

  /// Obtains the payload of a message.
  String? get getData => data;

  /// Obtains the payload of a Map message.
  Map<String, String>? get getDataOfMap => dataOfMap;

  /// Obtains the ID of a message.
  String? get getMessageId => messageId;

  /// Obtains the type of a message.
  String? get getMessageType => type;

  /// Obtains the notification data instance from a message.
  RemoteMessageNotification? get getNotification => notification;

  /// Obtains the message priority set by an app.
  int? get getOriginalUrgency => originalUrgency;

  /// Obtains the message priority set on the Huawei Push Kit server.
  int? get getUrgency => urgency;

  /// Obtains the maximum cache duration of a message.
  int? get getTtl => ttl;

  /// Obtains the time when a message is sent from the server.
  int? get getSentTime => sentTime;

  /// Obtains the recipient of a message.
  String? get getTo => to;

  /// Obtains the source of a message.
  String? get getFrom => from;

  /// Obtains the token in a message.
  String? get getToken => token;

  /// Obtains the tag of a message in a batch delivery task (bi_tag).
  String? get getAnalyticInfo => analyticInfo;

  /// Obtains the analysis data of the Map type.
  ///
  /// Different from the [getAnalyticInfo] method, this method directly returns the instance of the Map type.
  Map<String, String>? get getAnalyticInfoMap => analyticInfoMap;

  factory RemoteMessage._fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return const RemoteMessage._();
    }
    return RemoteMessage._(
      to: map[RemoteMessage.TO],
      from: map[RemoteMessage.FROM],
      messageId: map[RemoteMessage.MESSAGE_ID],
      token: map[RemoteMessage.TOKEN],
      sentTime: map[RemoteMessage.SENT_TIME],
      urgency: map[RemoteMessage.URGENCY],
      originalUrgency: map[RemoteMessage.ORIGINAL_URGENCY],
      ttl: map[RemoteMessage.TTL],
      type: map[RemoteMessage.MESSAGE_TYPE],
      collapseKey: map[RemoteMessage.COLLAPSE_KEY],
      data: map[RemoteMessage.DATA],
      dataOfMap: map[RemoteMessage.DATA_OF_MAP] != null
          ? Map<String, String>.from(
              json.decode(map[RemoteMessage.DATA_OF_MAP]),
            )
          : null,
      notification: map[RemoteMessage.NOTIFICATION] != null
          ? RemoteMessageNotification._fromMap(
              map[RemoteMessage.NOTIFICATION],
            )
          : null,
      sendMode: map[RemoteMessage.SEND_MODE],
      receiptMode: map[RemoteMessage.RECEIPT_MODE],
      analyticInfo: map[RemoteMessage.ANALYTICS_INFO],
      analyticInfoMap: map[RemoteMessage.ANALYTIC_INFO_MAP] != null
          ? Map<String, String>.from(
              map[RemoteMessage.ANALYTIC_INFO_MAP],
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TO: to ?? '',
      FROM: from ?? '',
      MESSAGE_ID: messageId ?? '',
      TOKEN: token ?? '',
      SENT_TIME: sentTime ?? '',
      URGENCY: urgency ?? '',
      ORIGINAL_URGENCY: originalUrgency ?? '',
      TTL: ttl ?? '',
      MESSAGE_TYPE: type ?? '',
      COLLAPSE_KEY: collapseKey ?? '',
      DATA: data ?? '',
      DATA_OF_MAP: dataOfMap ?? <String, String>{},
      NOTIFICATION: notification?.toMap() ?? '',
      SEND_MODE: sendMode ?? '',
      RECEIPT_MODE: receiptMode ?? '',
      ANALYTICS_INFO: analyticInfo ?? '',
      ANALYTIC_INFO_MAP: analyticInfoMap ?? <String, String>{},
    };
  }
}
