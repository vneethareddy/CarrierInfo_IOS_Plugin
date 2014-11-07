#import "MyPlugin.h"
#import <Cordova/CDV.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@implementation MyPlugin

- (void)getCarrierInfo:(CDVInvokedUrlCommand*)command
{
    
    NSString *currentDate =[self getCurrentDate];
    
    
    
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:currentDate];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (NSString *) getCurrentDate{
    
    
    
//    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [netinfo subscriberCellularProvider];
//    NSLog(@"Carrier Name: %@", [carrier carrierName]);
//    NSString *dateString = [carrier carrierName];
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
      return dateString;
    
}

@end