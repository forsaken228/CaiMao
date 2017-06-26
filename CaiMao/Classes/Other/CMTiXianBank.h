//
//  CMTiXianBank.h
//  CaiMao
//
//  Created by MAC on 16/6/28.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTiXianBank : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>


@property(nonatomic,strong)NSMutableArray *dataSourceArray;
-(id)initWithBankList:(NSMutableArray*)arr;

-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;
@end
@protocol tBankListDelegate <NSObject>

-(void)alertViewShowWithRow:(NSInteger)aRow;

-(void)tapDimissView;

@end