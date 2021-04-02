<p align="center">
  <h1 align="center">Huawei Game Service Flutter Plugin</h1>
</p>



<p align="center">
  <a href="https://pub.dev/packages/huawei_gameservice"><img src="https://img.shields.io/pub/v/huawei_gameservice?style=for-the-badge" alt="pub.dev version"></a>
</p>


----

With HUAWEI Game Service, you will have access to a range of development capabilities. You can promote your game quickly and efficiently to Huawei's vast user base by having users sign in using their HUAWEI IDs. You can also use the service to quickly implement achievements, game events, and game addiction prevention functions, build basic game capabilities at a low cost, and perform in-depth game operations based on user and content localization.

HUAWEI Game Service provides the following basic functions for your game apps:
- Game addiction prevention
- Floating window
- Achievements
- Events
- Leaderboards
- Saved games
- Player statistics
- Access to basic game information

The HUAWEI Game Service Flutter Plugin enables communication between HUAWEI Game Service SDK and the Flutter Platform and it exposes all capabilities provided by the HUAWEI Game Service.

[Learn More](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/introduction-0000001080980430)

## Installation

Please see [pub.dev](https://pub.dev/packages/huawei_gameservice/install) and [AppGallery Connect Configuration](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/config-agc-0000001080660860).

## Documentation

- [Quick Start](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/client-dev-overview-0000001080675722)
- [Reference](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-References-V1/flutter-apis-overview-0000001080990190-V1)

### Additional Topics

#### Game Sign-in Requirements

- To implement the Game Sign-in function  for players to sign in to your game using HUAWEI IDs please use the [HUAWEI Account Flutter Plugin](https://pub.dev/packages/huawei_account) plugin. After the user successfully signs in, HUAWEI Account Kit sends the verification result to your game and you can obtain the player information by calling the related APIs from Players Client.

#### Testing Game Features

You need to have a tester account to perform the testing of some Game Features. For details about how to create a tester account, please refer to [Managing Tester Accounts](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-tester_account_mgt).

Before a game is released, you can use a tester account to sign in to the game and test the game achievements, leaderboards, and saved games. Avoid releasing achievements or leaderboards when the corresponding game is still undergoing tests. This is because achievement or leaderboard data changes along with game operations performed by the tester account, and it cannot be reset once they have been released.

Note that HUAWEI AppAssistant can display achievements, leaderboards, and saved games only after your game is released and only on devices running EMUI 10.0 or later and HUAWEI AppAssistant 10.3 or later is installed. (HUAWEI AppAssistant 10.1 or later for achievements).

## Sample Project

This plugin includes a demo project in the **example** folder, there you can find usage examples. Please follow the instructions on the [Installation](#installation) section in order to run the demo application successfully.

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-gameservice/example/.docs/demo_app_screenshot.png" width = 40% height = 40% style="margin:1.5em">

## Questions or Issues

If you have questions about how to use HMS samples, try the following options:

- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
  **huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

## License

Huawei Game Service Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
