//
//  CMAlertRegitView.h
//  CaiMao
//
//  Created by MAC on 16/8/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAlertRegitView : UIView<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
}

-(id)initWithRegist;
-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;
@end

@protocol CMAlertRegitViewDelegate <NSObject>

-(void)tapDismissView;

@end