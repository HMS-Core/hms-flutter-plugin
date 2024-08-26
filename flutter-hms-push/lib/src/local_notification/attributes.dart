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

abstract class HMSLocalNotificationAttr {
  static const String ID = 'id';
  static const String MESSAGE = 'message';
  static const String FIRE_DATE = 'fireDate';
  static const String TITLE = 'title';
  static const String TICKER = 'ticker';
  static const String SHOW_WHEN = 'showWhen';
  static const String AUTO_CANCEL = 'autoCancel';
  static const String LARGE_ICON = 'largeIcon';
  static const String LARGE_ICON_URL = 'largeIconUrl';
  static const String SMALL_ICON = 'smallIcon';
  static const String BIG_TEXT = 'bigText';
  static const String SUB_TEXT = 'subText';
  static const String BIG_PICTURE_URL = 'bigPictureUrl';
  static const String SHORTCUT_ID = 'shortcutId';
  static const String NUMBER = 'number';
  static const String CHANNEL_ID = 'channelId';
  static const String CHANNEL_NAME = 'channelName';
  static const String CHANNEL_DESCRIPTION = 'channelDescription';
  static const String SOUND = 'sound';
  static const String COLOR = 'color';
  static const String GROUP = 'group';
  static const String GROUP_SUMMARY = 'groupSummary';
  static const String USER_INTERACTION = 'userInteraction';
  static const String PLAY_SOUND = 'playSound';
  static const String SOUND_NAME = 'soundName';
  static const String VIBRATE = 'vibrate';
  static const String VIBRATE_DURATION = 'vibrateDuration';
  static const String ACTIONS = 'actions';
  static const String ACTION = 'action';
  static const String INVOKE_APP = 'invokeApp';
  static const String TAG = 'tag';
  static const String REPEAT_TYPE = 'repeatType';
  static const String REPEAT_TIME = 'repeatTime';
  static const String ONGOING = 'ongoing';
  static const String ALLOW_WHILE_IDLE = 'allowWhileIdle';
  static const String DONT_NOTIFY_IN_FOREGROUND = 'dontNotifyInForeground';
  static const String PRIORITY = 'priority';
  static const String IMPORTANCE = 'importance';
  static const String VISIBILITY = 'visibility';
  static const String DATA = 'data';
}
