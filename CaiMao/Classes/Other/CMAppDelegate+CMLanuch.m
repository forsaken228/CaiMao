//
//  CMAppDelegate+CMLanuch.m
//  CaiMao
//
//  Created by WangWei on 16/12/19.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAppDelegate+CMLanuch.h"
#import "CMLaunchAD.h"

@implementation CMAppDelegate (CMLanuch)

-(void)setUpLaunchAd{
    
    [CMLaunchAD showWithWindow:self.window
                     countTime:5
         showCountTimeOfButton:YES
                showSkipButton:YES
                isFullScreenAD:NO
                localAdImgName:@"LanuchAdImage"
                      imageURL:nil
                    canClickAD:YES
                       aDBlock:^(BOOL clickAD) {  
                           if (clickAD) {
                               [CMNSNotice  postNotificationName:@"clickAD" object:self];
                           } 
                       }];

    
}

@end
