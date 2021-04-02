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
import 'package:flutter/material.dart';
import 'package:huawei_ads/utils/constants.dart';

class _Key {
  static const String visibility = "visibility";
  static const String fontSize = "fontSize";
  static const String fontWeight = "fontWeight";
  static const String color = "color";
  static const String bgColor = "backgroundColor";
}

enum NativeFontWeight { normal, bold, italic, boldItalic }

class NativeStyles {
  bool showMedia = true;
  String mediaImageScaleType = ImageViewScaleType.fitCenter;
  Map<String, dynamic> _flag = _createNativeStyle(
    fontSize: 11,
    color: Colors.white,
    bgColor: Color(0xFFECC159),
  );
  Map<String, dynamic> _title = _createNativeStyle(
    fontSize: 15,
    color: Colors.black,
  );
  Map<String, dynamic> _source = _createNativeStyle(
    fontSize: 14,
    color: Colors.black,
  );
  Map<String, dynamic> _description = _createNativeStyle(
    fontSize: 12,
    color: Colors.grey,
  );
  Map<String, dynamic> _callToAction = _createNativeStyle(
    fontSize: 14,
    color: Colors.white,
    bgColor: Color(0xFF1D9CE7),
  );

  NativeStyles();

  void setFlag(
          {bool isVisible,
          double fontSize,
          NativeFontWeight fontWeight,
          Color color,
          Color bgColor}) =>
      _flag = _buildNativeStyle(
          _flag, isVisible, fontSize, fontWeight, color, bgColor);

  void setTitle(
          {bool isVisible,
          double fontSize,
          NativeFontWeight fontWeight,
          Color color,
          Color bgColor}) =>
      _buildNativeStyle(
          _title, isVisible, fontSize, fontWeight, color, bgColor);

  void setSource(
          {bool isVisible,
          double fontSize,
          NativeFontWeight fontWeight,
          Color color,
          Color bgColor}) =>
      _buildNativeStyle(
          _source, isVisible, fontSize, fontWeight, color, bgColor);

  void setDescription(
          {bool isVisible,
          double fontSize,
          NativeFontWeight fontWeight,
          Color color,
          Color bgColor}) =>
      _buildNativeStyle(
          _description, isVisible, fontSize, fontWeight, color, bgColor);

  void setCallToAction(
          {bool isVisible,
          double fontSize,
          NativeFontWeight fontWeight,
          Color color,
          Color bgColor}) =>
      _buildNativeStyle(
          _callToAction, isVisible, fontSize, fontWeight, color, bgColor);

  static Map<String, dynamic> _createNativeStyle(
      {double fontSize,
      NativeFontWeight fontWeight,
      Color color,
      Color bgColor}) {
    Map<String, dynamic> style = Map<String, dynamic>();
    style[_Key.visibility] = true;
    style[_Key.fontSize] = fontSize;
    style[_Key.fontWeight] = fontWeight ?? NativeFontWeight.normal.index;
    style[_Key.color] = _toHex(color);
    style[_Key.bgColor] = bgColor != null ? _toHex(bgColor) : null;

    return style;
  }

  static Map<String, dynamic> _buildNativeStyle(
      Map<String, dynamic> style,
      bool isVisible,
      double fontSize,
      NativeFontWeight fontWeight,
      Color color,
      Color bgColor) {
    if (isVisible != null) style[_Key.visibility] = isVisible;
    if (fontSize != null) style[_Key.fontSize] = fontSize;
    if (fontWeight != null) style[_Key.fontWeight] = fontWeight.index;
    if (color != null) style[_Key.color] = _toHex(color);
    if (bgColor != null) style[_Key.bgColor] = _toHex(bgColor);

    return style;
  }

  static String _toHex(Color color) => '#${color.value.toRadixString(16)}';

  Map<String, dynamic> toJson() => {
        "showMedia": this.showMedia,
        "mediaImageScaleType": this.mediaImageScaleType,
        "flag": _flag,
        "title": _title,
        "source": _source,
        "description": _description,
        "callToAction": _callToAction,
      };
}
