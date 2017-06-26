//
//  CMDuiHuanButton.h
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMDuiHuanButton : UIView

-(instancetype)initWithImageView:(NSString*)ALeftImage andButton:(NSString*)aButton;
@property(nonatomic,strong)UITapGestureRecognizer *MyIntegralBtn;
@end
