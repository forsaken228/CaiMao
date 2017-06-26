//
//  CMSafeDetailAlert.h
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMSafeDetailAlert : UIView
-(id)initWithDeatilTitle:(NSString *)DeatilTitle WithCancleTitle:(NSString*)aCancleTitle WithDetaildown:(NSString*)aDetaildown withTag:(NSInteger)aTag;

-(void)ShowAlert;
@property(nonatomic,assign)id delegate;

@end
@protocol CMSafeDetailAlertDelegate <NSObject>

-(void)jumpViewWithTag:(NSInteger)aTag;

@end