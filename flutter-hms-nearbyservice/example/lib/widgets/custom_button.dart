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
import 'package:huawei_nearbyservice_example/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final double height;

  CustomButton(
      {@required this.text,
      @required this.onPressed,
      this.width = 90,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        child: Center(
          child: Text(
            text,
            style: Styles.controlButtonStyle,
          ),
        ),
        width: width,
        height: height,
      ),
      onPressed: onPressed,
    );
  }
}
