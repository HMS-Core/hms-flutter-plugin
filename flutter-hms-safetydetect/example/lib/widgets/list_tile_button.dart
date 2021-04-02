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

import '../style.dart';

class ListTileButton extends StatefulWidget {
  final Function onTap;
  final String title;
  final IconData iconData;
  final Color iconColor;

  const ListTileButton(
      {Key key,
      @required this.onTap,
      @required this.iconData,
      @required this.title,
      this.iconColor = emperor})
      : super(key: key);

  @override
  _ListTileButtonState createState() => _ListTileButtonState();
}

class _ListTileButtonState extends State<ListTileButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          gradient: LinearGradient(
              colors: [galleryGreyDarker, mercuryGrey],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: alto,
              offset: Offset(4, 4),
            ),
            BoxShadow(
              blurRadius: 8,
              color: alabaster,
              offset: Offset(-4, -4),
            )
          ]),
      child: ListTile(
        onTap: widget.onTap,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.iconData,
              color: widget.iconColor,
              size: 50,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: boulder),
            ),
          ],
        ),
      ),
    );
  }
}
