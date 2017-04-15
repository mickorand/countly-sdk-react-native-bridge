#import <React/RCTBridge.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>
#import <React/RCTEventDispatcher.h>

#import "Countly.h"
#import "CountlyReactNative.h"
#import "CountlyConfig.h"
#import "CountlyPushNotifications.h"


CountlyConfig* config = nil;


@implementation CountlyReactNative

RCT_EXPORT_MODULE();


RCT_EXPORT_METHOD(echo:(NSArray*)arguments)
{
  RCTLogInfo(@"Nicolson look here this is called");
}

- (void)init:(NSArray*)arguments
{
  NSString* serverurl = [arguments objectAtIndex:0];
  NSString* appkey = [arguments objectAtIndex:1];
  
  config = CountlyConfig.new;
  config.appKey = appkey;
  config.host = serverurl;
  
  if (serverurl != nil && [serverurl length] > 0) {
    [[Countly sharedInstance] startWithConfig:config];
  } else {
  }
  
  
}

- (void)event:(NSArray*)arguments
{
  NSString* eventType = [arguments objectAtIndex:0];
  if (eventType != nil && [eventType length] > 0) {
    if ([eventType  isEqual: @"event"]) {
      NSString* eventName = [arguments objectAtIndex:1];
      NSString* countString = [arguments objectAtIndex:2];
      int countInt = [countString intValue];
      [[Countly sharedInstance] recordEvent:eventName count:countInt];
      
    }
    else if ([eventType  isEqual: @"eventWithSum"]){
      NSString* eventName = [arguments objectAtIndex:1];
      NSString* countString = [arguments objectAtIndex:2];
      int countInt = [countString intValue];
      NSString* sumString = [arguments objectAtIndex:3];
      float sumFloat = [sumString floatValue];
      [[Countly sharedInstance] recordEvent:eventName count:countInt  sum:sumFloat];
    }
    else if ([eventType  isEqual: @"eventWithSegment"]){
      NSString* eventName = [arguments objectAtIndex:1];
      NSString* countString = [arguments objectAtIndex:2];
      int countInt = [countString intValue];
      NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
      
      for(int i=3,il=(int)arguments.count;i<il;i+=2){
        dict[[arguments objectAtIndex:i]] = [arguments objectAtIndex:i+1];
      }
      [[Countly sharedInstance] recordEvent:eventName segmentation:dict count:countInt];
    }
    else if ([eventType  isEqual: @"eventWithSumSegment"]){
      NSString* eventName = [arguments objectAtIndex:1];
      NSString* countString = [arguments objectAtIndex:2];
      int countInt = [countString intValue];
      NSString* sumString = [arguments objectAtIndex:3];
      float sumFloat = [sumString floatValue];
      NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
      
      for(int i=4,il=(int)arguments.count;i<il;i+=2){
        dict[[arguments objectAtIndex:i]] = [arguments objectAtIndex:i+1];
      }
      [[Countly sharedInstance] recordEvent:eventName segmentation:dict count:countInt  sum:sumFloat];
    }
    else{
    }
  } else {
  }
  
  
}
- (void)recordView:(NSArray*)arguments
{
  
  NSString* recordView = [arguments objectAtIndex:0];
  [Countly.sharedInstance reportView:recordView];
  
}
- (void)setloggingenabled:(NSArray*)arguments
{
  
  
}

- (void)setuserdata:(NSArray*)arguments
{
  
  NSString* name = [arguments objectAtIndex:0];
  NSString* username = [arguments objectAtIndex:1];
  NSString* email = [arguments objectAtIndex:2];
  NSString* org = [arguments objectAtIndex:3];
  NSString* phone = [arguments objectAtIndex:4];
  NSString* picture = [arguments objectAtIndex:5];
  //NSString* picturePath = [arguments objectAtIndex:6];
  NSString* gender = [arguments objectAtIndex:7];
  NSString* byear = [arguments objectAtIndex:8];
  
  Countly.user.name = name;
  Countly.user.username = username;
  Countly.user.email = email;
  Countly.user.organization = org;
  Countly.user.phone = phone;
  Countly.user.pictureURL = picture;
  Countly.user.gender = gender;
  Countly.user.birthYear = @([byear integerValue]);
  //NSInteger byearint = [byear intValue];
  
  [Countly.user recordUserDetails];
  [Countly.user save];
  // [Countly.sharedInstance recordUserDetails: @{
  //                                             kCLYUserName: name,
  //                                             kCLYUserEmail: email,
  //                                             kCLYUserBirthYear: byear,
  //                                             kCLYUserGender: gender,
  //                                             kCLYUserOrganization: org,
  //                                             kCLYUserPhone: phone,
  //                                             kCLYUserUsername: username,
  //                                             kCLYUserPicture: picture
  //                                                          }];
  
}


- (void)onregistrationid:(NSArray*)arguments
{
  NSString* token = [arguments objectAtIndex:0];
  NSString* messagingMode = [arguments objectAtIndex:1];
  int mode = [messagingMode intValue];
  NSData *tokenByte = [token dataUsingEncoding:NSUTF8StringEncoding];
  if(mode == 1){
    // [[CountlyConnectionQueue sharedInstance] setStartedWithTest:YES];
  }
  //  CountlyPushNotifications.sharedInstance.token = token;
  //  [CountlyPushNotifications.sharedInstance sendToken];
  // [Countly.sharedInstance didRegisterForRemoteNotificationsWithDeviceToken:tokenByte];
  
  // [[CountlyConnectionQueue sharedInstance] tokenSession:token];
  
  
  
}

- (void)start:(NSArray*)arguments
{
  [Countly.sharedInstance resume];
  
  
  
}

- (void)stop:(NSArray*)arguments
{
  [Countly.sharedInstance suspend];
  
  
  
}

- (void)changeDeviceId:(NSArray*)arguments
{
  NSString* newDeviceID = [arguments objectAtIndex:0];
  [Countly.sharedInstance setNewDeviceID:newDeviceID onServer:YES];
  
  
  
}

- (void)setHttpPostForced:(NSArray*)arguments
{
  
  
}

- (void)enableParameterTamperingProtection:(NSArray*)arguments
{
  NSString* salt = [arguments objectAtIndex:0];
  config.secretSalt = salt;
  
  
  
}

- (void)startEvent:(NSArray*)arguments
{
  NSString* eventName = [arguments objectAtIndex:0];
  [Countly.sharedInstance startEvent:eventName];
  
  
  
}

- (void)endEvent:(NSArray*)arguments
{
  NSString* eventType = [arguments objectAtIndex:0];
  
  
  if ([eventType  isEqual: @"event"]) {
    NSString* eventName = [arguments objectAtIndex:1];
    [Countly.sharedInstance endEvent:eventName];
  }
  else if ([eventType  isEqual: @"eventWithSegment"]){
    NSString* eventName = [arguments objectAtIndex:1];
    NSString* countString = [arguments objectAtIndex:2];
    int countInt = [countString intValue];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    for(int i=3,il=(int)arguments.count;i<il;i+=2){
      dict[[arguments objectAtIndex:i]] = [arguments objectAtIndex:i+1];
    }
    [Countly.sharedInstance endEvent:eventName segmentation:dict count:countInt sum:0];
    
  }
  else{
  }
  
  
}

- (void)setLocation:(NSArray*)arguments
{
  NSString* latitudeString = [arguments objectAtIndex:0];
  NSString* longitudeString = [arguments objectAtIndex:1];
  
  double latitudeDouble = [latitudeString doubleValue];
  double longitudeDouble = [longitudeString doubleValue];
  
  config.location = (CLLocationCoordinate2D){latitudeDouble,longitudeDouble};
  
  
  
}

- (void)enableCrashReporting:(NSArray*)arguments
{
  config.features = @[CLYCrashReporting];
  
  
  
}

- (void)addCrashLog:(NSArray*)arguments
{
  NSString* token = [arguments objectAtIndex:0];
  NSString* messagingMode = [arguments objectAtIndex:1];
  int mode = [messagingMode intValue];
  NSData *tokenByte = [token dataUsingEncoding:NSUTF8StringEncoding];
  
  
}

- (void)userData_setProperty:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  NSString* keyValue = [arguments objectAtIndex:1];
  
  [Countly.user set:keyName value:keyValue];
  [Countly.user save];
  
  
  
}

- (void)userData_increment:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  
  [Countly.user increment:keyName];
  [Countly.user save];
  
  
  
}

- (void)userData_incrementBy:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  NSString* keyValue = [arguments objectAtIndex:1];
  int keyValueInteger = [keyValue intValue];
  
  [Countly.user incrementBy:keyName value:keyValueInteger];
  [Countly.user save];
  
  
  
}

- (void)userData_multiply:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  NSString* keyValue = [arguments objectAtIndex:1];
  int keyValueInteger = [keyValue intValue];
  
  [Countly.user multiply:keyName value:keyValueInteger];
  [Countly.user save];
  
  
  
}

- (void)userData_saveMax:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  NSString* keyValue = [arguments objectAtIndex:1];
  int keyValueInteger = [keyValue intValue];
  
  [Countly.user max:keyName value:keyValueInteger];
  [Countly.user save];
  
  
  
}

- (void)userData_saveMin:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  NSString* keyValue = [arguments objectAtIndex:1];
  int keyValueInteger = [keyValue intValue];
  
  [Countly.user min:keyName value:keyValueInteger];
  [Countly.user save];
  
  
  
}

- (void)userData_setOnce:(NSArray*)arguments
{
  NSString* keyName = [arguments objectAtIndex:0];
  NSString* keyValue = [arguments objectAtIndex:1];
  
  [Countly.user setOnce:keyName value:keyValue];
  [Countly.user save];
  
  
  
}

- (void)demo:(NSArray*)arguments
{
  NSString* token = [arguments objectAtIndex:0];
  NSString* messagingMode = [arguments objectAtIndex:1];
  int mode = [messagingMode intValue];
  NSData *tokenByte = [token dataUsingEncoding:NSUTF8StringEncoding];
  
  
}

@end