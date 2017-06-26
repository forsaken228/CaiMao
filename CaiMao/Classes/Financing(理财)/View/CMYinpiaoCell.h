//
//  CMYinpiaoCell.h
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"
@interface CMYinpiaoCell : UITableViewCell

/** 银票通标题 */
@property (strong, nonatomic)  UILabel *yinPiaoTitle;
/** 参与人数 */
@property (strong, nonatomic)  UILabel *yinCanyu;
/** 整数部分 */
@property (strong, nonatomic)  UILabel *yinZhengshu;
/** 小数部分 */
@property (strong, nonatomic)  UILabel *yinXiaoshu;
/** 期限 */
@property (strong, nonatomic)  UILabel *yinQiXian;
/** 起投金额 */
@property (strong, nonatomic)  UILabel *yinQitou;
/** 担保银行 */
@property (strong, nonatomic)  UILabel *yinYinhang;
/** 百分比 */
@property (strong, nonatomic)  KDGoalBar *yinPercentView;

@property (strong, nonatomic)  UIButton *yinPaiBtn;

@end
