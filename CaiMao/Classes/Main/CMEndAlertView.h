//
//  CMEndAlertView.h
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CMEndAlertViewDlegate <NSObject>

-(void)SureButtonAction;

@end
@interface CMEndAlertView : UIView
-(id)initCMSmsCodeAlertWithTitle:(NSString *)msg;
-(void)ShowAlert;
-(void)DissAlert;
@property(nonatomic,copy)void(^block)(void);
@property(nonatomic,weak)id delegate;
@end
