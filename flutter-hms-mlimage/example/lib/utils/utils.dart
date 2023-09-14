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
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

mixin DemoMixin {
  Future<void> analyseFrame(String? path);
  Future<void> asyncAnalyseFrame(String? path);
  Future<void> stop();
}

Future<String?> getImage(ImageSource source) async {
  final XFile? xFile = await ImagePicker().pickImage(
    source: source,
  );
  return xFile?.path;
}

void pickerDialog(
  GlobalKey<ScaffoldState> key,
  BuildContext context,
  Function(String? s) f,
) async {
  key.currentState?.showBottomSheet((BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(cameraText),
              onPressed: () async {
                final String? path = await getImage(ImageSource.camera);
                f(path);
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(galleryText),
              onPressed: () async {
                final String? path = await getImage(ImageSource.gallery);
                f(path);
              },
            ),
          ),
        ],
      ),
    );
  });
}

Future<void> exceptionDialog(
  BuildContext context,
  String content,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(exceptionText),
        content: Text(content),
      );
    },
  );
}

Widget resultBox(
  String name,
  dynamic value,
  BuildContext context,
) {
  return Container(
    width: context.highWidthValue,
    padding: smallAllPadding(context),
    margin: context.paddingNormal,
    decoration: BoxDecoration(
      color: kGrayColor.withOpacity(.6),
      borderRadius: BorderRadius.circular(4),
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
            text: '${value ?? noneText}',
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

Widget lensControllerButton(
  VoidCallback callback,
  Color color,
  String title,
) {
  return Expanded(
    child: SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: callback,
        style: buttonStyle,
        child: Text(title),
      ),
    ),
  );
}

PreferredSizeWidget demoAppBar(String title) {
  return AppBar(
    title: Center(
      child: Tooltip(
        message: 'Flutter Version: 3.11.0+300',
        child: Text(title),
      ),
    ),
  );
}

ButtonStyle get buttonStyle {
  return ElevatedButton.styleFrom(
    elevation: 2,
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

ButtonStyle get dangerbuttonStyle {
  return ElevatedButton.styleFrom(
    elevation: 2,
    backgroundColor: kDangerColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Widget containerElevatedButton(
  BuildContext context,
  Widget child,
) {
  return Container(
    width: context.highWidthValue,
    margin: context.paddingLow,
    child: child,
  );
}

class CustomGridElement extends StatelessWidget {
  final Widget? page;
  final String imagePath;
  final String name;

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
            border: Border.all(
              color: Colors.grey.withOpacity(.5),
            ),
            color: page != null ? Colors.white : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/$imagePath.png', height: 75),
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
