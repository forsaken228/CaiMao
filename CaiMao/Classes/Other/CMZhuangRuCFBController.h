//
//  CMZhuangRuCFBController.h
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFBZhuangFootView.h"
#import "CMCFBZhuangRuOneCell.h"
#import "CMCFBZhuangRuTwoCell.h"
#import "CMCFBZhuangRuAlertView.h"
#import "CMZhuanRuConfirmAlert.h"
@interface CMZhuangRuCFBController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CMZhuanRuConfirmAlertDelegate>
@property(nonatomic,assign) BOOL isFromHome;
@property(nonatomic,copy)NSString *productCount;
@end
