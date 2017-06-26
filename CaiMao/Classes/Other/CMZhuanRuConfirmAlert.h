//
//  CMZhuanRuConfirmAlert.h
//  CaiMao
//
//  Created by MAC on 16/11/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMZhuanRuConfirmAlert : UIView
-(id)initWithTitle:(NSString *)Title WithDeatilTitle:(NSString *)DeatilTitle WithCancleTitle:(NSString*)aCancleTitle WithDetaildown:(NSString*)aDetaildown;
@property(nonatomic,assign)id delegate;
-(void)ShowAlert;

@property(nonatomic,strong)UILabel *detailLabel;
@end




@protocol CMZhuanRuConfirmAlertDelegate <NSObject>

-(void)ConfirmViewActionWithIndex:(NSInteger)Index;

@end