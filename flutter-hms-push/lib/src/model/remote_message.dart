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

import 'dart:convert';

class RemoteMessage {
  static const String INSTANCE_ID_SCOPE = "HCM";

  static const int PRIORITY_UNKNOWN = 0;
  static const int PRIORITY_HIGH = 1;
  static const int PRIORITY_NORMAL = 2;

  /// Constant Json Field names
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
  final _RemoteMessageNotification? notification;
  final int? sendMode;
  final int? receiptMode;
  final String? analyticInfo;
  final Map<String, String>? analyticInfoMap;

  RemoteMessage._({
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
  _RemoteMessageNotification? get getNotification => notification;

  /// Obtains the message priority set by an app.
  int? get getOriginalUrgency => originalUrgency;

  /// Obtains the message priority set on the HUAWEI Push Kit server.
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

  factory RemoteMessage.fromMap(Map<String, dynamic>? map) {
    if (map == null) return RemoteMessage._();
    return RemoteMessage._(
      to: map[RemoteMessage.TO] == null ? null : map[RemoteMessage.TO],
      from: map[RemoteMessage.FROM] == null ? null : map[RemoteMessage.FROM],
      messageId: map[RemoteMessage.MESSAGE_ID] == null
          ? null
          : map[RemoteMessage.MESSAGE_ID],
      token: map[RemoteMessage.TOKEN] == null ? null : map[RemoteMessage.TOKEN],
      sentTime: map[RemoteMessage.SENT_TIME] == null
          ? null
          : map[RemoteMessage.SENT_TIME],
      urgency: map[RemoteMessage.URGENCY] == null
          ? null
          : map[RemoteMessage.URGENCY],
      originalUrgency: map[RemoteMessage.ORIGINAL_URGENCY] == null
          ? null
          : map[RemoteMessage.ORIGINAL_URGENCY],
      ttl: map[RemoteMessage.TTL] == null ? null : map[RemoteMessage.TTL],
      type: map[RemoteMessage.MESSAGE_TYPE] == null
          ? null
          : map[RemoteMessage.MESSAGE_TYPE],
      collapseKey: map[RemoteMessage.COLLAPSE_KEY] == null
          ? null
          : map[RemoteMessage.COLLAPSE_KEY],
      data: map[RemoteMessage.DATA] == null ? null : map[RemoteMessage.DATA],
      dataOfMap: map[RemoteMessage.DATA_OF_MAP] == null
          ? null
          : Map.from(json.decode(map[RemoteMessage.DATA_OF_MAP])),
      notification: map[RemoteMessage.NOTIFICATION] == null
          ? null
          : _RemoteMessageNotification.fromMap(map[RemoteMessage.NOTIFICATION]),
      sendMode: map[RemoteMessage.SEND_MODE] == null
          ? null
          : map[RemoteMessage.SEND_MODE],
      receiptMode: map[RemoteMessage.RECEIPT_MODE] == null
          ? null
          : map[RemoteMessage.RECEIPT_MODE],
      analyticInfo: map[RemoteMessage.ANALYTICS_INFO] == null
          ? null
          : map[RemoteMessage.ANALYTICS_INFO],
      analyticInfoMap: map[RemoteMessage.ANALYTIC_INFO_MAP] == null
          ? null
          : Map<String, String>.from(map[RemoteMessage.ANALYTIC_INFO_MAP]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TO: this.to ?? '',
      FROM: this.from ?? '',
      MESSAGE_ID: this.messageId ?? '',
      TOKEN: this.token ?? '',
      SENT_TIME: this.sentTime ?? '',
      URGENCY: this.urgency ?? '',
      ORIGINAL_URGENCY: this.originalUrgency ?? '',
      TTL: this.ttl ?? '',
      MESSAGE_TYPE: this.type ?? '',
      COLLAPSE_KEY: this.collapseKey ?? '',
      DATA: this.data ?? '',
      DATA_OF_MAP: this.dataOfMap ?? {},
      NOTIFICATION: this.notification != null ? this.notification!.toMap() : '',
      SEND_MODE: this.sendMode ?? '',
      RECEIPT_MODE: this.receiptMode ?? '',
      ANALYTICS_INFO: this.analyticInfo ?? '',
      ANALYTIC_INFO_MAP: this.analyticInfoMap ?? {}
    };
  }
}

class RemoteMessageBuilder {
  String? collapseKey;
  Map<String, String>? data;
  String? messageId;
  String? messageType;
  int? ttl;
  String? to;
  int sendMode;
  int receiptMode;

  RemoteMessageBuilder(
      {this.to,
      this.collapseKey,
      this.data,
      this.messageId,
      this.messageType,
      this.ttl,
      this.sendMode = 1,
      this.receiptMode = 1});

  /// Adds key-value pair data to a message.
  RemoteMessageBuilder addData(String key, String value) {
    this.data![key] = value;
    return this;
  }

  /// Sets Map data to a message.
  RemoteMessageBuilder setData(Map<String, String> dataMap) {
    this.data = dataMap;
    return this;
  }

  /// Deletes message data.
  RemoteMessageBuilder clearData() {
    this.data!.clear();
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
  /// user are determined by the default policy of HUAWEI Push Kit. Generally,
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

  Map<String, dynamic> toMap() {
    return {
      RemoteMessage.TO: this.to,
      RemoteMessage.COLLAPSE_KEY: this.collapseKey,
      RemoteMessage.DATA: this.data,
      RemoteMessage.MESSAGE_ID: this.messageId,
      RemoteMessage.MESSAGE_TYPE: this.messageType,
      RemoteMessage.TTL: this.ttl,
      RemoteMessage.SEND_MODE: this.sendMode,
      RemoteMessage.RECEIPT_MODE: this.receiptMode,
    };
  }
}

class _RemoteMessageNotification {
  /// Constant Json Field Names
  static const TITLE = 'title';
  static const TITLE_LOCALIZATION_KEY = 'titleLocalizationKey';
  static const TITLE_LOCALIZATION_ARGS = 'titleLocalizationArgs';
  static const BODY_LOCALIZATION_KEY = 'bodyLocalizationKey';
  static const BODY_LOCALIZATION_ARGS = 'bodyLocalizationArgs';
  static const BODY = 'body';
  static const ICON = 'icon';
  static const SOUND = 'Sound';
  static const TAG = 'Tag';
  static const COLOR = 'Color';
  static const CLICK_ACTION = 'ClickAction';
  static const CHANNEL_ID = 'ChannelId';
  static const IMAGE_URL = 'ImageUrl';
  static const LINK = 'Link';
  static const NOTIFY_ID = 'NotifyId';
  static const WHEN = 'When';
  static const LIGHT_SETTINGS = 'LightSettings';
  static const BADGE_NUMBER = 'BadgeNumber';
  static const IMPORTANCE = 'Importance';
  static const TICKER = 'Ticker';
  static const VIBRATE_CONFIG = 'vibrateConfig';
  static const VISIBILITY = 'visibility';
  static const INTENT_URI = 'intentUri';
  static const IS_AUTO_CANCEL = 'isAutoCancel';
  static const IS_LOCAL_ONLY = 'isLocalOnly';
  static const IS_DEFAULT_LIGHT = 'isDefaultLight';
  static const IS_DEFAULT_SOUND = 'isDefaultSound';
  static const IS_DEFAULT_VIBRATE = 'isDefaultVibrate';

  final String? title;
  final String? titleLocalizationKey;
  final String? body;
  final String? bodyLocalizationKey;
  final String? icon;
  final String? sound;
  final String? tag;
  final String? color;
  final String? clickAction;
  final String? channelId;
  final String? ticker;
  final String? intentUri;

  final bool? isDefaultLight;
  final bool? isDefaultSound;
  final bool? isDefaultVibrate;
  final bool? isAutoCancel;
  final bool? isLocalOnly;

  final int? notifyId;
  final int? badgeNumber;
  final int? importance;
  final int? visibility;

  final Uri? imageUrl;
  final Uri? link;

  final double? when;

  final List<dynamic>? lightSettings;
  final List<dynamic>? vibrateConfig;
  final List<dynamic>? titleLocalizationArgs;
  final List<dynamic>? bodyLocalizationArgs;

  _RemoteMessageNotification(
      {this.title,
      this.titleLocalizationKey,
      this.titleLocalizationArgs,
      this.body,
      this.bodyLocalizationKey,
      this.bodyLocalizationArgs,
      this.icon,
      this.sound,
      this.tag,
      this.color,
      this.clickAction,
      this.channelId,
      this.ticker,
      this.intentUri,
      this.notifyId,
      this.badgeNumber,
      this.importance,
      this.visibility,
      this.imageUrl,
      this.link,
      this.isDefaultLight,
      this.isDefaultSound,
      this.isDefaultVibrate,
      this.isAutoCancel,
      this.isLocalOnly,
      this.when,
      this.lightSettings,
      this.vibrateConfig});

  /// Obtains the title of a message.
  String? get getTitle => title;

  /// Obtains the key of the displayed title of a message.
  String? get getTitleLocalizationKey => titleLocalizationKey;

  /// Obtains variables of the displayed title of a message.
  List<dynamic>? get getTitleLocalizationArgs => titleLocalizationArgs;

  /// Obtains the key of the displayed content of a message.
  String? get getBodyLocalizationKey => bodyLocalizationKey;

  /// Obtains variables of the displayed content of a message.
  List<dynamic>? get getBodyLocalizationArgs => bodyLocalizationArgs;

  /// Obtains the displayed content of a message.
  String? get getBody => body;

  /// Obtains the image resource name of the notification icon.
  String? get getIcon => icon;

  /// Obtains the name of an audio resource to be played when a notification message is displayed.
  String? get getSound => sound;

  /// Obtains the tag from a message for message overwriting.
  String? get getTag => tag;

  /// Obtains the colors of icons and buttons in a message.
  String? get getColor => color;

  /// Obtains actions triggered by message tapping.
  String? get getClickAction => clickAction;

  /// Obtains IDs of channels that support the display of messages.
  String? get getChannelId => channelId;

  /// Obtains the image URL from a message.
  Uri? get getImageUrl => imageUrl;

  /// Obtains the deep link from a message.
  Uri? get getLink => link;

  /// Obtains the unique ID of a message.
  int? get getNotifyId => notifyId;

  /// Obtains the display time of a notification message.
  double? get getWhen => when;

  /// Obtains the blinking frequency and color of a breathing light.
  List<dynamic>? get getLightSettings => lightSettings;

  /// Obtains a badge number.
  int? get getBadgeNumber => badgeNumber;

  /// Obtains the priority of a notification message.
  int? get getImportance => importance;

  /// Obtains the text to be displayed on the status bar for a notification message.
  String? get getTicker => ticker;

  /// Obtains an array of vibration patterns.
  List<dynamic>? get getVibrateConfig => vibrateConfig;

  /// Obtains the visibility of a notification message.
  int? get getVisibility => visibility;

  /// Obtains the intent in a notification message.
  String? get getIntentUri => intentUri;

  factory _RemoteMessageNotification.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return _RemoteMessageNotification();
    return _RemoteMessageNotification(
      title: map[TITLE] == null ? null : map[TITLE],
      titleLocalizationKey: map[TITLE_LOCALIZATION_KEY] == null
          ? null
          : map[TITLE_LOCALIZATION_KEY],
      titleLocalizationArgs: map[TITLE_LOCALIZATION_ARGS] == null
          ? null
          : map[TITLE_LOCALIZATION_ARGS],
      body: map[BODY] == null ? null : map[BODY],
      bodyLocalizationKey: map[BODY_LOCALIZATION_KEY] == null
          ? null
          : map[BODY_LOCALIZATION_KEY],
      bodyLocalizationArgs: map[BODY_LOCALIZATION_ARGS] == null
          ? null
          : map[BODY_LOCALIZATION_ARGS],
      icon: map[ICON] == null ? null : map[ICON],
      sound: map[SOUND] == null ? null : map[SOUND],
      tag: map[TAG] == null ? null : map[TAG],
      color: map[COLOR] == null ? null : map[COLOR],
      clickAction: map[CLICK_ACTION] == null ? null : map[CLICK_ACTION],
      channelId: map[CHANNEL_ID] == null ? null : map[CHANNEL_ID],
      ticker: map[TICKER] == null ? null : map[TICKER],
      intentUri: map[INTENT_URI] == null ? null : map[INTENT_URI],
      isDefaultLight:
          map[IS_DEFAULT_LIGHT] == null ? null : map[IS_DEFAULT_LIGHT],
      isDefaultSound:
          map[IS_DEFAULT_SOUND] == null ? null : map[IS_DEFAULT_SOUND],
      isDefaultVibrate:
          map[IS_DEFAULT_VIBRATE] == null ? null : map[IS_DEFAULT_VIBRATE],
      isAutoCancel: map[IS_AUTO_CANCEL] == null ? null : map[IS_AUTO_CANCEL],
      isLocalOnly: map[IS_LOCAL_ONLY] == null ? null : map[IS_LOCAL_ONLY],
      notifyId: map[NOTIFY_ID] == null ? null : map[NOTIFY_ID],
      badgeNumber: map[BADGE_NUMBER] == null ? null : map[BADGE_NUMBER],
      importance: map[IMPORTANCE] == null ? null : map[IMPORTANCE],
      visibility: map[VISIBILITY] == null ? null : map[VISIBILITY],
      imageUrl: map[IMAGE_URL] == null ? null : Uri.parse(map[IMAGE_URL]),
      link: map[LINK] == null ? null : Uri.parse(map[LINK]),
      when: map[WHEN] == null ? null : map[WHEN],
      lightSettings: map[LIGHT_SETTINGS] == null ? null : map[LIGHT_SETTINGS],
      vibrateConfig: map[VIBRATE_CONFIG] == null ? null : map[VIBRATE_CONFIG],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TITLE: this.title,
      TITLE_LOCALIZATION_KEY: this.titleLocalizationKey,
      TITLE_LOCALIZATION_ARGS: this.titleLocalizationArgs,
      BODY: this.body,
      BODY_LOCALIZATION_KEY: this.bodyLocalizationKey,
      BODY_LOCALIZATION_ARGS: this.bodyLocalizationArgs,
      ICON: this.icon,
      SOUND: this.sound,
      TAG: this.tag,
      COLOR: this.color,
      CLICK_ACTION: this.clickAction,
      CHANNEL_ID: this.channelId,
      TICKER: this.ticker,
      INTENT_URI: this.intentUri,
      NOTIFY_ID: this.notifyId,
      BADGE_NUMBER: this.badgeNumber,
      IMPORTANCE: this.importance,
      VISIBILITY: this.visibility,
      IS_DEFAULT_LIGHT: this.isDefaultLight,
      IS_DEFAULT_SOUND: this.isDefaultSound,
      IS_DEFAULT_VIBRATE: this.isDefaultVibrate,
      IS_AUTO_CANCEL: this.isAutoCancel,
      IS_LOCAL_ONLY: this.isLocalOnly,
      IMAGE_URL: this.imageUrl,
      LINK: this.link,
      WHEN: this.when,
      LIGHT_SETTINGS: this.lightSettings,
      VIBRATE_CONFIG: this.vibrateConfig,
    };
  }
}
