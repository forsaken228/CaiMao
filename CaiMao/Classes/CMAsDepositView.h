//
//  CMAsDepositView.h
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
// 随心存

#import <UIKit/UIKit.h>
#import"CMScrollSlider.h"
@interface CMAsDepositView : UIView

@property(nonatomic,strong)UIButton *depositBtn;
@property(nonatomic,strong)UILabel *integerLabel;
@property(nonatomic,strong)UILabel *decimalsLabel;
@property(nonatomic,assign)int selectVaule;
@property(nonatomic,strong) CMScrollSlider *productSlider;
@end
