//
//  UIViewController+CMHubView.m
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "UIViewController+CMHubView.h"


@implementation UIViewController (CMHubView)
// 显示默认加载框
- (void)showDefaultProgressHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = nil;
}

// 隐藏最新加入的加载框
- (void)hiddenProgressHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)LoadHudWithMessage:(NSString*)Message{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = Message;
}



@end
