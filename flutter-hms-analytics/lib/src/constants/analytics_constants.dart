/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class ReportPolicyType {
  static const String ON_SCHEDULED_TIME_POLICY = "ON_SCHEDULED_TIME_POLICY";
  static const String ON_APP_LAUNCH_POLICY = "ON_APP_LAUNCH_POLICY";
  static const String ON_MOVE_BACKGROUND_POLICY = "ON_MOVE_BACKGROUND_POLICY";
  static const String ON_CACHE_THRESHOLD_POLICY = "ON_CACHE_THRESHOLD_POLICY";
}

class HAUserProfileType {
  static const USERLEVEL = "user_level";
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
  static const String NOVICEGUIDESTART = "\$NoviceGuideStart";
  static const String NOVICEGUIDEEND = "\$NoviceGuideEnd";
  static const String STARTGAME = "\$StartGame";
  static const String ENDGAME = "\$EndGame";
  static const String WINPROPS = "\$WinProps";
  static const String CONSUMEPROPS = "\$ConsumeProps";
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
  static const String DURATION = "\$Duration";
  static const String LEVEL = "\$Level";
  static const String PURCHASEENTRY = "\$PurchaseEntry";
  static const String PROPS = "\$Props";
  static const String ENTRY = "\$Entry";
}
