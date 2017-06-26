//
//  CMProductIncomeController.h
//  CaiMao
//
//  Created by MAC on 16/10/28.
//  Copyright © 2016年 58cm. All rights reserved.
//收益详情

#import <UIKit/UIKit.h>
#import "CMProductIncomeHead.h"
#import "CMShouYiPlanCell.h"
#import "CMProductIncomeFoot.h"
@interface CMProductIncomeController : UITableViewController
@property(nonatomic,copy)NSString *ProductID;
@property(nonatomic,assign)int  pageIndex;
@property(nonatomic,strong)NSMutableArray *shouYiArr;
@property(nonatomic,strong)NSMutableArray *TotalArr;
@end
