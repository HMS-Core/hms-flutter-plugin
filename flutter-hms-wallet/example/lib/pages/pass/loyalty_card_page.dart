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
import 'package:flutter/services.dart';
import 'package:huawei_wallet/huawei_wallet.dart';
import 'package:huawei_wallet_example/pages/pass/pass_action_page.dart';
import 'package:huawei_wallet_example/utils/utils.dart';

class LoyaltyCardPage extends StatefulWidget {
  final int environment;

  const LoyaltyCardPage({Key key, this.environment}) : super(key: key);
  @override
  _LoyaltyCardPageState createState() => _LoyaltyCardPageState();
}

class _LoyaltyCardPageState extends State<LoyaltyCardPage> {
  String status = 'ACTIVE';
  DateTime startDate = DateTime(2020, 1, 12);
  DateTime endDate = DateTime(2022, 1, 12);

  TextEditingController serialNumberController =
      TextEditingController.fromValue(
    TextEditingValue(text: Utils.getRandomNumber(12)),
  );
  TextEditingController passStyleIdController = TextEditingController.fromValue(
    TextEditingValue(text: Constants.passStyleIdLoyalty),
  );
  TextEditingController passTypeIdController = TextEditingController.fromValue(
    TextEditingValue(text: Constants.passTypeIdLoyalty),
  );
  TextEditingController cardPictureController = TextEditingController.fromValue(
    TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/AccessCard/cloudRes/img_access_edit_personalise_big6.jpg',
    ),
  );
  TextEditingController cardLogoController = TextEditingController.fromValue(
    TextEditingValue(
        text:
            'https://contentcenter-drcn.dbankcdn.com/cch5/Wallet-WalletKit/picres/cloudRes/card_loyalty_logo.png'),
  );
  TextEditingController merchantNameController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'carrefour vip'),
  );
  TextEditingController cardNameController = TextEditingController.fromValue(
    TextEditingValue(text: 'carrefour'),
  );
  TextEditingController cardNumberController = TextEditingController.fromValue(
    TextEditingValue(text: '0'),
  );
  TextEditingController pointsController = TextEditingController();
  TextEditingController balanceController = TextEditingController.fromValue(
    TextEditingValue(text: '199'),
  );
  TextEditingController currencyCodeController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'C'),
  );
  TextEditingController relatedIdController = TextEditingController();
  TextEditingController relatedValueController = TextEditingController();
  TextEditingController barValController = TextEditingController.fromValue(
    TextEditingValue(text: '1234567890'),
  );
  TextEditingController barTextController = TextEditingController.fromValue(
    TextEditingValue(text: '123456789123456'),
  );
  TextEditingController memberNameController = TextEditingController.fromValue(
    TextEditingValue(text: 'tester'),
  );
  TextEditingController tierLevelController = TextEditingController.fromValue(
    TextEditingValue(text: 'tier-level-0'),
  );
  TextEditingController messageHeaderController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Message'),
  );
  TextEditingController messageInfoController = TextEditingController.fromValue(
    TextEditingValue(text: 'Welcome to use loyalty card.'),
  );
  TextEditingController bannerURIController = TextEditingController.fromValue(
    TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/HiWallet/cloudRes/ic_empty_idcard.png',
    ),
  );
  TextEditingController bannerURIDescController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Rotation Chart'),
  );
  TextEditingController uriLabelController = TextEditingController();
  TextEditingController uriValueController = TextEditingController();
  TextEditingController nearbyLabelController = TextEditingController.fromValue(
    TextEditingValue(text: 'Nearby Location'),
  );
  TextEditingController nearbyValueController = TextEditingController();
  TextEditingController webSiteLabelController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Website'),
  );
  TextEditingController webSiteValueController = TextEditingController();
  TextEditingController hotlineLabelController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Customer Service'),
  );
  TextEditingController hotlineValueController =
      TextEditingController.fromValue(
    TextEditingValue(text: '4008205566'),
  );
  TextEditingController latitudeController = TextEditingController.fromValue(
    TextEditingValue(text: '89'),
  );
  TextEditingController longitudeController = TextEditingController.fromValue(
    TextEditingValue(text: '114'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Loyalty Card'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: serialNumberController,
            decoration: InputDecoration(labelText: 'Serial Number'),
          ),
          TextField(
            controller: passStyleIdController,
            decoration: InputDecoration(labelText: 'Template - Style Id'),
          ),
          TextField(
            controller: passTypeIdController,
            decoration: InputDecoration(labelText: 'Pass Type'),
          ),
          TextField(
            // 1
            controller: cardPictureController,
            decoration: InputDecoration(labelText: 'Card Picture Uri'),
          ),
          TextField(
            // 2
            controller: cardLogoController,
            decoration: InputDecoration(labelText: 'Logo Uri'),
          ),
          TextField(
            // 3
            controller: merchantNameController,
            decoration: InputDecoration(labelText: 'Merchant Name'),
          ),
          TextField(
            // 4
            controller: cardNameController,
            decoration: InputDecoration(labelText: 'Card Name'),
          ),
          TextField(
            // 5
            controller: cardNumberController,
            decoration: InputDecoration(labelText: 'Card Number'),
          ),
          TextField(
            // 6
            controller: balanceController,
            decoration: InputDecoration(labelText: 'Balance'),
          ),
          TextField(
            // 6
            controller: currencyCodeController,
            decoration: InputDecoration(labelText: 'Currency Code'),
          ),
          TextField(
            // 7
            controller: relatedIdController,
            decoration: InputDecoration(labelText: 'Related Card Id'),
          ),
          TextField(
            // 7
            controller: relatedValueController,
            decoration: InputDecoration(labelText: 'Related Card Type'),
          ),
          TextField(
            // 8
            controller: pointsController,
            decoration: InputDecoration(labelText: 'Points'),
          ),
          TextField(
            // 10
            controller: barValController,
            decoration: InputDecoration(labelText: 'Barcode Value'),
          ),
          TextField(
            // 10
            controller: barTextController,
            decoration: InputDecoration(labelText: 'Barcode Text'),
          ),
          TextField(
            // 11
            controller: memberNameController,
            decoration: InputDecoration(labelText: 'Member Name'),
          ),
          TextField(
            // 13
            controller: tierLevelController,
            decoration: InputDecoration(labelText: 'Tier'),
          ),
          TextField(
            // 14
            controller: messageHeaderController,
            decoration: InputDecoration(labelText: 'Message Header'),
          ),
          TextField(
            // 14
            controller: messageInfoController,
            decoration: InputDecoration(labelText: 'Message Info'),
          ),
          TextField(
            // 15
            controller: bannerURIController,
            decoration: InputDecoration(labelText: 'Banner URI'),
          ),
          TextField(
            // 15
            controller: bannerURIDescController,
            decoration: InputDecoration(labelText: 'Banner URI Description'),
          ),
          TextField(
            // 15
            controller: uriLabelController,
            decoration: InputDecoration(labelText: 'URL Label'),
          ),
          TextField(
            // 15
            controller: uriValueController,
            decoration: InputDecoration(labelText: 'URL Value'),
          ),
          TextField(
            // 16
            controller: nearbyLabelController,
            decoration: InputDecoration(labelText: 'Nearby Location Label'),
          ),
          TextField(
            // 16
            controller: nearbyValueController,
            decoration: InputDecoration(labelText: 'Nearby Location Value'),
          ),
          TextField(
            // 17
            controller: webSiteLabelController,
            decoration: InputDecoration(labelText: 'Website Label'),
          ),
          TextField(
            // 17
            controller: webSiteValueController,
            decoration: InputDecoration(labelText: 'Website Value'),
          ),
          TextField(
            // 18
            controller: hotlineLabelController,
            decoration: InputDecoration(labelText: 'Hotline Label'),
          ),
          TextField(
            // 18
            controller: hotlineValueController,
            decoration: InputDecoration(labelText: 'Hotline Value'),
          ),
          TextField(
            controller: latitudeController,
            decoration: InputDecoration(labelText: 'latitude'),
          ),
          TextField(
            controller: longitudeController,
            decoration: InputDecoration(labelText: 'longitude'),
          ),
          DropdownButton<String>(
            hint: Text('Status'),
            value: status,
            onChanged: (String newValue) {
              setState(() {
                status = newValue;
              });
            },
            items: <String>['ACTIVE', 'COMPLETED', 'EXPIRED', 'INACTIVE']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ListTile(
            subtitle: Text('Start Date'),
            title: Text(startDate?.toIso8601String() ?? ''),
            onTap: () async {
              startDate = await showDatePicker(
                context: context,
                initialDate: startDate ?? DateTime.now(),
                firstDate: DateTime.utc(2000),
                lastDate: DateTime.utc(2050),
              );
              setState(() {});
            },
          ),
          ListTile(
            subtitle: Text('End Date'),
            title: Text(endDate?.toIso8601String() ?? ''),
            onTap: () async {
              endDate = await showDatePicker(
                context: context,
                initialDate: endDate ?? DateTime.now(),
                firstDate: DateTime.utc(2000),
                lastDate: DateTime.utc(2050),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 32),
          MaterialButton(
            child: Text('Save Card'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PassActionPage(
                    passObject: getPassObject(),
                    environment: widget.environment,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  PassObject getPassObject() {
    return PassObject(
      serialNumber: serialNumberController.text,
      passStyleIdentifier: passStyleIdController.text,
      passTypeIdentifier: passTypeIdController.text,
      organizationPassId: cardNumberController.text,
      currencyCode: currencyCodeController.text,
      status: PassStatus(
        state: status.toLowerCase(),
        effectTime: '${startDate?.toIso8601String()}Z',
        expireTime: '${endDate?.toIso8601String()}Z',
      ),
      relatedPassIds: [
        RelatedPassInfo(
          id: relatedIdController.text,
          typeId: relatedValueController.text,
        ),
      ],
      locationList: [
        Location(
          latitude: latitudeController.text,
          longitude: longitudeController.text,
        )
      ],
      barCode: BarCode(
        type: BarCode.barcodeTypeQrCode,
        text: barTextController.text,
        value: barValController.text,
      ),
      appendFields: [
        AppendField(
          key: WalletPassConstant.passCommonFieldKeyBalance,
          label: 'Label',
          value: balanceController.text,
        ),
        AppendField(
          key: WalletPassConstant.passAppendFieldKeyPoints,
          label: 'Points',
          value: pointsController.text,
        ),
        AppendField(
          key: WalletPassConstant.passAppendFieldKeyRewardsLevel,
          label: 'Tier',
          value: tierLevelController.text,
        ),
        AppendField(
          key: WalletPassConstant.passAppendFieldKeyNearbyLocations,
          label: nearbyLabelController.text,
          value: nearbyValueController.text,
        ),
        AppendField(
          key: WalletPassConstant.passAppendFieldKeyMainpage,
          label: webSiteLabelController.text,
          value: webSiteValueController.text,
        ),
        AppendField(
          key: WalletPassConstant.passAppendFieldKeyHotline,
          label: hotlineLabelController.text,
          value: hotlineValueController.text,
        ),
      ],
      commonFields: [
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyBackgroundImg,
          label: 'backgroundImageLable',
          value: cardPictureController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyLogo,
          label: 'cardLogoLable',
          value: cardLogoController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyMerchantName,
          label: 'merchantNameLable',
          value: merchantNameController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyName,
          label: 'cardNameLable',
          value: cardNameController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyCardNumber,
          label: 'cardNumberLable',
          value: cardNumberController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyMemberName,
          label: 'memberNumberLable',
          value: memberNameController.text,
        ),
      ],
      messageList: [
        AppendField(
          key: '1',
          label: messageHeaderController.text,
          value: messageInfoController.text,
        ),
      ],
      imageList: [
        AppendField(
          key: '1',
          label: bannerURIDescController.text,
          value: bannerURIController.text,
        ),
      ],
      urlList: [
        AppendField(
          key: '1',
          label: uriLabelController.text,
          value: uriValueController.text,
        ),
      ],
    );
  }
}
