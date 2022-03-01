#import "HealthPlugin.h"
#if __has_include(<health/health-Swift.h>)
#import <health/health-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "health-Swift.h"
#endif

@implementation HealthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHealthPlugin registerWithRegistrar:registrar];
}
@end
