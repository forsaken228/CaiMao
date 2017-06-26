//
//  CMYuexiCell.h
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface CMYuexiCell : UITableViewCell

/** 月息盈标题 */
@property (strong, nonatomic)  UILabel *yueXiTitle;

/** 参与人数 */
@property (strong, nonatomic)  UILabel *yueCanyu;

/** 整数部分 */
@property (strong, nonatomic)  UILabel *yueZhengshu;

/** 小数部分 */
@property (strong, nonatomic)  UILabel *yueXiaoshu;

/** 期限 */
@property (strong, nonatomic)  UILabel *yueQixian;

/** 起投金额 */
@property (strong, nonatomic)  UILabel *yueQitou;

/** 百分比 */
@property (strong, nonatomic)  KDGoalBar *yuePercentView;

@property (strong, nonatomic)  UIButton *yuePaiBtn;


@end
