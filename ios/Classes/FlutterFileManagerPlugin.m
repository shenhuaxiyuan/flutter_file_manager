#import "FlutterFileManagerPlugin.h"
#import <flutter_file_manager/flutter_file_manager-Swift.h>

@implementation FlutterFileManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFileManagerPlugin registerWithRegistrar:registrar];
}
@end
