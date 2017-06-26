//
//  CMCFBZhuangRuAlertView.h
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCFBZhuangRuAlertView : UIView

-(id)initWithDeatilTitle:(NSString *)DeatilTitle WithCancleTitle:(NSString*)aCancleTitle WithDetaildown:(NSString*)aDetaildown withTag:(NSInteger)aTag;

-(void)ShowAlert;
@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)UILabel *detailLabel;

@end
@protocol CMCFBZhuangRuAlertViewDelegate <NSObject>

-(void)jumpViewWithTag:(NSInteger)aTag;
-(void)jumpViewWithIndex:(NSInteger)Index;

@end