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

part of huawei_ml_image;

class MLImageLens extends StatefulWidget {
  const MLImageLens({
    Key? key,
    this.textureId,
    this.width,
    this.height,
  }) : super(key: key);

  final int? textureId;
  final double? width;
  final double? height;

  @override
  State<MLImageLens> createState() => _MLImageLensState();
}

class _MLImageLensState extends State<MLImageLens> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: widget.width ?? MediaQuery.of(context).size.width * .8,
      height: widget.height ?? MediaQuery.of(context).size.height * .8,
      child: textureReady
          ? Texture(
              textureId: widget.textureId!,
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
    );
  }

  bool get textureReady => widget.textureId != null;
}
