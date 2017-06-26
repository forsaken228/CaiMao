//
//  CMMyIntegral.h
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMDuiHuanButton.h"
@interface CMMyIntegral : UIView
@property(nonatomic,strong)UILabel *MyIntegral;

@property(nonatomic,strong)CMDuiHuanButton *myDuiHuanRecord;
@property(nonatomic,strong)CMDuiHuanButton *myJFMx;

@property(nonatomic,strong)UIImageView *left;
@property(nonatomic,strong)UIView *IntegralRedView;
@property(nonatomic,weak)id delegate;

@end
@protocol CMMyIntegralDelegate <NSObject>

-(void)tapClickEventWithIndex:(NSInteger)Index;

@end
