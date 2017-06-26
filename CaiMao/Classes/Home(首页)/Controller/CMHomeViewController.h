//
//  CMHomeViewController.h
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FFScrollView.h"
#import "CMInviteFreindViewController.h"
#import "CMHomeDingQiView.h"
#import "CMHomeNewActionView.h"
#import "CMQQMailViewController.h"
#import "CMHomeBottomView.h"

@interface CMHomeViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
/*******************用户真实姓名**************************/
@property(nonatomic,copy)NSString *UserRealName;
/*******************认证银行卡数组**************************/
@property(nonatomic,strong)NSArray *NewBankArr;

@end
