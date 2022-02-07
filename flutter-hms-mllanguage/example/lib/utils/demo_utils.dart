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

exceptionDialog(BuildContext context, String m) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exception'),
          content: Text(m),
        );
      });
}

Widget recognitionButton(VoidCallback callback, {String? text, Color? color}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color ?? const Color(0xff6ddccf),
            onPrimary: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        child: Text(text ?? "Start Recognition"),
        onPressed: callback),
  );
}

Widget resultBox(String name, dynamic value) {
  return Container(
    width: double.infinity - 20,
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    decoration: BoxDecoration(
        color: const Color(0xffdbe2ef).withOpacity(.6),
        borderRadius: BorderRadius.circular(4)),
    child: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "$name: ",
            style: TextStyle(color: Colors.black.withOpacity(.5))),
        TextSpan(
            text: "${value ?? "None"}",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold))
      ]),
    ),
    //child: Text("$name: ${value ?? "null"}"),
  );
}

class CustomGridElement extends StatelessWidget {
  final Widget? page;
  final String imagePath;
  final String name;

  const CustomGridElement(
      {Key? key, this.page, required this.name, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => page!));
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width / 4,
            minHeight: MediaQuery.of(context).size.width / 4 + 10),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/$imagePath.png", height: 75),
              const SizedBox(height: 5),
              Text(name, textAlign: TextAlign.center)
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.5)),
              color: page != null ? Colors.white : Colors.white,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
