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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.blueGrey[400],
    title: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
        child: Image.asset("assets/hw_icon.png"),
      ),
    ],
    bottom: PreferredSize(
        child: SizedBox(
          height: 1,
          child: Container(
            color: Colors.grey[600],
          ),
        ),
        preferredSize: const Size.fromHeight(20.0)),
  );
}
