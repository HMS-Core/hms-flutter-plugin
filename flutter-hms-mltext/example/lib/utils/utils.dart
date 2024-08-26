/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> getImage(ImageSource source) async {
  final XFile? image = await ImagePicker().pickImage(
    source: source,
  );
  return image?.path;
}

mixin DemoMixin {
  void analyze(String? path);
  void isAvailable();
  void stop();
  void destroy();
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
              onPressed: () async {
                final String? path = await getImage(
                  ImageSource.camera,
                );
                f(path);
              },
              child: const Text(cameraText),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final String? path = await getImage(
                  ImageSource.gallery,
                );
                f(path);
              },
              child: const Text(galleryText),
            ),
          ),
        ],
      ),
    );
  });
}

void exceptionDialog(
  BuildContext context,
  String content,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(exceptionText),
        content: Text(content),
      );
    },
  );
}

Widget recognitionButton(
  Future<dynamic> callback, {
  String? text,
  Color? color,
  BuildContext? context,
}) {
  return Container(
    width: double.infinity,
    margin: context!.paddingNormal,
    child: customElevatedButton(
      text,
      callback,
    ),
  );
}

Widget customElevatedButton(
  String? text,
  Future<dynamic> callback,
) {
  return ElevatedButton(
    style: buttonStyle,
    onPressed: () => callback,
    child: Text(text ?? startRecognitionText),
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
        children: <InlineSpan>[
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

Widget resultBoxWidget(
  BuildContext context,
  String resultBoxText,
  String? res,
) {
  return Expanded(
    child: SingleChildScrollView(
      child: resultBox(
        resultBoxText,
        res,
        context,
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

Widget bcrImageContainer(
  BuildContext context,
  Image? image,
) {
  return Container(
    color: kGrayColor,
    margin: context.paddingLow,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.width,
    child: image ?? Image.asset(userImage),
  );
}

PreferredSizeWidget demoAppBar(String title) {
  return AppBar(
    title: Tooltip(
      message: 'Flutter Version: 3.12.0+300',
      child: Text(title),
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
  const CustomGridElement({
    Key? key,
    required this.name,
    required this.imagePath,
    this.page,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final Widget? page;

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
              color: Colors.grey.withOpacity(0.5),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
