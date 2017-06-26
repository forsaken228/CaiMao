//
//  CMBankList.h
//  CaiMao
//
//  Created by MAC on 16/6/16.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBankList : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *BankNameArray;
@property(nonatomic,strong)NSMutableArray *BankLimitArray;
@property(nonatomic,strong)NSMutableArray *BankIconArray;
@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,assign)id delegate;
-(id)initCreateBankListArry:(NSArray*)bankArry;
-(void)show;

@end
@protocol CMBankAlertViewDelegate <NSObject>

-(void)buttonClick;

@end