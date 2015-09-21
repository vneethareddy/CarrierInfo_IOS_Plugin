#import "MyPlugin.h"
#import <Cordova/CDV.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation UIDevice (ModelVersion)

- (NSString*)modelVersion
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString* platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return platform;
}

@end

@implementation MyPlugin

- (NSString*)uniqueAppInstanceIdentifier:(UIDevice*)device
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    static NSString* UUID_KEY = @"CDVUUID";
    
    NSString* app_uuid = [userDefaults stringForKey:UUID_KEY];
    
    if (app_uuid == nil) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
        
        app_uuid = [NSString stringWithString:(__bridge NSString*)uuidString];
        [userDefaults setObject:app_uuid forKey:UUID_KEY];
        [userDefaults synchronize];
        
        CFRelease(uuidString);
        CFRelease(uuidRef);
    }
    
    return app_uuid;
}

- (void)getCarrierInfo:(CDVInvokedUrlCommand*)command
{
    
 NSDictionary *currentDate =[self getCurrentDate];
    
    
    
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:currentDate];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (NSDictionary *) getCurrentDate{
    
    
    
    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
        UIDevice* device = [UIDevice currentDevice];


    
    NSString* appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString* appname = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
     
    
    
    
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:9];
    
    [devProps setObject:appversion forKey:@"appversion"];
    [devProps setObject:appname forKey:@"appname"];
    [devProps setObject:[carrier carrierName] forKey:@"carriername"];
    [devProps setObject:[carrier mobileNetworkCode] forKey:@"mnc"];
    [devProps setObject:[carrier mobileCountryCode] forKey:@"mcc"];
    [devProps setObject:@"Apple" forKey:@"manufacturer"];
    [devProps setObject:[device modelVersion] forKey:@"model"];
    [devProps setObject:@"iOS" forKey:@"platform"];
    [devProps setObject:[device systemVersion] forKey:@"version"];
    [devProps setObject:[self uniqueAppInstanceIdentifier:device] forKey:@"uuid"];
    [devProps setObject:[[self class] cordovaVersion] forKey:@"cordova"];
 NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end

