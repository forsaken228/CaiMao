//
//  CMPushHandle.m
//  CaiMao
//
//  Created by WangWei on 16/11/19.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMPushHandle.h"

@implementation CMPushHandle
+(void)PushMessageWithDict:(NSDictionary*)dict withController:(UIViewController*)controlller{
    
    NSString *page=[dict objectForKey:@"page"];
    NSString *urlStr = [dict objectForKey:@"ext"];
    NSString *product=[dict  objectForKey:@"product"];
    
    //    if(product==nil||[product isEqual:[NSNull null]]){
    //
    //        NSLog(@"执行");
    //        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    //        if (urlStr) {
    //
    //            proVc.urlStr = urlStr;
    //
    //            [self.navigationController pushViewController:proVc animated:NO];
    //        }
    //
    //
    //    }else{
    //
        if(product==nil&&urlStr==nil&&page==nil){
            
                 return;
          
           
    
        }
    
    if (page==nil||[page isEqual:[NSNull null]]) {
        
    
    if([product intValue]==0){
        NSLog(@"执行1");
        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        if (urlStr) {
            
            proVc.urlStr = urlStr;
            
           
        }
         [controlller.navigationController pushViewController:proVc animated:NO];
    }
    else if ([product intValue]==1){
        
        
        //如果是当前控制器是我的消息控制器的话，刷新数据即可
        if([controlller isKindOfClass:[CMHomeViewController class]])
        {
            
            return;
        }
        // 否
         CMTabBarController  *mainTab=(CMTabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [mainTab selectTap:0];
        
        
        
    }
    
    else if ([product intValue]==2){
        
        
        //如果是当前控制器是我的消息控制器的话，刷新数据即可
        if([controlller isKindOfClass:[CMDingQiDetailController class]])
        {
        
            return;
        }
        // 否
        CMDingQiDetailController *proVc = [[CMDingQiDetailController alloc] init];
       [controlller.navigationController pushViewController:proVc animated:NO];
        
        
        
    }
    else if ([product intValue]==3){
        if([controlller isKindOfClass:[CMJuHaiLiController class]])
        {
            
            return;
        }
        
        CMJuHaiLiController *proVc = [[CMJuHaiLiController alloc] init];
        
        [controlller.navigationController pushViewController:proVc animated:NO];
        
        
        
    }else if ([product intValue]==4){
        if([controlller isKindOfClass:[CMMiaoShaController class]])
        {
            
            return;
        }
        CMMiaoShaController *proVc = [[CMMiaoShaController alloc] init];
         [controlller.navigationController pushViewController:proVc animated:NO];
        
        
    }else if ([product intValue]==5){
        if([controlller isKindOfClass:[CMYueXiYingDetailController class]])
        {
            
            return;
        }
        CMYueXiYingDetailController *proVc = [[CMYueXiYingDetailController alloc] init];
         [controlller.navigationController pushViewController:proVc animated:NO];
        
        
    }
    else if ([product intValue]==6){
        if([controlller isKindOfClass:[CMXinKeController class]])
        {
            
            return;
        }
        CMXinKeController *proVc = [[CMXinKeController alloc] init];
         [controlller.navigationController pushViewController:proVc animated:NO];
        
    }
    
    
    }else{
    
                
                if([page isEqualToString:@"shouye"]){
                    
                
                    return;
                
                }
                else if ([page isEqualToString:@"dingqibao"]){
                    
                    if([controlller isKindOfClass:[CMDingQiDetailController class]])
                    {
                        
                        return;
                    }
                    CMDingQiDetailController *proVc = [[CMDingQiDetailController alloc] init];
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                    
                    
                }
                else if ([page isEqualToString:@"new"]){
                    
                    if([controlller isKindOfClass:[CMXinKeController class]])
                    {
                        
                        return;
                    }
                    CMXinKeController *proVc = [[CMXinKeController alloc] init];
                    
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                    
                    
                }
                else if ([page isEqualToString:@"juhaili"]){
                    if([controlller isKindOfClass:[CMJuHaiLiController class]])
                    {
                        
                        return;
                    }
                    CMJuHaiLiController *proVc = [[CMJuHaiLiController alloc] init];
                    
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                    
                    
                }else if ([page isEqualToString:@"miaoshahui"]){
                    if([controlller isKindOfClass:[CMMiaoShaController class]])
                    {
                        
                        return;
                    }
                    CMMiaoShaController *proVc = [[CMMiaoShaController alloc] init];
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                    
                }else if ([page isEqualToString:@"yuexiying"]){
                    if([controlller isKindOfClass:[CMYueXiYingDetailController class]])
                    {
                        
                        return;
                    }
                    CMYueXiYingDetailController *proVc = [[CMYueXiYingDetailController alloc] init];
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                    
                }
                else if ([page isEqualToString:@"8888"]){
                    if([controlller isKindOfClass:[CMProductDetailController class]])
                    {
                       
                        
                        return;
                    }
                    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
                    proVc.urlStr = @"http://app.58cm.com/activity/tqbjhd/userpromotion.aspx";
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                }
                else if ([page isEqualToString:@"miaoke18"]){
                    if([controlller isKindOfClass:[CMProductDetailController class]])
                    {
                        
                        
                        return;
                    }
                    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
                    proVc.urlStr = Miao18Action;
                    [controlller.navigationController pushViewController:proVc animated:NO];
                    
                }
                else if ([page isEqualToString:@"shiming"]){
                    if ([CMRequestManager islogin]) {
                        if([controlller isKindOfClass:[CMUserTrueController class]])
                        {
                            
                            
                            return;
                        }
                        CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
                        [controlller.navigationController pushViewController:productVc animated:YES];
                    }
                    else {
                        if([controlller isKindOfClass:[CMLoginController class]])
                        {
                            
                            
                            return;
                        }
                        CMLoginController *loginVc = [[CMLoginController alloc] init];
                        [controlller.navigationController pushViewController:loginVc animated:NO];

                    }
                    
                    
                }

                else if ([page isEqualToString:@"youhuijuan"]){
                    if ([CMRequestManager islogin]) {
                        if([controlller isKindOfClass:[CMMyCouponsController class]])
                        {
                            
                            
                            return;
                        }
                        CMMyCouponsController *productVc = [[CMMyCouponsController alloc] init];
                        [controlller.navigationController pushViewController:productVc animated:YES];
                    } else {
                        if([controlller isKindOfClass:[CMLoginController class]])
                        {
                            
                            
                            return;
                        }
                        CMLoginController *loginVc = [[CMLoginController alloc] init];
                        [controlller.navigationController pushViewController:loginVc animated:NO];
                        
                    }
                    
                    
                }
                else if ([page isEqualToString:@"vip"]){
                   
                    if ([CMRequestManager islogin]) {
                        if([controlller isKindOfClass:[CMVipQIanDaoViewController class]])
                        {
                            
                            
                            return;
                        }
                        CMVipQIanDaoViewController *productVc = [[CMVipQIanDaoViewController alloc] init];
                        [controlller.navigationController pushViewController:productVc animated:YES];
                    } else {
                        if([controlller isKindOfClass:[CMLoginController class]])
                        {
                            
                            
                            return;
                        }
                        CMLoginController *loginVc = [[CMLoginController alloc] init];
                        [controlller.navigationController pushViewController:loginVc animated:NO];
                        
                    }
                    
                    
                    
                }
                else if ([page isEqualToString:@"hold"]){
                    
                    if ([CMRequestManager islogin]) {
                        if([controlller isKindOfClass:[CMDQLController class]])
                        {
                            
                            
                            return;
                        }
                        CMDQLController *productVc = [[CMDQLController alloc] init];
                        [controlller.navigationController pushViewController:productVc animated:YES];
                    } else {
                        if([controlller isKindOfClass:[CMLoginController class]])
                        {
                            
                            
                            return;
                        }
                        CMLoginController *loginVc = [[CMLoginController alloc] init];
                        [controlller.navigationController pushViewController:loginVc animated:NO];
                        
                    }
                    
                    
                    
                }
        
                else if ([page isEqualToString:@"card"]){
                    
                    if ([CMRequestManager islogin]) {
                        if([controlller isKindOfClass:[CMBankListController class]])
                        {
                            
                            
                            return;
                        }
                        CMBankListController *productVc = [[CMBankListController alloc] init];
                        [controlller.navigationController pushViewController:productVc animated:YES];
                    } else {
                        if([controlller isKindOfClass:[CMLoginController class]])
                        {
                            return;
                        }
                        CMLoginController *loginVc = [[CMLoginController alloc] init];
                        [controlller.navigationController pushViewController:loginVc animated:NO];
                        
                    }
                    
                    
                    
                }
        
                else if ([page isEqualToString:@"income"]){
                    
                    if ([CMRequestManager islogin]) {
                        if([controlller isKindOfClass:[CMBankListController class]])
                        {
                            
                            
                            return;
                        }
                        CMDQLController *productVc = [[CMDQLController alloc] init];
                        [controlller.navigationController pushViewController:productVc animated:YES];
                    } else {
                        if([controlller isKindOfClass:[CMLoginController class]])
                        {
                            return;
                        }
                        CMLoginController *loginVc = [[CMLoginController alloc] init];
                        [controlller.navigationController pushViewController:loginVc animated:NO];
                        
                    }
                    
                    
                    
                }
                
    
    }
    
}
@end
