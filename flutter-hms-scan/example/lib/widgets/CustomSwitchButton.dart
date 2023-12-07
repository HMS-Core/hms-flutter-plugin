/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

class CustomSwitchButton extends StatelessWidget {
  final bool? value;
  final Function? onChanged;
  final String? label;
  final String? rightLabel;
  final String? leftLabel;

  const CustomSwitchButton({
    Key? key,
    this.value,
    this.onChanged,
    this.label,
    this.leftLabel,
    this.rightLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(leftLabel ?? ''),
            Switch(
              value: value ?? false,
              onChanged: onChanged as void Function(bool)?,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
            Text(rightLabel ?? ''),
          ],
        )
      ],
    );
  }
}
