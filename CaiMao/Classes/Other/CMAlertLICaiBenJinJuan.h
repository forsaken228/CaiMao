//
//  CMAlertLICaiBenJinJuan.h
//  CaiMao
//
//  Created by MAC on 16/8/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAlertLICaiBenJinJuan : UIView<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
   
    UITapGestureRecognizer *tap;
    UITableView *tTable;
    
}
@property(nonatomic,strong)NSArray *dataSourceArray;
-(id)initWithLiCaibenJinJuandata:(NSArray*)Data;

-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;

@end

@protocol CMAlertLICaiBenJinJuanDelegate <NSObject>

-(void)alertViewShowTiXianWithRow:(NSInteger)aRow;

-(void)tapDimissAlertView;
@end