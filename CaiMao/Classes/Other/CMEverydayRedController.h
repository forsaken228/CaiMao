//
//  CMEverydayRedController.h
//  CaiMao
//
//  Created by MAC on 16/9/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMRedPackage.h"
@interface CMEverydayRedController : UITableViewController
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,strong)CMRedPackage *MyRedPackage;
@property(nonatomic,strong)NSDictionary *redPackageDict;
@property(nonatomic,assign)int shareMoney;
//@property(nonatomic,copy)NSString *UserID;
@property(nonatomic,copy)NSString *PackageID;

@end
