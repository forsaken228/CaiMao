//
//  CMOnlinePaySuccessController.h
//  CaiMao
//
//  Created by MAC on 16/8/3.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CMOnLinePayViewController.h"
typedef enum{
    isProductPaySuccess = 1,
    isChongZhiPaySuccess,
    isSuiXinCunSuccess
    
}CMOnlinePaySuccessType;
@interface CMOnlinePaySuccessController : UIViewController
@property (nonatomic, assign) CMOnlinePaySuccessType type;
//@property(nonatomic,strong) NSDictionary *ProuctListArr;
@property(nonatomic,copy) NSString *juHili;

@property(nonatomic,copy)  NSString *pid;

@property(nonatomic,copy)NSString *prTitle;
@end
