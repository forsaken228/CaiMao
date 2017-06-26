//
//  CMJipaiView.h
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMJipaiView : UIView
@property(nonatomic,strong)UILabel *jinPai;
@property(nonatomic,strong)UILabel *PayJinEr;
@property(nonatomic,assign)id delegate;
@end
@protocol CMJipaiViewDelegate <NSObject>

-(void)jiPaiBtnClick;

@end