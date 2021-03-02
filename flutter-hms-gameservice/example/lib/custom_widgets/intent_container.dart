/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class IntentContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Function onTap;
  final IconData icon;

  IntentContainer(this.color, this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: color,
            ),
            child: Icon(
              icon,
              size: 35,
              color: Colors.white,
            ),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
      ],
    );
  }
}
