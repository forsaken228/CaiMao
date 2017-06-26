//
//  CMLoginView.h
//  CaiMao
//
//  Created by WangWei on 17/2/16.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMLoginView : UIView

@property (strong, nonatomic)  UIButton *forgetPsw;

@property (strong, nonatomic)  CMTextField *phoneTextField;
@property (strong, nonatomic)  CMTextField *pwdTextField;
@property (strong, nonatomic)  UIButton *loginBtn;
@property (strong, nonatomic)  UIImageView *phoneLeftIcon;
@property (strong, nonatomic)  UIImageView *pwdLeftIcon;
@property (strong, nonatomic)  UIButton *phoneClearBtn;
@property (strong, nonatomic)  UIButton *pwdClearBtn;


@end
