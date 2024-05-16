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

import 'package:flutter/material.dart';

import 'customClipper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String title2;
  final double size;
  final bool icon;
  final double fontSize;
  final bool backButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.size,
    this.title2 = '',
    required this.icon,
    this.fontSize = 30,
    this.backButton = false,
  }) : super(key: key);

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
              color: const Color.fromRGBO(30, 61, 89, 1),
            ),
          ),
        ),
        icon
            ? const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/AwarenessLogo.png'),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: const Color.fromRGBO(245, 240, 225, 1),
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title2,
                style: const TextStyle(
                  color: Color.fromRGBO(245, 240, 225, 1),
                ),
              ),
              icon ? const SizedBox(height: 10) : const SizedBox.shrink(),
            ],
          ),
        ),
        backButton
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color.fromRGBO(255, 110, 64, 1),
                    child: IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                        color: Color.fromRGBO(245, 240, 225, 1),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
