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

part of huawei_analytics;

class ReportPolicyType {
  static const String ON_SCHEDULED_TIME_POLICY = 'ON_SCHEDULED_TIME_POLICY';

  static const String ON_APP_LAUNCH_POLICY = 'ON_APP_LAUNCH_POLICY';

  static const String ON_MOVE_BACKGROUND_POLICY = 'ON_MOVE_BACKGROUND_POLICY';

  static const String ON_CACHE_THRESHOLD_POLICY = 'ON_CACHE_THRESHOLD_POLICY';
}

class HAUserProfileType {
  static const String USERLEVEL = 'user_level';

  static const String ISFULLLEVEL = 'is_full_level';

  static const String ISMEMBER = 'is_member';
}

// Huawei Analytics Event Types
class HAEventType {
  static const String CREATEPAYMENTINFO = '\$CreatePaymentInfo';

  static const String ADDPRODUCT2CART = '\$AddProduct2Cart';

  static const String ADDPRODUCT2WISHLIST = '\$AddProduct2WishList';

  static const String STARTAPP = '\$StartApp';

  static const String STARTCHECKOUT = '\$StartCheckout';

  static const String VIEWCAMPAIGN = '\$ViewCampaign';

  static const String VIEWCHECKOUTSTEP = '\$ViewCheckoutStep';

  static const String WINVIRTUALCOIN = '\$WinVirtualCoin';

  static const String COMPLETEPURCHASE = '\$CompletePurchase';

  static const String OBTAINLEADS = '\$ObtainLeads';

  static const String JOINUSERGROUP = '\$JoinUserGroup';

  static const String COMPLETELEVEL = '\$CompleteLevel';

  static const String STARTLEVEL = '\$StartLevel';

  static const String UPGRADELEVEL = '\$UpgradeLevel';

  static const String SIGNIN = '\$SignIn';

  static const String SIGNOUT = '\$SignOut';

  static const String SUBMITSCORE = '\$SubmitScore';

  static const String CREATEORDER = '\$CreateOrder';

  static const String REFUNDORDER = '\$RefundOrder';

  static const String DELPRODUCTFROMCART = '\$DelProductFromCart';

  static const String SEARCH = '\$Search';

  static const String VIEWCONTENT = '\$ViewContent';

  static const String UPDATECHECKOUTOPTION = '\$UpdateCheckoutOption';

  static const String SHARECONTENT = '\$ShareContent';

  static const String REGISTERACCOUNT = '\$RegisterAccount';

  static const String CONSUMEVIRTUALCOIN = '\$ConsumeVirtualCoin';

  static const String STARTTUTORIAL = '\$StartTutorial';

  static const String COMPLETETUTORIAL = '\$CompleteTutorial';

  static const String OBTAINACHIEVEMENT = '\$ObtainAchievement';

  static const String VIEWPRODUCT = '\$ViewProduct';

  static const String VIEWPRODUCTLIST = '\$ViewProductList';

  static const String VIEWSEARCHRESULT = '\$ViewSearchResult';

  static const String UPDATEMEMBERSHIPLEVEL = '\$UpdateMembershipLevel';

  static const String FILTRATEPRODUCT = '\$FiltrateProduct';

  static const String VIEWCATEGORY = '\$ViewCategory';

  static const String UPDATEORDER = '\$UpdateOrder';

  static const String CANCELORDER = '\$CancelOrder';

  static const String COMPLETEORDER = '\$CompleteOrder';

  static const String CANCELCHECKOUT = '\$CancelCheckout';

  static const String OBTAINVOUCHER = '\$ObtainVoucher';

  static const String CONTACTCUSTOMSERVICE = '\$ContactCustomService';

  static const String RATE = '\$Rate';

  static const String INVITE = '\$Invite';

  static const String NOVICEGUIDESTART = '\$NoviceGuideStart';

  static const String NOVICEGUIDEEND = '\$NoviceGuideEnd';

  static const String STARTGAME = '\$StartGame';

  static const String ENDGAME = '\$EndGame';

  static const String WINPROPS = '\$WinProps';

  static const String CONSUMEPROPS = '\$ConsumeProps';

  static const String ADDFRIEND = '\$AddFriend';

  static const String ADDBLACKLIST = '\$AddBlacklist';

  static const String VIEWFRIENDLIST = '\$ViewFriendList';

  static const String QUITUSERGROUP = '\$QuitUserGroup';

  static const String CREATEUSERGROUP = '\$CreateUserGroup';

  static const String DISBANDUSERGROUP = '\$DisbandUserGroup';

  static const String UPGRADEUSERGROUP = '\$UpgradeUserGroup';

  static const String VIEWUSERGROUP = '\$ViewUserGroup';

  static const String JOINTEAM = '\$JoinTeam';

  static const String SENDMESSAGE = '\$SendMessage';

  static const String LEARNSKILL = '\$LearnSkill';

  static const String USESKILL = '\$UseSkill';

  static const String GETEQUIPMENT = '\$GetEquipment';

  static const String LOSEEQUIPMENT = '\$LoseEquipment';

  static const String ENHANCEEQUIPMENT = '\$EnhanceEquipment';

  static const String SWITCHCLASS = '\$SwitchClass';

  static const String ACCEPTTASK = '\$AcceptTask';

  static const String FINISHTASK = '\$FinishTask';

  static const String ATTENDACTIVITY = '\$AttendActivity';

  static const String FINISHCUTSCENE = '\$FinishCutscene';

  static const String SKIPCUTSCENE = '\$SkipCutscene';

  static const String GETPET = '\$GetPet';

  static const String LOSEPET = '\$LosePet';

  static const String ENHANCEPET = '\$EnhancePet';

  static const String GETMOUNT = '\$GetMount';

  static const String LOSEMOUNT = '\$LoseMount';

  static const String ENHANCEMOUNT = '\$EnhanceMount';

  static const String CREATEROLE = '\$CreateRole';

  static const String SIGNINROLE = '\$SignInRole';

  static const String SIGNOUTROLE = '\$SignOutRole';

  static const String STARTBATTLE = '\$StartBattle';

  static const String ENDBATTLE = '\$EndBattle';

  static const String STARTDUNGEON = '\$StartDungeon';

  static const String FINISHDUNGEON = '\$FinishDungeon';

  static const String VIEWPACKAGE = '\$ViewPackage';

  static const String REDEEM = '\$Redeem';

  static const String MODIFYSETTING = '\$ModifySetting';

  static const String WATCHVIDEO = '\$WatchVideo';

  static const String CLICKMESSAGE = '\$ClickMessage';

  static const String DRAWCARD = '\$DrawCard';

  static const String VIEWCARDLIST = '\$ViewCardList';

  static const String BINDACCOUNT = '\$BindAccount';

  static const String STARTEXERCISE = '\$StartExercise';

  static const String ENDEXERCISE = '\$EndExercise';

  static const String STARTPLAYMEDIA = '\$StartPlayMedia';

  static const String ENDPLAYMEDIA = '\$EndPlayMedia';

  static const String STARTEXAMINE = '\$StartExamine';

  static const String ENDEXAMINE = '\$EndExamine';

  static const String CHECKIN = '\$CheckIn';

  static const String COMPENSATION = '\$Compensation';

  static const String POST = '\$Post';

  static const String SHAREAPP = '\$ShareApp';

  static const String IMPROVEINFORMATION = '\$ImproveInformation';

  static const String VIEWHOUSELIST = '\$ViewHouseList';

  static const String VIEWHOUSEDETAIL = '\$ViewHouseDetail';

  static const String EXCHANGEGOODS = '\$ExchangeGoods';

  static const String BINDDEVICE = '\$BindDevice';

  static const String UNBINDDEVICE = '\$UnBindDevice';

  static const String RESERVEMAINTENANCE = '\$ReserveMaintenance';

  static const String DEVICEMISSINGREPORT = '\$DeviceMissingReport';

  static const String MODULARCLICK = '\$ModularClick';

  static const String PAGEVIEW = '\$PageView';

  static const String STARTBOOKING = '\$StartBooking';

  static const String LEARNTARGET = '\$LearnTarget';

  static const String LANGUAGETEST = '\$LanguageTest';

  static const String STARTTRAINING = '\$StartTraining';

  static const String ENDTRAINING = '\$EndTraining';

  static const String REGISTERACTIVITY = '\$RegisterActivity';

  static const String EXITACTIVITY = '\$ExitActivity';

  static const String COMPLETEACTIVITY = '\$CompleteActivity';

  static const String ENTERACCOUNTOPENING = '\$EnterAccountOpening';

  static const String SUBMITACCOUNTOPENING = '\$SubmitAccountOpening';

  static const String BANDCARD = '\$BandCard';

  static const String BANKTRANSFERIN = '\$BankTransferIn';

  static const String BANKTRANSFEROUT = '\$BankTransferOut';

  static const String VIEWSTOCKDETAIL = '\$ViewStockDetail';

  static const String TRADESTOCKS = '\$TradeStocks';

  static const String VIEWFINANCEPAGE = '\$ViewFinancePage';

  static const String PURCHASEFINANCE = '\$PurchaseFinance';

  static const String REDEMPTIONFINANCE = '\$RedemptionFinance';

  static const String FUNDTRADING = '\$FundTrading';

  static const String FIXEDINVESTMENT = '\$FixedInvestment';

  static const String APPLYNEW = '\$ApplyNew';

  static const String VIEWINFORMATIONSECTION = '\$ViewInformationSection';

  static const String VIEWINFORMATION = '\$ViewInformation';

  static const String DISPLAYVOUCHER = '\$DisplayVoucher';

  static const String BOOKCOURSE = '\$BookCourse';

  static const String LEARNCOURSES = '\$LearnCourses';

  static const String TRYOUT = '\$TryOut';

  static const String ANSWER = '\$Answer';

  static const String VIEWFUNDPAGE = '\$ViewFundPage';

  static const String CLICKPURCHASE = '\$ClickPurchase';

  static const String ENABLEMEMBER = '\$EnableMember';

  static const String CANCELMEMBER = '\$CancelMember';

  static const String COMMENTCONTENT = '\$CommentContent';

  static const String LIKECONTENT = '\$LikeContent';

  static const String DELETEPRODUCT2WISHLIST = '\$DeleteProduct2Wishlist';

  static const String ADCLICK = '\$AdClick';

  static const String ADDISPLAY = '\$AdDisplay';

  static const String REGISTERFAILED = '\$RegisterFailed';

  static const String VIPCLICK = '\$VIPClick';

  static const String VIPFAILED = '\$VIPFailed';

  static const String VIPSUC = '\$VIPSuc';
}

// Huawei Analytics Parameter Types
class HAParamType {
  static const String ACHIEVEMENTID = '\$AchievementId';

  static const String STORENAME = '\$StoreName';

  static const String ROLENAME = '\$RoleName';

  static const String OPTION = '\$Option';

  static const String STEP = '\$Step';

  static const String CONTENTTYPE = '\$ContentType';

  static const String VOUCHER = '\$Voucher';

  static const String CURRNAME = '\$CurrName';

  static const String DESTINATION = '\$Destination';

  static const String ENDDATE = '\$EndDate';

  static const String FLIGHTNO = '\$FlightNo';

  static const String USERGROUPID = '\$UserGroupId';

  static const String POSITIONID = '\$PositionId';

  static const String BRAND = '\$Brand';

  static const String CATEGORY = '\$Category';

  static const String PRODUCTID = '\$ProductId';

  static const String PRODUCTLIST = '\$ProductList';

  static const String PRODUCTNAME = '\$ProductName';

  static const String PRODUCTFEATURE = '\$ProductFeature';

  static const String LEVELID = '\$LevelId';

  static const String LEVELNAME = '\$LevelName';

  static const String PLACE = '\$Place';

  static const String CHANNEL = '\$Channel';

  static const String BOOKINGDAYS = '\$BookingDays';

  static const String PASSENGERSNUMBER = '\$PassengersNumber';

  static const String BOOKINGROOMS = '\$BookingRooms';

  static const String ORIGINATINGPLACE = '\$OriginatingPlace';

  static const String PRICE = '\$Price';

  static const String QUANTITY = '\$Quantity';

  static const String SCORE = '\$Score';

  static const String SEARCHKEYWORDS = '\$SearchKeywords';

  static const String SHIPPING = '\$Shipping';

  static const String BEGINDATE = '\$BeginDate';

  static const String RESULT = '\$Result';

  static const String TAXFEE = '\$TaxFee';

  static const String KEYWORDS = '\$Keywords';

  static const String TRANSACTIONID = '\$TransactionId';

  static const String CLASS = '\$Class';

  static const String REVENUE = '\$Revenue';

  static const String VIRTUALCURRNAME = '\$VirtualCurrName';

  static const String CLICKID = '\$ClickId';

  static const String PROMOTIONNAME = '\$PromotionName';

  static const String CONTENT = '\$Content';

  static const String EXTENDPARAM = '\$ExtendParam';

  static const String MATERIALNAME = '\$MaterialName';

  static const String MATERIALSLOT = '\$MaterialSlot';

  static const String PLACEID = '\$PlaceId';

  static const String MEDIUM = '\$Medium';

  static const String SOURCE = '\$Source';

  static const String ACOUNTTYPE = '\$AccountType';

  static const String REGISTMETHOD = '\$RegistMeth';

  static const String EVTRESULT = '\$EvtResult';

  static const String PREVLEVEL = '\$PrevLevel';

  static const String CURRVLEVEL = '\$CurrvLevel';

  static const String REASON = '\$Reason';

  static const String VOUCHERS = '\$Vouchers';

  static const String MATERIALSLOTTYPE = '\$MaterialSlotType';

  static const String LISTID = '\$ListId';

  static const String FILTERS = '\$Filters';

  static const String SORTS = '\$Sorts';

  static const String ORDERID = '\$OrderId ';

  static const String PAYTYPE = '\$PayType';

  static const String EXPIREDATE = '\$ExpireDate';

  static const String VOUCHERTYPE = '\$VoucherType';

  static const String SERVICETYPE = '\$ServiceType';

  static const String DETAILS = '\$Details';

  static const String COMMENTTYPE = '\$CommentType';

  static const String DURATION = '\$Duration';

  static const String LEVEL = '\$Level';

  static const String PURCHASEENTRY = '\$PurchaseEntry';

  static const String PROPS = '\$Props';

  static const String ENTRY = '\$Entry';

  static const String INVITER = '\$Inviter';

  static const String VIPLEVEL = '\$VIPLevel';

  static const String FIRSTSIGNIN = '\$FirstSignIn';

  static const String DISCOUNT = '\$Discount';

  static const String FIRSTPAY = '\$FirstPay';

  static const String TASKID = '\$TaskId';

  static const String FRIENDNUMBER = '\$FriendNumber';

  static const String USERGROUPNAME = '\$UserGroupName';

  static const String USERGROUPLEVEL = '\$UserGroupLevel';

  static const String MEMBERS = '\$Members';

  static const String LEVELBEFORE = '\$LevelBefore';

  static const String MESSAGETYPE = '\$MessageType';

  static const String ROLECOMBAT = '\$RoleCombat';

  static const String ISTOPLEVEL = '\$IsTopLevel';

  static const String ROLECLASS = '\$RoleClass';

  static const String SKILLNAME = '\$SkillName';

  static const String SKILLLEVEL = '\$SkillLevel';

  static const String SKILLLEVELBEFORE = '\$SkillLevelBefore';

  static const String EQUIPMENTID = '\$EquipmentId';

  static const String EQUIPMENTNAME = '\$EquipmentName';

  static const String EQUIPMENTLEVEL = '\$EquipmentLevel';

  static const String CLASSLIMIT = '\$ClassLimit';

  static const String LEVELLIMIT = '\$LevelLimit';

  static const String ISFREE = '\$IsFree';

  static const String TOTALAFTERCHANGE = '\$TotalAfterChange';

  static const String QUALITY = '\$Quality';

  static const String ENHANCETYPE = '\$EnhanceType';

  static const String NEWCLASS = '\$NewClass';

  static const String OLDCLASS = '\$OldClass';

  static const String TASKTYPE = '\$TaskType';

  static const String TASKNAME = '\$TaskName';

  static const String REWARD = '\$Reward';

  static const String ACTIVITYTYPE = '\$ActivityType';

  static const String ACTIVITYNAME = '\$ActivityName';

  static const String CUTSCENENAME = '\$CutsceneName';

  static const String PETID = '\$PetId';

  static const String PETDEFAULTNAME = '\$PetDefaultName';

  static const String PETLEVEL = '\$PetLevel';

  static const String MOUNTID = '\$MountId';

  static const String MOUNTDEFAULTNAME = '\$MountDefaultName';

  static const String MOUNTLEVEL = '\$MountLevel';

  static const String ROLEGENDER = '\$RoleGender';

  static const String SERVER = '\$Server';

  static const String FIRSTCREATE = '\$FirstCreate';

  static const String COMBAT = '\$Combat';

  static const String BATTLETYPE = '\$BattleType';

  static const String BATTLENAME = '\$BattleName';

  static const String NUMBEROFCARDS = '\$NumberOfCards';

  static const String CARDLIST = '\$CardList';

  static const String PARTICIPANTS = '\$Participants';

  static const String DIFFICULTY = '\$Difficulty';

  static const String MVP = '\$MVP';

  static const String DAMAGE = '\$Damage';

  static const String RANKING = '\$Ranking';

  static const String DUNGEONNAME = '\$DungeonName';

  static const String WINREASON = '\$WinReason';

  static const String BALANCE = '\$Balance';

  static const String PACKAGETYPE = '\$PackageType';

  static const String AMOUNT = '\$Amount';

  static const String ITEMLIST = '\$ItemList';

  static const String GIFTTYPE = '\$GiftType';

  static const String GIFTNAME = '\$GiftName';

  static const String TYPE = '\$Type';

  static const String OLDVALUE = '\$OldValue';

  static const String NEWVALUE = '\$NewValue';

  static const String VIDEOTYPE = '\$VideoType';

  static const String VIDEONAME = '\$VideoName';

  static const String MESSAGETITLE = '\$MessageTitle';

  static const String OPERATION = '\$Operation';

  static const String NUMBEROFDRAWING = '\$NumberOfDrawing';

  static const String LEFTPULLSFORGUARANTEE = '\$LeftPullsForGuarantee';

  static const String VIPTYPE = '\$VIPType';

  static const String VIPSTATUS = '\$VIPStatus';

  static const String VIPEXPIREDATE = '\$VIPExpireDate';

  static const String ENTER = '\$Enter';

  static const String STARTDATE = '\$StartDate';

  static const String EFFECTIVETIME = '\$EffectiveTime';

  static const String NAME = '\$Name';

  static const String MODE = '\$Mode';

  static const String SUBJECT = '\$Subject';

  static const String ACCURACY = '\$Accuracy';

  static const String CONTENTLENGTH = '\$ContentLength';

  static const String REMARK = '\$Remark';

  static const String CONTENTNAME = '\$ContentName';

  static const String SECTION = '\$Section';

  static const String DAYS = '\$Days';

  static const String POSTID = '\$PostId';

  static const String INFORMATIONTYPE = '\$InformationType';

  static const String INFORMATION = '\$Information';

  static const String FEATURE = '\$Feature';

  static const String ROOMS = '\$Rooms';

  static const String SALEPRICE = '\$SalePrice';

  static const String RENTFEE = '\$RentFee';

  static const String RENTTYPE = '\$RentType';

  static const String PAGENAME = '\$PageName';

  static const String SERIES = '\$Series';

  static const String MODEL = '\$Model';

  static const String DEVICETYPE = '\$DeviceType';

  static const String DEVICENAME = '\$DeviceName';

  static const String BINDDURATION = '\$BindDuration';

  static const String DEALERNAME = '\$DealerName';

  static const String ARRIVALDATE = '\$ArrivalDate';

  static const String BUYERTYPE = '\$BuyerType';

  static const String SEAT = '\$Seat';

  static const String ENERGY = '\$Energy';

  static const String CONFIGURATION = '\$Configuration';

  static const String ISLOAN = '\$IsLoan';

  static const String LOANPRODUCTNAME = '\$LoanProductName';

  static const String LOANCHANNEL = '\$LoanChannel';

  static const String REPAYMENTMETHOD = '\$RepaymentMethod';

  static const String OCCURREDDATE = '\$OccurredDate';

  static const String ACTION = '\$Action';

  static const String PAGE = '\$Page';

  static const String INDEX = '\$Index';

  static const String MODULE = '\$Module';

  static const String SOURCEPAGENAME = '\$SourcePageName';

  static const String CITY = '\$City';

  static const String FROMCITY = '\$FromCity';

  static const String TOCITY = '\$ToCity';

  static const String DEPARTUREDATE = '\$DepartureDate';

  static const String RETURNDATE = '\$ReturnDate';

  static const String TRIPTYPE = '\$TripType';

  static const String SEARCHHOTEL = '\$SearchHotel';

  static const String SPECIALTICKET = '\$SpecialTicket';

  static const String COUNTRY = '\$Country';

  static const String STAR = '\$Star';

  static const String CHECKINDATE = '\$CheckInDate';

  static const String CHECKOUTDATE = '\$CheckOutDate';

  static const String ALDULTCOUNT = '\$AdultCount';

  static const String BABYCOUNT = '\$BabyCount';

  static const String CHILDRENCOUNT = '\$ChildrenCount';

  static const String FROM = '\$From';

  static const String CARMODE = '\$CarMode';

  static const String CARTIME = '\$CarTime';

  static const String DEPARTURETIME = '\$DepartureTime';

  static const String ARRIVETIME = '\$ArriveTime';

  static const String AIRLINE = '\$Airline';

  static const String FLIGHTTYPE = '\$FlightType';

  static const String DIRECTFLIGHT = '\$DirectFlight';

  static const String TRAINTYPE = '\$TrainType';

  static const String BEDTYPE = '\$BedType';

  static const String BREAKFAST = '\$Breakfast';

  static const String ARRIVEDATE = '\$ArriveDate';

  static const String HOTELNAME = '\$HotelName';

  static const String TRIPTAG = '\$TripTag';

  static const String HOTELTYPE = '\$HotelType';

  static const String ROOMTYPE = '\$RoomType';

  static const String CARTYPE = '\$CarType';

  static const String SUPPLIER = '\$Supplier';

  static const String VOUCHERID = '\$VoucherID';

  static const String VOUCHERNAME = '\$VoucherName';

  static const String VOUCHERPRICE = '\$VoucherPrice';

  static const String USERTYPE = '\$UserType';

  static const String TARGET = '\$Target';

  static const String ISCOMPELETED = '\$IsCompleted';

  static const String USERLEVEL = '\$UserLevel';

  static const String TIME = '\$Time';

  static const String DISTANCE = '\$Distance';

  static const String CALORIECONSUMED = '\$CalorieConsumed';

  static const String PROGRESS = '\$Progress';

  static const String SOURCEPAGE = '\$SourcePage';

  static const String MULTIPLEACCOUNTS = '\$MultipleAccounts';

  static const String ACCOUNTTYPE = '\$AccountType';

  static const String FAILUREREASON = '\$FailureReason';

  static const String AUTHORITY = '\$Authority';

  static const String CARDTYPE = '\$CardType';

  static const String ISSUEBANK = '\$IssueBank';

  static const String TRANSFORMAMOUNT = '\$TransformAmount';

  static const String BANKNAME = '\$BankName';

  static const String SOURCEMODULE = '\$SourceModule';

  static const String STOCKCODE = '\$StockCode';

  static const String STOCKNAME = '\$StockName';

  static const String MARKETCODE = '\$MarketCode';

  static const String MARKETNAME = '\$MarketName';

  static const String VIEWTYPE = '\$ViewType';

  static const String TRENDCYCLE = '\$TrendCycle';

  static const String TRANSACTIONTYPE = '\$TransactionType';

  static const String CURRENCY = '\$Currency';

  static const String MONEY = '\$Money';

  static const String FINANCEID = '\$FinanceID';

  static const String FINANCENAME = '\$FinanceName';

  static const String FINANCETYPE = '\$FinanceType';

  static const String FINANCERATE = '\$FinanceRate';

  static const String FINANCETIMELIMIT = '\$FinanceTimeLimit';

  static const String FINANCEAMOUNTMIN = '\$FinanceAmountMin';

  static const String FINANCERISKLEV = '\$FinanceRiskLev';

  static const String PURCHASEAMOUNT = '\$PurchaseAmount';

  static const String HANDLINGFEES = '\$HandlingFees';

  static const String REDEMPTIONAMOUNT = '\$RedemptionAmount';

  static const String RETURNAMOUNT = '\$ReturnAmount';

  static const String FUNDCODE = '\$FundCode';

  static const String FUNDTYPE = '\$FundType';

  static const String FUNDNAME = '\$FundName';

  static const String FUNDRISKLEV = '\$FundRiskLev';

  static const String CHARGERATE = '\$ChargeRate';

  static const String PAYMENTMETHOD = '\$PaymentMethod';

  static const String FIXEDCYCLE = '\$FixedCycle';

  static const String ENTRANCE = '\$Entrance';

  static const String CODE = '\$Code';

  static const String NEWSTOPIC = '\$NewsTopic';

  static const String INFORMATIONSOURCE = '\$InformationSource';

  static const String COMMENTSNUMBER = '\$CommentsNumber';

  static const String FORWARDINGNUMBER = '\$ForwardingNumber';

  static const String LIKES = '\$Likes';

  static const String TITLE = '\$Title';

  static const String SEARCHTYPE = '\$SearchType';

  static const String SOURCELOCATION = '\$SourceLocation';

  static const String LOCATION = '\$Location';

  static const String ID = '\$ID';

  static const String PLAYMODE = '\$PlayMode';

  static const String LISTS = '\$Lists';

  static const String ADLOCATION = '\$AdLocation';

  static const String ADCATEGORY = '\$AdCategory';

  static const String ADTHEME = '\$AdTheme';

  static const String BUTTONNAME = '\$ButtonName';

  static const String USERID = '\$UserID';

  static const String PAGECATEGORY = '\$PageCategory';

  static const String RATING = '\$Rating';

  static const String PERFORMANCE = '\$Performance';

  static const String TRADINGRULES = '\$TradingRules';

  static const String PORTFOLIO = '\$Portfolio';

  static const String INVESTMENTMANAGER = '\$InvestmentManager';

  static const String FUNDSIZE = '\$FundSize';

  static const String VIPMONEY = '\$VIPMoney';

  static const String VIPLOCATION = '\$VIPLocation';

  static const String VIPFAILED = '\$VIPFailed';
}
