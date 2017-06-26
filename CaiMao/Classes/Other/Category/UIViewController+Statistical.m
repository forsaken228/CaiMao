//
//  UIViewController+Statistical.m
//  CaiMao
//
//  Created by WangWei on 2017/6/2.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "UIViewController+Statistical.h"
#import <sys/utsname.h>
#import <objc/runtime.h>
@implementation UIViewController (Statistical)
+ (void)load {
   
    //交换方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        //webViewDidFinishLoad:
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(statisticalPage_viewDidAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
                BOOL didAddMethod =
                class_addMethod(class,
                                originalSelector,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
        
                if (didAddMethod) {
                    class_replaceMethod(class,
                                        swizzledSelector,
                                        method_getImplementation(originalMethod),
                                        method_getTypeEncoding(originalMethod));
                } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
         }
        
        
      
        
        
        
        
    });
    
    
 
    
    
    
    
    
}


-(void)statisticalPage:(NSString *)ActionInfo{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *UserId=@"0"; //用户会员ID
        if ([CMRequestManager islogin]) {
            UserId=[CMUserDefaults objectForKey:@"userID"];
            if (UserId ==nil ) {
                UserId=@"0";
            }
            
        }else{
            UserId=@"0";
        }
        NSString *EquipmentNum = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; //手机标示
        NSString *MobileType = [self iphoneType];//手机类型
        
        NSString *Platform=@"IOS"; //手机类型
        
        
        NSString *AccessPath=ActionInfo;
        if (AccessPath==nil ||[AccessPath isKindOfClass:[NSNull class]] || AccessPath == NULL||AccessPath.length==0) {
            AccessPath=@"首页";
        }
        
        // 获取当前日期
        
        NSDate *date=  [NSDate date];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *AccessDate = [formatter stringFromDate:date];
        
        NSString *Province=@"";
        NSString *City=@"";
        NSString *Area=@"";
        NSString *Address=@"";
        //纬度
        NSString *Latitude=@"";
        //经度
        NSString *Longitude=@"";
    
        if(![[CMUserDefaults objectForKey:@"AddressMsg"] isKindOfClass:[NSNull class]] &&[CMUserDefaults objectForKey:@"AddressMsg"]!=nil){
            NSDictionary *msgDict=(NSDictionary*)[CMUserDefaults objectForKey:@"AddressMsg"];
            //省
            if ([msgDict objectForKey:@"Province"]!=nil) {
                Province=[msgDict objectForKey:@"Province"];
            }else{
                Province=@"";
            }
            if ([msgDict objectForKey:@"City"]!=nil) {
                //市
                City=[msgDict objectForKey:@"City"];
            }else{
                
                City=@"";
            }
            
            //区
            if ([msgDict objectForKey:@"Area"]!=nil) {
                 Area=[msgDict objectForKey:@"Area"];
            }else{
                Area=@"";
            }
         
            //地址
            if([msgDict objectForKey:@"DetailAddress"]!=nil){
            Address=[msgDict objectForKey:@"DetailAddress"];
            }else{
                Address=@"";
            }
            if ([msgDict objectForKey:@"Latitude"]!=nil) {
                  Latitude=[msgDict objectForKey:@"Latitude"];
            }else{
               Latitude=@"";
            }
          
            if ([msgDict objectForKey:@"Longitude"]) {
                Longitude=[msgDict objectForKey:@"Longitude"];
            }else{
                Longitude=@"";
            }
           
        }else{
            //省
           Province=@"";
            //市
            City=@"";
            //区
            Area=@"";
            //地址
            Address=@"";
            
            Latitude=@"";
            
            Longitude=@"";
        }
        
        NSString *urlStr=[NSString stringWithFormat:@"%@/data/access/add",StaticCode];//@"http://192.168.1.225:7001"
        NSString *keyJson=[NSString stringWithFormat:@"UserId:%@,EquipmentNum:%@,MobileType:%@,Platform:%@,AccessPath:%@,AccessDate:%@,Province:%@,City:%@,Area:%@,Address:%@,Longitude:%@,Latitude:%@,Key:%@",UserId,EquipmentNum,MobileType,Platform,AccessPath,AccessDate,Province,City,Area,Address,Longitude,Latitude,@"agLA7wt26lxJeZQp"];
        
        NSString *MD5Str=[NSString md5:keyJson];
        NSDictionary *AccessInfo=@{
                                   @"AccountName":@"CMIOSApp",
                                   @"AccessInfo":@{
                                           @"UserId": UserId,
                                           @"EquipmentNum": EquipmentNum,
                                           @"MobileType":MobileType,
                                           @"Platform": Platform,
                                           @"AccessPath": AccessPath,
                                           @"AccessDate": AccessDate,
                                           @"Province": Province,
                                           @"City": City,
                                           @"Area": Area,
                                           @"Address":Address,
                                           @"Longitude":Longitude,
                                           @"Latitude":Latitude
                                           },
                                   @"Md5":MD5Str
                                   };
        
     //   DLog(@"++++%@___",AccessInfo);
        [CMHttpTool postWithURL:urlStr params:AccessInfo success:^(id responseObj) {
            
            
     
        // DLog(@"+++%@++%@",responseObj,[responseObj objectForKey:@"message"]);
            
        } failure:^(NSError *error) {
            DLog(@"error+++%@",error);
        }];
        
        
        

     
      
        
    });
      
     
       }

- (NSString *)iphoneType {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}

- (void)statisticalPage_viewDidAppear:(BOOL)animated {
 [self statisticalPage_viewDidAppear:animated];
 

    const char *className = object_getClassName(self);
   // DLog(@"++++%@",[self class]);
        if(![[NSString stringWithUTF8String:className] isEqualToString:@"CMProductDetailController"]){
            
            if (![[NSString stringWithUTF8String:className] isEqualToString:@"CMLiCaiDetailController"]&&![[NSString stringWithUTF8String:className] isEqualToString:@"CMPayViewController"]&&![[NSString stringWithUTF8String:className] isEqualToString:@"CMOnLinePayViewController"]&&![[NSString stringWithUTF8String:className] isEqualToString:@"CMOnlinePaySuccessController"]&&![[NSString stringWithUTF8String:className] isEqualToString:@"CMNavigationController"]
                &&![[NSString stringWithUTF8String:className] isEqualToString:@"UIInputWindowController"]
                &&![[NSString stringWithUTF8String:className] isEqualToString:@"UICompatibilityInputViewController"]) {
                
                if ([[NSString stringWithUTF8String:className] isEqualToString:@"CMTabBarController"]) {
                    [self statisticalPage:@"启动APP"];
                    return;
                }

                
                if ([[NSString stringWithUTF8String:className] isEqualToString:@"LLWalletNavController"]||[[NSString stringWithUTF8String:className] isEqualToString:@"LLPayFirstViewController"]) {
                     [self statisticalPage:@"认证支付"];
                    return;
                }
                [self statisticalPage:self.title];
                
               
                
            }
            
            
        }else{
            
            
      
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                Class class = [self class];
                SEL originalSelector = @selector(webViewDidFinishLoad:);
                SEL swizzledSelector = @selector(statisticalPage_webViewDidFinishLoad:);
                
                Method originalMethod = class_getInstanceMethod(class, originalSelector);
                Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
                
                BOOL didAddMethod =
                class_addMethod(class,
                                originalSelector,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
                
                if (didAddMethod) {
                    class_replaceMethod(class,
                                        swizzledSelector,
                                        method_getImplementation(originalMethod),
                                        method_getTypeEncoding(originalMethod));
                } else {
                    method_exchangeImplementations(originalMethod, swizzledMethod);
                }
            });
          
            
            
            
        }
    

}



-(void)statisticalPage_webViewDidFinishLoad:(UIWebView*)webView {
    [self statisticalPage_webViewDidFinishLoad:webView];
    
    
    [self statisticalPage:self.title];
}

@end
