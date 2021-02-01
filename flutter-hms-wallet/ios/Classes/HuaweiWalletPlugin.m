#import "HuaweiWalletPlugin.h"
#if __has_include(<huawei_wallet/huawei_wallet-Swift.h>)
#import <huawei_wallet/huawei_wallet-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "huawei_wallet-Swift.h"
#endif

@implementation HuaweiWalletPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHuaweiWalletPlugin registerWithRegistrar:registrar];
}
@end
