/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:async';

import 'package:flutter/services.dart';

class HMSAnalytics {
  static const MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.analytics');

  /// Enables the log function.
  ///  [note] This function is specifically used by Android Platforms.
  Future<void> enableLog() async {
    await _channel.invokeMethod('enableLog', {});
  }

  /// Enables the debug log function and sets the minimum log level.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> enableLogWithLevel(String logLevel) async {
    if (logLevel == null) {
      throw ArgumentError.notNull("loglevel");
    }

    if (!(logLevel == "DEBUG" ||
        logLevel == "INFO" ||
        logLevel == "WARN" ||
        logLevel == "ERROR")) {
      throw ArgumentError.value(
          logLevel, "logLevel", "Possible options [DEBUG, INFO, WARN, ERROR]");
    }

    await _channel.invokeMethod('enableLogWithLevel', {'logLevel': logLevel});
  }

  /// Set a user ID.
  ///  [important] : When the setUserId API is called, if the old userId is not
  /// empty and is different from the new userId, a new session is generated.
  /// If you do not want to use setUserId to identify a user
  /// (for example, when a user signs out), set userId to **null**.
  Future<void> setUserId(String userId) async {
    if (userId == null) {
      throw ArgumentError.notNull("userId");
    }
    await _channel.invokeMethod('setUserId', {'userId': userId});
  }

  /// User attribute values remain unchanged throughout the app's lifecycle and session.
  /// A maximum of 25 user attribute names are supported.
  /// If an attribute name is duplicate with an existing one, the attribute names needs to be changed.
  Future<void> setUserProfile(String key, String value) async {
    if (key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }
    dynamic params = {'key': key, 'value': value};
    await _channel.invokeMethod('setUserProfile', params);
  }

  /// Sets the push token, which is obtained using the Push Kit.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> setPushToken(String token) async {
    if (token == null) {
      throw ArgumentError.notNull("token");
    }
    await _channel.invokeMethod('setPushToken', {'': token});
  }

  /// Sets the minimum interval for starting a new session.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> setMinActivitySessions(int interval) async {
    if (interval == null) {
      throw ArgumentError.notNull("interval");
    }
    await _channel
        .invokeMethod('setMinActivitySessions', {'interval': interval});
  }

  /// Sets the session timeout interval.
  Future<void> setSessionDuration(int duration) async {
    if (duration == null) {
      throw ArgumentError.notNull("duration");
    }
    await _channel.invokeMethod('setSessionDuration', {'duration': duration});
  }

  /// Report custom events.
  Future<void> onEvent(String key, Map<String, dynamic> value) async {
    if (key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }

    dynamic params = {
      'key': key,
      'value': value,
    };
    await _channel.invokeMethod('onEvent', params);
  }

  /// Delete all collected data in the local cache, including the cached data that fails to be sent.
  Future<void> clearCachedData() async {
    await _channel.invokeMethod('clearCachedData', {});
  }

  /// Specifies whether to enable event collection.
  Future<void> setAnalyticsEnabled(bool enabled) async {
    if (enabled == null) {
      throw ArgumentError.notNull("enabled");
    }
    await _channel.invokeMethod('setAnalyticsEnabled', {'enabled': enabled});
  }

  /// Obtains the app instance ID from AppGallery Connect.
  Future<String> getAAID() async {
    return await _channel.invokeMethod('getAAID', {});
  }

  /// Enables AB Testing. Predefined or custom user attributes are supported.
  Future<Map<String, dynamic>> getUserProfiles(bool predefined) async {
    if (predefined == null) {
      throw ArgumentError.notNull("predefined");
    }
    Map<dynamic, dynamic> profiles = await _channel
        .invokeMethod('getUserProfiles', {'predefined': predefined});
    return Map<String, dynamic>.from(profiles);
  }

  /// Defines a custom page entry event.
  ///  [note] This function is specifically used by Android Platforms.
  Future<void> pageStart(String pageName, String pageClassOverride) async {
    if (pageName == null || pageClassOverride == null) {
      throw ArgumentError.notNull("pageName | pageClassOverride");
    }
    dynamic params = {
      'pageName': pageName,
      'pageClassOverride': pageClassOverride,
    };
    await _channel.invokeMethod('pageStart', params);
  }

  /// Defines a custom page exit event.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> pageEnd(String pageName) async {
    if (pageName == null) {
      throw ArgumentError.notNull("pageName");
    }
    await _channel.invokeMethod('pageEnd', {'pageName': pageName});
  }

  /// Sets data reporting policies.
  /// [note] This function is specifically used by IOS Platforms.
  Future<void> setReportPolicies(
      {int scheduledTime,
      bool appLaunch,
      bool moveBackground,
      int cacheThreshold}) async {
    Map<String, dynamic> policyMap = new Map();

    if (scheduledTime != null) {
      if (scheduledTime >= 60 && scheduledTime <= 1800)
        policyMap['scheduledTime'] = scheduledTime;
      else
        throw ("Invalid value provided for scheduledTime. Accepted value range: [60 - 1800]");
    }

    if (cacheThreshold != null) {
      if (scheduledTime >= 30 && scheduledTime <= 1000)
        policyMap['cacheThreshold'] = cacheThreshold;
      else
        throw ("Invalid value provided for cacheThreshold. Accepted value range: [30 - 1000]");
    }

    if (appLaunch != null) {
      policyMap['appLaunch'] = appLaunch;
    }

    if (moveBackground != null) {
      policyMap['moveBackground'] = moveBackground;
    }

    await _channel.invokeMethod('setReportPolicies', {'policyType': policyMap});
  }

  /// Enables the HMSLogger capability.
  Future<void> enableLogger() async {
    await _channel.invokeMethod('enableLogger', {});
  }

  ///Disables the HMSLogger capability.
  Future<void> disableLogger() async {
    await _channel.invokeMethod('disableLogger', {});
  }
}

// Huawei Analytics Event Types
class HAEventType {
  static const String CREATEPAYMENTINFO = "\$CreatePaymentInfo";
  static const String ADDPRODUCT2CART = "\$AddProduct2Cart";
  static const String ADDPRODUCT2WISHLIST = "\$AddProduct2WishList";
  static const String STARTAPP = "\$StartApp";
  static const String STARTCHECKOUT = "\$StartCheckout";
  static const String VIEWCAMPAIGN = "\$ViewCampaign";
  static const String VIEWCHECKOUTSTEP = "\$ViewCheckoutStep";
  static const String WINVIRTUALCOIN = "\$WinVirtualCoin";
  static const String COMPLETEPURCHASE = "\$CompletePurchase";
  static const String OBTAINLEADS = "\$ObtainLeads";
  static const String JOINUSERGROUP = "\$JoinUserGroup";
  static const String COMPLETELEVEL = "\$CompleteLevel";
  static const String STARTLEVEL = "\$StartLevel";
  static const String UPGRADELEVEL = "\$UpgradeLevel";
  static const String SIGNIN = "\$SignIn";
  static const String SIGNOUT = "\$SignOut";
  static const String SUBMITSCORE = "\$SubmitScore";
  static const String CREATEORDER = "\$CreateOrder";
  static const String REFUNDORDER = "\$RefundOrder";
  static const String DELPRODUCTFROMCART = "\$DelProductFromCart";
  static const String SEARCH = "\$Search";
  static const String VIEWCONTENT = "\$ViewContent";
  static const String UPDATECHECKOUTOPTION = "\$UpdateCheckoutOption";
  static const String SHARECONTENT = "\$ShareContent";
  static const String REGISTERACCOUNT = "\$RegisterAccount";
  static const String CONSUMEVIRTUALCOIN = "\$ConsumeVirtualCoin";
  static const String STARTTUTORIAL = "\$StartTutorial";
  static const String COMPLETETUTORIAL = "\$CompleteTutorial";
  static const String OBTAINACHIEVEMENT = "\$ObtainAchievement";
  static const String VIEWPRODUCT = "\$ViewProduct";
  static const String VIEWPRODUCTLIST = "\$ViewProductList";
  static const String VIEWSEARCHRESULT = "\$ViewSearchResult";
  static const String UPDATEMEMBERSHIPLEVEL = "\$UpdateMembershipLevel";
  static const String FILTRATEPRODUCT = "\$FiltrateProduct";
  static const String VIEWCATEGORY = "\$ViewCategory";
  static const String UPDATEORDER = "\$UpdateOrder";
  static const String CANCELORDER = "\$CancelOrder";
  static const String COMPLETEORDER = "\$CompleteOrder";
  static const String CANCELCHECKOUT = "\$CancelCheckout";
  static const String OBTAINVOUCHER = "\$ObtainVoucher";
  static const String CONTACTCUSTOMSERVICE = "\$ContactCustomService";
  static const String RATE = "\$Rate";
  static const String INVITE = "\$Invite";
}

// Huawei Analytics Parameter Types
class HAParamType {
  static const String ACHIEVEMENTID = "\$AchievementId";
  static const String STORENAME = "\$StoreName";
  static const String ROLENAME = "\$RoleName";
  static const String OPTION = "\$Option";
  static const String STEP = "\$Step";
  static const String CONTENTTYPE = "\$ContentType";
  static const String VOUCHER = "\$Voucher";
  static const String CURRNAME = "\$CurrName";
  static const String DESTINATION = "\$Destination";
  static const String ENDDATE = "\$EndDate";
  static const String FLIGHTNO = "\$FlightNo";
  static const String USERGROUPID = "\$UserGroupId";
  static const String POSITIONID = "\$PositionId";
  static const String BRAND = "\$Brand";
  static const String CATEGORY = "\$Category";
  static const String PRODUCTID = "\$ProductId";
  static const String PRODUCTLIST = "\$ProductList";
  static const String PRODUCTNAME = "\$ProductName";
  static const String PRODUCTFEATURE = "\$ProductFeature";
  static const String LEVELID = "\$LevelId";
  static const String LEVELNAME = "\$LevelName";
  static const String PLACE = "\$Place";
  static const String CHANNEL = "\$Channel";
  static const String BOOKINGDAYS = "\$BookingDays";
  static const String PASSENGERSNUMBER = "\$PassengersNumber";
  static const String BOOKINGROOMS = "\$BookingRooms";
  static const String ORIGINATINGPLACE = "\$OriginatingPlace";
  static const String PRICE = "\$Price";
  static const String QUANTITY = "\$Quantity";
  static const String SCORE = "\$Score";
  static const String SEARCHKEYWORDS = "\$SearchKeywords";
  static const String SHIPPING = "\$Shipping";
  static const String BEGINDATE = "\$BeginDate";
  static const String RESULT = "\$Result";
  static const String TAXFEE = "\$TaxFee";
  static const String KEYWORDS = "\$Keywords";
  static const String TRANSACTIONID = "\$TransactionId";
  static const String CLASS = "\$Class";
  static const String REVENUE = "\$Revenue";
  static const String VIRTUALCURRNAME = "\$VirtualCurrName";
  static const String CLICKID = "\$ClickId";
  static const String PROMOTIONNAME = "\$PromotionName";
  static const String CONTENT = "\$Content";
  static const String EXTENDPARAM = "\$ExtendParam";
  static const String MATERIALNAME = "\$MaterialName";
  static const String MATERIALSLOT = "\$MaterialSlot";
  static const String PLACEID = "\$PlaceId";
  static const String MEDIUM = "\$Medium";
  static const String SOURCE = "\$Source";
  static const String ACOUNTTYPE = "\$AcountType";
  static const String REGISTMETHOD = "\$RegistMeth";
  static const String OCCURREDTIME = "\$OccurredTime";
  static const String EVTRESULT = "\$EvtResult";
  static const String PREVLEVEL = "\$PrevLevel";
  static const String CURRVLEVEL = "\$CurrvLevel";
  static const String REASON = "\$Reason";
  static const String VOUCHERS = "\$Vouchers";
  static const String MATERIALSLOTTYPE = "\$MaterialSlotType";
  static const String LISTID = "\$ListId";
  static const String FILTERS = "\$Filters";
  static const String SORTS = "\$Sorts";
  static const String ORDERID = "\$OrderId ";
  static const String PAYTYPE = "\$PayType";
  static const String EXPIREDATE = "\$ExpireDate";
  static const String VOUCHERTYPE = "\$VoucherType";
  static const String SERVICETYPE = "\$ServiceType";
  static const String DETAILS = "\$Details";
  static const String COMMENTTYPE = "\$CommentType";
}
