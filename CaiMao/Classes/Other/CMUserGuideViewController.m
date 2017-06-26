//
//  CMUserGuideViewController.m
//  CaiMao
//
//  Created by MAC on 16/11/18.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMUserGuideViewController.h"

@implementation CMUserGuideViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"引导页";
    NSArray *array = @[@"引导页-24", @"引导页-25", @"引导页-26"];
    //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
    CMGuideView *GuideView = [[CMGuideView alloc] init:array];
    GuideView.delegate=self;
    [self.view addSubview:GuideView];
    
}

-(void)enterAppMainControllerWithIndex:(NSInteger)Index{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[CMTabBarController alloc] init];

    if (Index==10) {
     
   // [CMNSNotice postNotificationName:@"isfirstLauce" object:self];
        
        [CMUserDefaults setObject:@"isfirstLauce" forKey:@"isfirstLauce"];
        [CMUserDefaults synchronize];

    }
   
    
    
}
-(void)dealloc{
    
    [CMNSNotice removeObserver:self];
}
@end
