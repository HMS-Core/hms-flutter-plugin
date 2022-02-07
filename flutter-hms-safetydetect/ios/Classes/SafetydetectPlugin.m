#import "SafetydetectPlugin.h"
#if __has_include(<safetydetect/safetydetect-Swift.h>)
#import <safetydetect/safetydetect-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "safetydetect-Swift.h"
#endif

@implementation SafetydetectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSafetydetectPlugin registerWithRegistrar:registrar];
}
@end
