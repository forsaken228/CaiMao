//
//  CMProgressHud.m
//  CaiMao
//
//  Created by MAC on 16/9/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMProgressHud.h"

@implementation CMProgressHud
+ (CMProgressHud *)sharedCMProgressHud {
    static CMProgressHud *_sharedRequestAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRequestAPI = [[CMProgressHud alloc] init];
    });
    return _sharedRequestAPI;
}

-(void)loadData:(UIView*)showView completion:(void (^)(void))success{
    
    
    
    //有名字和密码自动登录
    MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:showView];
    HUD.color=ViewBackColor;
    HUD.alpha=0.5;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown_01"]];
    HUD.customView=imageView;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"努力加载中...";
    HUD.labelFont=[UIFont systemFontOfSize:13.0];
    HUD.labelColor=[UIColor lightGrayColor];
    [showView addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        NSMutableArray *idleImages = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 1; i<=3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%d", i]];
            [idleImages addObject:image];}
        //设置动画数组
        [imageView setAnimationImages:idleImages];
        //设置动画播放次数
        //[imageView setAnimationRepeatCount:1];
        //设置动画播放时间
        [imageView setAnimationDuration:idleImages.count*0.1];
        //开始动画
        [imageView startAnimating];
        sleep(1);
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        success();
        
    }];

}

-(void)LoadProgress:(UIView*)showView WithMessage:(NSString *)message{
    
   dispatch_async(dispatch_get_main_queue(), ^{
   self.ProgressHUD = [[MBProgressHUD alloc] initWithView:showView];
     self.ProgressHUD.color=ViewBackColor;
     self.ProgressHUD.alpha=0.5;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown_01"]];
     self.ProgressHUD.customView=imageView;
     self.ProgressHUD.mode = MBProgressHUDModeCustomView;
     self.ProgressHUD.labelText = message;
     self.ProgressHUD.labelFont=[UIFont systemFontOfSize:13.0];
     self.ProgressHUD.labelColor=[UIColor lightGrayColor];
    [showView addSubview: self.ProgressHUD];
    [ self.ProgressHUD showAnimated:YES whileExecutingBlock:^{
        NSMutableArray *idleImages = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 1; i<=3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%d", i]];
            [idleImages addObject:image];}
        //设置动画数组
        [imageView setAnimationImages:idleImages];
        //设置动画播放次数
        //[imageView setAnimationRepeatCount:1];
        //设置动画播放时间
        [imageView setAnimationDuration:idleImages.count*0.1];
        //开始动画
        [imageView startAnimating];
      sleep(1);

    }];
      
       });
   
    
}
-(void)removeProgressHUD{
    [ self.ProgressHUD removeFromSuperview];
    
}

@end
