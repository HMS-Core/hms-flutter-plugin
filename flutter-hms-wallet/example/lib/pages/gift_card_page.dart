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

class GiftCardPage extends StatefulWidget {
  const GiftCardPage({
    required this.environment,
    Key? key,
  }) : super(key: key);

  final int environment;

  @override
  State<GiftCardPage> createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  String status = 'ACTIVE';
  DateTime? lastBalanceDate = DateTime(2021, 1, 1);
  DateTime? startDate = DateTime(2020, 1, 12);
  DateTime? endDate = DateTime(2023, 6, 12);

  TextEditingController passTypeIdController = TextEditingController.fromValue(
    const TextEditingValue(
      text: Constants.passTypeIdGift,
    ),
  );
  TextEditingController passStyleIdController = TextEditingController.fromValue(
    const TextEditingValue(
      text: Constants.passStyleIdGift,
    ),
  );
  TextEditingController serialNumberController =
      TextEditingController.fromValue(
    TextEditingValue(
      text: Utils.getRandomNumber(12),
    ),
  );

  TextEditingController backgroundPictureController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/AccessCard/cloudRes/img_access_edit_personalise_big3.jpg',
    ),
  );
  TextEditingController cardLogoController = TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/Wallet-WalletKit/picres/cloudRes/card_gift_logo.png',
    ),
  );
  TextEditingController merchantNameController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'carrefour vip',
    ),
  );
  TextEditingController cardNameController = TextEditingController.fromValue(
    const TextEditingValue(
      text: 'carrefour',
    ),
  );
  TextEditingController cardNumberController = TextEditingController.fromValue(
    TextEditingValue(text: Utils.getRandomNumber(6)),
  );
  TextEditingController pinController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '1234',
    ),
  );
  TextEditingController balanceController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '1234',
    ),
  );
  TextEditingController currencyCodeController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'TL',
    ),
  );
  TextEditingController relatedIdController = TextEditingController();
  TextEditingController relatedValueController = TextEditingController();
  TextEditingController barValController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '1234567890',
    ),
  );
  TextEditingController barTextController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '123456789123456',
    ),
  );
  TextEditingController eventNumberController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '0',
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
      text: 'Welcome to use gift card.',
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
  TextEditingController uriLabelController = TextEditingController();
  TextEditingController uriValueController = TextEditingController();
  TextEditingController nearbyLabelController = TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Nearby Location',
    ),
  );
  TextEditingController nearbyValueController = TextEditingController();
  TextEditingController webSiteLabelController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Website',
    ),
  );
  TextEditingController webSiteValueController = TextEditingController();
  TextEditingController hotlineLabelController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Customer Service',
    ),
  );
  TextEditingController hotlineValueController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '4008205566',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gift Card'),
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
            controller: backgroundPictureController,
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
              labelText: 'Gift Card Number',
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
            // 8
            controller: pinController,
            decoration: const InputDecoration(
              labelText: 'Pin',
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
            // 13
            controller: eventNumberController,
            decoration: const InputDecoration(
              labelText: 'Evenet Number',
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
            subtitle: const Text('Last Balance Update Date'),
            title: Text(lastBalanceDate?.toIso8601String() ?? ''),
            onTap: () async {
              lastBalanceDate = await showDatePicker(
                context: context,
                initialDate: lastBalanceDate ?? DateTime.now(),
                firstDate: DateTime.utc(2000),
                lastDate: DateTime.utc(2050),
              );
              setState(() {});
            },
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
      relatedPassIds: <RelatedPassInfo>[
        RelatedPassInfo(
          id: relatedIdController.text,
          typeId: relatedValueController.text,
        ),
      ],
      barCode: BarCode(
        type: BarCode.barcodeTypeCodabar,
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
          value: backgroundPictureController.text,
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
