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

class HMSCardInfo {
  final int idx;
  final String name;
  final String imageAssetPath;
  bool isFound;
  bool selected;

  HMSCardInfo(this.idx, this.name, this.imageAssetPath, this.isFound,
      {this.selected = false});

  @override
  String toString() {
    return "Name: $name, " +
        "imageAssetPath:$imageAssetPath, " +
        "isFound:$isFound " +
        "selected:$selected";
  }

  static List<HMSCardInfo> get getShuffledCards {
    final HMSCardInfo hmsMap = HMSCardInfo(
        1, "Huawei Map", "assets/HMSIcons/HMSMap.png", false,
        selected: false);
    final HMSCardInfo hmsMapPair = HMSCardInfo(
        2, "Huawei Map", "assets/HMSIcons/HMSMap.png", false,
        selected: false);
    final HMSCardInfo hmsPush = HMSCardInfo(
        3, "Huawei Push", "assets/HMSIcons/HMSPush.png", false,
        selected: false);
    final HMSCardInfo hmsPushPair = HMSCardInfo(
        4, "Huawei Push", "assets/HMSIcons/HMSPush.png", false,
        selected: false);
    final HMSCardInfo hmsAdsPair = HMSCardInfo(
        5, "Huawei Ads", "assets/HMSIcons/HMSAds.png", false,
        selected: false);
    final HMSCardInfo hmsAds = HMSCardInfo(
        6, "Huawei Ads", "assets/HMSIcons/HMSAds.png", false,
        selected: false);
    final HMSCardInfo hmsDrive = HMSCardInfo(
        7, "Huawei Drive", "assets/HMSIcons/HMSDrive.png", false,
        selected: false);
    final HMSCardInfo hmsDrivePair = HMSCardInfo(
        8, "Huawei Drive", "assets/HMSIcons/HMSDrive.png", false,
        selected: false);
    final HMSCardInfo hmsLocation = HMSCardInfo(
        9, "Huawei Location", "assets/HMSIcons/HMSLocation.png", false,
        selected: false);
    final HMSCardInfo hmsLocationPair = HMSCardInfo(
        10, "Huawei Location", "assets/HMSIcons/HMSLocation.png", false,
        selected: false);
    final HMSCardInfo hmsML = HMSCardInfo(
        11, "Huawei ML", "assets/HMSIcons/HMSML.png", false,
        selected: false);
    final HMSCardInfo hmsMLPair = HMSCardInfo(
        12, "Huawei ML", "assets/HMSIcons/HMSML.png", false,
        selected: false);
    return [
      hmsMap,
      hmsPush,
      hmsMapPair,
      hmsPushPair,
      hmsAds,
      hmsAdsPair,
      hmsDrive,
      hmsDrivePair,
      hmsLocation,
      hmsLocationPair,
      hmsML,
      hmsMLPair
    ]..shuffle();
  }
}
