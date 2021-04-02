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
import 'inner_shadow.dart';

class ResultContainer extends StatelessWidget {
  final String methodName;
  final String methodResult;

  final EdgeInsets componentPadding =
      const EdgeInsets.symmetric(horizontal: 40, vertical: 20);

  const ResultContainer({Key key, this.methodName, this.methodResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: componentPadding,
      child: InnerShadow(
        blur: 5,
        color: emperor.withOpacity(.25),
        offset: const Offset(4, 4),
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: bgColor,
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      methodName.isEmpty ? "Method Result" : methodName,
                      style: TextStyle(fontSize: 24, color: textColor),
                    ),
                  ),
                ),
              ),
              InnerShadow(
                blur: 5,
                color: Colors.white,
                offset: const Offset(-4, -4),
                child: Container(
                  height: (MediaQuery.of(context).size.height / 4) - 50,
                  decoration: BoxDecoration(
                    color: galleryGrey,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        methodResult.isEmpty ? "Result" : methodResult,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
