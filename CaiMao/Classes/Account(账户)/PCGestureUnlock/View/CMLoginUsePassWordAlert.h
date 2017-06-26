//
//  CMLoginUsePassWordAlert.h
//  CaiMao
//
//  Created by MAC on 16/8/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMLoginUsePassWordAlert : UIView<UIGestureRecognizerDelegate>

-(id)initLoginUsePassWordAlert;
-(void)ShowLoginAlert;
-(void)dimissLoginAlert;
@property(nonatomic,assign)id  delegate;
@property(nonatomic,strong)UILabel  *errorlabel;
@property(nonatomic,strong)UILabel  *mainTitle;;
@property(nonatomic,strong)UITextField *passWordField;
@end
@protocol CMLoginUsePassWordAlertDelegate <NSObject>

-(void)exitView:(NSString*)passWord;

@end
