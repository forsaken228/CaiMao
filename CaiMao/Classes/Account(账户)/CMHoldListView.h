//
//  CMHoldListView.h
//  CaiMao
//
//  Created by WangWei on 2017/6/21.
//  Copyright © 2017年 58cm. All rights reserved.
//持有列表

#import <UIKit/UIKit.h>

@interface CMHoldListView : UIView

@property(nonatomic,strong)CMDQLController *receiveController;
@property(nonatomic,copy)void (^receiveDataSuccess)(void);

@end
