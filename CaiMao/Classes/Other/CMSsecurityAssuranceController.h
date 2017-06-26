//
//  CMSsecurityAssuranceController.h
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMSafeGuardHead.h"
@interface CMSsecurityAssuranceController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSDictionary *pListDict;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *detailArr;
@property(nonatomic,strong)NSMutableDictionary  *dataDict;
@end
