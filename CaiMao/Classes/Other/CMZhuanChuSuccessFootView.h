//
//  CMZhuanChuSuccessFootView.h
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMZhuanChuSuccessFootView : UIView

@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,weak)id  delegate;
@end
@protocol CMZhuanChuSuccessFootViewDelegate <NSObject>

-(void)changeViewActionWithTag:(NSInteger)aTag;

@end