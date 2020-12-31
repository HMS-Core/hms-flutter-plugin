#import "HuaweiNearbyservicePlugin.h"
#if __has_include(<huawei_nearbyservice/huawei_nearbyservice-Swift.h>)
#import <huawei_nearbyservice/huawei_nearbyservice-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "huawei_nearbyservice-Swift.h"
#endif

@implementation HuaweiNearbyservicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHuaweiNearbyservicePlugin registerWithRegistrar:registrar];
}
@end
