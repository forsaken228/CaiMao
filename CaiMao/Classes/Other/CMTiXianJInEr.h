//
//  CMTiXianJInEr.h
//  CaiMao
//
//  Created by MAC on 16/6/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTiXianJInEr : UIView
@property(nonatomic,assign)id delegate;

-(id)initWithCancleButtonTitle:(NSString *)CancleTitle WithDetailUp:(NSString*)aDetailUp WithDetaildown:(NSString*)aDetaildown;

-(void)ShowAlert;
@end
