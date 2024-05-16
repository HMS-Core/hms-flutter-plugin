/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_account;

enum AuthButtonTheme {
  FULL_TITLE,
  NO_TITLE,
}

enum AuthButtonBackground {
  BLACK,
  RED,
  WHITE,
}

enum AuthButtonRadius {
  SMALL,
  MEDIUM,
  LARGE,
}

const Color hwRed = Color(0xffCE0E2D);

/// Special widget for Account Kit Plugin
class HuaweiIdAuthButton extends StatelessWidget {
  final AuthButtonTheme? theme;
  final AuthButtonBackground? buttonColor;
  final AuthButtonRadius? borderRadius;
  final VoidCallback onPressed;

  final double? width;
  final double? height;
  final double? elevation;
  final double? padding;

  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const HuaweiIdAuthButton({
    required this.onPressed,
    Key? key,
    this.width,
    this.height,
    this.elevation,
    this.borderRadius,
    this.buttonColor,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.theme,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width / 1.1,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 2,
          backgroundColor: buttonColor == AuthButtonBackground.BLACK
              ? Colors.black
              : buttonColor == AuthButtonBackground.WHITE
                  ? Colors.white
                  : hwRed,
          padding: EdgeInsets.symmetric(vertical: padding ?? 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius == AuthButtonRadius.SMALL
                  ? 8
                  : borderRadius == AuthButtonRadius.MEDIUM
                      ? 14
                      : borderRadius == AuthButtonRadius.LARGE
                          ? 25
                          : 0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buttonColor == AuthButtonBackground.WHITE
                ? Image.asset(
                    'packages/huawei_account/src/ui/logored.png',
                    height: height != null ? height! * .9 : 50,
                  )
                : Image.asset(
                    'packages/huawei_account/src/ui/logo.png',
                    height: height != null ? height! * .9 : 50,
                  ),
            const SizedBox(width: 8),
            theme == AuthButtonTheme.NO_TITLE
                ? const SizedBox()
                : Text(
                    'Sign in with HUAWEI ID',
                    style: TextStyle(
                      color: textColor ??
                          (buttonColor == AuthButtonBackground.WHITE
                              ? Colors.black
                              : Colors.white),
                      fontSize: fontSize ?? 17,
                      letterSpacing: .5,
                      fontWeight: fontWeight ?? FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
