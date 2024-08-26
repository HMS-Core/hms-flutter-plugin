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

part of '../../huawei_location.dart';

class BackgroundNotification {
  String category;
  int priority;
  String channelName;
  String contentTitle;
  String contentText;
  String? defType;
  String? resourceName;
  int? color;
  bool? colorized;
  String? contentInfo;
  String? largeIcon;
  bool? onGoing;
  String? subText;
  String? sound;
  List<int>? vibrate;
  int? visibility;
  String? smallIcon;

  BackgroundNotification({
    required this.category,
    required this.priority,
    required this.channelName,
    required this.contentTitle,
    required this.contentText,
    this.defType,
    this.resourceName,
    this.color,
    this.colorized,
    this.contentInfo,
    this.largeIcon,
    this.onGoing,
    this.subText,
    this.sound,
    this.vibrate,
    this.visibility,
    this.smallIcon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'priority': priority,
      'channelName': channelName,
      'contentTitle': contentTitle,
      'contentText': contentText,
      'defType': defType,
      'resourceName': resourceName,
      'color': color,
      'colorized': colorized,
      'contentInfo': contentInfo,
      'largeIcon': largeIcon,
      'onGoing': onGoing,
      'subText': subText,
      'sound': sound,
      'vibrate': vibrate,
      'visibility': visibility,
      'smallIcon': smallIcon,
    };
  }

  factory BackgroundNotification.fromMap(Map<dynamic, dynamic>? map) {
    return BackgroundNotification(
      category: map?['category'],
      priority: map?['priority'],
      channelName: map?['channelName'],
      contentTitle: map?['contentTitle'],
      contentText: map?['contentText'],
      defType: map?['defType'],
      resourceName: map?['resourceName'],
      color: map?['color'],
      colorized: map?['colorized'],
      contentInfo: map?['contentInfo'],
      largeIcon: map?['largeIcon'],
      onGoing: map?['onGoing'],
      subText: map?['subText'],
      sound: map?['sound'],
      vibrate: map?['vibrate'],
      visibility: map?['visibility'],
      smallIcon: map?['smallIcon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BackgroundNotification.fromJson(String source) =>
      BackgroundNotification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LogConfig('
        'category: $category, '
        'priority: $priority, '
        'channelName: $channelName, '
        'contentTitle: $contentTitle, '
        'contentText: $contentText, '
        'defType: $defType, '
        'resourceName: $resourceName, '
        'color: $color, '
        'colorized: $colorized, '
        'contentInfo: $contentInfo, '
        'largeIcon: $largeIcon, '
        'onGoing: $onGoing, '
        'subText: $subText, '
        'sound: $sound, '
        'vibrate: $vibrate, '
        'visibility: $visibility, '
        'smallIcon: $smallIcon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BackgroundNotification &&
        other.category == category &&
        other.priority == priority &&
        other.channelName == channelName &&
        other.contentTitle == contentTitle &&
        other.contentText == contentText &&
        other.defType == defType &&
        other.resourceName == resourceName &&
        other.color == color &&
        other.colorized == colorized &&
        other.contentInfo == contentInfo &&
        other.largeIcon == largeIcon &&
        other.onGoing == onGoing &&
        other.subText == subText &&
        other.sound == sound &&
        other.vibrate == vibrate &&
        other.visibility == visibility &&
        other.smallIcon == smallIcon;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        category,
        priority,
        channelName,
        contentTitle,
        contentText,
        defType,
        resourceName,
        color,
        colorized,
        contentInfo,
        largeIcon,
        onGoing,
        subText,
        sound,
        vibrate,
        visibility,
        smallIcon
      ],
    );
  }
}
