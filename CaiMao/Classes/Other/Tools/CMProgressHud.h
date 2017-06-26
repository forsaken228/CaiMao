//
//  CMProgressHud.h
//  CaiMao
//
//  Created by MAC on 16/9/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface CMProgressHud : UIView
+ (CMProgressHud *)sharedCMProgressHud;
-(void)loadData:(UIView*)showView completion:(void (^)(void))success;


-(void)LoadProgress:(UIView*)showView WithMessage:(NSString *)message;
-(void)removeProgressHUD;
@property(nonatomic,strong)MBProgressHUD  *ProgressHUD;
@end
