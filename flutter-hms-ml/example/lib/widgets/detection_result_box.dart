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

Widget detectionResultBox(String name, dynamic value) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(name.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ))),
    Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: .5,
              color: Colors.black.withOpacity(.4),
              style: BorderStyle.solid)),
      child: Text(value.toString()),
    )
  ]);
}
