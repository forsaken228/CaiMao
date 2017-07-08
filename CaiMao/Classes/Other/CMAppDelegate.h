//
//  CMAppDelegate.h
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAppDelegate : UIResponder <UIAlertViewDelegate,UIApplicationDelegate>
//{
//    CMTabBarController *tab;
//
//}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSDictionary *userDict;
@property (assign, nonatomic) BOOL isAppIconLaunching;
@property (strong, nonatomic) CMTabBarController *tab;
@end
