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

part of huawei_site;

class HwLocationType {
  final String _value;

  const HwLocationType._create(this._value);

  factory HwLocationType.fromString(String value) {
    return HwLocationType._create(value);
  }

  @override
  String toString() {
    return _value;
  }

  static const HwLocationType ACCESS_GATEWAY =
      HwLocationType._create('ACCESS_GATEWAY');

  static const HwLocationType ADDRESS = HwLocationType._create('ADDRESS');

  static const HwLocationType ADMIN_FEATURE =
      HwLocationType._create('ADMIN_FEATURE');

  static const HwLocationType ADMINISTRATIVE_AREA_LEVEL_1 =
      HwLocationType._create('ADMINISTRATIVE_AREA_LEVEL_1');

  static const HwLocationType ADMINISTRATIVE_AREA_LEVEL_2 =
      HwLocationType._create('ADMINISTRATIVE_AREA_LEVEL_2');

  static const HwLocationType ADMINISTRATIVE_AREA_LEVEL_3 =
      HwLocationType._create('ADMINISTRATIVE_AREA_LEVEL_3');

  static const HwLocationType ADMINISTRATIVE_AREA_LEVEL_4 =
      HwLocationType._create('ADMINISTRATIVE_AREA_LEVEL_4');

  static const HwLocationType ADVENTURE_SPORTS_VENUE =
      HwLocationType._create('ADVENTURE_SPORTS_VENUE');

  static const HwLocationType ADVENTURE_VEHICLE_TRAIL =
      HwLocationType._create('ADVENTURE_VEHICLE_TRAIL');

  static const HwLocationType ADVERTISING_AND_MARKETING_COMPANY =
      HwLocationType._create('ADVERTISING_AND_MARKETING_COMPANY');

  static const HwLocationType AFGHAN_RESTAURANT =
      HwLocationType._create('AFGHAN_RESTAURANT');

  static const HwLocationType AFRICAN_RESTAURANT =
      HwLocationType._create('AFRICAN_RESTAURANT');

  static const HwLocationType AGRICULTURAL_SUPPLY_STORE =
      HwLocationType._create('AGRICULTURAL_SUPPLY_STORE');

  static const HwLocationType AGRICULTURAL_TECHNOLOGY_COMPANY =
      HwLocationType._create('AGRICULTURAL_TECHNOLOGY_COMPANY');

  static const HwLocationType AGRICULTURE_BUSINESS =
      HwLocationType._create('AGRICULTURE_BUSINESS');

  static const HwLocationType AIRFIELD = HwLocationType._create('AIRFIELD');

  static const HwLocationType AIRLINE = HwLocationType._create('AIRLINE');

  static const HwLocationType AIRLINE_ACCESS =
      HwLocationType._create('AIRLINE_ACCESS');

  static const HwLocationType AIRPORT = HwLocationType._create('AIRPORT');

  static const HwLocationType ALGERIAN_RESTAURANT =
      HwLocationType._create('ALGERIAN_RESTAURANT');

  static const HwLocationType AMBULANCE_UNIT =
      HwLocationType._create('AMBULANCE_UNIT');

  static const HwLocationType AMERICAN_RESTAURANT =
      HwLocationType._create('AMERICAN_RESTAURANT');

  static const HwLocationType AMPHITHEATER =
      HwLocationType._create('AMPHITHEATER');

  static const HwLocationType AMUSEMENT_ARCADE =
      HwLocationType._create('AMUSEMENT_ARCADE');

  static const HwLocationType AMUSEMENT_PARK =
      HwLocationType._create('AMUSEMENT_PARK');

  static const HwLocationType AMUSEMENT_PLACE =
      HwLocationType._create('AMUSEMENT_PLACE');

  static const HwLocationType ANIMAL_SERVICE_STORE =
      HwLocationType._create('ANIMAL_SERVICE_STORE');

  static const HwLocationType ANIMAL_SHELTER =
      HwLocationType._create('ANIMAL_SHELTER');

  static const HwLocationType ANTIQUE_ART_STORE =
      HwLocationType._create('ANTIQUE_ART_STORE');

  static const HwLocationType APARTMENT = HwLocationType._create('APARTMENT');

  static const HwLocationType AQUATIC_ZOO_MARINE_PARK =
      HwLocationType._create('AQUATIC_ZOO_MARINE_PARK');

  static const HwLocationType ARABIAN_RESTAURANT =
      HwLocationType._create('ARABIAN_RESTAURANT');

  static const HwLocationType ARBORETA_BOTANICAL_GARDENS =
      HwLocationType._create('ARBORETA_BOTANICAL_GARDENS');

  static const HwLocationType ARCH = HwLocationType._create('ARCH');

  static const HwLocationType ARGENTINEAN_RESTAURANT =
      HwLocationType._create('ARGENTINEAN_RESTAURANT');

  static const HwLocationType ARMENIAN_RESTAURANT =
      HwLocationType._create('ARMENIAN_RESTAURANT');

  static const HwLocationType ART_MUSEUM = HwLocationType._create('ART_MUSEUM');

  static const HwLocationType ART_SCHOOL = HwLocationType._create('ART_SCHOOL');

  static const HwLocationType ASHRAM = HwLocationType._create('ASHRAM');

  static const HwLocationType ASIAN_RESTAURANT =
      HwLocationType._create('ASIAN_RESTAURANT');

  static const HwLocationType ATHLETIC_STADIUM =
      HwLocationType._create('ATHLETIC_STADIUM');

  static const HwLocationType ATV_SNOWMOBILE_DEALER =
      HwLocationType._create('ATV_SNOWMOBILE_DEALER');

  static const HwLocationType AUSTRALIAN_RESTAURANT =
      HwLocationType._create('AUSTRALIAN_RESTAURANT');

  static const HwLocationType AUSTRIAN_RESTAURANT =
      HwLocationType._create('AUSTRIAN_RESTAURANT');

  static const HwLocationType AUTOMATIC_TELLER_MACHINE =
      HwLocationType._create('AUTOMATIC_TELLER_MACHINE');

  static const HwLocationType AUTOMOBILE_ACCESSORIES_SHOP =
      HwLocationType._create('AUTOMOBILE_ACCESSORIES_SHOP');

  static const HwLocationType AUTOMOBILE_COMPANY =
      HwLocationType._create('AUTOMOBILE_COMPANY');

  static const HwLocationType AUTOMOBILE_MANUFACTURING_COMPANY =
      HwLocationType._create('AUTOMOBILE_MANUFACTURING_COMPANY');

  static const HwLocationType AUTOMOTIVE = HwLocationType._create('AUTOMOTIVE');

  static const HwLocationType AUTOMOTIVE_DEALER =
      HwLocationType._create('AUTOMOTIVE_DEALER');

  static const HwLocationType AUTOMOTIVE_GLASS_REPLACEMENT_SHOP =
      HwLocationType._create('AUTOMOTIVE_GLASS_REPLACEMENT_SHOP');

  static const HwLocationType AUTOMOTIVE_REPAIR_SHOP =
      HwLocationType._create('AUTOMOTIVE_REPAIR_SHOP');

  static const HwLocationType BADMINTON_COURT =
      HwLocationType._create('BADMINTON_COURT');

  static const HwLocationType BAGS_LEATHERWEAR_SHOP =
      HwLocationType._create('BAGS_LEATHERWEAR_SHOP');

  static const HwLocationType BAKERY = HwLocationType._create('BAKERY');

  static const HwLocationType BANK = HwLocationType._create('BANK');

  static const HwLocationType BANQUET_ROOM =
      HwLocationType._create('BANQUET_ROOM');

  static const HwLocationType BAR = HwLocationType._create('BAR');

  static const HwLocationType BARBECUE_RESTAURANT =
      HwLocationType._create('BARBECUE_RESTAURANT');

  static const HwLocationType BASEBALL_FIELD =
      HwLocationType._create('BASEBALL_FIELD');

  static const HwLocationType BASKETBALL_COURT =
      HwLocationType._create('BASKETBALL_COURT');

  static const HwLocationType BASQUE_RESTAURANT =
      HwLocationType._create('BASQUE_RESTAURANT');

  static const HwLocationType BATTLEFIELD =
      HwLocationType._create('BATTLEFIELD');

  static const HwLocationType BAY = HwLocationType._create('BAY');

  static const HwLocationType BEACH = HwLocationType._create('BEACH');

  static const HwLocationType BEACH_CLUB = HwLocationType._create('BEACH_CLUB');

  static const HwLocationType BEAUTY_SALON =
      HwLocationType._create('BEAUTY_SALON');

  static const HwLocationType BEAUTY_SUPPLY_SHOP =
      HwLocationType._create('BEAUTY_SUPPLY_SHOP');

  static const HwLocationType BED_BREAKFAST_GUEST_HOUSES =
      HwLocationType._create('BED_BREAKFAST_GUEST_HOUSES');

  static const HwLocationType BELGIAN_RESTAURANT =
      HwLocationType._create('BELGIAN_RESTAURANT');

  static const HwLocationType BETTING_STATION =
      HwLocationType._create('BETTING_STATION');

  static const HwLocationType BICYCLE_PARKING_PLACE =
      HwLocationType._create('BICYCLE_PARKING_PLACE');

  static const HwLocationType BICYCLE_SHARING_LOCATION =
      HwLocationType._create('BICYCLE_SHARING_LOCATION');

  static const HwLocationType BILLIARDS_POOL_HALL =
      HwLocationType._create('BILLIARDS_POOL_HALL');

  static const HwLocationType BISTRO = HwLocationType._create('BISTRO');

  static const HwLocationType BLOOD_BANK = HwLocationType._create('BLOOD_BANK');

  static const HwLocationType BOAT_DEALER =
      HwLocationType._create('BOAT_DEALER');

  static const HwLocationType BOAT_FERRY = HwLocationType._create('BOAT_FERRY');

  static const HwLocationType BOAT_LAUNCHING_RAMP =
      HwLocationType._create('BOAT_LAUNCHING_RAMP');

  static const HwLocationType BOATING_EQUIPMENT_ACCESSORIES_STORE =
      HwLocationType._create('BOATING_EQUIPMENT_ACCESSORIES_STORE');

  static const HwLocationType BODYSHOPS = HwLocationType._create('BODYSHOPS');

  static const HwLocationType BOLIVIAN_RESTAURANT =
      HwLocationType._create('BOLIVIAN_RESTAURANT');

  static const HwLocationType BOOKSTORE = HwLocationType._create('BOOKSTORE');

  static const HwLocationType BORDER_POST =
      HwLocationType._create('BORDER_POST');

  static const HwLocationType BOSNIAN_RESTAURANT =
      HwLocationType._create('BOSNIAN_RESTAURANT');

  static const HwLocationType BOWLING_FIELD =
      HwLocationType._create('BOWLING_FIELD');

  static const HwLocationType BRAZILIAN_RESTAURANT =
      HwLocationType._create('BRAZILIAN_RESTAURANT');

  static const HwLocationType BRIDGE = HwLocationType._create('BRIDGE');

  static const HwLocationType BRIDGE_TUNNEL_ENGINEERING_COMPANY =
      HwLocationType._create('BRIDGE_TUNNEL_ENGINEERING_COMPANY');

  static const HwLocationType BRITISH_RESTAURANT =
      HwLocationType._create('BRITISH_RESTAURANT');

  static const HwLocationType BUDDHIST_TEMPLE =
      HwLocationType._create('BUDDHIST_TEMPLE');

  static const HwLocationType BUFFET = HwLocationType._create('BUFFET');

  static const HwLocationType BUILDING = HwLocationType._create('BUILDING');

  static const HwLocationType BULGARIAN_RESTAURANT =
      HwLocationType._create('BULGARIAN_RESTAURANT');

  static const HwLocationType BUNGALOW = HwLocationType._create('BUNGALOW');

  static const HwLocationType BURMESE_RESTAURANT =
      HwLocationType._create('BURMESE_RESTAURANT');

  static const HwLocationType BUS_CHARTER_RENTAL_COMPANY =
      HwLocationType._create('BUS_CHARTER_RENTAL_COMPANY');

  static const HwLocationType BUS_COMPANY =
      HwLocationType._create('BUS_COMPANY');

  static const HwLocationType BUS_DEALER = HwLocationType._create('BUS_DEALER');

  static const HwLocationType BUS_STOP = HwLocationType._create('BUS_STOP');

  static const HwLocationType BUSINESS = HwLocationType._create('BUSINESS');

  static const HwLocationType BUSINESS_PARK =
      HwLocationType._create('BUSINESS_PARK');

  static const HwLocationType BUSINESS_SERVICES_COMPANY =
      HwLocationType._create('BUSINESS_SERVICES_COMPANY');

  static const HwLocationType CABARET = HwLocationType._create('CABARET');

  static const HwLocationType CABINS_LODGES =
      HwLocationType._create('CABINS_LODGES');

  static const HwLocationType CABLE_TELEPHONE_COMPANY =
      HwLocationType._create('CABLE_TELEPHONE_COMPANY');

  static const HwLocationType CAFE = HwLocationType._create('CAFE');

  static const HwLocationType CAFE_PUB = HwLocationType._create('CAFE_PUB');

  static const HwLocationType CAFETERIA = HwLocationType._create('CAFETERIA');

  static const HwLocationType CALIFORNIAN_RESTAURANT =
      HwLocationType._create('CALIFORNIAN_RESTAURANT');

  static const HwLocationType CAMBODIAN_RESTAURANT =
      HwLocationType._create('CAMBODIAN_RESTAURANT');

  static const HwLocationType CAMPING_GROUND =
      HwLocationType._create('CAMPING_GROUND');

  static const HwLocationType CANADIAN_RESTAURANT =
      HwLocationType._create('CANADIAN_RESTAURANT');

  static const HwLocationType CAPE = HwLocationType._create('CAPE');

  static const HwLocationType CAPITAL = HwLocationType._create('CAPITAL');

  static const HwLocationType CAPITAL_CITY =
      HwLocationType._create('CAPITAL_CITY');

  static const HwLocationType CAR_CLUB = HwLocationType._create('CAR_CLUB');

  static const HwLocationType CAR_DEALER = HwLocationType._create('CAR_DEALER');

  static const HwLocationType CAR_RENTAL = HwLocationType._create('CAR_RENTAL');

  static const HwLocationType CAR_RENTAL_COMPANY =
      HwLocationType._create('CAR_RENTAL_COMPANY');

  static const HwLocationType CAR_WASH = HwLocationType._create('CAR_WASH');

  static const HwLocationType CAR_WASH_SUB =
      HwLocationType._create('CAR_WASH_SUB');

  static const HwLocationType CARAVAN_SITE =
      HwLocationType._create('CARAVAN_SITE');

  static const HwLocationType CARGO_CENTER =
      HwLocationType._create('CARGO_CENTER');

  static const HwLocationType CARIBBEAN_RESTAURANT =
      HwLocationType._create('CARIBBEAN_RESTAURANT');

  static const HwLocationType CARPET_FLOOR_COVERING_STORE =
      HwLocationType._create('CARPET_FLOOR_COVERING_STORE');

  static const HwLocationType CASINO = HwLocationType._create('CASINO');

  static const HwLocationType CATERING_COMPANY =
      HwLocationType._create('CATERING_COMPANY');

  static const HwLocationType CAVE = HwLocationType._create('CAVE');

  static const HwLocationType CD_DVD_VIDEO_RENTAL_STORE =
      HwLocationType._create('CD_DVD_VIDEO_RENTAL_STORE');

  static const HwLocationType CD_DVD_VIDEO_STORE =
      HwLocationType._create('CD_DVD_VIDEO_STORE');

  static const HwLocationType CD_DVD_VIDEO_STORE_SUB =
      HwLocationType._create('CD_DVD_VIDEO_STORE_SUB');

  static const HwLocationType CEMETERY = HwLocationType._create('CEMETERY');

  static const HwLocationType CHALET = HwLocationType._create('CHALET');

  static const HwLocationType CHEMICAL_COMPANY =
      HwLocationType._create('CHEMICAL_COMPANY');

  static const HwLocationType CHICKEN_RESTAURANT =
      HwLocationType._create('CHICKEN_RESTAURANT');

  static const HwLocationType CHILD_CARE_FACILITY =
      HwLocationType._create('CHILD_CARE_FACILITY');

  static const HwLocationType CHILDRENS_MUSEUM =
      HwLocationType._create('CHILDRENS_MUSEUM');

  static const HwLocationType CHILEAN_RESTAURANT =
      HwLocationType._create('CHILEAN_RESTAURANT');

  static const HwLocationType CHINESE_MEDICINE_HOSPITAL =
      HwLocationType._create('CHINESE_MEDICINE_HOSPITAL');

  static const HwLocationType CHINESE_RESTAURANT =
      HwLocationType._create('CHINESE_RESTAURANT');

  static const HwLocationType CHRISTMAS_HOLIDAY_STORE =
      HwLocationType._create('CHRISTMAS_HOLIDAY_STORE');

  static const HwLocationType CHURCH = HwLocationType._create('CHURCH');

  static const HwLocationType CINEMA = HwLocationType._create('CINEMA');

  static const HwLocationType CINEMA_SUB = HwLocationType._create('CINEMA_SUB');

  static const HwLocationType CITIES = HwLocationType._create('CITIES');

  static const HwLocationType CITY_CENTER =
      HwLocationType._create('CITY_CENTER');

  static const HwLocationType CITY_HALL = HwLocationType._create('CITY_HALL');

  static const HwLocationType CIVIC_COMMUNITY_CENTER =
      HwLocationType._create('CIVIC_COMMUNITY_CENTER');

  static const HwLocationType CLEANING_SERVICE_COMPANY =
      HwLocationType._create('CLEANING_SERVICE_COMPANY');

  static const HwLocationType CLOTHING_ACCESSORIES_STORE =
      HwLocationType._create('CLOTHING_ACCESSORIES_STORE');

  static const HwLocationType CLUB_ASSOCIATION =
      HwLocationType._create('CLUB_ASSOCIATION');

  static const HwLocationType COACH_PARKING_AREA =
      HwLocationType._create('COACH_PARKING_AREA');

  static const HwLocationType COACH_STATION =
      HwLocationType._create('COACH_STATION');

  static const HwLocationType COCKTAIL_BAR =
      HwLocationType._create('COCKTAIL_BAR');

  static const HwLocationType COFFEE_SHOP =
      HwLocationType._create('COFFEE_SHOP');

  static const HwLocationType COLLEGE_UNIVERSITY =
      HwLocationType._create('COLLEGE_UNIVERSITY');

  static const HwLocationType COLOMBIAN_RESTAURANT =
      HwLocationType._create('COLOMBIAN_RESTAURANT');

  static const HwLocationType COMEDY_CLUB =
      HwLocationType._create('COMEDY_CLUB');

  static const HwLocationType COMMERCIAL_BUILDING =
      HwLocationType._create('COMMERCIAL_BUILDING');

  static const HwLocationType COMMUNITY_CENTER =
      HwLocationType._create('COMMUNITY_CENTER');

  static const HwLocationType COMPANY = HwLocationType._create('COMPANY');

  static const HwLocationType COMPUTER_AND_DATA_SERVICES_CORPORATION =
      HwLocationType._create('COMPUTER_AND_DATA_SERVICES_CORPORATION');

  static const HwLocationType COMPUTER_SOFTWARE_COMPANY =
      HwLocationType._create('COMPUTER_SOFTWARE_COMPANY');

  static const HwLocationType COMPUTER_STORE =
      HwLocationType._create('COMPUTER_STORE');

  static const HwLocationType CONCERT_HALL =
      HwLocationType._create('CONCERT_HALL');

  static const HwLocationType CONDOMINIUM_COMPLEX =
      HwLocationType._create('CONDOMINIUM_COMPLEX');

  static const HwLocationType CONSTRUCTION_COMPANY =
      HwLocationType._create('CONSTRUCTION_COMPANY');

  static const HwLocationType CONSTRUCTION_MATERIAL_EQUIPMENT_SHOP =
      HwLocationType._create('CONSTRUCTION_MATERIAL_EQUIPMENT_SHOP');

  static const HwLocationType CONSUMER_ELECTRONICS_STORE =
      HwLocationType._create('CONSUMER_ELECTRONICS_STORE');

  static const HwLocationType CONTINENT = HwLocationType._create('CONTINENT');

  static const HwLocationType CONVENIENCE_STORE =
      HwLocationType._create('CONVENIENCE_STORE');

  static const HwLocationType CORSICAN_RESTAURANT =
      HwLocationType._create('CORSICAN_RESTAURANT');

  static const HwLocationType COTTAGE = HwLocationType._create('COTTAGE');

  static const HwLocationType COUNTRY = HwLocationType._create('COUNTRY');

  static const HwLocationType COUNTY = HwLocationType._create('COUNTY');

  static const HwLocationType COUNTY_COUNCIL =
      HwLocationType._create('COUNTY_COUNCIL');

  static const HwLocationType COURIER_DROP_BOX =
      HwLocationType._create('COURIER_DROP_BOX');

  static const HwLocationType COURTHOUSE = HwLocationType._create('COURTHOUSE');

  static const HwLocationType COVE = HwLocationType._create('COVE');

  static const HwLocationType CREOLE_CAJUN_RESTAURANT =
      HwLocationType._create('CREOLE_CAJUN_RESTAURANT');

  static const HwLocationType CREPERIE = HwLocationType._create('CREPERIE');

  static const HwLocationType CRICKET_GROUND =
      HwLocationType._create('CRICKET_GROUND');

  static const HwLocationType CUBAN_RESTAURANT =
      HwLocationType._create('CUBAN_RESTAURANT');

  static const HwLocationType CULINARY_SCHOOL =
      HwLocationType._create('CULINARY_SCHOOL');

  static const HwLocationType CULTURAL_CENTER =
      HwLocationType._create('CULTURAL_CENTER');

  static const HwLocationType CURRENCY_EXCHANGE =
      HwLocationType._create('CURRENCY_EXCHANGE');

  static const HwLocationType CURTAIN_TEXTILE_STORE =
      HwLocationType._create('CURTAIN_TEXTILE_STORE');

  static const HwLocationType CYPRIOT_RESTAURANT =
      HwLocationType._create('CYPRIOT_RESTAURANT');

  static const HwLocationType CZECH_RESTAURANT =
      HwLocationType._create('CZECH_RESTAURANT');

  static const HwLocationType DAM = HwLocationType._create('DAM');

  static const HwLocationType DANCE_STUDIO_SCHOOL =
      HwLocationType._create('DANCE_STUDIO_SCHOOL');

  static const HwLocationType DANCING_CLUB =
      HwLocationType._create('DANCING_CLUB');

  static const HwLocationType DANISH_RESTAURANT =
      HwLocationType._create('DANISH_RESTAURANT');

  static const HwLocationType DELICATESSEN_STORE =
      HwLocationType._create('DELICATESSEN_STORE');

  static const HwLocationType DELIVERY_ENTRANCE =
      HwLocationType._create('DELIVERY_ENTRANCE');

  static const HwLocationType DENTAL_CLINIC =
      HwLocationType._create('DENTAL_CLINIC');

  static const HwLocationType DEPARTMENT_STORE =
      HwLocationType._create('DEPARTMENT_STORE');

  static const HwLocationType DHARMA_TEMPLE =
      HwLocationType._create('DHARMA_TEMPLE');

  static const HwLocationType DINNER_THEATER =
      HwLocationType._create('DINNER_THEATER');

  static const HwLocationType DISCOTHEQUE =
      HwLocationType._create('DISCOTHEQUE');

  static const HwLocationType DIVERSIFIED_FINANCIAL_SERVICE_COMPANY =
      HwLocationType._create('DIVERSIFIED_FINANCIAL_SERVICE_COMPANY');

  static const HwLocationType DIVING_CENTER =
      HwLocationType._create('DIVING_CENTER');

  static const HwLocationType DO_IT_YOURSELF_CENTERS =
      HwLocationType._create('DO_IT_YOURSELF_CENTERS');

  static const HwLocationType DOCK = HwLocationType._create('DOCK');

  static const HwLocationType DOMINICAN_RESTAURANT =
      HwLocationType._create('DOMINICAN_RESTAURANT');

  static const HwLocationType DONGBEI_RESTAURANT =
      HwLocationType._create('DONGBEI_RESTAURANT');

  static const HwLocationType DOUGHNUT_SHOP =
      HwLocationType._create('DOUGHNUT_SHOP');

  static const HwLocationType DRIVE_IN_CINEMA =
      HwLocationType._create('DRIVE_IN_CINEMA');

  static const HwLocationType DRIVE_THROUGH_BOTTLE_SHOP =
      HwLocationType._create('DRIVE_THROUGH_BOTTLE_SHOP');

  static const HwLocationType DRIVING_SCHOOL =
      HwLocationType._create('DRIVING_SCHOOL');

  static const HwLocationType DRUGSTORE = HwLocationType._create('DRUGSTORE');

  static const HwLocationType DRY_CLEANERS =
      HwLocationType._create('DRY_CLEANERS');

  static const HwLocationType DUNE = HwLocationType._create('DUNE');

  static const HwLocationType DUTCH_RESTAURANT =
      HwLocationType._create('DUTCH_RESTAURANT');

  static const HwLocationType EARTHQUAKE_ASSEMBLY_POINT_ =
      HwLocationType._create('EARTHQUAKE_ASSEMBLY_POINT_');

  static const HwLocationType EATING_DRINKING =
      HwLocationType._create('EATING_DRINKING');

  static const HwLocationType EDUCATION_INSTITUTION =
      HwLocationType._create('EDUCATION_INSTITUTION');

  static const HwLocationType EGYPTIAN_RESTAURANT =
      HwLocationType._create('EGYPTIAN_RESTAURANT');

  static const HwLocationType ELECTRIC_VEHICLE_CHARGING_STATION =
      HwLocationType._create('ELECTRIC_VEHICLE_CHARGING_STATION');

  static const HwLocationType ELECTRICAL_APPLIANCE_STORE =
      HwLocationType._create('ELECTRICAL_APPLIANCE_STORE');

  static const HwLocationType ELECTRICAL_APPLIANCE_STORE_SUB =
      HwLocationType._create('ELECTRICAL_APPLIANCE_STORE_SUB');

  static const HwLocationType ELECTRONICS_COMPANY =
      HwLocationType._create('ELECTRONICS_COMPANY');

  static const HwLocationType ELECTRONICS_STORE =
      HwLocationType._create('ELECTRONICS_STORE');

  static const HwLocationType EMBASSY = HwLocationType._create('EMBASSY');

  static const HwLocationType EMERGENCY_ASSEMBLY_POINT =
      HwLocationType._create('EMERGENCY_ASSEMBLY_POINT');

  static const HwLocationType EMERGENCY_MEDICAL_SERVICE_CENTER =
      HwLocationType._create('EMERGENCY_MEDICAL_SERVICE_CENTER');

  static const HwLocationType EMERGENCY_ROOM =
      HwLocationType._create('EMERGENCY_ROOM');

  static const HwLocationType ENGLISH_RESTAURANT =
      HwLocationType._create('ENGLISH_RESTAURANT');

  static const HwLocationType ENTERTAINMENT_CABARET_LIVE =
      HwLocationType._create('ENTERTAINMENT_CABARET_LIVE');

  static const HwLocationType ENTERTAINMENT_PLACE =
      HwLocationType._create('ENTERTAINMENT_PLACE');

  static const HwLocationType EQUIPMENT_RENTAL_COMPANY =
      HwLocationType._create('EQUIPMENT_RENTAL_COMPANY');

  static const HwLocationType EROTIC_RESTAURANT =
      HwLocationType._create('EROTIC_RESTAURANT');

  static const HwLocationType ESTABLISHMENT =
      HwLocationType._create('ESTABLISHMENT');

  static const HwLocationType ETHIOPIAN_RESTAURANT =
      HwLocationType._create('ETHIOPIAN_RESTAURANT');

  static const HwLocationType EXCHANGE = HwLocationType._create('EXCHANGE');

  static const HwLocationType EXHIBITION_CONVENTION_CENTER =
      HwLocationType._create('EXHIBITION_CONVENTION_CENTER');

  static const HwLocationType EXOTIC_RESTAURANT =
      HwLocationType._create('EXOTIC_RESTAURANT');

  static const HwLocationType FACTORY_OUTLETS =
      HwLocationType._create('FACTORY_OUTLETS');

  static const HwLocationType FAIRGROUND = HwLocationType._create('FAIRGROUND');

  static const HwLocationType FARM = HwLocationType._create('FARM');

  static const HwLocationType FARMER_MARKET =
      HwLocationType._create('FARMER_MARKET');

  static const HwLocationType FAST_FOOD_RESTAURANT =
      HwLocationType._create('FAST_FOOD_RESTAURANT');

  static const HwLocationType FERRY_TERMINAL =
      HwLocationType._create('FERRY_TERMINAL');

  static const HwLocationType FILIPINO_RESTAURANT =
      HwLocationType._create('FILIPINO_RESTAURANT');

  static const HwLocationType FINNISH_RESTAURANT =
      HwLocationType._create('FINNISH_RESTAURANT');

  static const HwLocationType FIRE_ASSEMBLY_POINT =
      HwLocationType._create('FIRE_ASSEMBLY_POINT');

  static const HwLocationType FIRE_STATION_BRIGADE =
      HwLocationType._create('FIRE_STATION_BRIGADE');

  static const HwLocationType FISH_STORE = HwLocationType._create('FISH_STORE');

  static const HwLocationType FISHING_HUNTING_AREA =
      HwLocationType._create('FISHING_HUNTING_AREA');

  static const HwLocationType FITNESS_CLUB_CENTER =
      HwLocationType._create('FITNESS_CLUB_CENTER');

  static const HwLocationType FIVE_STAR_HOTEL =
      HwLocationType._create('FIVE_STAR_HOTEL');

  static const HwLocationType FLATS_APARTMENT_COMPLEX =
      HwLocationType._create('FLATS_APARTMENT_COMPLEX');

  static const HwLocationType FLOOD_ASSEMBLY_POINT =
      HwLocationType._create('FLOOD_ASSEMBLY_POINT');

  static const HwLocationType FLORISTS = HwLocationType._create('FLORISTS');

  static const HwLocationType FLYING_CLUB =
      HwLocationType._create('FLYING_CLUB');

  static const HwLocationType FONDUE_RESTAURANT =
      HwLocationType._create('FONDUE_RESTAURANT');

  static const HwLocationType FOOD_DRINK_SHOP =
      HwLocationType._create('FOOD_DRINK_SHOP');

  static const HwLocationType FOOD_MARKET =
      HwLocationType._create('FOOD_MARKET');

  static const HwLocationType FOOTBALL_FIELD =
      HwLocationType._create('FOOTBALL_FIELD');

  static const HwLocationType FOREST_AREA =
      HwLocationType._create('FOREST_AREA');

  static const HwLocationType FOUR_STAR_HOTEL =
      HwLocationType._create('FOUR_STAR_HOTEL');

  static const HwLocationType FRENCH_RESTAURANT =
      HwLocationType._create('FRENCH_RESTAURANT');

  static const HwLocationType FUNERAL_SERVICE_COMPANY =
      HwLocationType._create('FUNERAL_SERVICE_COMPANY');

  static const HwLocationType FURNITURE_ACCESSORIES_STORE =
      HwLocationType._create('FURNITURE_ACCESSORIES_STORE');

  static const HwLocationType FURNITURE_STORE =
      HwLocationType._create('FURNITURE_STORE');

  static const HwLocationType FUSION_RESTAURANT =
      HwLocationType._create('FUSION_RESTAURANT');

  static const HwLocationType GALLERY = HwLocationType._create('GALLERY');

  static const HwLocationType GARDENING_CERVICE_CENTER =
      HwLocationType._create('GARDENING_CERVICE_CENTER');

  static const HwLocationType GENERAL_AUTO_REPAIR_SERVICE_CENTER =
      HwLocationType._create('GENERAL_AUTO_REPAIR_SERVICE_CENTER');

  static const HwLocationType GENERAL_CITY =
      HwLocationType._create('GENERAL_CITY');

  static const HwLocationType GENERAL_CLINIC =
      HwLocationType._create('GENERAL_CLINIC');

  static const HwLocationType GENERAL_HOSPITAL =
      HwLocationType._create('GENERAL_HOSPITAL');

  static const HwLocationType GENERAL_POST_OFFICE =
      HwLocationType._create('GENERAL_POST_OFFICE');

  static const HwLocationType GEOCODE = HwLocationType._create('GEOCODE');

  static const HwLocationType GEOGRAPHIC_FEATURE =
      HwLocationType._create('GEOGRAPHIC_FEATURE');

  static const HwLocationType GERMAN_RESTAURANT =
      HwLocationType._create('GERMAN_RESTAURANT');

  static const HwLocationType GIFT_STORE = HwLocationType._create('GIFT_STORE');

  static const HwLocationType GLASS_WINDOW_STORE =
      HwLocationType._create('GLASS_WINDOW_STORE');

  static const HwLocationType GLASSWARE_CERAMIC_SHOP =
      HwLocationType._create('GLASSWARE_CERAMIC_SHOP');

  static const HwLocationType GOLD_EXCHANGE =
      HwLocationType._create('GOLD_EXCHANGE');

  static const HwLocationType GOLF_COURSE =
      HwLocationType._create('GOLF_COURSE');

  static const HwLocationType GOVERNMENT_OFFICE =
      HwLocationType._create('GOVERNMENT_OFFICE');

  static const HwLocationType GOVERNMENT_PUBLIC_SERVICE =
      HwLocationType._create('GOVERNMENT_PUBLIC_SERVICE');

  static const HwLocationType GREEK_RESTAURANT =
      HwLocationType._create('GREEK_RESTAURANT');

  static const HwLocationType GREENGROCERY =
      HwLocationType._create('GREENGROCERY');

  static const HwLocationType GRILL = HwLocationType._create('GRILL');

  static const HwLocationType GROCERY = HwLocationType._create('GROCERY');

  static const HwLocationType GUANGDONG_RESTAURANT =
      HwLocationType._create('GUANGDONG_RESTAURANT');

  static const HwLocationType GURUDWARA = HwLocationType._create('GURUDWARA');

  static const HwLocationType HAIR_SALON_BARBERSHOP =
      HwLocationType._create('HAIR_SALON_BARBERSHOP');

  static const HwLocationType HAMBURGER_RESTAURANT =
      HwLocationType._create('HAMBURGER_RESTAURANT');

  static const HwLocationType HAMLET = HwLocationType._create('HAMLET');

  static const HwLocationType HARBOR = HwLocationType._create('HARBOR');

  static const HwLocationType HARDWARE_STORE =
      HwLocationType._create('HARDWARE_STORE');

  static const HwLocationType HEALTH_CARE =
      HwLocationType._create('HEALTH_CARE');

  static const HwLocationType HEALTHCARE_SERVICE_CENTER =
      HwLocationType._create('HEALTHCARE_SERVICE_CENTER');

  static const HwLocationType HELIPAD_HELICOPTER_LANDING =
      HwLocationType._create('HELIPAD_HELICOPTER_LANDING');

  static const HwLocationType HIGH_SCHOOL =
      HwLocationType._create('HIGH_SCHOOL');

  static const HwLocationType HIGHWAY__ENTRANCE =
      HwLocationType._create('HIGHWAY__ENTRANCE');

  static const HwLocationType HIGHWAY_EXIT =
      HwLocationType._create('HIGHWAY_EXIT');

  static const HwLocationType HIKING_TRAIL =
      HwLocationType._create('HIKING_TRAIL');

  static const HwLocationType HILL = HwLocationType._create('HILL');

  static const HwLocationType HINDU_TEMPLE =
      HwLocationType._create('HINDU_TEMPLE');

  static const HwLocationType HISTORIC_SITE =
      HwLocationType._create('HISTORIC_SITE');

  static const HwLocationType HISTORICAL_PARK =
      HwLocationType._create('HISTORICAL_PARK');

  static const HwLocationType HISTORY_MUSEUM =
      HwLocationType._create('HISTORY_MUSEUM');

  static const HwLocationType HOBBY_SHOP = HwLocationType._create('HOBBY_SHOP');

  static const HwLocationType HOCKEY_CLUB =
      HwLocationType._create('HOCKEY_CLUB');

  static const HwLocationType HOCKEY_FIELD =
      HwLocationType._create('HOCKEY_FIELD');

  static const HwLocationType HOLIDAY_HOUSE_RENTAL =
      HwLocationType._create('HOLIDAY_HOUSE_RENTAL');

  static const HwLocationType HOME_APPLIANCE_REPAIR_COMPANY =
      HwLocationType._create('HOME_APPLIANCE_REPAIR_COMPANY');

  static const HwLocationType HOME_GOODS_STORE =
      HwLocationType._create('HOME_GOODS_STORE');

  static const HwLocationType HORSE_RACING_TRACK =
      HwLocationType._create('HORSE_RACING_TRACK');

  static const HwLocationType HORSE_RIDING_FIELD =
      HwLocationType._create('HORSE_RIDING_FIELD');

  static const HwLocationType HORSE_RIDING_TRAIL =
      HwLocationType._create('HORSE_RIDING_TRAIL');

  static const HwLocationType HORTICULTURE_COMPANY =
      HwLocationType._create('HORTICULTURE_COMPANY');

  static const HwLocationType HOSPITAL_FOR_WOMEN_AND_CHILDREN =
      HwLocationType._create('HOSPITAL_FOR_WOMEN_AND_CHILDREN');

  static const HwLocationType HOSPITAL_POLYCLINIC =
      HwLocationType._create('HOSPITAL_POLYCLINIC');

  static const HwLocationType HOSTEL = HwLocationType._create('HOSTEL');

  static const HwLocationType HOT_POT_RESTAURANT =
      HwLocationType._create('HOT_POT_RESTAURANT');

  static const HwLocationType HOTEL = HwLocationType._create('HOTEL');

  static const HwLocationType HOTEL_MOTEL =
      HwLocationType._create('HOTEL_MOTEL');

  static const HwLocationType HOTELS_WITH_LESS_THAN_TWO_STARS =
      HwLocationType._create('HOTELS_WITH_LESS_THAN_TWO_STARS');

  static const HwLocationType HOUSEHOLD_APPLIANCE_STORE =
      HwLocationType._create('HOUSEHOLD_APPLIANCE_STORE');

  static const HwLocationType HUNAN_RESTAURANT =
      HwLocationType._create('HUNAN_RESTAURANT');

  static const HwLocationType HUNGARIAN_RESTAURANT =
      HwLocationType._create('HUNGARIAN_RESTAURANT');

  static const HwLocationType ICE_CREAM_PARLOR =
      HwLocationType._create('ICE_CREAM_PARLOR');

  static const HwLocationType ICE_HOCKEY_RINK =
      HwLocationType._create('ICE_HOCKEY_RINK');

  static const HwLocationType ICE_SKATING_RINK =
      HwLocationType._create('ICE_SKATING_RINK');

  static const HwLocationType IMPORT_AND_EXPORT_DISTRIBUTION_COMPANY =
      HwLocationType._create('IMPORT_AND_EXPORT_DISTRIBUTION_COMPANY');

  static const HwLocationType IMPORTANT_TOURIST_ATTRACTION =
      HwLocationType._create('IMPORTANT_TOURIST_ATTRACTION');

  static const HwLocationType INDIAN_RESTAURANT =
      HwLocationType._create('INDIAN_RESTAURANT');

  static const HwLocationType INDONESIAN_RESTAURANT =
      HwLocationType._create('INDONESIAN_RESTAURANT');

  static const HwLocationType INDUSTRIAL_BUILDING =
      HwLocationType._create('INDUSTRIAL_BUILDING');

  static const HwLocationType INFORMAL_MARKET =
      HwLocationType._create('INFORMAL_MARKET');

  static const HwLocationType INSURANCE_COMPANY =
      HwLocationType._create('INSURANCE_COMPANY');

  static const HwLocationType INTERCITY_RAILWAY_STATION =
      HwLocationType._create('INTERCITY_RAILWAY_STATION');

  static const HwLocationType INTERNATIONAL_ORGANIZATION =
      HwLocationType._create('INTERNATIONAL_ORGANIZATION');

  static const HwLocationType INTERNATIONAL_RAILWAY_STATION =
      HwLocationType._create('INTERNATIONAL_RAILWAY_STATION');

  static const HwLocationType INTERNATIONAL_RESTAURANT =
      HwLocationType._create('INTERNATIONAL_RESTAURANT');

  static const HwLocationType INTERNET_CAFE =
      HwLocationType._create('INTERNET_CAFE');

  static const HwLocationType INVESTMENT_CONSULTING_FIRM =
      HwLocationType._create('INVESTMENT_CONSULTING_FIRM');

  static const HwLocationType IRANIAN_RESTAURANT =
      HwLocationType._create('IRANIAN_RESTAURANT');

  static const HwLocationType IRISH_RESTAURANT =
      HwLocationType._create('IRISH_RESTAURANT');

  static const HwLocationType ISLAND = HwLocationType._create('ISLAND');

  static const HwLocationType ISRAELI_RESTAURANT =
      HwLocationType._create('ISRAELI_RESTAURANT');

  static const HwLocationType ITALIAN_RESTAURANT =
      HwLocationType._create('ITALIAN_RESTAURANT');

  static const HwLocationType JAIN_TEMPLE =
      HwLocationType._create('JAIN_TEMPLE');

  static const HwLocationType JAMAICAN_RESTAURANT =
      HwLocationType._create('JAMAICAN_RESTAURANT');

  static const HwLocationType JAPANESE_RESTAURANT =
      HwLocationType._create('JAPANESE_RESTAURANT');

  static const HwLocationType JAZZ_CLUB = HwLocationType._create('JAZZ_CLUB');

  static const HwLocationType JEWELRY_CLOCK_AND_WATCH_SHOP =
      HwLocationType._create('JEWELRY_CLOCK_AND_WATCH_SHOP');

  static const HwLocationType JEWISH_RESTAURANT =
      HwLocationType._create('JEWISH_RESTAURANT');

  static const HwLocationType JUNIOR_COLLEGE_COMMUNITY_COLLEGE =
      HwLocationType._create('JUNIOR_COLLEGE_COMMUNITY_COLLEGE');

  static const HwLocationType KARAOKE_CLUB =
      HwLocationType._create('KARAOKE_CLUB');

  static const HwLocationType KITCHEN_AND_SANITATION_STORE =
      HwLocationType._create('KITCHEN_AND_SANITATION_STORE');

  static const HwLocationType KOREAN_RESTAURANT =
      HwLocationType._create('KOREAN_RESTAURANT');

  static const HwLocationType KOSHER_RESTAURANT =
      HwLocationType._create('KOSHER_RESTAURANT');

  static const HwLocationType LAGOON = HwLocationType._create('LAGOON');

  static const HwLocationType LAKESHORE = HwLocationType._create('LAKESHORE');

  static const HwLocationType LANGUAGE_SCHOOL =
      HwLocationType._create('LANGUAGE_SCHOOL');

  static const HwLocationType LATIN_AMERICAN_RESTAURANT =
      HwLocationType._create('LATIN_AMERICAN_RESTAURANT');

  static const HwLocationType LAUNDRY = HwLocationType._create('LAUNDRY');

  static const HwLocationType LEBANESE_RESTAURANT =
      HwLocationType._create('LEBANESE_RESTAURANT');

  static const HwLocationType LEGAL_SERVICE_COMPANY =
      HwLocationType._create('LEGAL_SERVICE_COMPANY');

  static const HwLocationType LEISURE = HwLocationType._create('LEISURE');

  static const HwLocationType LEISURE_CENTER =
      HwLocationType._create('LEISURE_CENTER');

  static const HwLocationType LIBRARY = HwLocationType._create('LIBRARY');

  static const HwLocationType LIGHTING_STORE =
      HwLocationType._create('LIGHTING_STORE');

  static const HwLocationType LOADING_ZONE =
      HwLocationType._create('LOADING_ZONE');

  static const HwLocationType LOCAL_POST_OFFICE =
      HwLocationType._create('LOCAL_POST_OFFICE');

  static const HwLocationType LOCAL_SPECIALTY_STORE =
      HwLocationType._create('LOCAL_SPECIALTY_STORE');

  static const HwLocationType LODGING_LIVING_ACCOMMODATION =
      HwLocationType._create('LODGING_LIVING_ACCOMMODATION');

  static const HwLocationType LOTTERY_SHOP =
      HwLocationType._create('LOTTERY_SHOP');

  static const HwLocationType LUXEMBOURGIAN_RESTAURANT =
      HwLocationType._create('LUXEMBOURGIAN_RESTAURANT');

  static const HwLocationType MACROBIOTIC_RESTAURANT =
      HwLocationType._create('MACROBIOTIC_RESTAURANT');

  static const HwLocationType MAGHRIB_RESTAURANT =
      HwLocationType._create('MAGHRIB_RESTAURANT');

  static const HwLocationType MAIL_PACKAGE_FREIGHT_DELIVERY_COMPANY =
      HwLocationType._create('MAIL_PACKAGE_FREIGHT_DELIVERY_COMPANY');

  static const HwLocationType MALTESE_RESTAURANT =
      HwLocationType._create('MALTESE_RESTAURANT');

  static const HwLocationType MANUFACTURING_COMPANY =
      HwLocationType._create('MANUFACTURING_COMPANY');

  static const HwLocationType MANUFACTURING_FACTORY =
      HwLocationType._create('MANUFACTURING_FACTORY');

  static const HwLocationType MARINA = HwLocationType._create('MARINA');

  static const HwLocationType MARINA_SUB = HwLocationType._create('MARINA_SUB');

  static const HwLocationType MARINE_ELECTRONIC_EQUIPMENT_STORE =
      HwLocationType._create('MARINE_ELECTRONIC_EQUIPMENT_STORE');

  static const HwLocationType MARKET = HwLocationType._create('MARKET');

  static const HwLocationType MARSH_SWAMP_VLEI =
      HwLocationType._create('MARSH_SWAMP_VLEI');

  static const HwLocationType MAURITIAN_RESTAURANT =
      HwLocationType._create('MAURITIAN_RESTAURANT');

  static const HwLocationType MAUSOLEUM_GRAVE =
      HwLocationType._create('MAUSOLEUM_GRAVE');

  static const HwLocationType MEAT_STORE = HwLocationType._create('MEAT_STORE');

  static const HwLocationType MECHANICAL_ENGINEERING_COMPANY =
      HwLocationType._create('MECHANICAL_ENGINEERING_COMPANY');

  static const HwLocationType MEDIA_COMPANY =
      HwLocationType._create('MEDIA_COMPANY');

  static const HwLocationType MEDICAL_CLINIC =
      HwLocationType._create('MEDICAL_CLINIC');

  static const HwLocationType MEDICAL_SUPPLIES_EQUIPMENT_STORE =
      HwLocationType._create('MEDICAL_SUPPLIES_EQUIPMENT_STORE');

  static const HwLocationType MEDITERRANEAN_RESTAURANT =
      HwLocationType._create('MEDITERRANEAN_RESTAURANT');

  static const HwLocationType MEMORIAL = HwLocationType._create('MEMORIAL');

  static const HwLocationType MEMORIAL_PLACE =
      HwLocationType._create('MEMORIAL_PLACE');

  static const HwLocationType METRO = HwLocationType._create('METRO');

  static const HwLocationType MEXICAN_RESTAURANT =
      HwLocationType._create('MEXICAN_RESTAURANT');

  static const HwLocationType MICROBREWERY_BEER_GARDEN =
      HwLocationType._create('MICROBREWERY_BEER_GARDEN');

  static const HwLocationType MIDDLE_EASTERN_RESTAURANT =
      HwLocationType._create('MIDDLE_EASTERN_RESTAURANT');

  static const HwLocationType MIDDLE_SCHOOL =
      HwLocationType._create('MIDDLE_SCHOOL');

  static const HwLocationType MILITARY_AUTHORITY =
      HwLocationType._create('MILITARY_AUTHORITY');

  static const HwLocationType MILITARY_BASE =
      HwLocationType._create('MILITARY_BASE');

  static const HwLocationType MINERAL_COMPANY =
      HwLocationType._create('MINERAL_COMPANY');

  static const HwLocationType MINERAL_HOT_SPRINGS =
      HwLocationType._create('MINERAL_HOT_SPRINGS');

  static const HwLocationType MISCELLANEOUS =
      HwLocationType._create('MISCELLANEOUS');

  static const HwLocationType MOBILE_PHONE_STORE =
      HwLocationType._create('MOBILE_PHONE_STORE');

  static const HwLocationType MONGOLIAN_RESTAURANT =
      HwLocationType._create('MONGOLIAN_RESTAURANT');

  static const HwLocationType MONUMENT = HwLocationType._create('MONUMENT');

  static const HwLocationType MORMON_CHURCH =
      HwLocationType._create('MORMON_CHURCH');

  static const HwLocationType MOROCCAN_RESTAURANT =
      HwLocationType._create('MOROCCAN_RESTAURANT');

  static const HwLocationType MOSQUE = HwLocationType._create('MOSQUE');

  static const HwLocationType MOTEL = HwLocationType._create('MOTEL');

  static const HwLocationType MOTORCYCLE_DEALER =
      HwLocationType._create('MOTORCYCLE_DEALER');

  static const HwLocationType MOTORCYCLE_REPAIR_SHOP =
      HwLocationType._create('MOTORCYCLE_REPAIR_SHOP');

  static const HwLocationType MOTORING_ORGANIZATION_OFFICE =
      HwLocationType._create('MOTORING_ORGANIZATION_OFFICE');

  static const HwLocationType MOTORSPORT_VENUE =
      HwLocationType._create('MOTORSPORT_VENUE');

  static const HwLocationType MOUNTAIN_BIKE_TRAIL =
      HwLocationType._create('MOUNTAIN_BIKE_TRAIL');

  static const HwLocationType MOUNTAIN_PASS =
      HwLocationType._create('MOUNTAIN_PASS');

  static const HwLocationType MOUNTAIN_PEAK =
      HwLocationType._create('MOUNTAIN_PEAK');

  static const HwLocationType MOVING_STORAGE_COMPANY =
      HwLocationType._create('MOVING_STORAGE_COMPANY');

  static const HwLocationType MULTIPURPOSE_STADIUM =
      HwLocationType._create('MULTIPURPOSE_STADIUM');

  static const HwLocationType MUSEUM = HwLocationType._create('MUSEUM');

  static const HwLocationType MUSIC_CENTER =
      HwLocationType._create('MUSIC_CENTER');

  static const HwLocationType MUSICAL_INSTRUMENT_STORE =
      HwLocationType._create('MUSICAL_INSTRUMENT_STORE');

  static const HwLocationType MUSSEL_RESTAURANT =
      HwLocationType._create('MUSSEL_RESTAURANT');

  static const HwLocationType NAIL_SALON = HwLocationType._create('NAIL_SALON');

  static const HwLocationType NAMED_INTERSECTION =
      HwLocationType._create('NAMED_INTERSECTION');

  static const HwLocationType NATIONAL_ORGANIZATION =
      HwLocationType._create('NATIONAL_ORGANIZATION');

  static const HwLocationType NATIONAL_RAILWAY_STATION =
      HwLocationType._create('NATIONAL_RAILWAY_STATION');

  static const HwLocationType NATIVE_RESERVATION =
      HwLocationType._create('NATIVE_RESERVATION');

  static const HwLocationType NATURAL_ATTRACTION =
      HwLocationType._create('NATURAL_ATTRACTION');

  static const HwLocationType NATURAL_ATTRACTION_TOURIST =
      HwLocationType._create('NATURAL_ATTRACTION_TOURIST');

  static const HwLocationType NEIGHBORHOOD =
      HwLocationType._create('NEIGHBORHOOD');

  static const HwLocationType NEPALESE_RESTAURANT =
      HwLocationType._create('NEPALESE_RESTAURANT');

  static const HwLocationType NETBALL_COURT =
      HwLocationType._create('NETBALL_COURT');

  static const HwLocationType NEWSAGENTS_AND_TOBACCONISTS =
      HwLocationType._create('NEWSAGENTS_AND_TOBACCONISTS');

  static const HwLocationType NIGHT_CLUB = HwLocationType._create('NIGHT_CLUB');

  static const HwLocationType NIGHTLIFE = HwLocationType._create('NIGHTLIFE');

  static const HwLocationType NON_GOVERNMENTAL_ORGANIZATION =
      HwLocationType._create('NON_GOVERNMENTAL_ORGANIZATION');

  static const HwLocationType NORWEGIAN_RESTAURANT =
      HwLocationType._create('NORWEGIAN_RESTAURANT');

  static const HwLocationType NURSING_HOME =
      HwLocationType._create('NURSING_HOME');

  static const HwLocationType OASIS = HwLocationType._create('OASIS');

  static const HwLocationType OBSERVATION_DECK =
      HwLocationType._create('OBSERVATION_DECK');

  static const HwLocationType OBSERVATORY =
      HwLocationType._create('OBSERVATORY');

  static const HwLocationType OEM = HwLocationType._create('OEM');

  static const HwLocationType OFFICE_EQUIPMENT_STORE =
      HwLocationType._create('OFFICE_EQUIPMENT_STORE');

  static const HwLocationType OFFICE_SUPPLY_SERVICES_STORE =
      HwLocationType._create('OFFICE_SUPPLY_SERVICES_STORE');

  static const HwLocationType OIL_NATURAL_GAS_COMPANY =
      HwLocationType._create('OIL_NATURAL_GAS_COMPANY');

  static const HwLocationType OPERA = HwLocationType._create('OPERA');

  static const HwLocationType OPTICIANS = HwLocationType._create('OPTICIANS');

  static const HwLocationType ORDER_1_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_1_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_1_AREA_POLICE_STATION =
      HwLocationType._create('ORDER_1_AREA_POLICE_STATION');

  static const HwLocationType ORDER_2_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_2_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_3_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_3_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_4_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_4_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_5_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_5_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_6_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_6_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_7_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_7_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_8_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_8_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_8_AREA_POLICE_STATION =
      HwLocationType._create('ORDER_8_AREA_POLICE_STATION');

  static const HwLocationType ORDER_9_AREA_GOVERNMENT_OFFICE =
      HwLocationType._create('ORDER_9_AREA_GOVERNMENT_OFFICE');

  static const HwLocationType ORDER_9_AREA_POLICE_STATION =
      HwLocationType._create('ORDER_9_AREA_POLICE_STATION');

  static const HwLocationType ORGANIC_RESTAURANT =
      HwLocationType._create('ORGANIC_RESTAURANT');

  static const HwLocationType ORGANIZATION =
      HwLocationType._create('ORGANIZATION');

  static const HwLocationType ORIENTAL_RESTAURANT =
      HwLocationType._create('ORIENTAL_RESTAURANT');

  static const HwLocationType OUTLETS = HwLocationType._create('OUTLETS');

  static const HwLocationType PAGODA = HwLocationType._create('PAGODA');

  static const HwLocationType PAINTING_DECORATING_STORE =
      HwLocationType._create('PAINTING_DECORATING_STORE');

  static const HwLocationType PAKISTANI_RESTAURANT =
      HwLocationType._create('PAKISTANI_RESTAURANT');

  static const HwLocationType PAN = HwLocationType._create('PAN');

  static const HwLocationType PARK = HwLocationType._create('PARK');

  static const HwLocationType PARK_AND_RECREATION_AREA =
      HwLocationType._create('PARK_AND_RECREATION_AREA');

  static const HwLocationType PARK_RIDE = HwLocationType._create('PARK_RIDE');

  static const HwLocationType PARKING_GARAGE =
      HwLocationType._create('PARKING_GARAGE');

  static const HwLocationType PARKING_LOT =
      HwLocationType._create('PARKING_LOT');

  static const HwLocationType PARKING_LOT_SUB =
      HwLocationType._create('PARKING_LOT_SUB');

  static const HwLocationType PARKWAY = HwLocationType._create('PARKWAY');

  static const HwLocationType PASSENGER_TRANSPORT_TICKET_OFFICE =
      HwLocationType._create('PASSENGER_TRANSPORT_TICKET_OFFICE');

  static const HwLocationType PAWN_SHOP = HwLocationType._create('PAWN_SHOP');

  static const HwLocationType PEDESTRIAN_SUBWAY =
      HwLocationType._create('PEDESTRIAN_SUBWAY');

  static const HwLocationType PERSONAL_CARE_INSTITUTION =
      HwLocationType._create('PERSONAL_CARE_INSTITUTION');

  static const HwLocationType PERSONAL_SERVICE_CENTER =
      HwLocationType._create('PERSONAL_SERVICE_CENTER');

  static const HwLocationType PERUVIAN_RESTAURANT =
      HwLocationType._create('PERUVIAN_RESTAURANT');

  static const HwLocationType PET_STORE = HwLocationType._create('PET_STORE');

  static const HwLocationType PET_SUPPLY_STORE =
      HwLocationType._create('PET_SUPPLY_STORE');

  static const HwLocationType PETROL_STATION =
      HwLocationType._create('PETROL_STATION');

  static const HwLocationType PHARMACEUTICAL_COMPANY =
      HwLocationType._create('PHARMACEUTICAL_COMPANY');

  static const HwLocationType PHARMACY = HwLocationType._create('PHARMACY');

  static const HwLocationType PHOTO_SHOP = HwLocationType._create('PHOTO_SHOP');

  static const HwLocationType PHOTOCOPY_SHOP =
      HwLocationType._create('PHOTOCOPY_SHOP');

  static const HwLocationType PHOTOGRAPHIC_EQUIPMENT_STORE =
      HwLocationType._create('PHOTOGRAPHIC_EQUIPMENT_STORE');

  static const HwLocationType PHYSIOTHERAPY_CLINIC =
      HwLocationType._create('PHYSIOTHERAPY_CLINIC');

  static const HwLocationType PICK_UP_AND_RETURN_POINT =
      HwLocationType._create('PICK_UP_AND_RETURN_POINT');

  static const HwLocationType PICNIC_AREA =
      HwLocationType._create('PICNIC_AREA');

  static const HwLocationType PIZZA_RESTAURANT =
      HwLocationType._create('PIZZA_RESTAURANT');

  static const HwLocationType PLACE_OF_WORSHIP =
      HwLocationType._create('PLACE_OF_WORSHIP');

  static const HwLocationType PLAIN_FLAT = HwLocationType._create('PLAIN_FLAT');

  static const HwLocationType PLANETARIUM =
      HwLocationType._create('PLANETARIUM');

  static const HwLocationType PLATEAU = HwLocationType._create('PLATEAU');

  static const HwLocationType POLICE_STATION =
      HwLocationType._create('POLICE_STATION');

  static const HwLocationType POLISH_RESTAURANT =
      HwLocationType._create('POLISH_RESTAURANT');

  static const HwLocationType POLYNESIAN_RESTAURANT =
      HwLocationType._create('POLYNESIAN_RESTAURANT');

  static const HwLocationType PORT_WAREHOUSE =
      HwLocationType._create('PORT_WAREHOUSE');

  static const HwLocationType PORTUGUESE_RESTAURANT =
      HwLocationType._create('PORTUGUESE_RESTAURANT');

  static const HwLocationType POST_OFFICE =
      HwLocationType._create('POST_OFFICE');

  static const HwLocationType POSTAL_CODE =
      HwLocationType._create('POSTAL_CODE');

  static const HwLocationType PRESCHOOL = HwLocationType._create('PRESCHOOL');

  static const HwLocationType PRESERVED_AREA =
      HwLocationType._create('PRESERVED_AREA');

  static const HwLocationType PRIMARY_SCHOOL =
      HwLocationType._create('PRIMARY_SCHOOL');

  static const HwLocationType PRISON = HwLocationType._create('PRISON');

  static const HwLocationType PRIVATE_AUTHORITY =
      HwLocationType._create('PRIVATE_AUTHORITY');

  static const HwLocationType PRIVATE_CLUB =
      HwLocationType._create('PRIVATE_CLUB');

  static const HwLocationType PRODUCER_COMPANY =
      HwLocationType._create('PRODUCER_COMPANY');

  static const HwLocationType PROTECTED_AREA =
      HwLocationType._create('PROTECTED_AREA');

  static const HwLocationType PROVENCAL_RESTAURANT =
      HwLocationType._create('PROVENCAL_RESTAURANT');

  static const HwLocationType PUB = HwLocationType._create('PUB');

  static const HwLocationType PUB_FOOD = HwLocationType._create('PUB_FOOD');

  static const HwLocationType PUBLIC_AMENITY =
      HwLocationType._create('PUBLIC_AMENITY');

  static const HwLocationType PUBLIC_AUTHORITY =
      HwLocationType._create('PUBLIC_AUTHORITY');

  static const HwLocationType PUBLIC_CALL_BOX =
      HwLocationType._create('PUBLIC_CALL_BOX');

  static const HwLocationType PUBLIC_HEALTH_TECHNOLOGY_COMPANY =
      HwLocationType._create('PUBLIC_HEALTH_TECHNOLOGY_COMPANY');

  static const HwLocationType PUBLIC_MARKET =
      HwLocationType._create('PUBLIC_MARKET');

  static const HwLocationType PUBLIC_RESTROOM =
      HwLocationType._create('PUBLIC_RESTROOM');

  static const HwLocationType PUBLIC_TRANSPORT_STOP =
      HwLocationType._create('PUBLIC_TRANSPORT_STOP');

  static const HwLocationType PUBLISHING_TECHNOLOGY_COMPANY =
      HwLocationType._create('PUBLISHING_TECHNOLOGY_COMPANY');

  static const HwLocationType QUARRY = HwLocationType._create('QUARRY');

  static const HwLocationType RACE_TRACK = HwLocationType._create('RACE_TRACK');

  static const HwLocationType RAIL_FERRY = HwLocationType._create('RAIL_FERRY');

  static const HwLocationType RAILWAY_SIDING =
      HwLocationType._create('RAILWAY_SIDING');

  static const HwLocationType RAILWAY_STATION =
      HwLocationType._create('RAILWAY_STATION');

  static const HwLocationType RAPIDS = HwLocationType._create('RAPIDS');

  static const HwLocationType REAL_ESTATE_AGENCY_COMPANY =
      HwLocationType._create('REAL_ESTATE_AGENCY_COMPANY');

  static const HwLocationType REAL_ESTATE_AGENCY_SHOP =
      HwLocationType._create('REAL_ESTATE_AGENCY_SHOP');

  static const HwLocationType RECREATION_AREA =
      HwLocationType._create('RECREATION_AREA');

  static const HwLocationType RECREATIONAL_SITE =
      HwLocationType._create('RECREATIONAL_SITE');

  static const HwLocationType RECREATIONAL_VEHICLE_DEALER =
      HwLocationType._create('RECREATIONAL_VEHICLE_DEALER');

  static const HwLocationType RECYCLING_SHOP =
      HwLocationType._create('RECYCLING_SHOP');

  static const HwLocationType REEF = HwLocationType._create('REEF');

  static const HwLocationType REGIONS = HwLocationType._create('REGIONS');

  static const HwLocationType REPAIR_SHOP =
      HwLocationType._create('REPAIR_SHOP');

  static const HwLocationType RESEARCH_INSTITUTE =
      HwLocationType._create('RESEARCH_INSTITUTE');

  static const HwLocationType RESERVOIR = HwLocationType._create('RESERVOIR');

  static const HwLocationType RESIDENTIAL_ACCOMMODATION =
      HwLocationType._create('RESIDENTIAL_ACCOMMODATION');

  static const HwLocationType RESIDENTIAL_ESTATE =
      HwLocationType._create('RESIDENTIAL_ESTATE');

  static const HwLocationType RESORT = HwLocationType._create('RESORT');

  static const HwLocationType REST_AREA = HwLocationType._create('REST_AREA');

  static const HwLocationType REST_CAMPS = HwLocationType._create('REST_CAMPS');

  static const HwLocationType RESTAURANT = HwLocationType._create('RESTAURANT');

  static const HwLocationType RESTAURANT_AREA =
      HwLocationType._create('RESTAURANT_AREA');

  static const HwLocationType RETAIL_OUTLETS =
      HwLocationType._create('RETAIL_OUTLETS');

  static const HwLocationType RETIREMENT_COMMUNITY =
      HwLocationType._create('RETIREMENT_COMMUNITY');

  static const HwLocationType RIDGE = HwLocationType._create('RIDGE');

  static const HwLocationType RIVER_CROSSING =
      HwLocationType._create('RIVER_CROSSING');

  static const HwLocationType ROAD_RESCUE_POINT =
      HwLocationType._create('ROAD_RESCUE_POINT');

  static const HwLocationType ROADSIDE = HwLocationType._create('ROADSIDE');

  static const HwLocationType ROCK_CLIMBING_TRAIL =
      HwLocationType._create('ROCK_CLIMBING_TRAIL');

  static const HwLocationType ROCKS = HwLocationType._create('ROCKS');

  static const HwLocationType ROMANIAN_RESTAURANT =
      HwLocationType._create('ROMANIAN_RESTAURANT');

  static const HwLocationType ROUTE = HwLocationType._create('ROUTE');

  static const HwLocationType RUGBY_GROUND =
      HwLocationType._create('RUGBY_GROUND');

  static const HwLocationType RUSSIAN_RESTAURANT =
      HwLocationType._create('RUSSIAN_RESTAURANT');

  static const HwLocationType SALAD_BAR = HwLocationType._create('SALAD_BAR');

  static const HwLocationType SANDWICH_RESTAURANT =
      HwLocationType._create('SANDWICH_RESTAURANT');

  static const HwLocationType SAUNA_SOLARIUM_MASSAGE_CENTER =
      HwLocationType._create('SAUNA_SOLARIUM_MASSAGE_CENTER');

  static const HwLocationType SAVINGS_INSTITUTION =
      HwLocationType._create('SAVINGS_INSTITUTION');

  static const HwLocationType SAVOYAN_RESTAURANT =
      HwLocationType._create('SAVOYAN_RESTAURANT');

  static const HwLocationType SCANDINAVIAN_RESTAURANT =
      HwLocationType._create('SCANDINAVIAN_RESTAURANT');

  static const HwLocationType SCENIC_RIVER_AREA =
      HwLocationType._create('SCENIC_RIVER_AREA');

  static const HwLocationType SCHOOL = HwLocationType._create('SCHOOL');

  static const HwLocationType SCHOOL_BUS_SERVICE_COMPANY =
      HwLocationType._create('SCHOOL_BUS_SERVICE_COMPANY');

  static const HwLocationType SCIENCE_MUSEUM =
      HwLocationType._create('SCIENCE_MUSEUM');

  static const HwLocationType SCOTTISH_RESTAURANT =
      HwLocationType._create('SCOTTISH_RESTAURANT');

  static const HwLocationType SEAFOOD_RESTAURANT =
      HwLocationType._create('SEAFOOD_RESTAURANT');

  static const HwLocationType SEASHORE = HwLocationType._create('SEASHORE');

  static const HwLocationType SECURITY_GATE =
      HwLocationType._create('SECURITY_GATE');

  static const HwLocationType SECURITY_STORE =
      HwLocationType._create('SECURITY_STORE');

  static const HwLocationType SENIOR_HIGH_SCHOOL =
      HwLocationType._create('SENIOR_HIGH_SCHOOL');

  static const HwLocationType SERVICE_COMPANY =
      HwLocationType._create('SERVICE_COMPANY');

  static const HwLocationType SHANDONG_RESTAURANT =
      HwLocationType._create('SHANDONG_RESTAURANT');

  static const HwLocationType SHANGHAI_RESTAURANT =
      HwLocationType._create('SHANGHAI_RESTAURANT');

  static const HwLocationType SHINTO_SHRINE =
      HwLocationType._create('SHINTO_SHRINE');

  static const HwLocationType SHOOTING_RANGE =
      HwLocationType._create('SHOOTING_RANGE');

  static const HwLocationType SHOP = HwLocationType._create('SHOP');

  static const HwLocationType SHOPPING = HwLocationType._create('SHOPPING');

  static const HwLocationType SHOPPING_CENTER =
      HwLocationType._create('SHOPPING_CENTER');

  static const HwLocationType SHOPPING_SERVICE_CENTER =
      HwLocationType._create('SHOPPING_SERVICE_CENTER');

  static const HwLocationType SICHUAN_RESTAURANT =
      HwLocationType._create('SICHUAN_RESTAURANT');

  static const HwLocationType SICILIAN_RESTAURANT =
      HwLocationType._create('SICILIAN_RESTAURANT');

  static const HwLocationType SKI_LIFT = HwLocationType._create('SKI_LIFT');

  static const HwLocationType SKI_RESORT = HwLocationType._create('SKI_RESORT');

  static const HwLocationType SLAVIC_RESTAURANT =
      HwLocationType._create('SLAVIC_RESTAURANT');

  static const HwLocationType SLOVAK_RESTAURANT =
      HwLocationType._create('SLOVAK_RESTAURANT');

  static const HwLocationType SNACKS = HwLocationType._create('SNACKS');

  static const HwLocationType SNOOKER_POOL_BILLIARD_HALL =
      HwLocationType._create('SNOOKER_POOL_BILLIARD_HALL');

  static const HwLocationType SOCCER_FIELD =
      HwLocationType._create('SOCCER_FIELD');

  static const HwLocationType SOUL_FOOD_RESTAURANT =
      HwLocationType._create('SOUL_FOOD_RESTAURANT');

  static const HwLocationType SOUP_RESTAURANT =
      HwLocationType._create('SOUP_RESTAURANT');

  static const HwLocationType SPA = HwLocationType._create('SPA');

  static const HwLocationType SPANISH_RESTAURANT =
      HwLocationType._create('SPANISH_RESTAURANT');

  static const HwLocationType SPECIAL_SCHOOL =
      HwLocationType._create('SPECIAL_SCHOOL');

  static const HwLocationType SPECIALIST_CLINIC =
      HwLocationType._create('SPECIALIST_CLINIC');

  static const HwLocationType SPECIALIZED_HOSPITAL =
      HwLocationType._create('SPECIALIZED_HOSPITAL');

  static const HwLocationType SPECIALTY_FOOD_STORE =
      HwLocationType._create('SPECIALTY_FOOD_STORE');

  static const HwLocationType SPECIALTY_STORE =
      HwLocationType._create('SPECIALTY_STORE');

  static const HwLocationType SPORT = HwLocationType._create('SPORT');

  static const HwLocationType SPORTS_CENTER =
      HwLocationType._create('SPORTS_CENTER');

  static const HwLocationType SPORTS_CENTER_SUB =
      HwLocationType._create('SPORTS_CENTER_SUB');

  static const HwLocationType SPORTS_SCHOOL =
      HwLocationType._create('SPORTS_SCHOOL');

  static const HwLocationType SPORTS_STORE =
      HwLocationType._create('SPORTS_STORE');

  static const HwLocationType SQUASH_COURT =
      HwLocationType._create('SQUASH_COURT');

  static const HwLocationType STADIUM = HwLocationType._create('STADIUM');

  static const HwLocationType STAMP_SHOP = HwLocationType._create('STAMP_SHOP');

  static const HwLocationType STATION_ACCESS =
      HwLocationType._create('STATION_ACCESS');

  static const HwLocationType STATUE = HwLocationType._create('STATUE');

  static const HwLocationType STEAK_HOUSE =
      HwLocationType._create('STEAK_HOUSE');

  static const HwLocationType STOCK_EXCHANGE =
      HwLocationType._create('STOCK_EXCHANGE');

  static const HwLocationType STORE = HwLocationType._create('STORE');

  static const HwLocationType STREET_ADDRESS =
      HwLocationType._create('STREET_ADDRESS');

  static const HwLocationType SUDANESE_RESTAURANT =
      HwLocationType._create('SUDANESE_RESTAURANT');

  static const HwLocationType SUPERMARKET_HYPERMARKET =
      HwLocationType._create('SUPERMARKET_HYPERMARKET');

  static const HwLocationType SURINAMESE_RESTAURANT =
      HwLocationType._create('SURINAMESE_RESTAURANT');

  static const HwLocationType SUSHI_RESTAURANT =
      HwLocationType._create('SUSHI_RESTAURANT');

  static const HwLocationType SWEDISH_RESTAURANT =
      HwLocationType._create('SWEDISH_RESTAURANT');

  static const HwLocationType SWIMMING_POOL =
      HwLocationType._create('SWIMMING_POOL');

  static const HwLocationType SWISS_RESTAURANT =
      HwLocationType._create('SWISS_RESTAURANT');

  static const HwLocationType SYNAGOGUE = HwLocationType._create('SYNAGOGUE');

  static const HwLocationType SYRIAN_RESTAURANT =
      HwLocationType._create('SYRIAN_RESTAURANT');

  static const HwLocationType TABLE_TENNIS_HALL =
      HwLocationType._create('TABLE_TENNIS_HALL');

  static const HwLocationType TAILOR_SHOP =
      HwLocationType._create('TAILOR_SHOP');

  static const HwLocationType TAIWANESE_RESTAURANT =
      HwLocationType._create('TAIWANESE_RESTAURANT');

  static const HwLocationType TAKE_AWAY_RESTAURANT =
      HwLocationType._create('TAKE_AWAY_RESTAURANT');

  static const HwLocationType TAPAS_RESTAURANT =
      HwLocationType._create('TAPAS_RESTAURANT');

  static const HwLocationType TAX_SERVICE_COMPANY =
      HwLocationType._create('TAX_SERVICE_COMPANY');

  static const HwLocationType TAXI_LIMOUSINE_SHUTTLE_SERVICE_COMPANY =
      HwLocationType._create('TAXI_LIMOUSINE_SHUTTLE_SERVICE_COMPANY');

  static const HwLocationType TAXI_STAND = HwLocationType._create('TAXI_STAND');

  static const HwLocationType TEA_HOUSE = HwLocationType._create('TEA_HOUSE');

  static const HwLocationType TECHNICAL_SCHOOL =
      HwLocationType._create('TECHNICAL_SCHOOL');

  static const HwLocationType TELECOMMUNICATIONS_COMPANY =
      HwLocationType._create('TELECOMMUNICATIONS_COMPANY');

  static const HwLocationType TEMPLE = HwLocationType._create('TEMPLE');

  static const HwLocationType TENNIS_COURT =
      HwLocationType._create('TENNIS_COURT');

  static const HwLocationType TEPPANYAKKI_RESTAURANT =
      HwLocationType._create('TEPPANYAKKI_RESTAURANT');

  static const HwLocationType TERMINAL = HwLocationType._create('TERMINAL');

  static const HwLocationType THAI_RESTAURANT =
      HwLocationType._create('THAI_RESTAURANT');

  static const HwLocationType THEATER = HwLocationType._create('THEATER');

  static const HwLocationType THEATER_SUB =
      HwLocationType._create('THEATER_SUB');

  static const HwLocationType THEMED_SPORTS_HALL =
      HwLocationType._create('THEMED_SPORTS_HALL');

  static const HwLocationType THREE_STAR_HOTEL =
      HwLocationType._create('THREE_STAR_HOTEL');

  static const HwLocationType TIBETAN_RESTAURANT =
      HwLocationType._create('TIBETAN_RESTAURANT');

  static const HwLocationType TIRE_REPAIR_SHOP =
      HwLocationType._create('TIRE_REPAIR_SHOP');

  static const HwLocationType TOILET = HwLocationType._create('TOILET');

  static const HwLocationType TOLL_GATE = HwLocationType._create('TOLL_GATE');

  static const HwLocationType TOURISM = HwLocationType._create('TOURISM');

  static const HwLocationType TOURIST_INFORMATION_OFFICE =
      HwLocationType._create('TOURIST_INFORMATION_OFFICE');

  static const HwLocationType TOWER = HwLocationType._create('TOWER');

  static const HwLocationType TOWN = HwLocationType._create('TOWN');

  static const HwLocationType TOWN_GOVERNMENT =
      HwLocationType._create('TOWN_GOVERNMENT');

  static const HwLocationType TOWNHOUSE_COMPLEX =
      HwLocationType._create('TOWNHOUSE_COMPLEX');

  static const HwLocationType TOYS_AND_GAMES_STORE =
      HwLocationType._create('TOYS_AND_GAMES_STORE');

  static const HwLocationType TRAFFIC = HwLocationType._create('TRAFFIC');

  static const HwLocationType TRAFFIC_CONTROL_DEPARTMENT =
      HwLocationType._create('TRAFFIC_CONTROL_DEPARTMENT');

  static const HwLocationType TRAFFIC_LIGHT =
      HwLocationType._create('TRAFFIC_LIGHT');

  static const HwLocationType TRAFFIC_MANAGEMENT_BUREAU =
      HwLocationType._create('TRAFFIC_MANAGEMENT_BUREAU');

  static const HwLocationType TRAFFIC_SIGN =
      HwLocationType._create('TRAFFIC_SIGN');

  static const HwLocationType TRAFFIC_SIGNAL =
      HwLocationType._create('TRAFFIC_SIGNAL');

  static const HwLocationType TRAIL_SYSTEM =
      HwLocationType._create('TRAIL_SYSTEM');

  static const HwLocationType TRAILHEAD = HwLocationType._create('TRAILHEAD');

  static const HwLocationType TRAM_STOP = HwLocationType._create('TRAM_STOP');

  static const HwLocationType TRANSPORT = HwLocationType._create('TRANSPORT');

  static const HwLocationType TRANSPORT__CENTER =
      HwLocationType._create('TRANSPORT__CENTER');

  static const HwLocationType TRANSPORTATION_COMPANY =
      HwLocationType._create('TRANSPORTATION_COMPANY');

  static const HwLocationType TRAVEL_AGENCY =
      HwLocationType._create('TRAVEL_AGENCY');

  static const HwLocationType TRUCK_DEALER =
      HwLocationType._create('TRUCK_DEALER');

  static const HwLocationType TRUCK_PARKING_AREA =
      HwLocationType._create('TRUCK_PARKING_AREA');

  static const HwLocationType TRUCK_REPAIR_SHOP =
      HwLocationType._create('TRUCK_REPAIR_SHOP');

  static const HwLocationType TRUCK_STOP = HwLocationType._create('TRUCK_STOP');

  static const HwLocationType TRUCK_WASH = HwLocationType._create('TRUCK_WASH');

  static const HwLocationType TSUNAMI_ASSEMBLY_POINT =
      HwLocationType._create('TSUNAMI_ASSEMBLY_POINT');

  static const HwLocationType TUNISIAN_RESTAURANT =
      HwLocationType._create('TUNISIAN_RESTAURANT');

  static const HwLocationType TUNNEL = HwLocationType._create('TUNNEL');

  static const HwLocationType TURKISH_RESTAURANT =
      HwLocationType._create('TURKISH_RESTAURANT');

  static const HwLocationType UNRATED_HOTEL =
      HwLocationType._create('UNRATED_HOTEL');

  static const HwLocationType URUGUAYAN_RESTAURANT =
      HwLocationType._create('URUGUAYAN_RESTAURANT');

  static const HwLocationType USED_CAR_DEALER =
      HwLocationType._create('USED_CAR_DEALER');

  static const HwLocationType VALLEY = HwLocationType._create('VALLEY');

  static const HwLocationType VAN_DEALER = HwLocationType._create('VAN_DEALER');

  static const HwLocationType VARIETY_STORE =
      HwLocationType._create('VARIETY_STORE');

  static const HwLocationType VEGETARIAN_RESTAURANT =
      HwLocationType._create('VEGETARIAN_RESTAURANT');

  static const HwLocationType VENEZUELAN_RESTAURANT =
      HwLocationType._create('VENEZUELAN_RESTAURANT');

  static const HwLocationType VETERINARY_CLINIC =
      HwLocationType._create('VETERINARY_CLINIC');

  static const HwLocationType VIDEO_ARCADE_GAMING_ROOM =
      HwLocationType._create('VIDEO_ARCADE_GAMING_ROOM');

  static const HwLocationType VIETNAMESE_RESTAURANT =
      HwLocationType._create('VIETNAMESE_RESTAURANT');

  static const HwLocationType VILLA = HwLocationType._create('VILLA');

  static const HwLocationType VOCATIONAL_TRAINING_SCHOOL =
      HwLocationType._create('VOCATIONAL_TRAINING_SCHOOL');

  static const HwLocationType VOLCANIC_ERUPTION_ASSEMBLY_POINT =
      HwLocationType._create('VOLCANIC_ERUPTION_ASSEMBLY_POINT');

  static const HwLocationType WAREHOUSE_SUPERMARKET =
      HwLocationType._create('WAREHOUSE_SUPERMARKET');

  static const HwLocationType WATER_HOLE = HwLocationType._create('WATER_HOLE');

  static const HwLocationType WATER_SPORTS_CENTER =
      HwLocationType._create('WATER_SPORTS_CENTER');

  static const HwLocationType WEDDING_SERVICE_COMPANY =
      HwLocationType._create('WEDDING_SERVICE_COMPANY');

  static const HwLocationType WEIGH_SCALES =
      HwLocationType._create('WEIGH_SCALES');

  static const HwLocationType WEIGH_STATION =
      HwLocationType._create('WEIGH_STATION');

  static const HwLocationType WEIGH_STATION_SUB =
      HwLocationType._create('WEIGH_STATION_SUB');

  static const HwLocationType WELFARE_ORGANIZATION =
      HwLocationType._create('WELFARE_ORGANIZATION');

  static const HwLocationType WELL = HwLocationType._create('WELL');

  static const HwLocationType WELSH_RESTAURANT =
      HwLocationType._create('WELSH_RESTAURANT');

  static const HwLocationType WESTERN_RESTAURANT =
      HwLocationType._create('WESTERN_RESTAURANT');

  static const HwLocationType WILDERNESS_AREA =
      HwLocationType._create('WILDERNESS_AREA');

  static const HwLocationType WILDLIFE_PARK =
      HwLocationType._create('WILDLIFE_PARK');

  static const HwLocationType WINE_BAR = HwLocationType._create('WINE_BAR');

  static const HwLocationType WINE_SPIRITS_STORE =
      HwLocationType._create('WINE_SPIRITS_STORE');

  static const HwLocationType WINERY = HwLocationType._create('WINERY');

  static const HwLocationType WINERY_TOURIST =
      HwLocationType._create('WINERY_TOURIST');

  static const HwLocationType WINTER_SPORT_AREA =
      HwLocationType._create('WINTER_SPORT_AREA');

  static const HwLocationType YACHT_BASIN =
      HwLocationType._create('YACHT_BASIN');

  static const HwLocationType YOGURT_JUICE_BAR =
      HwLocationType._create('YOGURT_JUICE_BAR');

  static const HwLocationType ZOO = HwLocationType._create('ZOO');

  static const HwLocationType ZOO_ARBORETA_BOTANICAL_GARDEN =
      HwLocationType._create('ZOO_ARBORETA_BOTANICAL_GARDEN');
}
