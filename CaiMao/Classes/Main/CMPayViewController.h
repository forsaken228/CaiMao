//
//  CMPayViewController.h
//  CaiMao
//
//  Created by MAC on 16/6/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMDingQiBaoList.h"
#import "CMRequestManager.h"
#import "CMAlertRegitView.h"
@interface CMPayViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)NSDictionary *ProuctListArr;
@property(nonatomic,copy)NSString *phoneNum;
@property(nonatomic,copy)NSString *yuer;

@property(nonatomic,strong)NSArray *NewArr;
@property(nonatomic,strong)NSArray *NewBankArr;


@property(nonatomic,copy)NSString *userDetaiName;
@property(nonatomic,copy)NSString *userID;
@property(nonatomic,assign)int  productFenE;
@property(nonatomic,assign)int countNum;

@property(nonatomic,copy)NSString *CPLB;
//@property(nonatomic,copy)NSString *JPFS;

@end
