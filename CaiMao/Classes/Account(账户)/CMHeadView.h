//
//  CMHeadView.h
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMHeadView : UIView
@property(nonatomic,strong)UILabel *CYLabel;
@property(nonatomic,strong)UIButton *headButton;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UILabel *LJTZLabel;
@property(nonatomic,strong)UILabel *LJSYLabel;
@property(nonatomic,strong)UILabel *DSTZLabel;
@property(nonatomic,strong)UILabel *DSSYLabel;
@property(nonatomic,strong)UILabel *BJLabel;
@property(nonatomic,strong)UIView *moveView;
@property(nonatomic,strong)CMProgressView *circleProgress;

@property(nonatomic,assign) id delegate;
@end
@protocol CMHeadViewDelegate <NSObject>

-(void)addTargetWith:(NSInteger)tag;

@end
