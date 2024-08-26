<p align="center">
  <h1 align="center">Huawei IAP Flutter Plugin</h1>
</p>

<p align="center">
  <a href="https://pub.dev/packages/huawei_iap"><img src="https://img.shields.io/pub/v/huawei_iap?style=for-the-badge" alt="pub.dev version"></a>
</p>


----

Huawei's In-App Purchases (IAP) service allows you to offer in-app purchases and facilitates in-app payment. Users can purchase a variety of virtual products, including one-time virtual products and subscriptions, directly within your app.

Huawei IAP provides the following core capabilities you need to quickly build apps with which your users can buy, consume and subscribe services you provide:
- **isEnvReady**: Returns a response which indicates user's environment status.
- **isSandboxActivated**: Returns a response which indicates user's account capabilities of sandbox testing.
- **obtainProductInfo**: Returns a list of product information. 
- **startIapActivity**: Starts an activity to manage and edit subscriptions.
- **createPurchaseIntent**: Starts an activity to buy the desired product or subscribe a product. 
- **consumeOwnedPurchase**: Consumes the desired purchased product.
- **obtainOwnedPurchases**: Returns a list of products that purchased by user.
- **obtainOwnedPurchaseRecord**: Returns a list of products that purchased and consumed by user. 
- **enableLogger**:  This method enables the HMSLogger capability which is used for sending usage analytics of IAP SDK's methods to improve the service quality.
- **disableLogger**: This method disables the HMSLogger capability which is used for sending usage analytics of IAP SDK's methods to improve the service quality.

This plugin enables communication between HUAWEI IAP Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI IAP Kit SDK.

[Learn More](https://developer.huawei.com/consumer/en/doc/HMS-Plugin-Guides/introduction-0000001051001685-V1?ha_source=hms1)

## Installation

Please see [pub.dev](https://pub.dev/packages/huawei_iap/install) and [AppGallery Connect Configuration](https://developer.huawei.com/consumer/en/doc/HMS-Plugin-Guides/config-agc-0000001051001687-V1?ha_source=hms1).

## Documentation

- [Quick Start](https://developer.huawei.com/consumer/en/doc/HMS-Plugin-Guides/client-dev-guide-0000001051001691-V1?ha_source=hms1)
- [Reference](https://developer.huawei.com/consumer/en/doc/HMS-Plugin-References/overview-0000001051005695-V1?ha_source=hms1)

## Questions or Issues

If you have questions about how to use HMS samples, try the following options:

- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
  **huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001&ha_source=hms1) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin?ha_source=hms1) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

## License

Huawei IAP Flutter Plugin is licensed under [Apache 2.0 license](LICENSE).