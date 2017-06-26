//
//  CMYinDetailCell.h
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface CMYinDetailCell : UITableViewCell

@property (strong, nonatomic)  KDGoalBar *yinPercentView;
@property (strong, nonatomic)  UIButton *yinPaiBtn;
@property (strong, nonatomic)  UILabel *yinCanyu;
@property (strong, nonatomic)  UILabel *yinJiShi;
@property (strong, nonatomic)  UILabel *yinPiaoTitle;
@property (strong, nonatomic)  UILabel *yinQiXian;
@property (strong, nonatomic)  UILabel *yinQitou;
@property (strong, nonatomic)  UILabel *yinXiaoshu;
@property (strong, nonatomic)  UILabel *yinYinhang;
@property (strong, nonatomic)  UILabel *yinZhengshu;


@end
