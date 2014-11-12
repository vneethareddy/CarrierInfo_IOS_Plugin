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
    
    
    
//    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [netinfo subscriberCellularProvider];
//    NSLog(@"Carrier Name: %@", [carrier carrierName]);
      NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    NSString* uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
    NSLog(@"UDID:: %@", uniqueIdentifier);
    
      
    NSString* appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString* appname = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:3];
    

      [dict setObject:[NSString stringWithString:appversion] forKey:@"appversion"];
    [dict setObject:[NSString stringWithString:appname] forKey:@"appname"];
   

     NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [devProps setObject:appversion forKey:@"appversion"];
    [devProps setObject:appname forKey:@"appname"];
    [devProps setObject:uniqueIdentifier forKey:@"uuid"];
    [devProps setObject:@"iOS" forKey:@"platform"];
    [devProps setObject:dateString forKey:@"version"];
    NSLog(@"UDID:: %@", devProps);
    
    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end
