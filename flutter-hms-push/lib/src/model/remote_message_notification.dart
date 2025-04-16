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

class RemoteMessageNotification {
  static const String _TITLE = 'title';
  static const String _TITLE_LOCALIZATION_KEY = 'titleLocalizationKey';
  static const String _TITLE_LOCALIZATION_ARGS = 'titleLocalizationArgs';
  static const String _BODY_LOCALIZATION_KEY = 'bodyLocalizationKey';
  static const String _BODY_LOCALIZATION_ARGS = 'bodyLocalizationArgs';
  static const String _BODY = 'body';
  static const String _ICON = 'icon';
  static const String _SOUND = 'Sound';
  static const String _TAG = 'Tag';
  static const String _COLOR = 'Color';
  static const String _CLICK_ACTION = 'ClickAction';
  static const String _CHANNEL_ID = 'ChannelId';
  static const String _IMAGE_URL = 'ImageUrl';
  static const String _LINK = 'Link';
  static const String _NOTIFY_ID = 'NotifyId';
  static const String _WHEN = 'When';
  static const String _LIGHT_SETTINGS = 'LightSettings';
  static const String _BADGE_NUMBER = 'BadgeNumber';
  static const String _IMPORTANCE = 'Importance';
  static const String _TICKER = 'Ticker';
  static const String _VIBRATE_CONFIG = 'vibrateConfig';
  static const String _VISIBILITY = 'visibility';
  static const String _INTENT_URI = 'intentUri';
  static const String _IS_AUTO_CANCEL = 'isAutoCancel';
  static const String _IS_LOCAL_ONLY = 'isLocalOnly';
  static const String _IS_DEFAULT_LIGHT = 'isDefaultLight';
  static const String _IS_DEFAULT_SOUND = 'isDefaultSound';
  static const String _IS_DEFAULT_VIBRATE = 'isDefaultVibrate';

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

  const RemoteMessageNotification._({
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

  factory RemoteMessageNotification._fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return const RemoteMessageNotification._();
    }
    return RemoteMessageNotification._(
      title: map[_TITLE],
      titleLocalizationKey: map[_TITLE_LOCALIZATION_KEY],
      titleLocalizationArgs: map[_TITLE_LOCALIZATION_ARGS],
      body: map[_BODY],
      bodyLocalizationKey: map[_BODY_LOCALIZATION_KEY],
      bodyLocalizationArgs: map[_BODY_LOCALIZATION_ARGS],
      icon: map[_ICON],
      sound: map[_SOUND],
      tag: map[_TAG],
      color: map[_COLOR],
      clickAction: map[_CLICK_ACTION],
      channelId: map[_CHANNEL_ID],
      ticker: map[_TICKER],
      intentUri: map[_INTENT_URI],
      isDefaultLight: map[_IS_DEFAULT_LIGHT],
      isDefaultSound: map[_IS_DEFAULT_SOUND],
      isDefaultVibrate: map[_IS_DEFAULT_VIBRATE],
      isAutoCancel: map[_IS_AUTO_CANCEL],
      isLocalOnly: map[_IS_LOCAL_ONLY],
      notifyId: map[_NOTIFY_ID],
      badgeNumber: map[_BADGE_NUMBER],
      importance: map[_IMPORTANCE],
      visibility: map[_VISIBILITY],
      imageUrl: map[_IMAGE_URL] != null ? Uri.parse(map[_IMAGE_URL]) : null,
      link: map[_LINK] != null ? Uri.parse(map[_LINK]) : null,
      when: map[_WHEN],
      lightSettings: map[_LIGHT_SETTINGS],
      vibrateConfig: map[_VIBRATE_CONFIG],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _TITLE: title,
      _TITLE_LOCALIZATION_KEY: titleLocalizationKey,
      _TITLE_LOCALIZATION_ARGS: titleLocalizationArgs,
      _BODY: body,
      _BODY_LOCALIZATION_KEY: bodyLocalizationKey,
      _BODY_LOCALIZATION_ARGS: bodyLocalizationArgs,
      _ICON: icon,
      _SOUND: sound,
      _TAG: tag,
      _COLOR: color,
      _CLICK_ACTION: clickAction,
      _CHANNEL_ID: channelId,
      _TICKER: ticker,
      _INTENT_URI: intentUri,
      _NOTIFY_ID: notifyId,
      _BADGE_NUMBER: badgeNumber,
      _IMPORTANCE: importance,
      _VISIBILITY: visibility,
      _IS_DEFAULT_LIGHT: isDefaultLight,
      _IS_DEFAULT_SOUND: isDefaultSound,
      _IS_DEFAULT_VIBRATE: isDefaultVibrate,
      _IS_AUTO_CANCEL: isAutoCancel,
      _IS_LOCAL_ONLY: isLocalOnly,
      _IMAGE_URL: imageUrl,
      _LINK: link,
      _WHEN: when,
      _LIGHT_SETTINGS: lightSettings,
      _VIBRATE_CONFIG: vibrateConfig,
    };
  }
}
