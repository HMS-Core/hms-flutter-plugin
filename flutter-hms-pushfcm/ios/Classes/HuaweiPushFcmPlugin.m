#import "HuaweiPushFcmPlugin.h"
#if __has_include(<huawei_push_fcm/huawei_push_fcm-Swift.h>)
#import <huawei_push_fcm/huawei_push_fcm-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "huawei_push_fcm-Swift.h"
#endif

@implementation HuaweiPushFcmPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHuaweiPushFcmPlugin registerWithRegistrar:registrar];
}
@end
