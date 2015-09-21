#import "MyPlugin.h"
#import <Cordova/CDV.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

 

@implementation MyPlugin

- (void)getCarrierInfo:(CDVInvokedUrlCommand*)command
{
    
 NSDictionary *currentDate =[self getCurrentDate];
    
    
    
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:currentDate];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (NSDictionary *) getCurrentDate{
    
    
    
    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
 

    
    NSString* appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString* appname = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
     
    
    
    
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [devProps setObject:appversion forKey:@"appversion"];
    [devProps setObject:appname forKey:@"appname"];
    [devProps setObject:[carrier carrierName] forKey:@"carriername"];
    [devProps setObject:[carrier mobileNetworkCode] forKey:@"mnc"];
    [devProps setObject:[carrier mobileCountryCode] forKey:@"mcc"];
 NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end

