//
//  CMCommon.h
//  CaiMao
//
//  Created by Fengpj on 16/1/20.
//  Copyright © 2016年 58cm. All rights reserved.
//

#ifndef CMCommon_h
#define CMCommon_h

//选择targe
/*
#ifdef ISTest
//target2的处理代码
 // #define OnLineCode @"192.168.1.49:8889"
#define OnLineCode @"http://192.168.1.225:8889"
#define redpackageCode @"http://test_qtpay.58cm.com"
#define SmsLine @"http://api.yx.ihuyi.com"
#define DLog(...) NSLog(__VA_ARGS__)

#define  NSLog(format, ...) printf("[%s] %s %s\n", __TIME__, __FUNCTION__,[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else
*/
#ifdef DEBUG

#define DLog(...) NSLog(__VA_ARGS__)
#define  NSLog(format, ...) printf("[%s] %s %s\n", __TIME__, __FUNCTION__,[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else

#define DLog(...)
#define NSLog(format, ...)
#endif

#define OnLineCode @"https://m.58cm.com"  //线上正式

#define HttpCode @"http://m.58cm.com"  //线上正式

#define  StaticCode @"http://fangkeapi.58cm.com" //@"http://192.168.1.225:7001"
// #define OnLineCode @"http://192.168.1.225:7001" //本地测试
 //#define OnLineCode @"http://192.168.1.19:8889"
 // #define OnLineCode @"http://m_test.58cm.com" //线上测试

#define redpackageCode @"https://app.58cm.com"
#define SmsLine @"http://api.yx.ihuyi.com"
#define Miao18Action @"http://m.58cm.com/Partners/18new.aspx";
//#endif
//// 自定义Log
//#ifdef DEBUG
//#define DLog(...) NSLog(__VA_ARGS__)
//#else
//#define DLog(...)
//#endif   114.55.116.90
//rgb颜色转换（16进制->10进制）

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获得RGB颜色
#define CMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//屏幕尺寸
#define CMScreenW [UIScreen mainScreen].bounds.size.width
#define CMScreenH [UIScreen mainScreen].bounds.size.height
//#define IPCode @"192.168.1.225:8889"
//#define OnLineCode @"m.58cm.com"

#define CMOrderHandle [CMOrderManager sharedCMOrderManager]

#define CMAlert(msg) UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];\

//按钮颜色
#define RedButtonColor UIColorFromRGB(0xfb3c19)

//视图背景色
#define ViewBackColor UIColorFromRGB(0xEFEFF4)
//产品按钮高度
#define buttonHeight  35
//分隔线颜色
#define separateLineColor UIColorFromRGB(0xe6e6e6)

#define YuQiShouYi @"年收益"

#define f_i5real(f)         (((int)((CMScreenW * ((f)/320.f))*2))/2.f)

//商户号
#define OidPartner @"201501191000180503"
#define PartnerKey @"201501191000180503qtmll_20151125"

//CMRequestHandle单列请求
#define CMRequestHandle [CMRequestManager sharedCMRequestManager]

//本地储存
#define CMUserDefaults [NSUserDefaults standardUserDefaults]
//监听中心
#define CMNSNotice [NSNotificationCenter defaultCenter]
//push
#define CMPush(vc) [self.navigationController pushViewController:vc animated:YES];

#define IOS9_LATER ([[UIDevice currentDevice] systemVersion].floatValue > 9.0 ? YES : NO )
//判断网络
#define checkNet \
- (BOOL)checkNetWork { \
        if ([CMHttpTool cheackNet]){ \
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
        hud.mode = MBProgressHUDModeText;\
        hud.labelText = @"无法连接到网络！";\
        hud.margin = 10.f;\
        hud.removeFromSuperViewOnHide = YES;\
        [hud hide:YES afterDelay:3];\
        return NO;\
    }else{\
    return YES;}\
}
#define CMTiShi(Msg) CMSmsCodeAlert *smsAlert=[[CMSmsCodeAlert alloc]initCMSmsCodeAlertWithTitle:Msg];\
[smsAlert ShowAlert];\

//解决内存警告
#define ReceiveMemoryWarning   -(void)didReceiveMemoryWarning {  \
                       [super didReceiveMemoryWarning];\
                    if (self.isViewLoaded && !self.view.window){\
                      self.view = nil;  }\
                        }\


#endif
