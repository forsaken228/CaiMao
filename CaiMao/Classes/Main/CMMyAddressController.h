//
//  CMMyAddressController.h
//  CaiMao
//
//  Created by MAC on 16/9/7.
//  Copyright © 2016年 58cm. All rights reserved.
//  我的地址

#import <UIKit/UIKit.h>

@interface CMMyAddressController : UITableViewController<UITextViewDelegate,UITextFieldDelegate>
//@property(nonatomic,copy)NSString *userID;

@property(nonatomic,strong)NSArray *UserBankListArr;
@end
