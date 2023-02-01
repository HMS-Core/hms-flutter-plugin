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

class CouponCardPage extends StatefulWidget {
  const CouponCardPage({
    required this.environment,
    Key? key,
  }) : super(key: key);

  final int environment;

  @override
  State<CouponCardPage> createState() => _CouponCardPageState();
}

class _CouponCardPageState extends State<CouponCardPage> {
  String status = 'ACTIVE';
  DateTime? lastBalanceDate = DateTime(2021, 1, 1);
  DateTime? startDate = DateTime(2020, 1, 12);
  DateTime? endDate = DateTime(2023, 6, 12);

  TextEditingController passTypeIdController = TextEditingController.fromValue(
    const TextEditingValue(
      text: Constants.passTypeIdCoupon,
    ),
  );
  TextEditingController passStyleIdController = TextEditingController.fromValue(
    const TextEditingValue(
      text: Constants.passStyleIdCoupon,
    ),
  );
  TextEditingController serialNumberController =
      TextEditingController.fromValue(
    TextEditingValue(
      text: Utils.getRandomNumber(12),
    ),
  );
  TextEditingController cardLogoController = TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/Wallet-WalletKit/picres/cloudRes/coupon_logo.png',
    ),
  );
  TextEditingController merchantNameController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Merchant Name',
    ),
  );
  TextEditingController cardNameController = TextEditingController.fromValue(
    const TextEditingValue(
      text: 'Coupon Name',
    ),
  );
  TextEditingController cardNumberController = TextEditingController.fromValue(
    TextEditingValue(
      text: Utils.getRandomNumber(6),
    ),
  );
  TextEditingController backgroundColorController =
      TextEditingController.fromValue(
    const TextEditingValue(
      text: '#FF483D8B',
    ),
  );
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
      text: 'Welcome to use Coupon Card.',
    ),
  );
  TextEditingController bannerURIController = TextEditingController.fromValue(
    const TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/HiWallet/cloudRes/ic_empty_traffic.png',
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
            // 8
            controller: backgroundColorController,
            decoration: const InputDecoration(
              labelText: 'Hex Background Color for Coupon',
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
      status: PassStatus(
        state: status.toLowerCase(),
        effectTime: '${startDate?.toIso8601String()}Z',
        expireTime: '${endDate?.toIso8601String()}Z',
      ),
      barCode: BarCode(
        type: BarCode.barcodeTypeQrCode,
        text: barTextController.text,
        value: barValController.text,
      ),
      commonFields: <CommonField>[
        CommonField(
          key: WalletPassConstant.passAppendFieldKeyBackgroundColor,
          label: 'backgroundColorLable',
          value: backgroundColorController.text,
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
