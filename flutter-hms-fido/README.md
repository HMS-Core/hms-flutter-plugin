<p align="center">
  <h1 align="center">Huawei FIDO Flutter Plugin</h1>
</p>


<p align="center">
  <a href="https://pub.dev/packages/huawei_fido"><img src="https://img.shields.io/pub/v/huawei_fido?style=for-the-badge" alt="pub.dev version"></a>
</p>

----

HUAWEI FIDO Plugin provides your app with FIDO2 based on the WebAuthn standard. It provides Android Java APIs for apps and browsers, and allows users to complete authentication through roaming authenticators (USB, NFC, and Bluetooth authenticators) and platform authenticators (fingerprint and 3D face authenticator). In addition, FIDO provides your app with powerful local biometric authentication capabilities, including fingerprint authentication and 3D facial authentication. It allows your app to provide secure and easy-to-use password-free authentication for users while ensuring reliable authentication results. The plugin provides HmsBioAuthnManager, HmsBioAuthnPrompt, HmsFaceManager and HmsFido2Client APIs provided by the **HUAWEI FIDO SDK**.

- HmsBioAuthnManager

    Entrance to the API for checking whether fingerprint authentication of FIDO BioAuthn is available.

- HmsBioAuthnPrompt

    Main entrance to the fingerprint authentication API of FIDO BioAuthn.

- HmsFaceManager

    Main entrance to the 3D facial authentication API of FIDO. HmsFaceManger requires devices that support 3D facial recognition.

- HmsFido2Client

    Entrance to FIDO2 APIs. Allows registration and authentication through platform authenticators or cross platform authenticators.

[Learn More](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/introduction-0000001096579081)

## Installation

Please see [pub.dev](https://pub.dev/packages/huawei_fido/install) and [AppGallery Connect Configuration](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/config-agc-0000001077561434).

## Documentation

- [Quick Start](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/integrate-fido-client-0000001077890662)
- [Reference](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-References/overview-0000001096697417)

### Additional Topics
- To learn more about WebAuthn, please refer [here](https://www.w3.org/TR/webauthn/#webauthn-client).

## Questions or Issues

If you have questions about how to use HMS samples, try the following options:
- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
**huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

## License

Huawei FIDO Flutter Plugin is licensed under [Apache 2.0 license](LICENCE)