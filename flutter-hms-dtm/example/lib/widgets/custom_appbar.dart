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

PreferredSizeWidget customAppBar({String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.orange),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Image.asset("assets/hw_icon.png"),
      ),
    ],
    bottom: new PreferredSize(
        child: new SizedBox(
          height: 1,
          child: Container(
            color: Colors.orange,
          ),
        ),
        preferredSize: const Size.fromHeight(20.0)),
  );
}
