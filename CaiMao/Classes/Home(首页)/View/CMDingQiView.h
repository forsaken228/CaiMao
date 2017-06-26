//
//  CMDingQiView.h
//  CaiMao
//
//  Created by Fengpj on 15/12/7.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"
#import "CMDingQiBaoList.h"
@interface CMDingQiView : UIView

/** 定期宝产品百分比 */
@property (strong, nonatomic)  KDGoalBar *percentView;

/** 定期宝产品标题 */
@property (strong, nonatomic)  UILabel *dingTitle;

/** 定期宝产品参与人数 */
@property (strong, nonatomic)  UILabel *dingCanyu;

/** 定期宝产品收益整数 */
@property (strong, nonatomic)  UILabel *dingShouyiZheng;

/** 定期宝产品收益小数 */
@property (strong, nonatomic)  UILabel *dingShouyiXiao;

/** 定期宝产品期限 */
@property (strong, nonatomic)  UILabel *dingQixian;

/** 定期宝产品起投金额 */
@property (weak, nonatomic)  UILabel *dingJinE;

@property (strong, nonatomic)  UIButton *dingJoinBtn;

@property(nonatomic,strong)CMDingQiBaoList *DingQiBaoList;


@end
