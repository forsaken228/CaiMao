//
//  CMJPush.m
//  CaiMao
//
//  Created by MAC on 16/11/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVenderConfiguration.h"

@implementation CMVenderConfiguration
CMSingletonM(CMVenderConfiguration)
#pragma mark  极光推送配置

+ (NSDictionary*)setupWithOptions:(NSDictionary *)launchOptions {

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
        
    [JPUSHService setupWithOption:launchOptions appKey:jpushAppKey channel:channel apsForProduction:isProduction];
  NSDictionary *message = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
   
  
 return message;
    
    

}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    return;
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion {
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (completion) {
        completion(UIBackgroundFetchResultNewData);
    }
    return;
}
+(void)registerID:(void(^)(NSString * registerID))success{
    
    [JPUSHService  registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if (resCode==0) {
            success(registrationID);
        }
        
    }];
    
}


#pragma mark 分享配置
/*
+(void)registerShare{
    
    [ShareSDK registerApp:@"5708c459c100"
          activePlatforms:@[@(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeSMS)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeTencentWeibo:
                             [appInfo SSDKSetupTencentWeiboByAppKey:@"801558287" appSecret:@"16eedc51cd2e88d07297df4be90debed" redirectUri:@"http://www.58cm.com"];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             // 设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"376421421"
                                                       appSecret:@"7ebaab095b6ec20e5fa8665f5b14219a"
                                                     redirectUri:@"http://www.58cm.com"
                                                        authType:SSDKAuthTypeBoth];
                             break;
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wx9e97b3dbdac46bfe"
                                                   appSecret:@"4a03f22ec20c2c50e5e049118b6ffda9"];
                             break;
                             //QQ
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1104914591" appKey:@"pMNrwdG3DQruX2Bh" authType:SSDKAuthTypeBoth];
                             break;
                         default:
                             break;
                     }
                 }];

}
*/


+(void)registerShare{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
    
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;

             default:
                 break;
         }
     }];
    
}

#pragma mark 高德
+(void)registerMap{
    
    [AMapServices sharedServices].apiKey =@"d241ca9d6ec4a975b726f46a96e0d9a5";
}

- (void)AMapstartLocation{
    self.AMaplocationManager = [[AMapLocationManager alloc] init];
   // self.AMaplocationManager.delegate = self;
    [self.AMaplocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
   // [self.AMaplocationManager setPausesLocationUpdatesAutomatically:NO];
    //[self.AMaplocationManager setAllowsBackgroundLocationUpdates:YES];
    //带逆地理定位
   // [self.AMaplocationManager setLocatingWithReGeocode:YES];
    //[self.AMaplocationManager startUpdatingLocation];
    
    
    [self.AMaplocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            DLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            [CMUserDefaults removeObjectForKey:@"AddressMsg"];
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
           
        }
        
  
        if (regeocode)
            
        {
            NSDate *date= location.timestamp;
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //定位时间
            NSString *dateString=[formatter stringFromDate:date];
            //纬度
            NSString *latitude=@"";
            if (location.coordinate.latitude) {
            latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
            }
             NSString *longitude=@"";
            if (location.coordinate.longitude) {
                //经度
                longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
            }
           
         NSString *province=@"";
            if (regeocode.province) {
                province=regeocode.province;
            }
           NSString *city=@"";
            if (regeocode.city) {
                city=regeocode.city;
            }
            //位置
            NSString *Address=@"";
            if (regeocode.street) {
                if (regeocode.number) {
                    Address=[NSString stringWithFormat:@"%@%@%@%@",regeocode.district,regeocode.street,regeocode.number,regeocode.POIName];
                }else{
                    
                    Address=[NSString stringWithFormat:@"%@%@%@",regeocode.district,regeocode.street,regeocode.POIName];
                }
            }else{
                Address=[NSString stringWithFormat:@"%@%@",regeocode.district,regeocode.POIName];
            }
            
            NSString *upId=@"0";
            if ([CMRequestManager islogin]) {
                upId=[CMUserDefaults objectForKey:@"userID"];
            }else{
                
                upId=@"0";
            }
              // DLog(@"定位时间++%@++纬度++%@++经度++%@++省份++%@++城市++%@++地址++%@",dateString,latitude,longitude,province,city,Address);
            NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
            //创建时间
             [messageDict setObject:dateString forKey:@"CreateDate"];
            if(province!=nil){
            //省
             [messageDict setObject:province forKey:@"Province"];
            }
            if (city !=nil) {
                //市
             [messageDict setObject:city forKey:@"City"];
            }
            if (Address!=nil) {
                  //详细地址
             [messageDict setObject:Address forKey:@"DetailAddress"];
            }
          
            //设备标示
             [messageDict setObject:@"1" forKey:@"Equipment"];
            //会员ID
            if (upId!=nil) {
                [messageDict setObject:upId forKey:@"HYID"];
            }
            if (latitude!=nil) {
                //纬度
                [messageDict setObject:latitude forKey:@"Latitude"];
            }
            if (longitude!=nil) {
                //经度
                [messageDict setObject:longitude forKey:@"Longitude"];
            }
          
     
            //设备注册ID
            if([JPUSHService registrationID]){
                [messageDict setObject:[JPUSHService registrationID] forKey:@"Code"];
            }else{
                [messageDict setObject:@"0" forKey:@"Code"];
            }
         
            NSMutableDictionary *newDict=[NSMutableDictionary dictionaryWithDictionary:messageDict];
            if(regeocode.district !=nil){
                
            [newDict setObject:regeocode.district forKey:@"Area"];
                
            }
            [CMUserDefaults setObject:newDict forKey:@"AddressMsg"];
            [CMUserDefaults synchronize];
            
     //[CMAlert(Address);
            [CMRequestHandle upLoadAddressMessageWithMessageArr:messageDict andSuccess:^(id responseObj) {
               
           // DLog(@"+++++%@+++%@",responseObj,messageDict);
            }];
        }
    }];
    
 
}


//#pragma mark --AMapLocationManagerDelegate
//- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
//{
//    //定位错误
//    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
//}
//
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
//    
//    if(reGeocode){
//   DLog(@"location:{lat:%f; lon:%f;}", location.coordinate.latitude, location.coordinate.longitude);
//    DLog(@"++%@++%@==%@",reGeocode.province,reGeocode.city,[NSString stringWithFormat:@"%@%@%@",reGeocode.district,reGeocode.street,reGeocode.AOIName]);
//    
//    }
//    
//}



@end
