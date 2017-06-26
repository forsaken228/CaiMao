//
//  CMQianDaoView.h
//  CaiMao
//
//  Created by MAC on 16/11/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMVipBottomImage.h"
#import "CMCircleAnimationView.h"
@interface CMQianDaoView : UIView
@property(nonatomic,strong)UILabel *QianDaoLabel;
@property(nonatomic,strong)UIButton *ShengjiButton;

@property(nonatomic,strong)UILabel *NameLabel;
@property(nonatomic,strong)UILabel *currentLevel;
@property(nonatomic,strong)UIImageView *qiandaoImageView;
@property(nonatomic,strong)UILabel *chengzhangVaule;
@property(nonatomic,strong)CMVipBottomImage *VipBottomView;
@property (nonatomic, strong) CMCircleAnimationView *circleProgressView;
@property(nonatomic,weak)id delegate;
@end
@protocol CMQianDaoViewDelegtae <NSObject>

-(void)bugVipProductOrCheackFuLiWithIndex:(NSInteger)index;

@end