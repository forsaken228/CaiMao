//
//  UIViewController+CMHubView.h
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CMHubView)
/**
 *  显示默认加载框
 */
- (void)showDefaultProgressHUD;

/**
 *  隐藏最新加入的加载框
 */
- (void)hiddenProgressHUD;


-(void)LoadHudWithMessage:(NSString*)Message;





@end
