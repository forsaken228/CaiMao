//
//  ChangeBank.h
//  TestAlertView
//
//  Created by MAC on 16/6/20.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeBank : UIView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,copy)NSMutableArray *dataSourceArray;
-(id)initWithHistoryBankListWithBankList:(NSMutableArray*)arr;

-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)UITableView *myTableView;
@end
@protocol changeBankDelegate <NSObject>

-(void)alertViewShowWithSection:(NSInteger)section andRow:(NSInteger)aRow;

@end
