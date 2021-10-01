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

class HwLocationType {
  final String _value;

  const HwLocationType._create(this._value);

  factory HwLocationType.fromString(String value) =>
      HwLocationType._create(value);

  toString() => _value;

  static const ACCESS_GATEWAY = const HwLocationType._create("ACCESS_GATEWAY");
  static const ADDRESS = const HwLocationType._create("ADDRESS");
  static const ADMIN_FEATURE = const HwLocationType._create("ADMIN_FEATURE");
  static const ADMINISTRATIVE_AREA_LEVEL_1 =
      const HwLocationType._create("ADMINISTRATIVE_AREA_LEVEL_1");
  static const ADMINISTRATIVE_AREA_LEVEL_2 =
      const HwLocationType._create("ADMINISTRATIVE_AREA_LEVEL_2");
  static const ADMINISTRATIVE_AREA_LEVEL_3 =
      const HwLocationType._create("ADMINISTRATIVE_AREA_LEVEL_3");
  static const ADMINISTRATIVE_AREA_LEVEL_4 =
      const HwLocationType._create("ADMINISTRATIVE_AREA_LEVEL_4");
  static const ADVENTURE_SPORTS_VENUE =
      const HwLocationType._create("ADVENTURE_SPORTS_VENUE");
  static const ADVENTURE_VEHICLE_TRAIL =
      const HwLocationType._create("ADVENTURE_VEHICLE_TRAIL");
  static const ADVERTISING_AND_MARKETING_COMPANY =
      const HwLocationType._create("ADVERTISING_AND_MARKETING_COMPANY");
  static const AFGHAN_RESTAURANT =
      const HwLocationType._create("AFGHAN_RESTAURANT");
  static const AFRICAN_RESTAURANT =
      const HwLocationType._create("AFRICAN_RESTAURANT");
  static const AGRICULTURAL_SUPPLY_STORE =
      const HwLocationType._create("AGRICULTURAL_SUPPLY_STORE");
  static const AGRICULTURAL_TECHNOLOGY_COMPANY =
      const HwLocationType._create("AGRICULTURAL_TECHNOLOGY_COMPANY");
  static const AGRICULTURE_BUSINESS =
      const HwLocationType._create("AGRICULTURE_BUSINESS");
  static const AIRFIELD = const HwLocationType._create("AIRFIELD");
  static const AIRLINE = const HwLocationType._create("AIRLINE");
  static const AIRLINE_ACCESS = const HwLocationType._create("AIRLINE_ACCESS");
  static const AIRPORT = const HwLocationType._create("AIRPORT");
  static const ALGERIAN_RESTAURANT =
      const HwLocationType._create("ALGERIAN_RESTAURANT");
  static const AMBULANCE_UNIT = const HwLocationType._create("AMBULANCE_UNIT");
  static const AMERICAN_RESTAURANT =
      const HwLocationType._create("AMERICAN_RESTAURANT");
  static const AMPHITHEATER = const HwLocationType._create("AMPHITHEATER");
  static const AMUSEMENT_ARCADE =
      const HwLocationType._create("AMUSEMENT_ARCADE");
  static const AMUSEMENT_PARK = const HwLocationType._create("AMUSEMENT_PARK");
  static const AMUSEMENT_PLACE =
      const HwLocationType._create("AMUSEMENT_PLACE");
  static const ANIMAL_SERVICE_STORE =
      const HwLocationType._create("ANIMAL_SERVICE_STORE");
  static const ANIMAL_SHELTER = const HwLocationType._create("ANIMAL_SHELTER");
  static const ANTIQUE_ART_STORE =
      const HwLocationType._create("ANTIQUE_ART_STORE");
  static const APARTMENT = const HwLocationType._create("APARTMENT");
  static const AQUATIC_ZOO_MARINE_PARK =
      const HwLocationType._create("AQUATIC_ZOO_MARINE_PARK");
  static const ARABIAN_RESTAURANT =
      const HwLocationType._create("ARABIAN_RESTAURANT");
  static const ARBORETA_BOTANICAL_GARDENS =
      const HwLocationType._create("ARBORETA_BOTANICAL_GARDENS");
  static const ARCH = const HwLocationType._create("ARCH");
  static const ARGENTINEAN_RESTAURANT =
      const HwLocationType._create("ARGENTINEAN_RESTAURANT");
  static const ARMENIAN_RESTAURANT =
      const HwLocationType._create("ARMENIAN_RESTAURANT");
  static const ART_MUSEUM = const HwLocationType._create("ART_MUSEUM");
  static const ART_SCHOOL = const HwLocationType._create("ART_SCHOOL");
  static const ASHRAM = const HwLocationType._create("ASHRAM");
  static const ASIAN_RESTAURANT =
      const HwLocationType._create("ASIAN_RESTAURANT");
  static const ATHLETIC_STADIUM =
      const HwLocationType._create("ATHLETIC_STADIUM");
  static const ATV_SNOWMOBILE_DEALER =
      const HwLocationType._create("ATV_SNOWMOBILE_DEALER");
  static const AUSTRALIAN_RESTAURANT =
      const HwLocationType._create("AUSTRALIAN_RESTAURANT");
  static const AUSTRIAN_RESTAURANT =
      const HwLocationType._create("AUSTRIAN_RESTAURANT");
  static const AUTOMATIC_TELLER_MACHINE =
      const HwLocationType._create("AUTOMATIC_TELLER_MACHINE");
  static const AUTOMOBILE_ACCESSORIES_SHOP =
      const HwLocationType._create("AUTOMOBILE_ACCESSORIES_SHOP");
  static const AUTOMOBILE_COMPANY =
      const HwLocationType._create("AUTOMOBILE_COMPANY");
  static const AUTOMOBILE_MANUFACTURING_COMPANY =
      const HwLocationType._create("AUTOMOBILE_MANUFACTURING_COMPANY");
  static const AUTOMOTIVE = const HwLocationType._create("AUTOMOTIVE");
  static const AUTOMOTIVE_DEALER =
      const HwLocationType._create("AUTOMOTIVE_DEALER");
  static const AUTOMOTIVE_GLASS_REPLACEMENT_SHOP =
      const HwLocationType._create("AUTOMOTIVE_GLASS_REPLACEMENT_SHOP");
  static const AUTOMOTIVE_REPAIR_SHOP =
      const HwLocationType._create("AUTOMOTIVE_REPAIR_SHOP");
  static const BADMINTON_COURT =
      const HwLocationType._create("BADMINTON_COURT");
  static const BAGS_LEATHERWEAR_SHOP =
      const HwLocationType._create("BAGS_LEATHERWEAR_SHOP");
  static const BAKERY = const HwLocationType._create("BAKERY");
  static const BANK = const HwLocationType._create("BANK");
  static const BANQUET_ROOM = const HwLocationType._create("BANQUET_ROOM");
  static const BAR = const HwLocationType._create("BAR");
  static const BARBECUE_RESTAURANT =
      const HwLocationType._create("BARBECUE_RESTAURANT");
  static const BASEBALL_FIELD = const HwLocationType._create("BASEBALL_FIELD");
  static const BASKETBALL_COURT =
      const HwLocationType._create("BASKETBALL_COURT");
  static const BASQUE_RESTAURANT =
      const HwLocationType._create("BASQUE_RESTAURANT");
  static const BATTLEFIELD = const HwLocationType._create("BATTLEFIELD");
  static const BAY = const HwLocationType._create("BAY");
  static const BEACH = const HwLocationType._create("BEACH");
  static const BEACH_CLUB = const HwLocationType._create("BEACH_CLUB");
  static const BEAUTY_SALON = const HwLocationType._create("BEAUTY_SALON");
  static const BEAUTY_SUPPLY_SHOP =
      const HwLocationType._create("BEAUTY_SUPPLY_SHOP");
  static const BED_BREAKFAST_GUEST_HOUSES =
      const HwLocationType._create("BED_BREAKFAST_GUEST_HOUSES");
  static const BELGIAN_RESTAURANT =
      const HwLocationType._create("BELGIAN_RESTAURANT");
  static const BETTING_STATION =
      const HwLocationType._create("BETTING_STATION");
  static const BICYCLE_PARKING_PLACE =
      const HwLocationType._create("BICYCLE_PARKING_PLACE");
  static const BICYCLE_SHARING_LOCATION =
      const HwLocationType._create("BICYCLE_SHARING_LOCATION");
  static const BILLIARDS_POOL_HALL =
      const HwLocationType._create("BILLIARDS_POOL_HALL");
  static const BISTRO = const HwLocationType._create("BISTRO");
  static const BLOOD_BANK = const HwLocationType._create("BLOOD_BANK");
  static const BOAT_DEALER = const HwLocationType._create("BOAT_DEALER");
  static const BOAT_FERRY = const HwLocationType._create("BOAT_FERRY");
  static const BOAT_LAUNCHING_RAMP =
      const HwLocationType._create("BOAT_LAUNCHING_RAMP");
  static const BOATING_EQUIPMENT_ACCESSORIES_STORE =
      const HwLocationType._create("BOATING_EQUIPMENT_ACCESSORIES_STORE");
  static const BODYSHOPS = const HwLocationType._create("BODYSHOPS");
  static const BOLIVIAN_RESTAURANT =
      const HwLocationType._create("BOLIVIAN_RESTAURANT");
  static const BOOKSTORE = const HwLocationType._create("BOOKSTORE");
  static const BORDER_POST = const HwLocationType._create("BORDER_POST");
  static const BOSNIAN_RESTAURANT =
      const HwLocationType._create("BOSNIAN_RESTAURANT");
  static const BOWLING_FIELD = const HwLocationType._create("BOWLING_FIELD");
  static const BRAZILIAN_RESTAURANT =
      const HwLocationType._create("BRAZILIAN_RESTAURANT");
  static const BRIDGE = const HwLocationType._create("BRIDGE");
  static const BRIDGE_TUNNEL_ENGINEERING_COMPANY =
      const HwLocationType._create("BRIDGE_TUNNEL_ENGINEERING_COMPANY");
  static const BRITISH_RESTAURANT =
      const HwLocationType._create("BRITISH_RESTAURANT");
  static const BUDDHIST_TEMPLE =
      const HwLocationType._create("BUDDHIST_TEMPLE");
  static const BUFFET = const HwLocationType._create("BUFFET");
  static const BUILDING = const HwLocationType._create("BUILDING");
  static const BULGARIAN_RESTAURANT =
      const HwLocationType._create("BULGARIAN_RESTAURANT");
  static const BUNGALOW = const HwLocationType._create("BUNGALOW");
  static const BURMESE_RESTAURANT =
      const HwLocationType._create("BURMESE_RESTAURANT");
  static const BUS_CHARTER_RENTAL_COMPANY =
      const HwLocationType._create("BUS_CHARTER_RENTAL_COMPANY");
  static const BUS_COMPANY = const HwLocationType._create("BUS_COMPANY");
  static const BUS_DEALER = const HwLocationType._create("BUS_DEALER");
  static const BUS_STOP = const HwLocationType._create("BUS_STOP");
  static const BUSINESS = const HwLocationType._create("BUSINESS");
  static const BUSINESS_PARK = const HwLocationType._create("BUSINESS_PARK");
  static const BUSINESS_SERVICES_COMPANY =
      const HwLocationType._create("BUSINESS_SERVICES_COMPANY");
  static const CABARET = const HwLocationType._create("CABARET");
  static const CABINS_LODGES = const HwLocationType._create("CABINS_LODGES");
  static const CABLE_TELEPHONE_COMPANY =
      const HwLocationType._create("CABLE_TELEPHONE_COMPANY");
  static const CAFE = const HwLocationType._create("CAFE");
  static const CAFE_PUB = const HwLocationType._create("CAFE_PUB");
  static const CAFETERIA = const HwLocationType._create("CAFETERIA");
  static const CALIFORNIAN_RESTAURANT =
      const HwLocationType._create("CALIFORNIAN_RESTAURANT");
  static const CAMBODIAN_RESTAURANT =
      const HwLocationType._create("CAMBODIAN_RESTAURANT");
  static const CAMPING_GROUND = const HwLocationType._create("CAMPING_GROUND");
  static const CANADIAN_RESTAURANT =
      const HwLocationType._create("CANADIAN_RESTAURANT");
  static const CAPE = const HwLocationType._create("CAPE");
  static const CAPITAL = const HwLocationType._create("CAPITAL");
  static const CAPITAL_CITY = const HwLocationType._create("CAPITAL_CITY");
  static const CAR_CLUB = const HwLocationType._create("CAR_CLUB");
  static const CAR_DEALER = const HwLocationType._create("CAR_DEALER");
  static const CAR_RENTAL = const HwLocationType._create("CAR_RENTAL");
  static const CAR_RENTAL_COMPANY =
      const HwLocationType._create("CAR_RENTAL_COMPANY");
  static const CAR_WASH = const HwLocationType._create("CAR_WASH");
  static const CAR_WASH_SUB = const HwLocationType._create("CAR_WASH_SUB");
  static const CARAVAN_SITE = const HwLocationType._create("CARAVAN_SITE");
  static const CARGO_CENTER = const HwLocationType._create("CARGO_CENTER");
  static const CARIBBEAN_RESTAURANT =
      const HwLocationType._create("CARIBBEAN_RESTAURANT");
  static const CARPET_FLOOR_COVERING_STORE =
      const HwLocationType._create("CARPET_FLOOR_COVERING_STORE");
  static const CASINO = const HwLocationType._create("CASINO");
  static const CATERING_COMPANY =
      const HwLocationType._create("CATERING_COMPANY");
  static const CAVE = const HwLocationType._create("CAVE");
  static const CD_DVD_VIDEO_RENTAL_STORE =
      const HwLocationType._create("CD_DVD_VIDEO_RENTAL_STORE");
  static const CD_DVD_VIDEO_STORE =
      const HwLocationType._create("CD_DVD_VIDEO_STORE");
  static const CD_DVD_VIDEO_STORE_SUB =
      const HwLocationType._create("CD_DVD_VIDEO_STORE_SUB");
  static const CEMETERY = const HwLocationType._create("CEMETERY");
  static const CHALET = const HwLocationType._create("CHALET");
  static const CHEMICAL_COMPANY =
      const HwLocationType._create("CHEMICAL_COMPANY");
  static const CHICKEN_RESTAURANT =
      const HwLocationType._create("CHICKEN_RESTAURANT");
  static const CHILD_CARE_FACILITY =
      const HwLocationType._create("CHILD_CARE_FACILITY");
  static const CHILDRENS_MUSEUM =
      const HwLocationType._create("CHILDRENS_MUSEUM");
  static const CHILEAN_RESTAURANT =
      const HwLocationType._create("CHILEAN_RESTAURANT");
  static const CHINESE_MEDICINE_HOSPITAL =
      const HwLocationType._create("CHINESE_MEDICINE_HOSPITAL");
  static const CHINESE_RESTAURANT =
      const HwLocationType._create("CHINESE_RESTAURANT");
  static const CHRISTMAS_HOLIDAY_STORE =
      const HwLocationType._create("CHRISTMAS_HOLIDAY_STORE");
  static const CHURCH = const HwLocationType._create("CHURCH");
  static const CINEMA = const HwLocationType._create("CINEMA");
  static const CINEMA_SUB = const HwLocationType._create("CINEMA_SUB");
  static const CITIES = const HwLocationType._create("CITIES");
  static const CITY_CENTER = const HwLocationType._create("CITY_CENTER");
  static const CITY_HALL = const HwLocationType._create("CITY_HALL");
  static const CIVIC_COMMUNITY_CENTER =
      const HwLocationType._create("CIVIC_COMMUNITY_CENTER");
  static const CLEANING_SERVICE_COMPANY =
      const HwLocationType._create("CLEANING_SERVICE_COMPANY");
  static const CLOTHING_ACCESSORIES_STORE =
      const HwLocationType._create("CLOTHING_ACCESSORIES_STORE");
  static const CLUB_ASSOCIATION =
      const HwLocationType._create("CLUB_ASSOCIATION");
  static const COACH_PARKING_AREA =
      const HwLocationType._create("COACH_PARKING_AREA");
  static const COACH_STATION = const HwLocationType._create("COACH_STATION");
  static const COCKTAIL_BAR = const HwLocationType._create("COCKTAIL_BAR");
  static const COFFEE_SHOP = const HwLocationType._create("COFFEE_SHOP");
  static const COLLEGE_UNIVERSITY =
      const HwLocationType._create("COLLEGE_UNIVERSITY");
  static const COLOMBIAN_RESTAURANT =
      const HwLocationType._create("COLOMBIAN_RESTAURANT");
  static const COMEDY_CLUB = const HwLocationType._create("COMEDY_CLUB");
  static const COMMERCIAL_BUILDING =
      const HwLocationType._create("COMMERCIAL_BUILDING");
  static const COMMUNITY_CENTER =
      const HwLocationType._create("COMMUNITY_CENTER");
  static const COMPANY = const HwLocationType._create("COMPANY");
  static const COMPUTER_AND_DATA_SERVICES_CORPORATION =
      const HwLocationType._create("COMPUTER_AND_DATA_SERVICES_CORPORATION");
  static const COMPUTER_SOFTWARE_COMPANY =
      const HwLocationType._create("COMPUTER_SOFTWARE_COMPANY");
  static const COMPUTER_STORE = const HwLocationType._create("COMPUTER_STORE");
  static const CONCERT_HALL = const HwLocationType._create("CONCERT_HALL");
  static const CONDOMINIUM_COMPLEX =
      const HwLocationType._create("CONDOMINIUM_COMPLEX");
  static const CONSTRUCTION_COMPANY =
      const HwLocationType._create("CONSTRUCTION_COMPANY");
  static const CONSTRUCTION_MATERIAL_EQUIPMENT_SHOP =
      const HwLocationType._create("CONSTRUCTION_MATERIAL_EQUIPMENT_SHOP");
  static const CONSUMER_ELECTRONICS_STORE =
      const HwLocationType._create("CONSUMER_ELECTRONICS_STORE");
  static const CONTINENT = const HwLocationType._create("CONTINENT");
  static const CONVENIENCE_STORE =
      const HwLocationType._create("CONVENIENCE_STORE");
  static const CORSICAN_RESTAURANT =
      const HwLocationType._create("CORSICAN_RESTAURANT");
  static const COTTAGE = const HwLocationType._create("COTTAGE");
  static const COUNTRY = const HwLocationType._create("COUNTRY");
  static const COUNTY = const HwLocationType._create("COUNTY");
  static const COUNTY_COUNCIL = const HwLocationType._create("COUNTY_COUNCIL");
  static const COURIER_DROP_BOX =
      const HwLocationType._create("COURIER_DROP_BOX");
  static const COURTHOUSE = const HwLocationType._create("COURTHOUSE");
  static const COVE = const HwLocationType._create("COVE");
  static const CREOLE_CAJUN_RESTAURANT =
      const HwLocationType._create("CREOLE_CAJUN_RESTAURANT");
  static const CREPERIE = const HwLocationType._create("CREPERIE");
  static const CRICKET_GROUND = const HwLocationType._create("CRICKET_GROUND");
  static const CUBAN_RESTAURANT =
      const HwLocationType._create("CUBAN_RESTAURANT");
  static const CULINARY_SCHOOL =
      const HwLocationType._create("CULINARY_SCHOOL");
  static const CULTURAL_CENTER =
      const HwLocationType._create("CULTURAL_CENTER");
  static const CURRENCY_EXCHANGE =
      const HwLocationType._create("CURRENCY_EXCHANGE");
  static const CURTAIN_TEXTILE_STORE =
      const HwLocationType._create("CURTAIN_TEXTILE_STORE");
  static const CYPRIOT_RESTAURANT =
      const HwLocationType._create("CYPRIOT_RESTAURANT");
  static const CZECH_RESTAURANT =
      const HwLocationType._create("CZECH_RESTAURANT");
  static const DAM = const HwLocationType._create("DAM");
  static const DANCE_STUDIO_SCHOOL =
      const HwLocationType._create("DANCE_STUDIO_SCHOOL");
  static const DANCING_CLUB = const HwLocationType._create("DANCING_CLUB");
  static const DANISH_RESTAURANT =
      const HwLocationType._create("DANISH_RESTAURANT");
  static const DELICATESSEN_STORE =
      const HwLocationType._create("DELICATESSEN_STORE");
  static const DELIVERY_ENTRANCE =
      const HwLocationType._create("DELIVERY_ENTRANCE");
  static const DENTAL_CLINIC = const HwLocationType._create("DENTAL_CLINIC");
  static const DEPARTMENT_STORE =
      const HwLocationType._create("DEPARTMENT_STORE");
  static const DHARMA_TEMPLE = const HwLocationType._create("DHARMA_TEMPLE");
  static const DINNER_THEATER = const HwLocationType._create("DINNER_THEATER");
  static const DISCOTHEQUE = const HwLocationType._create("DISCOTHEQUE");
  static const DIVERSIFIED_FINANCIAL_SERVICE_COMPANY =
      const HwLocationType._create("DIVERSIFIED_FINANCIAL_SERVICE_COMPANY");
  static const DIVING_CENTER = const HwLocationType._create("DIVING_CENTER");
  static const DO_IT_YOURSELF_CENTERS =
      const HwLocationType._create("DO_IT_YOURSELF_CENTERS");
  static const DOCK = const HwLocationType._create("DOCK");
  static const DOMINICAN_RESTAURANT =
      const HwLocationType._create("DOMINICAN_RESTAURANT");
  static const DONGBEI_RESTAURANT =
      const HwLocationType._create("DONGBEI_RESTAURANT");
  static const DOUGHNUT_SHOP = const HwLocationType._create("DOUGHNUT_SHOP");
  static const DRIVE_IN_CINEMA =
      const HwLocationType._create("DRIVE_IN_CINEMA");
  static const DRIVE_THROUGH_BOTTLE_SHOP =
      const HwLocationType._create("DRIVE_THROUGH_BOTTLE_SHOP");
  static const DRIVING_SCHOOL = const HwLocationType._create("DRIVING_SCHOOL");
  static const DRUGSTORE = const HwLocationType._create("DRUGSTORE");
  static const DRY_CLEANERS = const HwLocationType._create("DRY_CLEANERS");
  static const DUNE = const HwLocationType._create("DUNE");
  static const DUTCH_RESTAURANT =
      const HwLocationType._create("DUTCH_RESTAURANT");
  static const EARTHQUAKE_ASSEMBLY_POINT_ =
      const HwLocationType._create("EARTHQUAKE_ASSEMBLY_POINT_");
  static const EATING_DRINKING =
      const HwLocationType._create("EATING_DRINKING");
  static const EDUCATION_INSTITUTION =
      const HwLocationType._create("EDUCATION_INSTITUTION");
  static const EGYPTIAN_RESTAURANT =
      const HwLocationType._create("EGYPTIAN_RESTAURANT");
  static const ELECTRIC_VEHICLE_CHARGING_STATION =
      const HwLocationType._create("ELECTRIC_VEHICLE_CHARGING_STATION");
  static const ELECTRICAL_APPLIANCE_STORE =
      const HwLocationType._create("ELECTRICAL_APPLIANCE_STORE");
  static const ELECTRICAL_APPLIANCE_STORE_SUB =
      const HwLocationType._create("ELECTRICAL_APPLIANCE_STORE_SUB");
  static const ELECTRONICS_COMPANY =
      const HwLocationType._create("ELECTRONICS_COMPANY");
  static const ELECTRONICS_STORE =
      const HwLocationType._create("ELECTRONICS_STORE");
  static const EMBASSY = const HwLocationType._create("EMBASSY");
  static const EMERGENCY_ASSEMBLY_POINT =
      const HwLocationType._create("EMERGENCY_ASSEMBLY_POINT");
  static const EMERGENCY_MEDICAL_SERVICE_CENTER =
      const HwLocationType._create("EMERGENCY_MEDICAL_SERVICE_CENTER");
  static const EMERGENCY_ROOM = const HwLocationType._create("EMERGENCY_ROOM");
  static const ENGLISH_RESTAURANT =
      const HwLocationType._create("ENGLISH_RESTAURANT");
  static const ENTERTAINMENT_CABARET_LIVE =
      const HwLocationType._create("ENTERTAINMENT_CABARET_LIVE");
  static const ENTERTAINMENT_PLACE =
      const HwLocationType._create("ENTERTAINMENT_PLACE");
  static const EQUIPMENT_RENTAL_COMPANY =
      const HwLocationType._create("EQUIPMENT_RENTAL_COMPANY");
  static const EROTIC_RESTAURANT =
      const HwLocationType._create("EROTIC_RESTAURANT");
  static const ESTABLISHMENT = const HwLocationType._create("ESTABLISHMENT");
  static const ETHIOPIAN_RESTAURANT =
      const HwLocationType._create("ETHIOPIAN_RESTAURANT");
  static const EXCHANGE = const HwLocationType._create("EXCHANGE");
  static const EXHIBITION_CONVENTION_CENTER =
      const HwLocationType._create("EXHIBITION_CONVENTION_CENTER");
  static const EXOTIC_RESTAURANT =
      const HwLocationType._create("EXOTIC_RESTAURANT");
  static const FACTORY_OUTLETS =
      const HwLocationType._create("FACTORY_OUTLETS");
  static const FAIRGROUND = const HwLocationType._create("FAIRGROUND");
  static const FARM = const HwLocationType._create("FARM");
  static const FARMER_MARKET = const HwLocationType._create("FARMER_MARKET");
  static const FAST_FOOD_RESTAURANT =
      const HwLocationType._create("FAST_FOOD_RESTAURANT");
  static const FERRY_TERMINAL = const HwLocationType._create("FERRY_TERMINAL");
  static const FILIPINO_RESTAURANT =
      const HwLocationType._create("FILIPINO_RESTAURANT");
  static const FINNISH_RESTAURANT =
      const HwLocationType._create("FINNISH_RESTAURANT");
  static const FIRE_ASSEMBLY_POINT =
      const HwLocationType._create("FIRE_ASSEMBLY_POINT");
  static const FIRE_STATION_BRIGADE =
      const HwLocationType._create("FIRE_STATION_BRIGADE");
  static const FISH_STORE = const HwLocationType._create("FISH_STORE");
  static const FISHING_HUNTING_AREA =
      const HwLocationType._create("FISHING_HUNTING_AREA");
  static const FITNESS_CLUB_CENTER =
      const HwLocationType._create("FITNESS_CLUB_CENTER");
  static const FIVE_STAR_HOTEL =
      const HwLocationType._create("FIVE_STAR_HOTEL");
  static const FLATS_APARTMENT_COMPLEX =
      const HwLocationType._create("FLATS_APARTMENT_COMPLEX");
  static const FLOOD_ASSEMBLY_POINT =
      const HwLocationType._create("FLOOD_ASSEMBLY_POINT");
  static const FLORISTS = const HwLocationType._create("FLORISTS");
  static const FLYING_CLUB = const HwLocationType._create("FLYING_CLUB");
  static const FONDUE_RESTAURANT =
      const HwLocationType._create("FONDUE_RESTAURANT");
  static const FOOD_DRINK_SHOP =
      const HwLocationType._create("FOOD_DRINK_SHOP");
  static const FOOD_MARKET = const HwLocationType._create("FOOD_MARKET");
  static const FOOTBALL_FIELD = const HwLocationType._create("FOOTBALL_FIELD");
  static const FOREST_AREA = const HwLocationType._create("FOREST_AREA");
  static const FOUR_STAR_HOTEL =
      const HwLocationType._create("FOUR_STAR_HOTEL");
  static const FRENCH_RESTAURANT =
      const HwLocationType._create("FRENCH_RESTAURANT");
  static const FUNERAL_SERVICE_COMPANY =
      const HwLocationType._create("FUNERAL_SERVICE_COMPANY");
  static const FURNITURE_ACCESSORIES_STORE =
      const HwLocationType._create("FURNITURE_ACCESSORIES_STORE");
  static const FURNITURE_STORE =
      const HwLocationType._create("FURNITURE_STORE");
  static const FUSION_RESTAURANT =
      const HwLocationType._create("FUSION_RESTAURANT");
  static const GALLERY = const HwLocationType._create("GALLERY");
  static const GARDENING_CERVICE_CENTER =
      const HwLocationType._create("GARDENING_CERVICE_CENTER");
  static const GENERAL_AUTO_REPAIR_SERVICE_CENTER =
      const HwLocationType._create("GENERAL_AUTO_REPAIR_SERVICE_CENTER");
  static const GENERAL_CITY = const HwLocationType._create("GENERAL_CITY");
  static const GENERAL_CLINIC = const HwLocationType._create("GENERAL_CLINIC");
  static const GENERAL_HOSPITAL =
      const HwLocationType._create("GENERAL_HOSPITAL");
  static const GENERAL_POST_OFFICE =
      const HwLocationType._create("GENERAL_POST_OFFICE");
  static const GEOCODE = const HwLocationType._create("GEOCODE");
  static const GEOGRAPHIC_FEATURE =
      const HwLocationType._create("GEOGRAPHIC_FEATURE");
  static const GERMAN_RESTAURANT =
      const HwLocationType._create("GERMAN_RESTAURANT");
  static const GIFT_STORE = const HwLocationType._create("GIFT_STORE");
  static const GLASS_WINDOW_STORE =
      const HwLocationType._create("GLASS_WINDOW_STORE");
  static const GLASSWARE_CERAMIC_SHOP =
      const HwLocationType._create("GLASSWARE_CERAMIC_SHOP");
  static const GOLD_EXCHANGE = const HwLocationType._create("GOLD_EXCHANGE");
  static const GOLF_COURSE = const HwLocationType._create("GOLF_COURSE");
  static const GOVERNMENT_OFFICE =
      const HwLocationType._create("GOVERNMENT_OFFICE");
  static const GOVERNMENT_PUBLIC_SERVICE =
      const HwLocationType._create("GOVERNMENT_PUBLIC_SERVICE");
  static const GREEK_RESTAURANT =
      const HwLocationType._create("GREEK_RESTAURANT");
  static const GREENGROCERY = const HwLocationType._create("GREENGROCERY");
  static const GRILL = const HwLocationType._create("GRILL");
  static const GROCERY = const HwLocationType._create("GROCERY");
  static const GUANGDONG_RESTAURANT =
      const HwLocationType._create("GUANGDONG_RESTAURANT");
  static const GURUDWARA = const HwLocationType._create("GURUDWARA");
  static const HAIR_SALON_BARBERSHOP =
      const HwLocationType._create("HAIR_SALON_BARBERSHOP");
  static const HAMBURGER_RESTAURANT =
      const HwLocationType._create("HAMBURGER_RESTAURANT");
  static const HAMLET = const HwLocationType._create("HAMLET");
  static const HARBOR = const HwLocationType._create("HARBOR");
  static const HARDWARE_STORE = const HwLocationType._create("HARDWARE_STORE");
  static const HEALTH_CARE = const HwLocationType._create("HEALTH_CARE");
  static const HEALTHCARE_SERVICE_CENTER =
      const HwLocationType._create("HEALTHCARE_SERVICE_CENTER");
  static const HELIPAD_HELICOPTER_LANDING =
      const HwLocationType._create("HELIPAD_HELICOPTER_LANDING");
  static const HIGH_SCHOOL = const HwLocationType._create("HIGH_SCHOOL");
  static const HIGHWAY__ENTRANCE =
      const HwLocationType._create("HIGHWAY__ENTRANCE");
  static const HIGHWAY_EXIT = const HwLocationType._create("HIGHWAY_EXIT");
  static const HIKING_TRAIL = const HwLocationType._create("HIKING_TRAIL");
  static const HILL = const HwLocationType._create("HILL");
  static const HINDU_TEMPLE = const HwLocationType._create("HINDU_TEMPLE");
  static const HISTORIC_SITE = const HwLocationType._create("HISTORIC_SITE");
  static const HISTORICAL_PARK =
      const HwLocationType._create("HISTORICAL_PARK");
  static const HISTORY_MUSEUM = const HwLocationType._create("HISTORY_MUSEUM");
  static const HOBBY_SHOP = const HwLocationType._create("HOBBY_SHOP");
  static const HOCKEY_CLUB = const HwLocationType._create("HOCKEY_CLUB");
  static const HOCKEY_FIELD = const HwLocationType._create("HOCKEY_FIELD");
  static const HOLIDAY_HOUSE_RENTAL =
      const HwLocationType._create("HOLIDAY_HOUSE_RENTAL");
  static const HOME_APPLIANCE_REPAIR_COMPANY =
      const HwLocationType._create("HOME_APPLIANCE_REPAIR_COMPANY");
  static const HOME_GOODS_STORE =
      const HwLocationType._create("HOME_GOODS_STORE");
  static const HORSE_RACING_TRACK =
      const HwLocationType._create("HORSE_RACING_TRACK");
  static const HORSE_RIDING_FIELD =
      const HwLocationType._create("HORSE_RIDING_FIELD");
  static const HORSE_RIDING_TRAIL =
      const HwLocationType._create("HORSE_RIDING_TRAIL");
  static const HORTICULTURE_COMPANY =
      const HwLocationType._create("HORTICULTURE_COMPANY");
  static const HOSPITAL_FOR_WOMEN_AND_CHILDREN =
      const HwLocationType._create("HOSPITAL_FOR_WOMEN_AND_CHILDREN");
  static const HOSPITAL_POLYCLINIC =
      const HwLocationType._create("HOSPITAL_POLYCLINIC");
  static const HOSTEL = const HwLocationType._create("HOSTEL");
  static const HOT_POT_RESTAURANT =
      const HwLocationType._create("HOT_POT_RESTAURANT");
  static const HOTEL = const HwLocationType._create("HOTEL");
  static const HOTEL_MOTEL = const HwLocationType._create("HOTEL_MOTEL");
  static const HOTELS_WITH_LESS_THAN_TWO_STARS =
      const HwLocationType._create("HOTELS_WITH_LESS_THAN_TWO_STARS");
  static const HOUSEHOLD_APPLIANCE_STORE =
      const HwLocationType._create("HOUSEHOLD_APPLIANCE_STORE");
  static const HUNAN_RESTAURANT =
      const HwLocationType._create("HUNAN_RESTAURANT");
  static const HUNGARIAN_RESTAURANT =
      const HwLocationType._create("HUNGARIAN_RESTAURANT");
  static const ICE_CREAM_PARLOR =
      const HwLocationType._create("ICE_CREAM_PARLOR");
  static const ICE_HOCKEY_RINK =
      const HwLocationType._create("ICE_HOCKEY_RINK");
  static const ICE_SKATING_RINK =
      const HwLocationType._create("ICE_SKATING_RINK");
  static const IMPORT_AND_EXPORT_DISTRIBUTION_COMPANY =
      const HwLocationType._create("IMPORT_AND_EXPORT_DISTRIBUTION_COMPANY");
  static const IMPORTANT_TOURIST_ATTRACTION =
      const HwLocationType._create("IMPORTANT_TOURIST_ATTRACTION");
  static const INDIAN_RESTAURANT =
      const HwLocationType._create("INDIAN_RESTAURANT");
  static const INDONESIAN_RESTAURANT =
      const HwLocationType._create("INDONESIAN_RESTAURANT");
  static const INDUSTRIAL_BUILDING =
      const HwLocationType._create("INDUSTRIAL_BUILDING");
  static const INFORMAL_MARKET =
      const HwLocationType._create("INFORMAL_MARKET");
  static const INSURANCE_COMPANY =
      const HwLocationType._create("INSURANCE_COMPANY");
  static const INTERCITY_RAILWAY_STATION =
      const HwLocationType._create("INTERCITY_RAILWAY_STATION");
  static const INTERNATIONAL_ORGANIZATION =
      const HwLocationType._create("INTERNATIONAL_ORGANIZATION");
  static const INTERNATIONAL_RAILWAY_STATION =
      const HwLocationType._create("INTERNATIONAL_RAILWAY_STATION");
  static const INTERNATIONAL_RESTAURANT =
      const HwLocationType._create("INTERNATIONAL_RESTAURANT");
  static const INTERNET_CAFE = const HwLocationType._create("INTERNET_CAFE");
  static const INVESTMENT_CONSULTING_FIRM =
      const HwLocationType._create("INVESTMENT_CONSULTING_FIRM");
  static const IRANIAN_RESTAURANT =
      const HwLocationType._create("IRANIAN_RESTAURANT");
  static const IRISH_RESTAURANT =
      const HwLocationType._create("IRISH_RESTAURANT");
  static const ISLAND = const HwLocationType._create("ISLAND");
  static const ISRAELI_RESTAURANT =
      const HwLocationType._create("ISRAELI_RESTAURANT");
  static const ITALIAN_RESTAURANT =
      const HwLocationType._create("ITALIAN_RESTAURANT");
  static const JAIN_TEMPLE = const HwLocationType._create("JAIN_TEMPLE");
  static const JAMAICAN_RESTAURANT =
      const HwLocationType._create("JAMAICAN_RESTAURANT");
  static const JAPANESE_RESTAURANT =
      const HwLocationType._create("JAPANESE_RESTAURANT");
  static const JAZZ_CLUB = const HwLocationType._create("JAZZ_CLUB");
  static const JEWELRY_CLOCK_AND_WATCH_SHOP =
      const HwLocationType._create("JEWELRY_CLOCK_AND_WATCH_SHOP");
  static const JEWISH_RESTAURANT =
      const HwLocationType._create("JEWISH_RESTAURANT");
  static const JUNIOR_COLLEGE_COMMUNITY_COLLEGE =
      const HwLocationType._create("JUNIOR_COLLEGE_COMMUNITY_COLLEGE");
  static const KARAOKE_CLUB = const HwLocationType._create("KARAOKE_CLUB");
  static const KITCHEN_AND_SANITATION_STORE =
      const HwLocationType._create("KITCHEN_AND_SANITATION_STORE");
  static const KOREAN_RESTAURANT =
      const HwLocationType._create("KOREAN_RESTAURANT");
  static const KOSHER_RESTAURANT =
      const HwLocationType._create("KOSHER_RESTAURANT");
  static const LAGOON = const HwLocationType._create("LAGOON");
  static const LAKESHORE = const HwLocationType._create("LAKESHORE");
  static const LANGUAGE_SCHOOL =
      const HwLocationType._create("LANGUAGE_SCHOOL");
  static const LATIN_AMERICAN_RESTAURANT =
      const HwLocationType._create("LATIN_AMERICAN_RESTAURANT");
  static const LAUNDRY = const HwLocationType._create("LAUNDRY");
  static const LEBANESE_RESTAURANT =
      const HwLocationType._create("LEBANESE_RESTAURANT");
  static const LEGAL_SERVICE_COMPANY =
      const HwLocationType._create("LEGAL_SERVICE_COMPANY");
  static const LEISURE = const HwLocationType._create("LEISURE");
  static const LEISURE_CENTER = const HwLocationType._create("LEISURE_CENTER");
  static const LIBRARY = const HwLocationType._create("LIBRARY");
  static const LIGHTING_STORE = const HwLocationType._create("LIGHTING_STORE");
  static const LOADING_ZONE = const HwLocationType._create("LOADING_ZONE");
  static const LOCAL_POST_OFFICE =
      const HwLocationType._create("LOCAL_POST_OFFICE");
  static const LOCAL_SPECIALTY_STORE =
      const HwLocationType._create("LOCAL_SPECIALTY_STORE");
  static const LODGING_LIVING_ACCOMMODATION =
      const HwLocationType._create("LODGING_LIVING_ACCOMMODATION");
  static const LOTTERY_SHOP = const HwLocationType._create("LOTTERY_SHOP");
  static const LUXEMBOURGIAN_RESTAURANT =
      const HwLocationType._create("LUXEMBOURGIAN_RESTAURANT");
  static const MACROBIOTIC_RESTAURANT =
      const HwLocationType._create("MACROBIOTIC_RESTAURANT");
  static const MAGHRIB_RESTAURANT =
      const HwLocationType._create("MAGHRIB_RESTAURANT");
  static const MAIL_PACKAGE_FREIGHT_DELIVERY_COMPANY =
      const HwLocationType._create("MAIL_PACKAGE_FREIGHT_DELIVERY_COMPANY");
  static const MALTESE_RESTAURANT =
      const HwLocationType._create("MALTESE_RESTAURANT");
  static const MANUFACTURING_COMPANY =
      const HwLocationType._create("MANUFACTURING_COMPANY");
  static const MANUFACTURING_FACTORY =
      const HwLocationType._create("MANUFACTURING_FACTORY");
  static const MARINA = const HwLocationType._create("MARINA");
  static const MARINA_SUB = const HwLocationType._create("MARINA_SUB");
  static const MARINE_ELECTRONIC_EQUIPMENT_STORE =
      const HwLocationType._create("MARINE_ELECTRONIC_EQUIPMENT_STORE");
  static const MARKET = const HwLocationType._create("MARKET");
  static const MARSH_SWAMP_VLEI =
      const HwLocationType._create("MARSH_SWAMP_VLEI");
  static const MAURITIAN_RESTAURANT =
      const HwLocationType._create("MAURITIAN_RESTAURANT");
  static const MAUSOLEUM_GRAVE =
      const HwLocationType._create("MAUSOLEUM_GRAVE");
  static const MEAT_STORE = const HwLocationType._create("MEAT_STORE");
  static const MECHANICAL_ENGINEERING_COMPANY =
      const HwLocationType._create("MECHANICAL_ENGINEERING_COMPANY");
  static const MEDIA_COMPANY = const HwLocationType._create("MEDIA_COMPANY");
  static const MEDICAL_CLINIC = const HwLocationType._create("MEDICAL_CLINIC");
  static const MEDICAL_SUPPLIES_EQUIPMENT_STORE =
      const HwLocationType._create("MEDICAL_SUPPLIES_EQUIPMENT_STORE");
  static const MEDITERRANEAN_RESTAURANT =
      const HwLocationType._create("MEDITERRANEAN_RESTAURANT");
  static const MEMORIAL = const HwLocationType._create("MEMORIAL");
  static const MEMORIAL_PLACE = const HwLocationType._create("MEMORIAL_PLACE");
  static const METRO = const HwLocationType._create("METRO");
  static const MEXICAN_RESTAURANT =
      const HwLocationType._create("MEXICAN_RESTAURANT");
  static const MICROBREWERY_BEER_GARDEN =
      const HwLocationType._create("MICROBREWERY_BEER_GARDEN");
  static const MIDDLE_EASTERN_RESTAURANT =
      const HwLocationType._create("MIDDLE_EASTERN_RESTAURANT");
  static const MIDDLE_SCHOOL = const HwLocationType._create("MIDDLE_SCHOOL");
  static const MILITARY_AUTHORITY =
      const HwLocationType._create("MILITARY_AUTHORITY");
  static const MILITARY_BASE = const HwLocationType._create("MILITARY_BASE");
  static const MINERAL_COMPANY =
      const HwLocationType._create("MINERAL_COMPANY");
  static const MINERAL_HOT_SPRINGS =
      const HwLocationType._create("MINERAL_HOT_SPRINGS");
  static const MISCELLANEOUS = const HwLocationType._create("MISCELLANEOUS");
  static const MOBILE_PHONE_STORE =
      const HwLocationType._create("MOBILE_PHONE_STORE");
  static const MONGOLIAN_RESTAURANT =
      const HwLocationType._create("MONGOLIAN_RESTAURANT");
  static const MONUMENT = const HwLocationType._create("MONUMENT");
  static const MORMON_CHURCH = const HwLocationType._create("MORMON_CHURCH");
  static const MOROCCAN_RESTAURANT =
      const HwLocationType._create("MOROCCAN_RESTAURANT");
  static const MOSQUE = const HwLocationType._create("MOSQUE");
  static const MOTEL = const HwLocationType._create("MOTEL");
  static const MOTORCYCLE_DEALER =
      const HwLocationType._create("MOTORCYCLE_DEALER");
  static const MOTORCYCLE_REPAIR_SHOP =
      const HwLocationType._create("MOTORCYCLE_REPAIR_SHOP");
  static const MOTORING_ORGANIZATION_OFFICE =
      const HwLocationType._create("MOTORING_ORGANIZATION_OFFICE");
  static const MOTORSPORT_VENUE =
      const HwLocationType._create("MOTORSPORT_VENUE");
  static const MOUNTAIN_BIKE_TRAIL =
      const HwLocationType._create("MOUNTAIN_BIKE_TRAIL");
  static const MOUNTAIN_PASS = const HwLocationType._create("MOUNTAIN_PASS");
  static const MOUNTAIN_PEAK = const HwLocationType._create("MOUNTAIN_PEAK");
  static const MOVING_STORAGE_COMPANY =
      const HwLocationType._create("MOVING_STORAGE_COMPANY");
  static const MULTIPURPOSE_STADIUM =
      const HwLocationType._create("MULTIPURPOSE_STADIUM");
  static const MUSEUM = const HwLocationType._create("MUSEUM");
  static const MUSIC_CENTER = const HwLocationType._create("MUSIC_CENTER");
  static const MUSICAL_INSTRUMENT_STORE =
      const HwLocationType._create("MUSICAL_INSTRUMENT_STORE");
  static const MUSSEL_RESTAURANT =
      const HwLocationType._create("MUSSEL_RESTAURANT");
  static const NAIL_SALON = const HwLocationType._create("NAIL_SALON");
  static const NAMED_INTERSECTION =
      const HwLocationType._create("NAMED_INTERSECTION");
  static const NATIONAL_ORGANIZATION =
      const HwLocationType._create("NATIONAL_ORGANIZATION");
  static const NATIONAL_RAILWAY_STATION =
      const HwLocationType._create("NATIONAL_RAILWAY_STATION");
  static const NATIVE_RESERVATION =
      const HwLocationType._create("NATIVE_RESERVATION");
  static const NATURAL_ATTRACTION =
      const HwLocationType._create("NATURAL_ATTRACTION");
  static const NATURAL_ATTRACTION_TOURIST =
      const HwLocationType._create("NATURAL_ATTRACTION_TOURIST");
  static const NEIGHBORHOOD = const HwLocationType._create("NEIGHBORHOOD");
  static const NEPALESE_RESTAURANT =
      const HwLocationType._create("NEPALESE_RESTAURANT");
  static const NETBALL_COURT = const HwLocationType._create("NETBALL_COURT");
  static const NEWSAGENTS_AND_TOBACCONISTS =
      const HwLocationType._create("NEWSAGENTS_AND_TOBACCONISTS");
  static const NIGHT_CLUB = const HwLocationType._create("NIGHT_CLUB");
  static const NIGHTLIFE = const HwLocationType._create("NIGHTLIFE");
  static const NON_GOVERNMENTAL_ORGANIZATION =
      const HwLocationType._create("NON_GOVERNMENTAL_ORGANIZATION");
  static const NORWEGIAN_RESTAURANT =
      const HwLocationType._create("NORWEGIAN_RESTAURANT");
  static const NURSING_HOME = const HwLocationType._create("NURSING_HOME");
  static const OASIS = const HwLocationType._create("OASIS");
  static const OBSERVATION_DECK =
      const HwLocationType._create("OBSERVATION_DECK");
  static const OBSERVATORY = const HwLocationType._create("OBSERVATORY");
  static const OEM = const HwLocationType._create("OEM");
  static const OFFICE_EQUIPMENT_STORE =
      const HwLocationType._create("OFFICE_EQUIPMENT_STORE");
  static const OFFICE_SUPPLY_SERVICES_STORE =
      const HwLocationType._create("OFFICE_SUPPLY_SERVICES_STORE");
  static const OIL_NATURAL_GAS_COMPANY =
      const HwLocationType._create("OIL_NATURAL_GAS_COMPANY");
  static const OPERA = const HwLocationType._create("OPERA");
  static const OPTICIANS = const HwLocationType._create("OPTICIANS");
  static const ORDER_1_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_1_AREA_GOVERNMENT_OFFICE");
  static const ORDER_1_AREA_POLICE_STATION =
      const HwLocationType._create("ORDER_1_AREA_POLICE_STATION");
  static const ORDER_2_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_2_AREA_GOVERNMENT_OFFICE");
  static const ORDER_3_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_3_AREA_GOVERNMENT_OFFICE");
  static const ORDER_4_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_4_AREA_GOVERNMENT_OFFICE");
  static const ORDER_5_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_5_AREA_GOVERNMENT_OFFICE");
  static const ORDER_6_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_6_AREA_GOVERNMENT_OFFICE");
  static const ORDER_7_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_7_AREA_GOVERNMENT_OFFICE");
  static const ORDER_8_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_8_AREA_GOVERNMENT_OFFICE");
  static const ORDER_8_AREA_POLICE_STATION =
      const HwLocationType._create("ORDER_8_AREA_POLICE_STATION");
  static const ORDER_9_AREA_GOVERNMENT_OFFICE =
      const HwLocationType._create("ORDER_9_AREA_GOVERNMENT_OFFICE");
  static const ORDER_9_AREA_POLICE_STATION =
      const HwLocationType._create("ORDER_9_AREA_POLICE_STATION");
  static const ORGANIC_RESTAURANT =
      const HwLocationType._create("ORGANIC_RESTAURANT");
  static const ORGANIZATION = const HwLocationType._create("ORGANIZATION");
  static const ORIENTAL_RESTAURANT =
      const HwLocationType._create("ORIENTAL_RESTAURANT");
  static const OUTLETS = const HwLocationType._create("OUTLETS");
  static const PAGODA = const HwLocationType._create("PAGODA");
  static const PAINTING_DECORATING_STORE =
      const HwLocationType._create("PAINTING_DECORATING_STORE");
  static const PAKISTANI_RESTAURANT =
      const HwLocationType._create("PAKISTANI_RESTAURANT");
  static const PAN = const HwLocationType._create("PAN");
  static const PARK = const HwLocationType._create("PARK");
  static const PARK_AND_RECREATION_AREA =
      const HwLocationType._create("PARK_AND_RECREATION_AREA");
  static const PARK_RIDE = const HwLocationType._create("PARK_RIDE");
  static const PARKING_GARAGE = const HwLocationType._create("PARKING_GARAGE");
  static const PARKING_LOT = const HwLocationType._create("PARKING_LOT");
  static const PARKING_LOT_SUB =
      const HwLocationType._create("PARKING_LOT_SUB");
  static const PARKWAY = const HwLocationType._create("PARKWAY");
  static const PASSENGER_TRANSPORT_TICKET_OFFICE =
      const HwLocationType._create("PASSENGER_TRANSPORT_TICKET_OFFICE");
  static const PAWN_SHOP = const HwLocationType._create("PAWN_SHOP");
  static const PEDESTRIAN_SUBWAY =
      const HwLocationType._create("PEDESTRIAN_SUBWAY");
  static const PERSONAL_CARE_INSTITUTION =
      const HwLocationType._create("PERSONAL_CARE_INSTITUTION");
  static const PERSONAL_SERVICE_CENTER =
      const HwLocationType._create("PERSONAL_SERVICE_CENTER");
  static const PERUVIAN_RESTAURANT =
      const HwLocationType._create("PERUVIAN_RESTAURANT");
  static const PET_STORE = const HwLocationType._create("PET_STORE");
  static const PET_SUPPLY_STORE =
      const HwLocationType._create("PET_SUPPLY_STORE");
  static const PETROL_STATION = const HwLocationType._create("PETROL_STATION");
  static const PHARMACEUTICAL_COMPANY =
      const HwLocationType._create("PHARMACEUTICAL_COMPANY");
  static const PHARMACY = const HwLocationType._create("PHARMACY");
  static const PHOTO_SHOP = const HwLocationType._create("PHOTO_SHOP");
  static const PHOTOCOPY_SHOP = const HwLocationType._create("PHOTOCOPY_SHOP");
  static const PHOTOGRAPHIC_EQUIPMENT_STORE =
      const HwLocationType._create("PHOTOGRAPHIC_EQUIPMENT_STORE");
  static const PHYSIOTHERAPY_CLINIC =
      const HwLocationType._create("PHYSIOTHERAPY_CLINIC");
  static const PICK_UP_AND_RETURN_POINT =
      const HwLocationType._create("PICK_UP_AND_RETURN_POINT");
  static const PICNIC_AREA = const HwLocationType._create("PICNIC_AREA");
  static const PIZZA_RESTAURANT =
      const HwLocationType._create("PIZZA_RESTAURANT");
  static const PLACE_OF_WORSHIP =
      const HwLocationType._create("PLACE_OF_WORSHIP");
  static const PLAIN_FLAT = const HwLocationType._create("PLAIN_FLAT");
  static const PLANETARIUM = const HwLocationType._create("PLANETARIUM");
  static const PLATEAU = const HwLocationType._create("PLATEAU");
  static const POLICE_STATION = const HwLocationType._create("POLICE_STATION");
  static const POLISH_RESTAURANT =
      const HwLocationType._create("POLISH_RESTAURANT");
  static const POLYNESIAN_RESTAURANT =
      const HwLocationType._create("POLYNESIAN_RESTAURANT");
  static const PORT_WAREHOUSE = const HwLocationType._create("PORT_WAREHOUSE");
  static const PORTUGUESE_RESTAURANT =
      const HwLocationType._create("PORTUGUESE_RESTAURANT");
  static const POST_OFFICE = const HwLocationType._create("POST_OFFICE");
  static const POSTAL_CODE = const HwLocationType._create("POSTAL_CODE");
  static const PRESCHOOL = const HwLocationType._create("PRESCHOOL");
  static const PRESERVED_AREA = const HwLocationType._create("PRESERVED_AREA");
  static const PRIMARY_SCHOOL = const HwLocationType._create("PRIMARY_SCHOOL");
  static const PRISON = const HwLocationType._create("PRISON");
  static const PRIVATE_AUTHORITY =
      const HwLocationType._create("PRIVATE_AUTHORITY");
  static const PRIVATE_CLUB = const HwLocationType._create("PRIVATE_CLUB");
  static const PRODUCER_COMPANY =
      const HwLocationType._create("PRODUCER_COMPANY");
  static const PROTECTED_AREA = const HwLocationType._create("PROTECTED_AREA");
  static const PROVENCAL_RESTAURANT =
      const HwLocationType._create("PROVENCAL_RESTAURANT");
  static const PUB = const HwLocationType._create("PUB");
  static const PUB_FOOD = const HwLocationType._create("PUB_FOOD");
  static const PUBLIC_AMENITY = const HwLocationType._create("PUBLIC_AMENITY");
  static const PUBLIC_AUTHORITY =
      const HwLocationType._create("PUBLIC_AUTHORITY");
  static const PUBLIC_CALL_BOX =
      const HwLocationType._create("PUBLIC_CALL_BOX");
  static const PUBLIC_HEALTH_TECHNOLOGY_COMPANY =
      const HwLocationType._create("PUBLIC_HEALTH_TECHNOLOGY_COMPANY");
  static const PUBLIC_MARKET = const HwLocationType._create("PUBLIC_MARKET");
  static const PUBLIC_RESTROOM =
      const HwLocationType._create("PUBLIC_RESTROOM");
  static const PUBLIC_TRANSPORT_STOP =
      const HwLocationType._create("PUBLIC_TRANSPORT_STOP");
  static const PUBLISHING_TECHNOLOGY_COMPANY =
      const HwLocationType._create("PUBLISHING_TECHNOLOGY_COMPANY");
  static const QUARRY = const HwLocationType._create("QUARRY");
  static const RACE_TRACK = const HwLocationType._create("RACE_TRACK");
  static const RAIL_FERRY = const HwLocationType._create("RAIL_FERRY");
  static const RAILWAY_SIDING = const HwLocationType._create("RAILWAY_SIDING");
  static const RAILWAY_STATION =
      const HwLocationType._create("RAILWAY_STATION");
  static const RAPIDS = const HwLocationType._create("RAPIDS");
  static const REAL_ESTATE_AGENCY_COMPANY =
      const HwLocationType._create("REAL_ESTATE_AGENCY_COMPANY");
  static const REAL_ESTATE_AGENCY_SHOP =
      const HwLocationType._create("REAL_ESTATE_AGENCY_SHOP");
  static const RECREATION_AREA =
      const HwLocationType._create("RECREATION_AREA");
  static const RECREATIONAL_SITE =
      const HwLocationType._create("RECREATIONAL_SITE");
  static const RECREATIONAL_VEHICLE_DEALER =
      const HwLocationType._create("RECREATIONAL_VEHICLE_DEALER");
  static const RECYCLING_SHOP = const HwLocationType._create("RECYCLING_SHOP");
  static const REEF = const HwLocationType._create("REEF");
  static const REGIONS = const HwLocationType._create("REGIONS");
  static const REPAIR_SHOP = const HwLocationType._create("REPAIR_SHOP");
  static const RESEARCH_INSTITUTE =
      const HwLocationType._create("RESEARCH_INSTITUTE");
  static const RESERVOIR = const HwLocationType._create("RESERVOIR");
  static const RESIDENTIAL_ACCOMMODATION =
      const HwLocationType._create("RESIDENTIAL_ACCOMMODATION");
  static const RESIDENTIAL_ESTATE =
      const HwLocationType._create("RESIDENTIAL_ESTATE");
  static const RESORT = const HwLocationType._create("RESORT");
  static const REST_AREA = const HwLocationType._create("REST_AREA");
  static const REST_CAMPS = const HwLocationType._create("REST_CAMPS");
  static const RESTAURANT = const HwLocationType._create("RESTAURANT");
  static const RESTAURANT_AREA =
      const HwLocationType._create("RESTAURANT_AREA");
  static const RETAIL_OUTLETS = const HwLocationType._create("RETAIL_OUTLETS");
  static const RETIREMENT_COMMUNITY =
      const HwLocationType._create("RETIREMENT_COMMUNITY");
  static const RIDGE = const HwLocationType._create("RIDGE");
  static const RIVER_CROSSING = const HwLocationType._create("RIVER_CROSSING");
  static const ROAD_RESCUE_POINT =
      const HwLocationType._create("ROAD_RESCUE_POINT");
  static const ROADSIDE = const HwLocationType._create("ROADSIDE");
  static const ROCK_CLIMBING_TRAIL =
      const HwLocationType._create("ROCK_CLIMBING_TRAIL");
  static const ROCKS = const HwLocationType._create("ROCKS");
  static const ROMANIAN_RESTAURANT =
      const HwLocationType._create("ROMANIAN_RESTAURANT");
  static const ROUTE = const HwLocationType._create("ROUTE");
  static const RUGBY_GROUND = const HwLocationType._create("RUGBY_GROUND");
  static const RUSSIAN_RESTAURANT =
      const HwLocationType._create("RUSSIAN_RESTAURANT");
  static const SALAD_BAR = const HwLocationType._create("SALAD_BAR");
  static const SANDWICH_RESTAURANT =
      const HwLocationType._create("SANDWICH_RESTAURANT");
  static const SAUNA_SOLARIUM_MASSAGE_CENTER =
      const HwLocationType._create("SAUNA_SOLARIUM_MASSAGE_CENTER");
  static const SAVINGS_INSTITUTION =
      const HwLocationType._create("SAVINGS_INSTITUTION");
  static const SAVOYAN_RESTAURANT =
      const HwLocationType._create("SAVOYAN_RESTAURANT");
  static const SCANDINAVIAN_RESTAURANT =
      const HwLocationType._create("SCANDINAVIAN_RESTAURANT");
  static const SCENIC_RIVER_AREA =
      const HwLocationType._create("SCENIC_RIVER_AREA");
  static const SCHOOL = const HwLocationType._create("SCHOOL");
  static const SCHOOL_BUS_SERVICE_COMPANY =
      const HwLocationType._create("SCHOOL_BUS_SERVICE_COMPANY");
  static const SCIENCE_MUSEUM = const HwLocationType._create("SCIENCE_MUSEUM");
  static const SCOTTISH_RESTAURANT =
      const HwLocationType._create("SCOTTISH_RESTAURANT");
  static const SEAFOOD_RESTAURANT =
      const HwLocationType._create("SEAFOOD_RESTAURANT");
  static const SEASHORE = const HwLocationType._create("SEASHORE");
  static const SECURITY_GATE = const HwLocationType._create("SECURITY_GATE");
  static const SECURITY_STORE = const HwLocationType._create("SECURITY_STORE");
  static const SENIOR_HIGH_SCHOOL =
      const HwLocationType._create("SENIOR_HIGH_SCHOOL");
  static const SERVICE_COMPANY =
      const HwLocationType._create("SERVICE_COMPANY");
  static const SHANDONG_RESTAURANT =
      const HwLocationType._create("SHANDONG_RESTAURANT");
  static const SHANGHAI_RESTAURANT =
      const HwLocationType._create("SHANGHAI_RESTAURANT");
  static const SHINTO_SHRINE = const HwLocationType._create("SHINTO_SHRINE");
  static const SHOOTING_RANGE = const HwLocationType._create("SHOOTING_RANGE");
  static const SHOP = const HwLocationType._create("SHOP");
  static const SHOPPING = const HwLocationType._create("SHOPPING");
  static const SHOPPING_CENTER =
      const HwLocationType._create("SHOPPING_CENTER");
  static const SHOPPING_SERVICE_CENTER =
      const HwLocationType._create("SHOPPING_SERVICE_CENTER");
  static const SICHUAN_RESTAURANT =
      const HwLocationType._create("SICHUAN_RESTAURANT");
  static const SICILIAN_RESTAURANT =
      const HwLocationType._create("SICILIAN_RESTAURANT");
  static const SKI_LIFT = const HwLocationType._create("SKI_LIFT");
  static const SKI_RESORT = const HwLocationType._create("SKI_RESORT");
  static const SLAVIC_RESTAURANT =
      const HwLocationType._create("SLAVIC_RESTAURANT");
  static const SLOVAK_RESTAURANT =
      const HwLocationType._create("SLOVAK_RESTAURANT");
  static const SNACKS = const HwLocationType._create("SNACKS");
  static const SNOOKER_POOL_BILLIARD_HALL =
      const HwLocationType._create("SNOOKER_POOL_BILLIARD_HALL");
  static const SOCCER_FIELD = const HwLocationType._create("SOCCER_FIELD");
  static const SOUL_FOOD_RESTAURANT =
      const HwLocationType._create("SOUL_FOOD_RESTAURANT");
  static const SOUP_RESTAURANT =
      const HwLocationType._create("SOUP_RESTAURANT");
  static const SPA = const HwLocationType._create("SPA");
  static const SPANISH_RESTAURANT =
      const HwLocationType._create("SPANISH_RESTAURANT");
  static const SPECIAL_SCHOOL = const HwLocationType._create("SPECIAL_SCHOOL");
  static const SPECIALIST_CLINIC =
      const HwLocationType._create("SPECIALIST_CLINIC");
  static const SPECIALIZED_HOSPITAL =
      const HwLocationType._create("SPECIALIZED_HOSPITAL");
  static const SPECIALTY_FOOD_STORE =
      const HwLocationType._create("SPECIALTY_FOOD_STORE");
  static const SPECIALTY_STORE =
      const HwLocationType._create("SPECIALTY_STORE");
  static const SPORT = const HwLocationType._create("SPORT");
  static const SPORTS_CENTER = const HwLocationType._create("SPORTS_CENTER");
  static const SPORTS_CENTER_SUB =
      const HwLocationType._create("SPORTS_CENTER_SUB");
  static const SPORTS_SCHOOL = const HwLocationType._create("SPORTS_SCHOOL");
  static const SPORTS_STORE = const HwLocationType._create("SPORTS_STORE");
  static const SQUASH_COURT = const HwLocationType._create("SQUASH_COURT");
  static const STADIUM = const HwLocationType._create("STADIUM");
  static const STAMP_SHOP = const HwLocationType._create("STAMP_SHOP");
  static const STATION_ACCESS = const HwLocationType._create("STATION_ACCESS");
  static const STATUE = const HwLocationType._create("STATUE");
  static const STEAK_HOUSE = const HwLocationType._create("STEAK_HOUSE");
  static const STOCK_EXCHANGE = const HwLocationType._create("STOCK_EXCHANGE");
  static const STORE = const HwLocationType._create("STORE");
  static const STREET_ADDRESS = const HwLocationType._create("STREET_ADDRESS");
  static const SUDANESE_RESTAURANT =
      const HwLocationType._create("SUDANESE_RESTAURANT");
  static const SUPERMARKET_HYPERMARKET =
      const HwLocationType._create("SUPERMARKET_HYPERMARKET");
  static const SURINAMESE_RESTAURANT =
      const HwLocationType._create("SURINAMESE_RESTAURANT");
  static const SUSHI_RESTAURANT =
      const HwLocationType._create("SUSHI_RESTAURANT");
  static const SWEDISH_RESTAURANT =
      const HwLocationType._create("SWEDISH_RESTAURANT");
  static const SWIMMING_POOL = const HwLocationType._create("SWIMMING_POOL");
  static const SWISS_RESTAURANT =
      const HwLocationType._create("SWISS_RESTAURANT");
  static const SYNAGOGUE = const HwLocationType._create("SYNAGOGUE");
  static const SYRIAN_RESTAURANT =
      const HwLocationType._create("SYRIAN_RESTAURANT");
  static const TABLE_TENNIS_HALL =
      const HwLocationType._create("TABLE_TENNIS_HALL");
  static const TAILOR_SHOP = const HwLocationType._create("TAILOR_SHOP");
  static const TAIWANESE_RESTAURANT =
      const HwLocationType._create("TAIWANESE_RESTAURANT");
  static const TAKE_AWAY_RESTAURANT =
      const HwLocationType._create("TAKE_AWAY_RESTAURANT");
  static const TAPAS_RESTAURANT =
      const HwLocationType._create("TAPAS_RESTAURANT");
  static const TAX_SERVICE_COMPANY =
      const HwLocationType._create("TAX_SERVICE_COMPANY");
  static const TAXI_LIMOUSINE_SHUTTLE_SERVICE_COMPANY =
      const HwLocationType._create("TAXI_LIMOUSINE_SHUTTLE_SERVICE_COMPANY");
  static const TAXI_STAND = const HwLocationType._create("TAXI_STAND");
  static const TEA_HOUSE = const HwLocationType._create("TEA_HOUSE");
  static const TECHNICAL_SCHOOL =
      const HwLocationType._create("TECHNICAL_SCHOOL");
  static const TELECOMMUNICATIONS_COMPANY =
      const HwLocationType._create("TELECOMMUNICATIONS_COMPANY");
  static const TEMPLE = const HwLocationType._create("TEMPLE");
  static const TENNIS_COURT = const HwLocationType._create("TENNIS_COURT");
  static const TEPPANYAKKI_RESTAURANT =
      const HwLocationType._create("TEPPANYAKKI_RESTAURANT");
  static const TERMINAL = const HwLocationType._create("TERMINAL");
  static const THAI_RESTAURANT =
      const HwLocationType._create("THAI_RESTAURANT");
  static const THEATER = const HwLocationType._create("THEATER");
  static const THEATER_SUB = const HwLocationType._create("THEATER_SUB");
  static const THEMED_SPORTS_HALL =
      const HwLocationType._create("THEMED_SPORTS_HALL");
  static const THREE_STAR_HOTEL =
      const HwLocationType._create("THREE_STAR_HOTEL");
  static const TIBETAN_RESTAURANT =
      const HwLocationType._create("TIBETAN_RESTAURANT");
  static const TIRE_REPAIR_SHOP =
      const HwLocationType._create("TIRE_REPAIR_SHOP");
  static const TOILET = const HwLocationType._create("TOILET");
  static const TOLL_GATE = const HwLocationType._create("TOLL_GATE");
  static const TOURISM = const HwLocationType._create("TOURISM");
  static const TOURIST_INFORMATION_OFFICE =
      const HwLocationType._create("TOURIST_INFORMATION_OFFICE");
  static const TOWER = const HwLocationType._create("TOWER");
  static const TOWN = const HwLocationType._create("TOWN");
  static const TOWN_GOVERNMENT =
      const HwLocationType._create("TOWN_GOVERNMENT");
  static const TOWNHOUSE_COMPLEX =
      const HwLocationType._create("TOWNHOUSE_COMPLEX");
  static const TOYS_AND_GAMES_STORE =
      const HwLocationType._create("TOYS_AND_GAMES_STORE");
  static const TRAFFIC = const HwLocationType._create("TRAFFIC");
  static const TRAFFIC_CONTROL_DEPARTMENT =
      const HwLocationType._create("TRAFFIC_CONTROL_DEPARTMENT");
  static const TRAFFIC_LIGHT = const HwLocationType._create("TRAFFIC_LIGHT");
  static const TRAFFIC_MANAGEMENT_BUREAU =
      const HwLocationType._create("TRAFFIC_MANAGEMENT_BUREAU");
  static const TRAFFIC_SIGN = const HwLocationType._create("TRAFFIC_SIGN");
  static const TRAFFIC_SIGNAL = const HwLocationType._create("TRAFFIC_SIGNAL");
  static const TRAIL_SYSTEM = const HwLocationType._create("TRAIL_SYSTEM");
  static const TRAILHEAD = const HwLocationType._create("TRAILHEAD");
  static const TRAM_STOP = const HwLocationType._create("TRAM_STOP");
  static const TRANSPORT = const HwLocationType._create("TRANSPORT");
  static const TRANSPORT__CENTER =
      const HwLocationType._create("TRANSPORT__CENTER");
  static const TRANSPORTATION_COMPANY =
      const HwLocationType._create("TRANSPORTATION_COMPANY");
  static const TRAVEL_AGENCY = const HwLocationType._create("TRAVEL_AGENCY");
  static const TRUCK_DEALER = const HwLocationType._create("TRUCK_DEALER");
  static const TRUCK_PARKING_AREA =
      const HwLocationType._create("TRUCK_PARKING_AREA");
  static const TRUCK_REPAIR_SHOP =
      const HwLocationType._create("TRUCK_REPAIR_SHOP");
  static const TRUCK_STOP = const HwLocationType._create("TRUCK_STOP");
  static const TRUCK_WASH = const HwLocationType._create("TRUCK_WASH");
  static const TSUNAMI_ASSEMBLY_POINT =
      const HwLocationType._create("TSUNAMI_ASSEMBLY_POINT");
  static const TUNISIAN_RESTAURANT =
      const HwLocationType._create("TUNISIAN_RESTAURANT");
  static const TUNNEL = const HwLocationType._create("TUNNEL");
  static const TURKISH_RESTAURANT =
      const HwLocationType._create("TURKISH_RESTAURANT");
  static const UNRATED_HOTEL = const HwLocationType._create("UNRATED_HOTEL");
  static const URUGUAYAN_RESTAURANT =
      const HwLocationType._create("URUGUAYAN_RESTAURANT");
  static const USED_CAR_DEALER =
      const HwLocationType._create("USED_CAR_DEALER");
  static const VALLEY = const HwLocationType._create("VALLEY");
  static const VAN_DEALER = const HwLocationType._create("VAN_DEALER");
  static const VARIETY_STORE = const HwLocationType._create("VARIETY_STORE");
  static const VEGETARIAN_RESTAURANT =
      const HwLocationType._create("VEGETARIAN_RESTAURANT");
  static const VENEZUELAN_RESTAURANT =
      const HwLocationType._create("VENEZUELAN_RESTAURANT");
  static const VETERINARY_CLINIC =
      const HwLocationType._create("VETERINARY_CLINIC");
  static const VIDEO_ARCADE_GAMING_ROOM =
      const HwLocationType._create("VIDEO_ARCADE_GAMING_ROOM");
  static const VIETNAMESE_RESTAURANT =
      const HwLocationType._create("VIETNAMESE_RESTAURANT");
  static const VILLA = const HwLocationType._create("VILLA");
  static const VOCATIONAL_TRAINING_SCHOOL =
      const HwLocationType._create("VOCATIONAL_TRAINING_SCHOOL");
  static const VOLCANIC_ERUPTION_ASSEMBLY_POINT =
      const HwLocationType._create("VOLCANIC_ERUPTION_ASSEMBLY_POINT");
  static const WAREHOUSE_SUPERMARKET =
      const HwLocationType._create("WAREHOUSE_SUPERMARKET");
  static const WATER_HOLE = const HwLocationType._create("WATER_HOLE");
  static const WATER_SPORTS_CENTER =
      const HwLocationType._create("WATER_SPORTS_CENTER");
  static const WEDDING_SERVICE_COMPANY =
      const HwLocationType._create("WEDDING_SERVICE_COMPANY");
  static const WEIGH_SCALES = const HwLocationType._create("WEIGH_SCALES");
  static const WEIGH_STATION = const HwLocationType._create("WEIGH_STATION");
  static const WEIGH_STATION_SUB =
      const HwLocationType._create("WEIGH_STATION_SUB");
  static const WELFARE_ORGANIZATION =
      const HwLocationType._create("WELFARE_ORGANIZATION");
  static const WELL = const HwLocationType._create("WELL");
  static const WELSH_RESTAURANT =
      const HwLocationType._create("WELSH_RESTAURANT");
  static const WESTERN_RESTAURANT =
      const HwLocationType._create("WESTERN_RESTAURANT");
  static const WILDERNESS_AREA =
      const HwLocationType._create("WILDERNESS_AREA");
  static const WILDLIFE_PARK = const HwLocationType._create("WILDLIFE_PARK");
  static const WINE_BAR = const HwLocationType._create("WINE_BAR");
  static const WINE_SPIRITS_STORE =
      const HwLocationType._create("WINE_SPIRITS_STORE");
  static const WINERY = const HwLocationType._create("WINERY");
  static const WINERY_TOURIST = const HwLocationType._create("WINERY_TOURIST");
  static const WINTER_SPORT_AREA =
      const HwLocationType._create("WINTER_SPORT_AREA");
  static const YACHT_BASIN = const HwLocationType._create("YACHT_BASIN");
  static const YOGURT_JUICE_BAR =
      const HwLocationType._create("YOGURT_JUICE_BAR");
  static const ZOO = const HwLocationType._create("ZOO");
  static const ZOO_ARBORETA_BOTANICAL_GARDEN =
      const HwLocationType._create("ZOO_ARBORETA_BOTANICAL_GARDEN");
}
