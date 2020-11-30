#import "ContactShieldPlugin.h"
#if __has_include(<huawei_contactshield/huawei_contactshield-Swift.h>)
#import <huawei_contactshield/huawei_contactshield-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "huawei_contactshield-Swift.h"
#endif

@implementation ContactShieldPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftContactShieldPlugin registerWithRegistrar:registrar];
}
@end
