//
//  CMMiaoShaCell.h
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface CMMiaoShaCell : UITableViewCell


@property (strong, nonatomic)  KDGoalBar *miaoPercentView;
@property (strong, nonatomic)  UIButton *miaoJoin;
@property (strong, nonatomic)  UILabel *miaoPaiShu;
@property (strong, nonatomic)  UILabel *miaoQiTou;
@property (strong, nonatomic)  UILabel *miaoQiXian;
@property (strong, nonatomic)  UILabel *miaoShouXiao;
@property (strong, nonatomic)  UILabel *miaoShouZheng;
@property (strong, nonatomic)  UILabel *miaoTime;
@property (strong, nonatomic)  UILabel *miaoTitle;
@property (strong, nonatomic)  UILabel *miaoQiSX;
@end
