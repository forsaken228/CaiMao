//
//  CMDealrecordController.h
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMDealRecordHead.h"
@interface CMDealrecordController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *MyTableView;
@property(nonatomic,assign)int page;
@property(nonatomic,copy)NSString *pid;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int fenEr;
@end
