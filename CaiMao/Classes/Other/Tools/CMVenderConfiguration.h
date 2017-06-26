//
//  CMJPush.h
//  CaiMao
//
//  Created by MAC on 16/11/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

static NSString *channel = @"Publish channel";
static NSString *jpushAppKey= @"575b8b2dd9c09336da04d106";
static BOOL isProduction =YES;
@interface CMVenderConfiguration : NSObject<AMapLocationManagerDelegate>
CMSingletonH(CMVenderConfiguration)

@property(nonatomic,strong)AMapLocationManager *AMaplocationManager;
// 在应用启动的时候调用
+ (NSDictionary*)setupWithOptions:(NSDictionary *)launchOptions;

// 在appdelegate注册设备处调用
+(void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;


+(void)registerID:(void(^)(NSString * registerID))success;

+(void)registerShare;

//高德定位

+(void)registerMap;
- (void)AMapstartLocation;

@end
