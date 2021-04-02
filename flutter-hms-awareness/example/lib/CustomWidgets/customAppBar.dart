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
import 'customClipper.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  final String title2;
  final double size;
  final bool icon;
  final double fontSize;
  final bool backButton;

  CustomAppBar({
    this.title,
    this.size,
    this.title2 = "",
    this.icon,
    this.fontSize = 30,
    this.backButton = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: ClipPath(
            clipper: AwarenessCustomClipper(),
            child: Container(
              color: Color.fromRGBO(30, 61, 89, 1),
            ),
          ),
        ),
        icon
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/AwarenessLogo.png"),
                  ),
                ),
              )
            : SizedBox.shrink(),
        Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Color.fromRGBO(245, 240, 225, 1),
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  title2,
                  style: TextStyle(color: Color.fromRGBO(245, 240, 225, 1)),
                ),
                icon
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox.shrink()
              ],
            )),
        backButton
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CircleAvatar(
                    child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Color.fromRGBO(245, 240, 225, 1),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    radius: 25,
                    backgroundColor: Color.fromRGBO(255, 110, 64, 1),
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
