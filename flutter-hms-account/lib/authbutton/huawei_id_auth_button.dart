/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/


import 'package:flutter/material.dart';

enum AuthButtonTheme {FULL_TITLE, NO_TITLE}
enum AuthButtonBackground {BLUE, BLACK, GREY, RED, WHITE}
enum AuthButtonRadius {SMALL, MEDIUM, LARGE}

class HuaweiIdAuthButton extends StatelessWidget {

  final AuthButtonTheme theme;
  final AuthButtonBackground buttonColor;
  final AuthButtonRadius borderRadius;
  final Function onPressed;

  final double width;
  final double padding;


  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const HuaweiIdAuthButton(
      {Key key,
      @required this.onPressed,
      this.width,
      this.borderRadius,
      this.buttonColor,
      this.fontWeight,
      this.fontSize,
      this.textColor,
      this.theme,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 1.1,
      child: RaisedButton(
        elevation: 2,
          padding: EdgeInsets.symmetric(vertical: padding ?? 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius == AuthButtonRadius.SMALL ? 8 : borderRadius == AuthButtonRadius.MEDIUM ? 14 : borderRadius == AuthButtonRadius.LARGE ? 20 : 4)),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buttonColor == AuthButtonBackground.WHITE ? Image.asset("packages/huawei_account/images/logored.png", height: 45) : Image.asset("packages/huawei_account/images/logo.png", height: 45),
              theme == AuthButtonTheme.NO_TITLE ? SizedBox()
                  : Text("Log in with Huawei",
                  style: TextStyle(
                    color: textColor == null ? buttonColor == AuthButtonBackground.WHITE ? Colors.black : Colors.white : textColor,
                    fontSize: fontSize ?? 17,
                    fontWeight: fontWeight ?? FontWeight.bold,
                  )),
            ],
          ),
          color: buttonColor == AuthButtonBackground.BLACK ? Colors.black
                 : buttonColor == AuthButtonBackground.GREY ? Colors.grey
                 : buttonColor == AuthButtonBackground.BLUE ? Colors.blue
                 : buttonColor == AuthButtonBackground.WHITE ? Colors.white
                 : Colors.red),
    );
  }
}
