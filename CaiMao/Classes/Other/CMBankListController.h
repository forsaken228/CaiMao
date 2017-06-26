//
//  CMBankListController.h
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMMyBankListCell.h"
@interface CMBankListController : UITableViewController
@property(nonatomic,copy)NSArray *bankListArr;
@property(nonatomic,copy)NSArray *dataList;
@property(nonatomic,copy)NSMutableDictionary *bankStateDict;
@property(nonatomic,assign)BOOL NotSetIdeal;
@end
