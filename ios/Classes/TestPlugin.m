#import "TestPlugin.h"
#if __has_include(<test_plugin/test_plugin-Swift.h>)
#import <test_plugin/test_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "test_plugin-Swift.h"
#endif

@implementation TestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTestPlugin registerWithRegistrar:registrar];
}
@end
