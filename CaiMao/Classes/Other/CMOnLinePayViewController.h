//
//  CMOnLinePayViewController.h
//  CaiMao
//
//  Created by MAC on 16/8/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMOrderCreat.h"
@interface CMOnLinePayViewController : UIViewController
//@property(nonatomic,copy)NSString *userID;
@property(nonatomic,copy)NSString *userAccountYuEr;
@property(nonatomic,copy)NSString *userPhoneNum;

@property(nonatomic,copy)NSString * UseBankNumber;
@property(nonatomic,copy)NSString * UseCardId;

@property(nonatomic,assign)int payMoney;


@property(nonatomic,strong)NSArray *bankArr;

@property(nonatomic,strong)NSArray *bankListArray;


@property(nonatomic,strong)NSDictionary *orderDict;
@property(nonatomic,strong)NSDictionary *orderPayDict;
@property(nonatomic,assign)float Yuer;
@property(nonatomic,copy)NSString*bankCode;

@property(nonatomic,copy)NSString *bankPayMoney;

@property(nonatomic,strong)NSDictionary *MBArr;
@property(nonatomic,strong)NSArray *liCaiArr;
@property(nonatomic,copy)NSString *BenJinJuanID;

@property(nonatomic,assign)int productFenEr;
@property(nonatomic,copy)NSString *resultMsg;

//@property(nonatomic,strong) NSDictionary *ProuctListArr;
@property(nonatomic,assign)BOOL isSuxincun;


@property(nonatomic,copy) NSString *prTitle;
@end
