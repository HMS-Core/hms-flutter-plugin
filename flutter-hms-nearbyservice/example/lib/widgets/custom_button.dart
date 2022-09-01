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

import 'package:flutter/material.dart';
import 'package:huawei_nearbyservice_example/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double width;
  final double height;

  const CustomButton({
    required this.text,
    required this.onPressed,
    Key? key,
    this.width = 90,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: Styles.controlButtonStyle,
          ),
        ),
      ),
    );
  }
}
