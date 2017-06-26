//
//  CMSafeDetailAlert.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSafeDetailAlert.h"

@implementation CMSafeDetailAlert
-(id)initWithDeatilTitle:(NSString *)DeatilTitle WithCancleTitle:(NSString*)aCancleTitle WithDetaildown:(NSString*)aDetaildown withTag:(NSInteger)aTag{
self=[super init];
if (self) {
    
    
    self.frame=[UIScreen mainScreen].bounds;
    //模糊视图
    UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
    bgView.userInteractionEnabled=YES;
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.52f;
    [self addSubview:bgView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
    [bgView addGestureRecognizer:tap];
    //弹框背景
    UIImageView *contentView=[[UIImageView alloc]init];
    contentView.backgroundColor=[UIColor whiteColor];
    contentView.userInteractionEnabled=YES;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.mas_equalTo(550/2.0);
        make.height.mas_equalTo(218/2.0);
        
    }];
    
    //弹框顶部说明
    UILabel *label=[[UILabel alloc]init];
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentCenter;
    label.text=DeatilTitle;
    CGRect rect=[DeatilTitle boundingRectWithSize:CGSizeMake(220-16, 50) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
    
    label.font=[UIFont systemFontOfSize:14.0];
    label.textColor=UIColorFromRGB(0x333333);
    [contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(contentView.mas_top).offset(15);
        make.left.equalTo(contentView.mas_left).offset(8);
        make.right.equalTo(contentView.mas_right).offset(-8);
        make.height.mas_equalTo(rect.size.height);
        
    }];
    UILabel *line=[UILabel new];
    line.backgroundColor=separateLineColor;
    [contentView addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.width.left.equalTo(contentView);
        make.top.equalTo(label.mas_bottom).offset(15);
    }];
    UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CancleBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [CancleBtn setTitleColor:UIColorFromRGB(0x8f8e94) forState:UIControlStateNormal];
    [CancleBtn setTitle:aCancleTitle forState:UIControlStateNormal];
    [CancleBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:CancleBtn];
    [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom).offset(5);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(550/4.0);
        
    }];
    UIButton *next=[UIButton buttonWithType:UIButtonTypeCustom];
    next.titleLabel.font=[UIFont systemFontOfSize:14];
    [next setTitleColor:RedButtonColor forState:UIControlStateNormal];
    [next setTitle:aDetaildown forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    next.tag=aTag;
    [contentView addSubview:next];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.height.top.width.equalTo(CancleBtn);
        make.left.equalTo(CancleBtn.mas_right);
        
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
    
    [self removeFromSuperview];
    
}
-(void)nextClick:(UIButton*)btn{

    if ([_delegate respondsToSelector:@selector(jumpViewWithTag:)]) {
        [_delegate jumpViewWithTag:btn.tag];
    }
    [self dismissView];
}
@end
