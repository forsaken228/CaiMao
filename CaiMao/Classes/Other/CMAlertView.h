//
//  CMAlertView.h
//  CaiMao
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAlertView : UIView

-(id)initWithCancleButtonTitle:(NSString *)CancleTitle WithTitle:(NSString*)aTitle WithDetailUp:(NSString*)aDetailUp WithDetaildown:(NSString*)aDetaildown;

-(void)ShowAlert;
@end
