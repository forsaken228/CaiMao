//
//  CMAccountDespositTopView.h
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAccountDespositTopView : UIView

@property(nonatomic,strong)UILabel *CYLabel;
@property(nonatomic,strong)UILabel *LJTZLabel;
@property(nonatomic,strong)UILabel *LJSYLabel;
@property(nonatomic,strong)CMProgressView *circleProgress;
@property(nonatomic,strong)NSTimer *progressTimer;

@end
