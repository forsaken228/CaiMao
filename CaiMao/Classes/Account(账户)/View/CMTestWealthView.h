//
//  CMTestWealthView.h
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTestWealthView : UIView

@property(nonatomic,strong)UILabel *joinLabel;

@property(nonatomic,copy)void (^testBlockClick)(void);

@end
