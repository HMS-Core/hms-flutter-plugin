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

Widget authButton(String text, Function function) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
    child: RaisedButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(text.toUpperCase()),
      onPressed: function,
    ),
  );
}
