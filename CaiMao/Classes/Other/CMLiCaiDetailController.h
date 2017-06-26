//
//  CMLiCaiDetailController.h
//  CaiMao
//
//  Created by MAC on 16/8/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMProductBottomview.h"
@interface CMLiCaiDetailController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)NSDictionary *productListArr;
@property(nonatomic,strong)UITableView *myTabelView;

@property(nonatomic,assign)int productFenEr;
//@property(nonatomic,copy)NSString *active;
@property(nonatomic,copy)NSString *CPLB;
@property(nonatomic,copy)NSString *recordTotalNum;
@property(nonatomic,assign)BOOL isZao;
@property(nonatomic,assign)BOOL isMiaosha;
@end
