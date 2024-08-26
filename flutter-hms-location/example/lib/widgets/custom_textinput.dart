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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  static const bool _IS_DENSE = true;
  static const EdgeInsetsGeometry _CONTENT_PADDING = EdgeInsets.all(5);

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<FilteringTextInputFormatter>? inputFormatters;
  final int? maxLength;
  final EdgeInsets padding;

  const CustomTextInput({
    Key? key,
    this.labelText = '',
    this.hintText = '',
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.padding = const EdgeInsets.only(top: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        controller: controller,
        decoration: InputDecoration(
          isDense: _IS_DENSE,
          contentPadding: _CONTENT_PADDING,
          labelText: labelText,
          hintText: hintText,
          fillColor: const Color(0xfff3f3f4),
          filled: true,
        ),
      ),
    );
  }
}
