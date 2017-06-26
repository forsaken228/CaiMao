//
//  CMTiXianViewController.h
//  CaiMao
//
//  Created by MAC on 16/6/23.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTiXianViewController : UIViewController

@property(nonatomic,strong)NSArray *userArray;
//@property(nonatomic,strong)NSArray *userBankArr;
//余额
//@property(nonatomic,copy)NSString *MoneyOut;
//传的额度
//@property(nonatomic,copy)NSString *passVaule;

//@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,copy)NSString *selectAddressID;

@property(nonatomic,copy)NSString *BankNameOne;

@property(nonatomic,strong)NSArray *TiXianArr;

//@property(nonatomic,strong)NSDictionary *userBankDict;

//银行卡编号
@property(nonatomic,copy)NSString *Bank_code;
@property(nonatomic,copy)NSString *vipMsg;

@property(nonatomic,assign)BOOL isFromTiXian;
@property(nonatomic,assign)NSInteger bankIndex;
@end
