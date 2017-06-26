//
//  CMConfirmRedeemView.h
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMConfirmRedeemView : UIView
@property(nonatomic,strong)UILabel *totalMoneyLabel;
@property(nonatomic,strong)UILabel *MoneyLabel;
@property(nonatomic,strong)UILabel *beginDateLabel;
@property(nonatomic,strong)UILabel *JXBeginDateLabel;
@property(nonatomic,strong)UILabel *JXDateLabel;
@property(nonatomic,strong)UILabel *yieldLabel;
@property(nonatomic,strong)UILabel *SJGetMoneyTotal;
@property(nonatomic,strong)UIButton *cancleButton;
@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,copy)NSString *orderId;

-(void)ShowAlert;
@end
