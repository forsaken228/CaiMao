//
//  CMMyMBinController.h
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//  我的M币

#import <UIKit/UIKit.h>
#import "CMMBin.h"
#import "CMRecordBgView.h"
#import "CMMBinCell.h"
@interface CMMyMBinController : UITableViewController
@property(nonatomic,strong)NSMutableArray *MyMBArr;
@property(nonatomic,assign)int pageIndex;
@end
