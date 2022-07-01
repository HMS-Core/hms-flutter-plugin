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

import 'dart:ui' show Offset, VoidCallback;

class InfoWindow {
  final String? title;
  final String? snippet;
  final Offset anchor;
  final VoidCallback? onClick;
  final VoidCallback? onLongClick;
  final VoidCallback? onClose;

  static const InfoWindow noText = InfoWindow();

  const InfoWindow({
    this.title,
    this.snippet,
    this.anchor = const Offset(0.5, 0.0),
    this.onClick,
    this.onLongClick,
    this.onClose,
  });

  InfoWindow updateCopy({
    String? title,
    String? snippet,
    Offset? anchor,
    VoidCallback? onClick,
    VoidCallback? onLongClick,
    VoidCallback? onClose,
  }) {
    return InfoWindow(
      title: title ?? this.title,
      snippet: snippet ?? this.snippet,
      anchor: anchor ?? this.anchor,
      onClick: onClick ?? this.onClick,
      onLongClick: onLongClick ?? this.onLongClick,
      onClose: onClose ?? this.onClose,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is InfoWindow &&
        this.title == other.title &&
        this.snippet == other.snippet &&
        this.anchor == other.anchor;
  }

  @override
  int get hashCode => Object.hash(title.hashCode, snippet, anchor);
}
