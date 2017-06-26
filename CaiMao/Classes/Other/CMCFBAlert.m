//
//  CMCFBAlert.m
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCFBAlert.h"

@implementation CMCFBAlert

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
      UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
    
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIImage *tImage=[UIImage imageNamed:@"cfbht_tankuangtu"];
        UIImageView *contentView=[[UIImageView alloc]init];
        contentView.image=tImage;;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(tImage.size.height);
            make.width.mas_equalTo(tImage.size.width);
            make.centerX.equalTo(bgView.mas_centerX).offset(5);
            make.top.equalTo(bgView.mas_top).offset(170);
        }];
        

        
    }
    return self;
}
-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dismissView{
    
    for (UIView *vc in self.subviews) {
        [vc removeFromSuperview];
    }
    [self removeFromSuperview];

}
@end
