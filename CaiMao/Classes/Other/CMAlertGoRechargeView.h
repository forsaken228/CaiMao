//
//  CMAlertGoRechargeView.h
//  CaiMao
//
//  Created by MAC on 16/8/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAlertGoRechargeView : UIView<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
}

-(id)initWithReChargeWith:(int)msg;
-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;
@end
@protocol CMAlertGoRechargeViewDelegate <NSObject>

-(void)tapDismissView;
-(void)goRechargeView;
@end