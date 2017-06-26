//
//  CMJuHaiLiCell.h
//  CaiMao
//
//  Created by Fengpj on 15/12/22.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface CMJuHaiLiCell : UITableViewCell

/** 聚嗨利标题 */
@property (strong, nonatomic)  UILabel *juTitle;

/** 聚嗨利收益率整数部分 */
@property (strong, nonatomic)  UILabel *juShouZheng;

/** 聚嗨利收益率小数部分 */
@property (strong, nonatomic)  UILabel *juShouXiao;

/** 聚嗨利起始收益率 */
@property (strong, nonatomic)  UILabel *juQiShilv;

/** 聚嗨利已拍人数 */
@property (strong, nonatomic)  UILabel *juPaiShu;

/** 聚嗨利倒计时 */
@property (strong, nonatomic)  UILabel *juJiShi;

/** 聚嗨利百分比 */
@property (strong, nonatomic)  KDGoalBar *juPercentView;

/** 聚嗨利期限 */
@property (strong, nonatomic)  UILabel *juQixian;

/** 聚嗨利嗨标题 */
@property (strong, nonatomic)  UILabel *juHaiLable;

/** 聚嗨利起投金额 */
@property (strong, nonatomic)  UILabel *juQitou;

@property (strong, nonatomic)  UILabel *juShou1;
@property (strong, nonatomic)  UILabel *juRen1;
@property (strong, nonatomic)  UILabel *juShou2;
@property (strong, nonatomic)  UILabel *juRen2;
@property (strong, nonatomic)  UILabel *juShou3;
@property (strong, nonatomic)  UILabel *juRen3;
@property (strong, nonatomic)  UILabel *juShou4;
@property (strong, nonatomic)  UILabel *juRen4;

@property (strong, nonatomic)  UIImageView *juImage1;
@property (strong, nonatomic)  UIImageView *juImage2;
@property (strong, nonatomic)  UIImageView *juImage3;
@property (strong, nonatomic)  UIImageView *juImage4;

@property (strong, nonatomic)  UILabel *juSubTitle;

@property (strong, nonatomic)  UIButton *juPaiBtn;

@end
