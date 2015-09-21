#import <Cordova/CDV.h>

@interface MyPlugin : CDVPlugin

- (void)getCarrierInfo:(CDVInvokedUrlCommand*)command;
+ (NSString*)cordovaVersion;

@end
