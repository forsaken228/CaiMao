//
//  CMTiXianJuan.h
//  CaiMao
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTiXianJuan : UIView<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray *dataSourceArray;
-(id)initWithTiXianJuanList:(NSMutableArray*)arr;

-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;
@end
@protocol tTiXianJuanDelegate <NSObject>

-(void)alertViewShowTiXianWithRow:(NSInteger)aRow;


@end