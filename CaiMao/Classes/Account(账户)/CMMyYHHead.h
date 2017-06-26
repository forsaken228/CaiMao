//
//  CMMyYHHead.h
//  CaiMao
//
//  Created by MAC on 16/11/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMMyYHHead : UIView

@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)UIView *moveView;

@end
@protocol CMMyYHHeadDelegate <NSObject>

-(void)choiceViewWithButtonTage:(NSInteger)aTag;

@end
