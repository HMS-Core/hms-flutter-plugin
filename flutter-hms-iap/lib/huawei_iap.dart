/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

library huawei_iap;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'src/HmsIapResult.dart';
part 'src/IapClient.dart';
part 'src/model/ConsumeOwnedPurchaseReq.dart';
part 'src/model/ConsumeOwnedPurchaseResult.dart';
part 'src/model/ConsumePurchaseData.dart';
part 'src/model/InAppPurchaseData.dart';
part 'src/model/IsEnvReadyResult.dart';
part 'src/model/IsSandboxActivatedResult.dart';
part 'src/model/OwnedPurchasesReq.dart';
part 'src/model/OwnedPurchasesResult.dart';
part 'src/model/ProductInfo.dart';
part 'src/model/ProductInfoReq.dart';
part 'src/model/ProductInfoResult.dart';
part 'src/model/PurchaseIntentReq.dart';
part 'src/model/PurchaseResultInfo.dart';
part 'src/model/SignAlgorithmConstants.dart';
part 'src/model/StartIapActivityReq.dart';
part 'src/model/Status.dart';
part 'src/model/BaseReq.dart';
