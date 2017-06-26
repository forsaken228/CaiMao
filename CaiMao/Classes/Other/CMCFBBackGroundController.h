//
//  CMCFBBackGroundController.h
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCfbTopView.h"
#import "CMRecordBgView.h"
#import "CMCFBAlert.h"
#import "CMBottomXuanFu.h"
#import "CMYuErMingXiCell.h"
#import "CMZhuanRuRecordCell.h"
#import "CMZhuanChuCell.h"
@interface CMCFBBackGroundController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,copy)NSMutableArray *YuErMingXiArr;
@property(nonatomic,copy)NSMutableArray *ZhuanRuArr;
@property(nonatomic,copy)NSMutableArray *ZhuanChuArr;


@end
