#import "HuaweiGameservicePlugin.h"
#if __has_include(<huawei_gameservice/huawei_gameservice-Swift.h>)
#import <huawei_gameservice/huawei_gameservice-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "huawei_gameservice-Swift.h"
#endif

@implementation HuaweiGameservicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHuaweiGameservicePlugin registerWithRegistrar:registrar];
}
@end
