//
//  CMAppDelegate.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMAppDelegate.h"
#import "CMAppDelegate+CMLanuch.h"

@implementation CMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    //application.statusBarHidden = NO;
    DLog(@"didFinishLaunchingWithOptions");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    NSDictionary *isJpushMessage=[CMVenderConfiguration setupWithOptions:launchOptions];
    
    if(![CMUserDefaults boolForKey:@"firstLaunch"]){
        
        [CMUserDefaults setBool:YES forKey:@"firstLaunch"];
        CMUserGuideViewController *vc=[[CMUserGuideViewController alloc]init];
        self.window.rootViewController=vc;
    }else{
     
        tab=[[CMTabBarController alloc]init];
        if (isJpushMessage) { // 点击通远程知启动的程序
         //   self.window.rootViewController =self.tab;
           
       }
      //  else { // 直接点击app图标启动的程序
            self.window.rootViewController = tab;
            
        //}
        [self setUpLaunchAd];
        
    }
     
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    
  [self configureBoardManager];
    
    //分享集成
  [CMVenderConfiguration registerShare];
    // 自动登录
    
    [self loginAuto];
    //监听通讯录
  ABAddressBookRegisterExternalChangeCallback( ABAddressBookCreateWithOptions(NULL, NULL), addressBookChanged, (__bridge void *)(self));

    [CMMessageDao createTable];


    //高德地图初始化
    [CMVenderConfiguration registerMap];
    
    [[CMVenderConfiguration sharedCMVenderConfiguration] AMapstartLocation];
//
//    [CMVenderConfiguration registerID:^(NSString *registerID) {
//        DLog(@"+++%@",registerID);
//    }];
//  

   
    return YES;
}
//-(CMTabBarController*)tab{
//    if(!_tab){
//        _tab=[[CMTabBarController alloc] init];
//    }
//    return _tab;
//}

void addressBookChanged(ABAddressBookRef addressBook, CFDictionaryRef info, void *context)
{
    // 比如上传
    [CMUserDefaults setBool:YES forKey:@"gaibai"];
    [CMUserDefaults synchronize];
      
    
}
#pragma mark 键盘收回管理
-(void)configureBoardManager{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
  
    NSDate*currentDate = [NSDate date];
    [CMUserDefaults setObject:currentDate forKey:@"AppTimeLastOpenDate"];
    [CMUserDefaults synchronize];
 
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
    NSDate*userLastOpenDate =[CMUserDefaults objectForKey:@"AppTimeLastOpenDate"];
    if (userLastOpenDate) {
        
        
        NSDate*currentDate = [NSDate date];
        NSCalendar*calendar = [NSCalendar currentCalendar];
        
        //计算两个日期的差值
        
        NSDateComponents *cmps= [calendar components:NSCalendarUnitMinute fromDate:userLastOpenDate toDate:currentDate options:0];
        
        NSInteger date=[cmps minute];
       //
      //  NSLog(@"cmps.date==%d",date);
        if (date>=3) {
            if ([CMUserDefaults objectForKey:@"name"]&&[PassWordTool readPassWord]&&[CMUserDefaults objectForKey:gestureFinalSaveKey]&&[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey]!=nil) {
                CMLoginGestureController *gestureVc = [[CMLoginGestureController alloc] init];
                //[gestureVc setType:GestureViewControllerTypeLogin];
                [self.window.rootViewController presentViewController:gestureVc animated:YES completion:nil];
                
            }
            
            
        }
    }

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
 
   
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    DLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    [CMVenderConfiguration registerDeviceToken:deviceToken];
}

// 接收到远程推送通知调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
     DLog(@"didReceiveRemoteNotification");
 
    [CMVenderConfiguration handleRemoteNotification:userinfo completion:nil];
 
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
     DLog(@"didReceiveRemoteNotification fetchCompletionHandler");
    //DLog(@"didReceiveRemoteNotificationuseinfo==%@",userInfo);
    if (application.applicationState == UIApplicationStateActive) {
        
        NSDictionary *aps=[userInfo objectForKey:@"aps"];
        NSString *message=[aps objectForKey:@"alert"];
        NSString *urlStr = [userInfo valueForKey:@"ext"];
        NSString *str=[NSString currentDateFormatter:@"yyyy/MM/dd HH:mm:ss"];
        
        self.userDict=userInfo;
        // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
        //if([CMRequestManager islogin]){
        NSString *page=[NSString dictionaryToJson:userInfo];
        [tab.tabBar showBadgeOnItemIndex:3];
        [CMMessageDao insertWithMessage:message andMessageUrl:urlStr andTime:str andIsread:@"1" andPage:page];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"忽略"
                                              otherButtonTitles:@"查看", nil];
     //  alert.tag=101;
        [alert show];
        
        
    }else{
       
        static BOOL isOk;
        if (isOk==NO) {
            NSDictionary *aps=[userInfo objectForKey:@"aps"];
            NSString *message=[aps objectForKey:@"alert"];
            NSString *urlStr = [userInfo valueForKey:@"ext"];
            NSString *str=[NSString currentDateFormatter:@"yyyy/MM/dd HH:mm:ss"];
            self.userDict=userInfo;
            NSString *page=[NSString dictionaryToJson:userInfo];
            [tab.tabBar showBadgeOnItemIndex:3];
            [CMMessageDao insertWithMessage:message andMessageUrl:urlStr andTime:str andIsread:@"1" andPage:page];
            
            self.isAppIconLaunching=NO;
            
      }else{
            CMTabBarController  *mainTab=(CMTabBarController*)self.window.rootViewController;
            CMNavigationController * nav = (CMNavigationController *)mainTab.selectedViewController;
            UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
            [CMPushHandle PushMessageWithDict:userInfo withController:baseVC];
            self.userDict=userInfo;
            self.isAppIconLaunching=YES;
        }
        isOk =!isOk;
 
    }
    
 [CMVenderConfiguration handleRemoteNotification:userInfo completion:completionHandler];
  
    
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
   // DLog(@"applicationDidBecomeActive");

    if (self.isAppIconLaunching==NO) {
        if (self.userDict.allKeys!=0) {
            CMTabBarController  *mainTab=(CMTabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
            CMNavigationController * nav = (CMNavigationController *)mainTab.selectedViewController;
            UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
            [CMPushHandle PushMessageWithDict:self.userDict withController:baseVC];
             self.isAppIconLaunching=YES;
        }
        
        

     }
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
 
    
    if (buttonIndex==1) {
   
        CMTabBarController  *mainTab=(CMTabBarController*)self.window.rootViewController;
        CMNavigationController * nav = (CMNavigationController *)mainTab.selectedViewController;
        UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
        [CMPushHandle PushMessageWithDict:self.userDict withController:baseVC];
    
    }


}
#pragma mark - 取出用户名密码自动登陆
- (void)loginAuto
{
    // 取出账号、密码
   
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    NSString *password =[PassWordTool readPassWord];
    if (name&&password) {
    
       NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
       //   NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            // DLog(@"loginAutoLogingChenggong----- %@",responseObj);
            
            NSString *strStatus = [responseObj valueForKey:@"status"];
            NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
            
            [CMUserDefaults objectForKey:@"userID"];
            [CMUserDefaults synchronize];
            if ([strStatus isEqualToString:@"200"]) {
                [CMCookie getAndSaveCookie];
                [CMRequestHandle GetAccountMsgWithHYID:userID andSuccess:^(id responseObj) {
                    NSString *statusStr = [responseObj valueForKey:@"status"];
                    
                    if ([statusStr isEqualToString:@"200"]) {
                        
                        
                        NSString *userStr = name;
                        NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
                        NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
                        NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
                        NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
                        NSString *diongjie=[[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount_dj"] objectAtIndex:0];
                        NSDictionary *infoSign = @{@"userID":userID,
                                                   @"user":userStr,
                                                   @"jinrishouyi":jinriStr,
                                                   @"leijishouyi":leijiStr,
                                                   @"zhanghuyue":yueStr,
                                                   @"zongzichan":zongStr,
                                                   @"dongjie":diongjie
                                                   };
                        
                        [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
                        [CMUserDefaults synchronize];
                        [CMNSNotice postNotificationName:@"MesToAccount" object:self userInfo:infoSign]; // 发送通知 —— 账户
            
                    }
                }];
                
            }
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [PassWordTool deletePassWord];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                
            } failure:^(NSError *error) {
                DLog(@"exitLoginAcconntError--%@",error);
            }];
            
        }];
        
    }
}



@end
