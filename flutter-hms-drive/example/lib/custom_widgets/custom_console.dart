/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

class CustomConsole extends StatelessWidget {
  final List<String?> responses;

  const CustomConsole({
    Key? key,
    this.responses = const <String>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(30, 61, 89, 1),
          ),
        ),
        child: ListView.builder(
          itemCount: responses.length,
          itemBuilder: (BuildContext context, int index) {
            List<String?> reversedList = responses.reversed.toList();
            return Text(' > ${reversedList[index]}');
          },
        ),
      ),
    );
  }
}
