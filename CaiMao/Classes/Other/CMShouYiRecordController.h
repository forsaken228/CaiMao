//
//  CMShouYiRecordController.h
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMShouYiRecordController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *MyTableView;
@property(nonatomic,strong)NSArray *PlandataArr;
@property(nonatomic,copy)NSString *JXDate;
@property(nonatomic,strong)NSString *pid;
@end
