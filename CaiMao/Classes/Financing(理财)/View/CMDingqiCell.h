//
//  CMDingqiCell.h
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface CMDingqiCell : UITableViewCell

/** 定期宝标题 */
@property (strong, nonatomic)  UILabel *dingqiTitle;
/** 参与人数 */
@property (strong, nonatomic)  UILabel *dingCanyu;
/** 整数部分 */
@property (strong, nonatomic)  UILabel *dingZhengshu;
/** 小数部分 */
@property (strong, nonatomic)  UILabel *dingXiaoshu;
/** 期限 */
@property (strong, nonatomic)  UILabel *dingQixian;
/** 起投金额 */
@property (strong, nonatomic)  UILabel *dingQitou;
/** 百分比 */
@property (strong, nonatomic)  KDGoalBar *dingPercentView;

@property (strong, nonatomic)  UIButton *dingJoinBtn;


@end
