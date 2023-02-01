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
import 'package:huawei_wallet/huawei_wallet.dart';

import 'package:huawei_wallet_example/constants.dart';
import 'package:huawei_wallet_example/utils.dart';
import 'package:huawei_wallet_example/pages/pass_action_page.dart';

class LoyaltyCardPage extends StatefulWidget {
  const LoyaltyCardPage({
    required this.environment,
    Key? key,
  }) : super(key: key);

  final int environment;

  @override
  State<LoyaltyCardPage> createState() => _LoyaltyCardPageState();
}

class _LoyaltyCardPageState extends State<LoyaltyCardPage> {
  String status = 'ACTIVE';
  DateTime? startDate = DateTime(2020, 6, 12);
  DateTime? endDate = DateTime(2023, 6, 12);

  final TextEditingController serialNumberController =
      TextEditingController.fromValue(
    TextEditingValue(
      text: Utils.getRandomNumber(12),
    ),
  );
  final TextEditingController passStyleIdController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: Constants.passStyleIdLoyalty,
    ),
  );
  final TextEditingController passTypeIdController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: Constants.passTypeIdLoyalty,
    ),
  );
  final TextEditingController cardPictureController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/AccessCard/cloudRes/img_access_edit_personalise_big6.jpg',
    ),
  );
  final TextEditingController cardLogoController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/Wallet-WalletKit/picres/cloudRes/card_loyalty_logo.png',
    ),
  );
  final TextEditingController merchantNameController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'carrefour vip',
    ),
  );
  final TextEditingController cardNameController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'carrefour',
    ),
  );
  final TextEditingController cardNumberController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '0',
    ),
  );
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController balanceController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '199',
    ),
  );
  final TextEditingController currencyCodeController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'C',
    ),
  );
  final TextEditingController relatedIdController = TextEditingController();
  final TextEditingController relatedValueController = TextEditingController();
  final TextEditingController barValController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '1234567890',
    ),
  );
  final TextEditingController barTextController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '123456789123456',
    ),
  );
  final TextEditingController memberNameController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'tester',
    ),
  );
  final TextEditingController tierLevelController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'tier-level-0',
    ),
  );
  TextEditingController messageHeaderController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Message',
    ),
  );
  TextEditingController messageInfoController = TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Welcome to use loyalty card.',
    ),
  );
  TextEditingController bannerURIController = TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/HiWallet/cloudRes/ic_empty_idcard.png',
    ),
  );
  TextEditingController bannerURIDescController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Rotation Chart',
    ),
  );
  final TextEditingController uriLabelController = TextEditingController();
  final TextEditingController uriValueController = TextEditingController();
  final TextEditingController nearbyLabelController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Nearby Location',
    ),
  );
  final TextEditingController nearbyValueController = TextEditingController();
  final TextEditingController webSiteLabelController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Website',
    ),
  );
  final TextEditingController webSiteValueController = TextEditingController();
  final TextEditingController hotlineLabelController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Customer Service',
    ),
  );
  final TextEditingController hotlineValueController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '4008205566',
    ),
  );
  final TextEditingController latitudeController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '89',
    ),
  );
  final TextEditingController longitudeController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '114',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Loyalty Card'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: serialNumberController,
            decoration: const InputDecoration(
              labelText: 'Serial Number',
            ),
          ),
          TextField(
            controller: passStyleIdController,
            decoration: const InputDecoration(
              labelText: 'Template - Style Id',
            ),
          ),
          TextField(
            controller: passTypeIdController,
            decoration: const InputDecoration(
              labelText: 'Pass Type',
            ),
          ),
          TextField(
            // 1
            controller: cardPictureController,
            decoration: const InputDecoration(
              labelText: 'Card Picture Uri',
            ),
          ),
          TextField(
            // 2
            controller: cardLogoController,
            decoration: const InputDecoration(
              labelText: 'Logo Uri',
            ),
          ),
          TextField(
            // 3
            controller: merchantNameController,
            decoration: const InputDecoration(
              labelText: 'Merchant Name',
            ),
          ),
          TextField(
            // 4
            controller: cardNameController,
            decoration: const InputDecoration(
              labelText: 'Card Name',
            ),
          ),
          TextField(
            // 5
            controller: cardNumberController,
            decoration: const InputDecoration(
              labelText: 'Card Number',
            ),
          ),
          TextField(
            // 6
            controller: balanceController,
            decoration: const InputDecoration(
              labelText: 'Balance',
            ),
          ),
          TextField(
            // 6
            controller: currencyCodeController,
            decoration: const InputDecoration(
              labelText: 'Currency Code',
            ),
          ),
          TextField(
            // 7
            controller: relatedIdController,
            decoration: const InputDecoration(
              labelText: 'Related Card Id',
            ),
          ),
          TextField(
            // 7
            controller: relatedValueController,
            decoration: const InputDecoration(
              labelText: 'Related Card Type',
            ),
          ),
          TextField(
            // 8
            controller: pointsController,
            decoration: const InputDecoration(
              labelText: 'Points',
            ),
          ),
          TextField(
            // 10
            controller: barValController,
            decoration: const InputDecoration(
              labelText: 'Barcode Value',
            ),
          ),
          TextField(
            // 10
            controller: barTextController,
            decoration: const InputDecoration(
              labelText: 'Barcode Text',
            ),
          ),
          TextField(
            // 11
            controller: memberNameController,
            decoration: const InputDecoration(
              labelText: 'Member Name',
            ),
          ),
          TextField(
            // 13
            controller: tierLevelController,
            decoration: const InputDecoration(
              labelText: 'Tier',
            ),
          ),
          TextField(
            // 14
            controller: messageHeaderController,
            decoration: const InputDecoration(
              labelText: 'Message Header',
            ),
          ),
          TextField(
            // 14
            controller: messageInfoController,
            decoration: const InputDecoration(
              labelText: 'Message Info',
            ),
          ),
          TextField(
            // 15
            controller: bannerURIController,
            decoration: const InputDecoration(
              labelText: 'Banner URI',
            ),
          ),
          TextField(
            // 15
            controller: bannerURIDescController,
            decoration: const InputDecoration(
              labelText: 'Banner URI Description',
            ),
          ),
          TextField(
            // 15
            controller: uriLabelController,
            decoration: const InputDecoration(
              labelText: 'URL Label',
            ),
          ),
          TextField(
            // 15
            controller: uriValueController,
            decoration: const InputDecoration(
              labelText: 'URL Value',
            ),
          ),
          TextField(
            // 16
            controller: nearbyLabelController,
            decoration: const InputDecoration(
              labelText: 'Nearby Location Label',
            ),
          ),
          TextField(
            // 16
            controller: nearbyValueController,
            decoration: const InputDecoration(
              labelText: 'Nearby Location Value',
            ),
          ),
          TextField(
            // 17
            controller: webSiteLabelController,
            decoration: const InputDecoration(
              labelText: 'Website Label',
            ),
          ),
          TextField(
            // 17
            controller: webSiteValueController,
            decoration: const InputDecoration(
              labelText: 'Website Value',
            ),
          ),
          TextField(
            // 18
            controller: hotlineLabelController,
            decoration: const InputDecoration(
              labelText: 'Hotline Label',
            ),
          ),
          TextField(
            // 18
            controller: hotlineValueController,
            decoration: const InputDecoration(
              labelText: 'Hotline Value',
            ),
          ),
          TextField(
            controller: latitudeController,
            decoration: const InputDecoration(
              labelText: 'latitude',
            ),
          ),
          TextField(
            controller: longitudeController,
            decoration: const InputDecoration(
              labelText: 'longitude',
            ),
          ),
          DropdownButton<String>(
            hint: const Text('Status'),
            value: status,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  status = newValue;
                });
              }
            },
            items: <String>[
              'ACTIVE',
              'COMPLETED',
              'EXPIRED',
              'INACTIVE',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ListTile(
            subtitle: const Text('Start Date'),
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
            subtitle: const Text('End Date'),
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
            child: const Text('Save Card'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (_) {
                    return PassActionPage(
                      passObject: getPassObject(),
                      environment: widget.environment,
                    );
                  },
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
      relatedPassIds: <RelatedPassInfo>[
        RelatedPassInfo(
          id: relatedIdController.text,
          typeId: relatedValueController.text,
        ),
      ],
      locationList: <Location>[
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
      appendFields: <AppendField>[
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
      commonFields: <CommonField>[
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
      messageList: <AppendField>[
        AppendField(
          key: '1',
          label: messageHeaderController.text,
          value: messageInfoController.text,
        ),
      ],
      imageList: <AppendField>[
        AppendField(
          key: '1',
          label: bannerURIDescController.text,
          value: bannerURIController.text,
        ),
      ],
      urlList: <AppendField>[
        AppendField(
          key: '1',
          label: uriLabelController.text,
          value: uriValueController.text,
        ),
      ],
    );
  }
}
