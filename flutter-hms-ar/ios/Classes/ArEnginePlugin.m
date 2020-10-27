#import "ArEnginePlugin.h"
#if __has_include(<huawei_arengine/huawei_arengine-Swift.h>)
#import <huawei_arengine/huawei_arengine-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "huawei_arengine-Swift.h"
#endif

@implementation ArEnginePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftArEnginePlugin registerWithRegistrar:registrar];
}
@end
