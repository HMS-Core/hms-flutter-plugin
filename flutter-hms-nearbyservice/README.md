<p align="center">
  <h1 align="center">Huawei Nearby Service Flutter Plugin</h1>
</p>

<p align="center">
  <a href="https://pub.dev/packages/huawei_nearbyservice"><img src="https://img.shields.io/pub/v/huawei_nearbyservice?style=for-the-badge" alt="pub.dev version"></a>
</p>

---

## Introduction

Nearby Data Communication allows devices to easily discover nearby devices and set up communication with them using technologies such as Bluetooth and Wi-Fi. The plugin provides Nearby Connection, Nearby Message, and Nearby Wi-Fi Sharing APIs provided by the **HUAWEI Nearby Service SDK**.

- Nearby Connection

    Discovers devices and sets up secure communication channels with them without connecting to the Internet and transfers byte arrays, files, and streams to them; supports seamless nearby interactions, such as multi-player gaming, real-time collaboration, resource broadcasting, and content sharing.

- Nearby Message

    Allows message publishing and subscription between nearby devices that are connected to the Internet. A subscriber (app) can obtain the message content from the cloud service based on the sharing code broadcast by a publisher (beacon or another app).

- Nearby Wi-Fi Sharing

    Provides the Wi-Fi configuration sharing function to help users connect their own or friends' smart devices to the Wi-Fi network in one-click mode.
[Learn More](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides-V1/introduction-0000001074107546-V1?ha_source=hms1)

## Installing the Plugin

Add dependencies to the pubspec.yaml file of the Flutter project.
huawei_nearbyservice:
Run the following command on the Terminal page or click Pub get in Android Studio to add dependencies.
flutter pub get
For more details, please refer to [Getting Started with Flutter](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides-V1/prepare-dev-env-0000001074265856-V1?ha_source=hms1)

## Development Guide

- [Guides](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001073825475?ha_source=hms1)
- [Reference](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-References/overview-0000001074428872?ha_source=hms1)

## License

Huawei Nearby Service Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
