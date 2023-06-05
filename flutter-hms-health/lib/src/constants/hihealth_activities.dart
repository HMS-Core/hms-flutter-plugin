/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

/// Defines different types of activity that a user is performing.
abstract class HiHealthActivities {
  /// General prefix of the MIME type as the activity state.
  static const String MIME_TYPE_PREFIX = 'vnd.huawei.hihealth.activity/';

  /// A string that contains STATUS_ACTION_START and STATUS_ACTION_END as two extra activity states.
  static const String EXTRA_ACTION_STATUS = 'actionStatus';

  /// Indicates that the activity has started.
  static const String STATUS_ACTION_START = 'StartedActionStatus';

  /// Indicates that the activity has ended.
  static const String STATUS_ACTION_END = 'EndedActionStatus';

  /// The user is doing an aerobic exercise.
  static const String aerobics = 'aerobics';

  /// The user is doing archery.
  static const String archery = 'archery';

  /// The user is playing badminton.
  static const String badminton = 'badminton';

  /// The user is playing baseball.
  static const String baseball = 'baseball';

  /// The user is playing basketball.
  static const String basketball = 'basketball';

  /// The user is doing cross-country skiing and rifle shooting.
  static const String biathlon = 'biathlon';

  /// The user is boxing.
  static const String boxing = 'boxing';

  /// The user is doing a calisthenics exercise.
  static const String calisthenics = 'calisthenics';

  /// The user is doing a circuit training exercise.
  static const String circuitTraining = 'circuit_training';

  /// The user is playing cricket.
  static const String cricket = 'cricket';

  /// The user is doing a crossfit exercise.
  static const String crossfit = 'crossfit';

  /// The user is playing curling.
  static const String curling = 'curling';

  /// The user is cycling.
  static const String cycling = 'cycling';

  /// The user is doing indoor cycling.
  static const String cyclingIndoor = 'cycling_indoor';

  /// The user is dancing.
  static const String dancing = 'dancing';

  /// The user is diving.
  static const String diving = 'diving';

  /// The user is taking an elevator.
  static const String elevator = 'elevator';

  /// The user is using an elliptical machine.
  static const String elliptical = 'elliptical';

  /// The user is using an ergometer machine.
  static const String ergometer = 'ergometer';

  /// The user is taking an escalator.
  static const String escalator = 'escalator';

  /// The user is fencing.
  static const String fencing = 'fencing';

  /// The user is throwing a Frisbee.
  static const String flyingDisc = 'flying_disc';

  /// The user is playing American football.
  static const String footballAmerican = 'football.american';

  /// The user is playing Australian football.
  static const String footballAustralian = 'football.australian';

  /// The user is playing soccer.
  static const String footballSoccer = 'football.soccer';

  /// The user is gardening.
  static const String gardening = 'gardening';

  /// The user is playing golf.
  static const String golf = 'golf';

  /// The user is doing gymnastics.
  static const String gymnastics = 'gymnastics';

  /// The user is playing handball.
  static const String handball = 'handball';

  /// The user is doing high intensity interval training (HIIT).
  static const String hiit = 'interval_training.high_intensity';

  /// The user is hiking.
  static const String hiking = 'hiking';

  /// The user is playing hockey.
  static const String hockey = 'hockey';

  /// The user is riding a horse.
  static const String horseRiding = 'horse_riding';

  /// The user is doing housework.
  static const String housework = 'housework';

  /// The user is ice-skating.
  static const String iceSkating = 'ice_skating';

  /// The user is in a vehicle.
  static const String inVehicle = 'in_vehicle';

  /// The user is doing an interval training exercise.
  static const String intervalTraining = 'interval_training';

  /// The user is jumping rope.
  static const String jumpingRope = 'jumping_rope';

  /// The user is kayaking.
  static const String kayaking = 'kayaking';

  /// The user is training with a kettlebell.
  static const String kettlebellTraining = 'kettlebell_training';

  /// The user is practising kickboxing.
  static const String kickboxing = 'kickboxing';

  /// The user is kite-surfing.
  static const String kitesurfing = 'kitesurfing';

  /// The user is practising martial arts.
  static const String martialArts = 'martial_arts';

  /// The user is meditating.
  static const String meditation = 'meditation';

  /// The user is practising mixed martial arts.
  static const String mixedMartialArts = 'martial_arts.mixed';

  /// The user is on foot.
  static const String onFoot = 'on_foot';

  /// The user is doing some other activity.
  ///
  /// (not an unknown activity that cannot be identified).
  static const String other = 'other';

  /// The user is doing a P90X exercise.
  static const String p90x = 'p90x';

  /// The user is paragliding.
  static const String paragliding = 'paragliding';

  /// The user is doing a Pilates exercise.
  static const String pilates = 'pilates';

  /// The user is playing polo.
  static const String polo = 'polo';

  /// The user is playing racquetball.
  static const String racquetball = 'racquetball';

  /// The user is rock climbing.
  static const String rockClimbing = 'rock_climbing';

  /// The user is rowing.
  static const String rowing = 'rowing';

  /// The user is using a rowing machine.
  static const String rowingMachine = 'rowing.machine';

  /// The user is playing rugby.
  static const String rugby = 'rugby';

  /// The user is running.
  static const String running = 'running';

  /// The user is running on a treadmill.
  static const String runningmachine = 'running.machine';

  /// The user is sailing.
  static const String sailing = 'sailing';

  /// The user is scuba diving.
  static const String scubaDiving = 'scuba_diving';

  /// The user is riding a scooter.
  static const String scooterRiding = 'scooter_riding';

  /// The user is skateboarding.
  static const String skateboarding = 'skateboarding';

  /// The user is skating.
  static const String skating = 'skating';

  /// The user is skiing.
  static const String skiing = 'skiing';

  /// The user is sledding.
  static const String sledding = 'sledding';

  /// The user is sleeping.
  static const String sleep = 'sleep';

  /// The user is snowboarding.
  static const String snowboarding = 'snowboarding';

  /// The user is riding a snow mobile.
  static const String snowmobile = 'snowmobile';

  /// The user is walking in snowshoes.
  static const String snowshoeing = 'snowshoeing';

  /// The user is playing softball.
  static const String softball = 'softball';

  /// The user is playing squash.
  static const String squash = 'squash';

  /// The user is climbing stairs.
  static const String stairClimbing = 'stair_climbing';

  /// The user is using a stair-climbing machine.
  static const String stairClimbingMachine = 'stair_climbing.machine';

  /// The user is on a stand-up paddle board.
  static const String standupPaddleboarding = 'standup_paddleboarding';

  /// The user is still.
  static const String still = 'still';

  /// The user is strength training.
  static const String strengthTraining = 'strength_training';

  /// The user is surfing.
  static const String surfing = 'surfing';

  /// The user is swimming.
  static const String swimming = 'swimming';

  /// The user is swimming in a swimming pool.
  static const String swimmingPool = 'swimming.pool';

  /// The user is swimming in open waters.
  static const String swimmingOpenWater = 'swimming.open_water';

  /// The user is playing table tennis.
  static const String tableTennis = 'table_tennis';

  /// The user is playing a team sport.
  static const String teamSports = 'team_sports';

  /// The user is playing tennis.
  static const String tennis = 'tennis';

  /// The user is tilting the phone.
  static const String tilting = 'tilting';

  /// The user is performing an unknown activity (that can't be identified).
  static const String unknown = 'unknown';

  /// The user is playing volleyball.
  static const String volleyball = 'volleyball';

  /// The user is wakeboarding (being pulled by a motorboat).
  static const String wakeboarding = 'wakeboarding';

  /// The user is walking.
  static const String walking = 'walking';

  /// The user is playing water polo.
  static const String waterPolo = 'water_polo';

  /// The user is weightlifting.
  static const String weightlifting = 'weightlifting';

  /// The user is in a wheelchair.
  static const String wheelchair = 'wheelchair';

  /// The user is windsurfing.
  static const String windsurfing = 'windsurfing';

  /// The user is doing Yoga.
  static const String yoga = 'yoga';

  /// The user is doing Zumba (a kind of fitness dance).
  static const String zumba = 'zumba';

  /// The user is throwing darts.
  static const String darts = 'darts';

  /// The user is playing billiards.
  static const String billiards = 'billiards';

  /// The user is playing shuttlecock.
  static const String shuttlecock = 'shuttlecock';

  /// The user is playing bowling.
  static const String bowling = 'bowling';

  /// The user is practising group calisthenics.
  static const String groupCalisthenics = 'group_calisthenics';

  /// The user is playing tug of war.
  static const String tugOfWar = 'tug_of_war';

  /// The user is playing beach soccer.
  static const String beachSoccer = 'beach_soccer';

  /// The user is playing beach volleyball.
  static const String beachVolleyball = 'beach_volleyball';

  /// The user is playing gateball.
  static const String gateball = 'gateball';

  /// The user is playing Sepak Takraw.
  static const String sepaktakraw = 'sepaktakraw';

  /// The user is playing dodgeball.
  static const String dodgeBall = 'dodge_ball';

  /// The user is practising using a stair stepper.
  static const String treadmill = 'treadmill';

  /// The user is practising using a spinning bike.
  static const String spinning = 'spinning';

  /// The user is practising using a spacewalk machine.
  static const String strollMachine = 'stroll_machine';

  /// The user is practising crossfit.
  static const String crossFit = 'cross_fit';

  /// The user is having a functional training session.
  static const String functionalTraining = 'functional_training';

  /// The user is having a physical training session.
  static const String physicalTraining = 'physical_training';

  /// The user is practising/performing belly dance.
  static const String bellyDance = 'belly_dance';

  /// The user is practising/performing Jazz dance.
  static const String jazz = 'jazz';

  /// The user is practising/performing Latin dance.
  static const String latin = 'latin';

  /// The user is practising/performing ballet.
  static const String ballet = 'ballet';

  /// The user is having a core strength training.
  static const String coreTraining = 'core_training';

  /// The user is practising on a horizontal bar.
  static const String horizontalBar = 'horizontal_bar';

  /// The user is practising on parallel bars.
  static const String parallelBars = 'parallel_bars';

  /// The user is practising/performing hip-hop dance.
  static const String hipHop = 'hip_hop';

  /// The user is square dancing.
  static const String squareDance = 'square_dance';

  /// The user is practising with a hula hoop.
  static const String huLaHoop = 'hu_la_hoop';

  /// The user is riding a BMX bicycle.
  static const String bmx = 'bmx';

  /// The user is participating in orienteering.
  static const String orienteering = 'orienteering';

  /// The user is walking indoors.
  static const String indoorWalk = 'indoor_walk';

  /// The user is running indoors.
  static const String indoorRunning = 'indoor_running';

  /// The user is participating in mountaineering.
  static const String mountainClimbing = 'mountain_climbing';

  /// The user is doing cross-country running.
  static const String crossCountryRace = 'cross_country_race';

  /// The user is roller skating.
  static const String rollerSkating = 'roller_skating';

  /// The user is hunting.
  static const String hunting = 'hunting';

  /// The user is flying a kite.
  static const String flyAKite = 'fly_a_kite';

  /// The user is playing on a swing.
  static const String swing = 'swing';

  /// The user is doing an obstacle race.
  static const String obstacleRace = 'obstacle_race';

  /// The user is doing bungee jumping.
  static const String bungeeJumping = 'bungee_jumping';

  /// The user is playing parkour.
  static const String parkour = 'parkour';

  /// The user is performing parachuting.
  static const String parachute = 'parachute';

  /// The user is participating in a car race.
  static const String racingCar = 'racing_car';

  /// The user is participating in triathlon.
  static const String triathlons = 'triathlons';

  /// The user is playing ice hockey.
  static const String iceHockey = 'ice_hockey';

  /// The user is doing cross-country skiing.
  static const String crossCountrySkiing = 'crosscountry_skiing';

  /// The user is sledding.
  static const String sled = 'sled';

  /// The user is fishing.
  static const String fishing = 'fishing';

  /// The user is drifting in a river.
  static const String drifting = 'drifting';

  /// The user is participating in a dragon boat race.
  static const String dragonBoat = 'dragon_boat';

  /// The user is riding a motorboat.
  static const String motorboat = 'motorboat';

  /// The user is doing standup paddleboarding.
  static const String sup = 'sup';

  /// The user is practising free sparring.
  static const String freeSparring = 'free_sparring';

  /// The user is practising Karate.
  static const String karate = 'karate';

  /// The user is practising BodyCombat.
  static const String bodyCombat = 'body_combat';

  /// The user is practising Kendo.
  static const String kendo = 'kendo';

  /// The user is practising Tai chi.
  static const String taiChi = 'tai_chi';

  /// The user is practising free diving.
  static const String freeDiving = 'freediving';

  /// The user is having an apnea training.
  static const String apneaTraining = 'apnea_training';

  /// The user is having an apnea testing.
  static const String apneaTest = 'apnea_test';

  static const Map<int, String> typeActivityMap = <int, String>{
    0: 'unknown',
    1: 'aerobics',
    2: 'archery',
    3: 'badminton',
    4: 'baseball',
    5: 'basketball',
    6: 'biathlon',
    7: 'boxing',
    8: 'calisthenics',
    9: 'circuit_training',
    10: 'cricket',
    11: 'crossfit',
    12: 'curling',
    13: 'cycling',
    14: 'dancing',
    15: 'diving',
    16: 'elevator',
    17: 'elliptical',
    18: 'ergometer',
    19: 'escalator',
    20: 'fencing',
    21: 'football.american',
    22: 'football.australian',
    23: 'football.soccer',
    24: 'flying_disc',
    25: 'gardening',
    26: 'golf',
    27: 'gymnastics',
    28: 'handball',
    29: 'interval_training.high_intensity',
    30: 'hiking',
    31: 'hockey',
    32: 'horse_riding',
    33: 'housework',
    34: 'ice_skating',
    35: 'in_vehicle',
    36: 'interval_training',
    37: 'jumping_rope',
    38: 'kayaking',
    39: 'kettlebell_training',
    40: 'kickboxing',
    41: 'kitesurfing',
    42: 'martial_arts',
    44: 'meditation',
    43: 'martial_arts.mixed',
    45: 'on_foot',
    46: 'other',
    47: 'p90x',
    48: 'paragliding',
    49: 'pilates',
    50: 'polo',
    51: 'racquetball',
    52: 'rock_climbing',
    53: 'rowing',
    54: 'rowing.machine',
    55: 'rugby',
    56: 'running',
    57: 'running.machine',
    58: 'sailing',
    59: 'scuba_diving',
    60: 'scooter_riding',
    61: 'skateboarding',
    62: 'skating',
    63: 'skiing',
    64: 'sledding',
    65: 'sleep',
    66: 'sleep.light',
    67: 'sleep.deep',
    68: 'sleep.rem',
    69: 'sleep.awake',
    70: 'snowboarding',
    71: 'snowmobile',
    72: 'snowshoeing',
    73: 'softball',
    74: 'squash',
    75: 'stair_climbing',
    76: 'stair_climbing.machine',
    77: 'standup_paddleboarding',
    78: 'still',
    79: 'strength_training',
    80: 'surfing',
    81: 'swimming',
    83: 'swimming.pool',
    82: 'swimming.open_water',
    84: 'table_tennis',
    85: 'team_sports',
    86: 'tennis',
    87: 'tilting',
    88: 'volleyball',
    89: 'wakeboarding',
    90: 'walking',
    91: 'water_polo',
    92: 'weightlifting',
    93: 'wheelchair',
    94: 'windsurfing',
    95: 'yoga',
    96: 'zumba',
    97: 'cycling_indoor',
    98: 'darts',
    99: 'billiards',
    100: 'shuttlecock',
    101: 'bowling',
    102: 'group_calisthenics',
    103: 'tug_of_war',
    104: 'beach_soccer',
    105: 'beach_volleyball',
    106: 'gateball',
    107: 'sepaktakraw',
    108: 'dodge_ball',
    109: 'treadmill',
    110: 'spinning',
    111: 'stroll_machine',
    112: 'cross_fit',
    113: 'functional_training',
    114: 'physical_training',
    115: 'belly_dance',
    116: 'jazz',
    117: 'latin',
    118: 'ballet',
    119: 'core_training',
    120: 'horizontal_bar',
    121: 'parallel_bars',
    122: 'hip_hop',
    123: 'square_dance',
    124: 'hu_la_hoop',
    125: 'bmx',
    126: 'orienteering',
    127: 'indoor_walk',
    128: 'indoor_running',
    129: 'mountain_climbing',
    130: 'cross_country_race',
    131: 'roller_skating',
    132: 'hunting',
    133: 'fly_a_kite',
    134: 'swing',
    135: 'obstacle_race',
    136: 'bungee_jumping',
    137: 'parkour',
    138: 'parachute',
    139: 'racing_car',
    140: 'triathlons',
    141: 'ice_hockey',
    142: 'crosscountry_skiing',
    143: 'sled',
    144: 'fishing',
    145: 'drifting',
    146: 'dragon_boat',
    147: 'motorboat',
    148: 'sup',
    149: 'free_sparring',
    150: 'karate',
    151: 'body_combat',
    152: 'kendo',
    153: 'tai_chi',
    154: 'freediving',
    155: 'apnea_training',
    156: 'apnea_test',
  };

  static String getMimeType(String activity) {
    return '$MIME_TYPE_PREFIX$activity';
  }
}
