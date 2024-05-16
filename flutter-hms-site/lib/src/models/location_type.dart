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

class LocationType {
  final String _value;

  const LocationType._create(this._value);

  factory LocationType.fromString(String value) {
    return LocationType._create(value);
  }

  @override
  String toString() {
    return _value;
  }

  static const LocationType ACCOUNTING = LocationType._create('ACCOUNTING');

  static const LocationType ADDRESS = LocationType._create('ADDRESS');

  static const LocationType ADMINISTRATIVE_AREA_LEVEL_1 =
      LocationType._create('ADMINISTRATIVE_AREA_LEVEL_1');

  static const LocationType ADMINISTRATIVE_AREA_LEVEL_2 =
      LocationType._create('ADMINISTRATIVE_AREA_LEVEL_2');

  static const LocationType ADMINISTRATIVE_AREA_LEVEL_3 =
      LocationType._create('ADMINISTRATIVE_AREA_LEVEL_3');

  static const LocationType ADMINISTRATIVE_AREA_LEVEL_4 =
      LocationType._create('ADMINISTRATIVE_AREA_LEVEL_4');

  static const LocationType ADMINISTRATIVE_AREA_LEVEL_5 =
      LocationType._create('ADMINISTRATIVE_AREA_LEVEL_5');

  static const LocationType AIRPORT = LocationType._create('AIRPORT');

  static const LocationType AMUSEMENT_PARK =
      LocationType._create('AMUSEMENT_PARK');

  static const LocationType AQUARIUM = LocationType._create('AQUARIUM');

  static const LocationType ARCHIPELAGO = LocationType._create('ARCHIPELAGO');

  static const LocationType ART_GALLERY = LocationType._create('ART_GALLERY');

  static const LocationType ATM = LocationType._create('ATM');

  static const LocationType BAKERY = LocationType._create('BAKERY');

  static const LocationType BANK = LocationType._create('BANK');

  static const LocationType BAR = LocationType._create('BAR');

  static const LocationType BEAUTY_SALON = LocationType._create('BEAUTY_SALON');

  static const LocationType BICYCLE_STORE =
      LocationType._create('BICYCLE_STORE');

  static const LocationType BOOK_STORE = LocationType._create('BOOK_STORE');

  static const LocationType BOWLING_ALLEY =
      LocationType._create('BOWLING_ALLEY');

  static const LocationType BUS_STATION = LocationType._create('BUS_STATION');

  static const LocationType CAFE = LocationType._create('CAFE');

  static const LocationType CAMPGROUND = LocationType._create('CAMPGROUND');

  static const LocationType CAPITAL = LocationType._create('CAPITAL');

  static const LocationType CAPITAL_CITY = LocationType._create('CAPITAL_CITY');

  static const LocationType CAR_DEALER = LocationType._create('CAR_DEALER');

  static const LocationType CAR_RENTAL = LocationType._create('CAR_RENTAL');

  static const LocationType CAR_REPAIR = LocationType._create('CAR_REPAIR');

  static const LocationType CAR_WASH = LocationType._create('CAR_WASH');

  static const LocationType CASINO = LocationType._create('CASINO');

  static const LocationType CEMETERY = LocationType._create('CEMETERY');

  static const LocationType CHURCH = LocationType._create('CHURCH');

  static const LocationType CITIES = LocationType._create('CITIES');

  static const LocationType CITY_HALL = LocationType._create('CITY_HALL');

  static const LocationType CLOTHING_STORE =
      LocationType._create('CLOTHING_STORE');

  static const LocationType COLLOQUIAL_AREA =
      LocationType._create('COLLOQUIAL_AREA');

  static const LocationType CONTINENT = LocationType._create('CONTINENT');

  static const LocationType CONVENIENCE_STORE =
      LocationType._create('CONVENIENCE_STORE');

  static const LocationType COUNTRY = LocationType._create('COUNTRY');

  static const LocationType COURTHOUSE = LocationType._create('COURTHOUSE');

  static const LocationType DENTIST = LocationType._create('DENTIST');

  static const LocationType DEPARTMENT_STORE =
      LocationType._create('DEPARTMENT_STORE');

  static const LocationType DOCTOR = LocationType._create('DOCTOR');

  static const LocationType DRUGSTORE = LocationType._create('DRUGSTORE');

  static const LocationType ELECTRICIAN = LocationType._create('ELECTRICIAN');

  static const LocationType ELECTRONICS_STORE =
      LocationType._create('ELECTRONICS_STORE');

  static const LocationType EMBASSY = LocationType._create('EMBASSY');

  static const LocationType ESTABLISHMENT =
      LocationType._create('ESTABLISHMENT');

  static const LocationType FINANCE = LocationType._create('FINANCE');

  static const LocationType FIRE_STATION = LocationType._create('FIRE_STATION');

  static const LocationType FLOOR = LocationType._create('FLOOR');

  static const LocationType FLORIST = LocationType._create('FLORIST');

  static const LocationType FOOD = LocationType._create('FOOD');

  static const LocationType FUNERAL_HOME = LocationType._create('FUNERAL_HOME');

  static const LocationType FURNITURE_STORE =
      LocationType._create('FURNITURE_STORE');

  static const LocationType GAS_STATION = LocationType._create('GAS_STATION');

  static const LocationType GENERAL_CITY = LocationType._create('GENERAL_CITY');

  static const LocationType GENERAL_CONTRACTOR =
      LocationType._create('GENERAL_CONTRACTOR');

  static const LocationType GEOCODE = LocationType._create('GEOCODE');

  static const LocationType GROCERY_OR_SUPERMARKET =
      LocationType._create('GROCERY_OR_SUPERMARKET');

  static const LocationType GYM = LocationType._create('GYM');

  static const LocationType HAIR_CARE = LocationType._create('HAIR_CARE');

  static const LocationType HAMLET = LocationType._create('HAMLET');

  static const LocationType HARDWARE_STORE =
      LocationType._create('HARDWARE_STORE');

  static const LocationType HEALTH = LocationType._create('HEALTH');

  static const LocationType HINDU_TEMPLE = LocationType._create('HINDU_TEMPLE');

  static const LocationType HOME_GOODS_STORE =
      LocationType._create('HOME_GOODS_STORE');

  static const LocationType HOSPITAL = LocationType._create('HOSPITAL');

  static const LocationType INSURANCE_AGENCY =
      LocationType._create('INSURANCE_AGENCY');

  static const LocationType INTERSECTION = LocationType._create('INTERSECTION');

  static const LocationType JEWELRY_STORE =
      LocationType._create('JEWELRY_STORE');

  static const LocationType LAUNDRY = LocationType._create('LAUNDRY');

  static const LocationType LAWYER = LocationType._create('LAWYER');

  static const LocationType LIBRARY = LocationType._create('LIBRARY');

  static const LocationType LIGHT_RAIL_STATION =
      LocationType._create('LIGHT_RAIL_STATION');

  static const LocationType LIQUOR_STORE = LocationType._create('LIQUOR_STORE');

  static const LocationType LOCALITY = LocationType._create('LOCALITY');

  static const LocationType LOCAL_GOVERNMENT_OFFICE =
      LocationType._create('LOCAL_GOVERNMENT_OFFICE');

  static const LocationType LOCKSMITH = LocationType._create('LOCKSMITH');

  static const LocationType LODGING = LocationType._create('LODGING');

  static const LocationType MEAL_DELIVERY =
      LocationType._create('MEAL_DELIVERY');

  static const LocationType MEAL_TAKEAWAY =
      LocationType._create('MEAL_TAKEAWAY');

  static const LocationType MOSQUE = LocationType._create('MOSQUE');

  static const LocationType MOVIE_RENTAL = LocationType._create('MOVIE_RENTAL');

  static const LocationType MOVIE_THEATER =
      LocationType._create('MOVIE_THEATER');

  static const LocationType MOVING_COMPANY =
      LocationType._create('MOVING_COMPANY');

  static const LocationType MUSEUM = LocationType._create('MUSEUM');

  static const LocationType NATURAL_FEATURE =
      LocationType._create('NATURAL_FEATURE');

  static const LocationType NEIGHBORHOOD = LocationType._create('NEIGHBORHOOD');

  static const LocationType NIGHT_CLUB = LocationType._create('NIGHT_CLUB');

  static const LocationType OTHER = LocationType._create('OTHER');

  static const LocationType PAINTER = LocationType._create('PAINTER');

  static const LocationType PARK = LocationType._create('PARK');

  static const LocationType PARKING = LocationType._create('PARKING');

  static const LocationType PET_STORE = LocationType._create('PET_STORE');

  static const LocationType PHARMACY = LocationType._create('PHARMACY');

  static const LocationType PHYSIOTHERAPIST =
      LocationType._create('PHYSIOTHERAPIST');

  static const LocationType PLACE_OF_WORSHIP =
      LocationType._create('PLACE_OF_WORSHIP');

  static const LocationType PLUMBER = LocationType._create('PLUMBER');

  static const LocationType POINT_OF_INTEREST =
      LocationType._create('POINT_OF_INTEREST');

  static const LocationType POLICE = LocationType._create('POLICE');

  static const LocationType POLITICAL = LocationType._create('POLITICAL');

  static const LocationType POSTAL_CODE = LocationType._create('POSTAL_CODE');

  static const LocationType POSTAL_CODE_PREFIX =
      LocationType._create('POSTAL_CODE_PREFIX');

  static const LocationType POSTAL_CODE_SUFFIX =
      LocationType._create('POSTAL_CODE_SUFFIX');

  static const LocationType POSTAL_TOWN = LocationType._create('POSTAL_TOWN');

  static const LocationType POST_BOX = LocationType._create('POST_BOX');

  static const LocationType POST_OFFICE = LocationType._create('POST_OFFICE');

  static const LocationType PREMISE = LocationType._create('PREMISE');

  static const LocationType PRIMARY_SCHOOL =
      LocationType._create('PRIMARY_SCHOOL');

  static const LocationType REAL_ESTATE_AGENCY =
      LocationType._create('REAL_ESTATE_AGENCY');

  static const LocationType REGION = LocationType._create('REGION');

  static const LocationType REGIONS = LocationType._create('REGIONS');

  static const LocationType RESTAURANT = LocationType._create('RESTAURANT');

  static const LocationType ROOFING_CONTRACTOR =
      LocationType._create('ROOFING_CONTRACTOR');

  static const LocationType ROOM = LocationType._create('ROOM');

  static const LocationType ROUTE = LocationType._create('ROUTE');

  static const LocationType RV_PARK = LocationType._create('RV_PARK');

  static const LocationType SCHOOL = LocationType._create('SCHOOL');

  static const LocationType SECONDARY_SCHOOL =
      LocationType._create('SECONDARY_SCHOOL');

  static const LocationType SHOE_STORE = LocationType._create('SHOE_STORE');

  static const LocationType SHOPPING_MALL =
      LocationType._create('SHOPPING_MALL');

  static const LocationType SPA = LocationType._create('SPA');

  static const LocationType STADIUM = LocationType._create('STADIUM');

  static const LocationType STORAGE = LocationType._create('STORAGE');

  static const LocationType STORE = LocationType._create('STORE');

  static const LocationType STREET_ADDRESS =
      LocationType._create('STREET_ADDRESS');

  static const LocationType STREET_NUMBER =
      LocationType._create('STREET_NUMBER');

  static const LocationType SUBLOCALITY = LocationType._create('SUBLOCALITY');

  static const LocationType SUBLOCALITY_LEVEL_1 =
      LocationType._create('SUBLOCALITY_LEVEL_1');

  static const LocationType SUBLOCALITY_LEVEL_2 =
      LocationType._create('SUBLOCALITY_LEVEL_2');

  static const LocationType SUBLOCALITY_LEVEL_3 =
      LocationType._create('SUBLOCALITY_LEVEL_3');

  static const LocationType SUBLOCALITY_LEVEL_4 =
      LocationType._create('SUBLOCALITY_LEVEL_4');

  static const LocationType SUBLOCALITY_LEVEL_5 =
      LocationType._create('SUBLOCALITY_LEVEL_5');

  static const LocationType SUBPREMISE = LocationType._create('SUBPREMISE');

  static const LocationType SUBWAY_STATION =
      LocationType._create('SUBWAY_STATION');

  static const LocationType SUPERMARKET = LocationType._create('SUPERMARKET');

  static const LocationType SYNAGOGUE = LocationType._create('SYNAGOGUE');

  static const LocationType TAXI_STAND = LocationType._create('TAXI_STAND');

  static const LocationType TOURIST_ATTRACTION =
      LocationType._create('TOURIST_ATTRACTION');

  static const LocationType TOWN = LocationType._create('TOWN');

  static const LocationType TOWN_SQUARE = LocationType._create('TOWN_SQUARE');

  static const LocationType TRAIN_STATION =
      LocationType._create('TRAIN_STATION');

  static const LocationType TRANSIT_STATION =
      LocationType._create('TRANSIT_STATION');

  static const LocationType TRAVEL_AGENCY =
      LocationType._create('TRAVEL_AGENCY');

  static const LocationType UNIVERSITY = LocationType._create('UNIVERSITY');

  static const LocationType VETERINARY_CARE =
      LocationType._create('VETERINARY_CARE');

  static const LocationType ZOO = LocationType._create('ZOO');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationType && other._value == _value;
  }

  @override
  int get hashCode {
    return _value.hashCode;
  }
}
