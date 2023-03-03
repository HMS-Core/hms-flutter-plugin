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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final AsyncCallback onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.redAccent),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(12),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: const BorderSide(color: Colors.red),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () async {
        await onPressed();
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
