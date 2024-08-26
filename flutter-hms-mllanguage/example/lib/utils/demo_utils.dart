/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

void exceptionDialog(BuildContext context, String m) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exception'),
        content: Text(m),
      );
    },
  );
}

Widget recognitionButton(
  VoidCallback callback, {
  String? text,
  Color? color,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color ?? const Color(0xFF3C4279),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      onPressed: callback,
      child: Text(text ?? 'Start Recognition'),
    ),
  );
}

Widget resultBox(String name, dynamic value) {
  return Container(
    width: double.infinity - 20,
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    decoration: BoxDecoration(
      color: const Color(0xffdbe2ef).withOpacity(.6),
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$name: ',
            style: TextStyle(
              color: Colors.black.withOpacity(.5),
            ),
          ),
          TextSpan(
            text: "${value ?? "None"}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomGridElement extends StatelessWidget {
  final String imagePath;
  final String name;
  final Widget? page;

  const CustomGridElement({
    required this.name,
    required this.imagePath,
    this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => page!,
            ),
          );
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width / 4,
          minHeight: MediaQuery.of(context).size.width / 4 + 10,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            color: page != null ? Colors.white : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/$imagePath.png',
                height: 75,
              ),
              const SizedBox(height: 5),
              Text(
                name,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
