//
//  CMReChargeView.h
//  CaiMao
//
//  Created by MAC on 16/7/16.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMReChargeView : UIView

@property(nonatomic,strong)UIButton *Rechargebtn;
@property(nonatomic,strong)UIButton *limitContent;
@property(nonatomic,strong)UIImageView *bankIcon;
@property(nonatomic,strong)UILabel *BalanceLabel;
@property(nonatomic,strong)UILabel *RechargeLimit;
@property(nonatomic,strong)UILabel *bankNum;
@property(nonatomic,strong)UILabel *limitMoney;
@property(nonatomic,strong)UITextField *RechargeNum;
@end
