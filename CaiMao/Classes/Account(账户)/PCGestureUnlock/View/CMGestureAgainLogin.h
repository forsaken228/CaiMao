//
//  CMGestureAgainLogin.h
//  CaiMao
//
//  Created by MAC on 16/8/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMGestureAgainLogin : UIView<UIGestureRecognizerDelegate>

-(id)initWithRegist;
-(void)ShowAlert;
-(void)dimissAlert;

@property(nonatomic,assign)id delegate;
@end


@protocol CMGestureAgainLoginDelegate <NSObject>

-(void)exitView;

@end
