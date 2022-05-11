/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_push;

class _RemoteMessageNotification {
  static const String TITLE = 'title';
  static const String TITLE_LOCALIZATION_KEY = 'titleLocalizationKey';
  static const String TITLE_LOCALIZATION_ARGS = 'titleLocalizationArgs';
  static const String BODY_LOCALIZATION_KEY = 'bodyLocalizationKey';
  static const String BODY_LOCALIZATION_ARGS = 'bodyLocalizationArgs';
  static const String BODY = 'body';
  static const String ICON = 'icon';
  static const String SOUND = 'Sound';
  static const String TAG = 'Tag';
  static const String COLOR = 'Color';
  static const String CLICK_ACTION = 'ClickAction';
  static const String CHANNEL_ID = 'ChannelId';
  static const String IMAGE_URL = 'ImageUrl';
  static const String LINK = 'Link';
  static const String NOTIFY_ID = 'NotifyId';
  static const String WHEN = 'When';
  static const String LIGHT_SETTINGS = 'LightSettings';
  static const String BADGE_NUMBER = 'BadgeNumber';
  static const String IMPORTANCE = 'Importance';
  static const String TICKER = 'Ticker';
  static const String VIBRATE_CONFIG = 'vibrateConfig';
  static const String VISIBILITY = 'visibility';
  static const String INTENT_URI = 'intentUri';
  static const String IS_AUTO_CANCEL = 'isAutoCancel';
  static const String IS_LOCAL_ONLY = 'isLocalOnly';
  static const String IS_DEFAULT_LIGHT = 'isDefaultLight';
  static const String IS_DEFAULT_SOUND = 'isDefaultSound';
  static const String IS_DEFAULT_VIBRATE = 'isDefaultVibrate';

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

  _RemoteMessageNotification._({
    this.title,
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
    this.vibrateConfig,
  });

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

  factory _RemoteMessageNotification._fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return _RemoteMessageNotification._();

    return _RemoteMessageNotification._(
      title: map[TITLE],
      titleLocalizationKey: map[TITLE_LOCALIZATION_KEY],
      titleLocalizationArgs: map[TITLE_LOCALIZATION_ARGS],
      body: map[BODY],
      bodyLocalizationKey: map[BODY_LOCALIZATION_KEY],
      bodyLocalizationArgs: map[BODY_LOCALIZATION_ARGS],
      icon: map[ICON],
      sound: map[SOUND],
      tag: map[TAG],
      color: map[COLOR],
      clickAction: map[CLICK_ACTION],
      channelId: map[CHANNEL_ID],
      ticker: map[TICKER],
      intentUri: map[INTENT_URI],
      isDefaultLight: map[IS_DEFAULT_LIGHT],
      isDefaultSound: map[IS_DEFAULT_SOUND],
      isDefaultVibrate: map[IS_DEFAULT_VIBRATE],
      isAutoCancel: map[IS_AUTO_CANCEL],
      isLocalOnly: map[IS_LOCAL_ONLY],
      notifyId: map[NOTIFY_ID],
      badgeNumber: map[BADGE_NUMBER],
      importance: map[IMPORTANCE],
      visibility: map[VISIBILITY],
      imageUrl: map[IMAGE_URL] == null ? null : Uri.parse(map[IMAGE_URL]),
      link: map[LINK] == null ? null : Uri.parse(map[LINK]),
      when: map[WHEN],
      lightSettings: map[LIGHT_SETTINGS],
      vibrateConfig: map[VIBRATE_CONFIG],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TITLE: title,
      TITLE_LOCALIZATION_KEY: titleLocalizationKey,
      TITLE_LOCALIZATION_ARGS: titleLocalizationArgs,
      BODY: body,
      BODY_LOCALIZATION_KEY: bodyLocalizationKey,
      BODY_LOCALIZATION_ARGS: bodyLocalizationArgs,
      ICON: icon,
      SOUND: sound,
      TAG: tag,
      COLOR: color,
      CLICK_ACTION: clickAction,
      CHANNEL_ID: channelId,
      TICKER: ticker,
      INTENT_URI: intentUri,
      NOTIFY_ID: notifyId,
      BADGE_NUMBER: badgeNumber,
      IMPORTANCE: importance,
      VISIBILITY: visibility,
      IS_DEFAULT_LIGHT: isDefaultLight,
      IS_DEFAULT_SOUND: isDefaultSound,
      IS_DEFAULT_VIBRATE: isDefaultVibrate,
      IS_AUTO_CANCEL: isAutoCancel,
      IS_LOCAL_ONLY: isLocalOnly,
      IMAGE_URL: imageUrl,
      LINK: link,
      WHEN: when,
      LIGHT_SETTINGS: lightSettings,
      VIBRATE_CONFIG: vibrateConfig,
    };
  }
}
