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

class LocationType {
  final String _value;

  const LocationType._create(this._value);

  factory LocationType.fromString(String value) => LocationType._create(value);

  toString() => _value;

  static const ACCOUNTING = const LocationType._create('ACCOUNTING');
  static const ADDRESS = const LocationType._create('ADDRESS');
  static const ADMINISTRATIVE_AREA_LEVEL_1 =
      const LocationType._create('ADMINISTRATIVE_AREA_LEVEL_1');
  static const ADMINISTRATIVE_AREA_LEVEL_2 =
      const LocationType._create('ADMINISTRATIVE_AREA_LEVEL_2');
  static const ADMINISTRATIVE_AREA_LEVEL_3 =
      const LocationType._create('ADMINISTRATIVE_AREA_LEVEL_3');
  static const ADMINISTRATIVE_AREA_LEVEL_4 =
      const LocationType._create('ADMINISTRATIVE_AREA_LEVEL_4');
  static const ADMINISTRATIVE_AREA_LEVEL_5 =
      const LocationType._create('ADMINISTRATIVE_AREA_LEVEL_5');
  static const AIRPORT = const LocationType._create('AIRPORT');
  static const AMUSEMENT_PARK = const LocationType._create('AMUSEMENT_PARK');
  static const AQUARIUM = const LocationType._create('AQUARIUM');
  static const ARCHIPELAGO = const LocationType._create('ARCHIPELAGO');
  static const ART_GALLERY = const LocationType._create('ART_GALLERY');
  static const ATM = const LocationType._create('ATM');
  static const BAKERY = const LocationType._create('BAKERY');
  static const BANK = const LocationType._create('BANK');
  static const BAR = const LocationType._create('BAR');
  static const BEAUTY_SALON = const LocationType._create('BEAUTY_SALON');
  static const BICYCLE_STORE = const LocationType._create('BICYCLE_STORE');
  static const BOOK_STORE = const LocationType._create('BOOK_STORE');
  static const BOWLING_ALLEY = const LocationType._create('BOWLING_ALLEY');
  static const BUS_STATION = const LocationType._create('BUS_STATION');
  static const CAFE = const LocationType._create('CAFE');
  static const CAMPGROUND = const LocationType._create('CAMPGROUND');
  static const CAPITAL = const LocationType._create('CAPITAL');
  static const CAPITAL_CITY = const LocationType._create('CAPITAL_CITY');
  static const CAR_DEALER = const LocationType._create('CAR_DEALER');
  static const CAR_RENTAL = const LocationType._create('CAR_RENTAL');
  static const CAR_REPAIR = const LocationType._create('CAR_REPAIR');
  static const CAR_WASH = const LocationType._create('CAR_WASH');
  static const CASINO = const LocationType._create('CASINO');
  static const CEMETERY = const LocationType._create('CEMETERY');
  static const CHURCH = const LocationType._create('CHURCH');
  static const CITIES = const LocationType._create('CITIES');
  static const CITY_HALL = const LocationType._create('CITY_HALL');
  static const CLOTHING_STORE = const LocationType._create('CLOTHING_STORE');
  static const COLLOQUIAL_AREA = const LocationType._create('COLLOQUIAL_AREA');
  static const CONTINENT = const LocationType._create('CONTINENT');
  static const CONVENIENCE_STORE =
      const LocationType._create('CONVENIENCE_STORE');
  static const COUNTRY = const LocationType._create('COUNTRY');
  static const COURTHOUSE = const LocationType._create('COURTHOUSE');
  static const DENTIST = const LocationType._create('DENTIST');
  static const DEPARTMENT_STORE =
      const LocationType._create('DEPARTMENT_STORE');
  static const DOCTOR = const LocationType._create('DOCTOR');
  static const DRUGSTORE = const LocationType._create('DRUGSTORE');
  static const ELECTRICIAN = const LocationType._create('ELECTRICIAN');
  static const ELECTRONICS_STORE =
      const LocationType._create('ELECTRONICS_STORE');
  static const EMBASSY = const LocationType._create('EMBASSY');
  static const ESTABLISHMENT = const LocationType._create('ESTABLISHMENT');
  static const FINANCE = const LocationType._create('FINANCE');
  static const FIRE_STATION = const LocationType._create('FIRE_STATION');
  static const FLOOR = const LocationType._create('FLOOR');
  static const FLORIST = const LocationType._create('FLORIST');
  static const FOOD = const LocationType._create('FOOD');
  static const FUNERAL_HOME = const LocationType._create('FUNERAL_HOME');
  static const FURNITURE_STORE = const LocationType._create('FURNITURE_STORE');
  static const GAS_STATION = const LocationType._create('GAS_STATION');
  static const GENERAL_CITY = const LocationType._create('GENERAL_CITY');
  static const GENERAL_CONTRACTOR =
      const LocationType._create('GENERAL_CONTRACTOR');
  static const GEOCODE = const LocationType._create('GEOCODE');
  static const GROCERY_OR_SUPERMARKET =
      const LocationType._create('GROCERY_OR_SUPERMARKET');
  static const GYM = const LocationType._create('GYM');
  static const HAIR_CARE = const LocationType._create('HAIR_CARE');
  static const HAMLET = const LocationType._create('HAMLET');
  static const HARDWARE_STORE = const LocationType._create('HARDWARE_STORE');
  static const HEALTH = const LocationType._create('HEALTH');
  static const HINDU_TEMPLE = const LocationType._create('HINDU_TEMPLE');
  static const HOME_GOODS_STORE =
      const LocationType._create('HOME_GOODS_STORE');
  static const HOSPITAL = const LocationType._create('HOSPITAL');
  static const INSURANCE_AGENCY =
      const LocationType._create('INSURANCE_AGENCY');
  static const INTERSECTION = const LocationType._create('INTERSECTION');
  static const JEWELRY_STORE = const LocationType._create('JEWELRY_STORE');
  static const LAUNDRY = const LocationType._create('LAUNDRY');
  static const LAWYER = const LocationType._create('LAWYER');
  static const LIBRARY = const LocationType._create('LIBRARY');
  static const LIGHT_RAIL_STATION =
      const LocationType._create('LIGHT_RAIL_STATION');
  static const LIQUOR_STORE = const LocationType._create('LIQUOR_STORE');
  static const LOCALITY = const LocationType._create('LOCALITY');
  static const LOCAL_GOVERNMENT_OFFICE =
      const LocationType._create('LOCAL_GOVERNMENT_OFFICE');
  static const LOCKSMITH = const LocationType._create('LOCKSMITH');
  static const LODGING = const LocationType._create('LODGING');
  static const MEAL_DELIVERY = const LocationType._create('MEAL_DELIVERY');
  static const MEAL_TAKEAWAY = const LocationType._create('MEAL_TAKEAWAY');
  static const MOSQUE = const LocationType._create('MOSQUE');
  static const MOVIE_RENTAL = const LocationType._create('MOVIE_RENTAL');
  static const MOVIE_THEATER = const LocationType._create('MOVIE_THEATER');
  static const MOVING_COMPANY = const LocationType._create('MOVING_COMPANY');
  static const MUSEUM = const LocationType._create('MUSEUM');
  static const NATURAL_FEATURE = const LocationType._create('NATURAL_FEATURE');
  static const NEIGHBORHOOD = const LocationType._create('NEIGHBORHOOD');
  static const NIGHT_CLUB = const LocationType._create('NIGHT_CLUB');
  static const OTHER = const LocationType._create('OTHER');
  static const PAINTER = const LocationType._create('PAINTER');
  static const PARK = const LocationType._create('PARK');
  static const PARKING = const LocationType._create('PARKING');
  static const PET_STORE = const LocationType._create('PET_STORE');
  static const PHARMACY = const LocationType._create('PHARMACY');
  static const PHYSIOTHERAPIST = const LocationType._create('PHYSIOTHERAPIST');
  static const PLACE_OF_WORSHIP =
      const LocationType._create('PLACE_OF_WORSHIP');
  static const PLUMBER = const LocationType._create('PLUMBER');
  static const POINT_OF_INTEREST =
      const LocationType._create('POINT_OF_INTEREST');
  static const POLICE = const LocationType._create('POLICE');
  static const POLITICAL = const LocationType._create('POLITICAL');
  static const POSTAL_CODE = const LocationType._create('POSTAL_CODE');
  static const POSTAL_CODE_PREFIX =
      const LocationType._create('POSTAL_CODE_PREFIX');
  static const POSTAL_CODE_SUFFIX =
      const LocationType._create('POSTAL_CODE_SUFFIX');
  static const POSTAL_TOWN = const LocationType._create('POSTAL_TOWN');
  static const POST_BOX = const LocationType._create('POST_BOX');
  static const POST_OFFICE = const LocationType._create('POST_OFFICE');
  static const PREMISE = const LocationType._create('PREMISE');
  static const PRIMARY_SCHOOL = const LocationType._create('PRIMARY_SCHOOL');
  static const REAL_ESTATE_AGENCY =
      const LocationType._create('REAL_ESTATE_AGENCY');
  static const REGION = const LocationType._create('REGION');
  static const REGIONS = const LocationType._create('REGIONS');
  static const RESTAURANT = const LocationType._create('RESTAURANT');
  static const ROOFING_CONTRACTOR =
      const LocationType._create('ROOFING_CONTRACTOR');
  static const ROOM = const LocationType._create('ROOM');
  static const ROUTE = const LocationType._create('ROUTE');
  static const RV_PARK = const LocationType._create('RV_PARK');
  static const SCHOOL = const LocationType._create('SCHOOL');
  static const SECONDARY_SCHOOL =
      const LocationType._create('SECONDARY_SCHOOL');
  static const SHOE_STORE = const LocationType._create('SHOE_STORE');
  static const SHOPPING_MALL = const LocationType._create('SHOPPING_MALL');
  static const SPA = const LocationType._create('SPA');
  static const STADIUM = const LocationType._create('STADIUM');
  static const STORAGE = const LocationType._create('STORAGE');
  static const STORE = const LocationType._create('STORE');
  static const STREET_ADDRESS = const LocationType._create('STREET_ADDRESS');
  static const STREET_NUMBER = const LocationType._create('STREET_NUMBER');
  static const SUBLOCALITY = const LocationType._create('SUBLOCALITY');
  static const SUBLOCALITY_LEVEL_1 =
      const LocationType._create('SUBLOCALITY_LEVEL_1');
  static const SUBLOCALITY_LEVEL_2 =
      const LocationType._create('SUBLOCALITY_LEVEL_2');
  static const SUBLOCALITY_LEVEL_3 =
      const LocationType._create('SUBLOCALITY_LEVEL_3');
  static const SUBLOCALITY_LEVEL_4 =
      const LocationType._create('SUBLOCALITY_LEVEL_4');
  static const SUBLOCALITY_LEVEL_5 =
      const LocationType._create('SUBLOCALITY_LEVEL_5');
  static const SUBPREMISE = const LocationType._create('SUBPREMISE');
  static const SUBWAY_STATION = const LocationType._create('SUBWAY_STATION');
  static const SUPERMARKET = const LocationType._create('SUPERMARKET');
  static const SYNAGOGUE = const LocationType._create('SYNAGOGUE');
  static const TAXI_STAND = const LocationType._create('TAXI_STAND');
  static const TOURIST_ATTRACTION =
      const LocationType._create('TOURIST_ATTRACTION');
  static const TOWN = const LocationType._create('TOWN');
  static const TOWN_SQUARE = const LocationType._create('TOWN_SQUARE');
  static const TRAIN_STATION = const LocationType._create('TRAIN_STATION');
  static const TRANSIT_STATION = const LocationType._create('TRANSIT_STATION');
  static const TRAVEL_AGENCY = const LocationType._create('TRAVEL_AGENCY');
  static const UNIVERSITY = const LocationType._create('UNIVERSITY');
  static const VETERINARY_CARE = const LocationType._create('VETERINARY_CARE');
  static const ZOO = const LocationType._create('ZOO');

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocationType && o._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;
}
