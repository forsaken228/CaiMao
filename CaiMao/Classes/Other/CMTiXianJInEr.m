//
//  CMTiXianJInEr.m
//  CaiMao
//
//  Created by MAC on 16/6/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTiXianJInEr.h"

@implementation CMTiXianJInEr

-(id)initWithCancleButtonTitle:(NSString *)CancleTitle WithDetailUp:(NSString*)aDetailUp WithDetaildown:(NSString*)aDetaildown{
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
        //WithFrame:CGRectMake(10, 150, 300,210)
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX);
                   make.centerY.equalTo(bgView.mas_centerY);
            make.width.equalTo(@300);
            make.height.mas_equalTo(140);
            
        }];
    
        //弹框顶部说明
        UILabel *label1=[[UILabel alloc]init];
        //WithFrame:CGRectMake(10,10, contentView.bounds.size.width-20, 30)
        label1.text=aDetailUp;
        label1.numberOfLines=0;
        label1.font=[UIFont systemFontOfSize:14];
        label1.textColor=UIColorFromRGB(0x333333);
        [contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(contentView.mas_top).offset(8);
            make.left.equalTo(contentView.mas_left).offset(10);
            make.right.equalTo(contentView.mas_right).offset(-10);
            make.height.mas_equalTo(15);
            
        }];
       
         //弹框底部说明
        UILabel *label2=[[UILabel alloc]init];
        //WithFrame:CGRectMake(10, 50, contentView.bounds.size.width-20, 80)
        label2.text=aDetaildown;
        label2.numberOfLines=0;
        label2.textColor=UIColorFromRGB(0x8e8d93);
        label2.font=[UIFont systemFontOfSize:13];
        [contentView addSubview:label2];
        CGRect rect=[ label2.text boundingRectWithSize:CGSizeMake(CMScreenW-30, MAXFLOAT) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(label1.mas_bottom).offset(10);
            make.left.equalTo(contentView.mas_left).offset(15);
            make.right.equalTo(contentView.mas_right).offset(-15);
            make.height.mas_equalTo(rect.size.height+2);
            
        }];
        //取消按钮
        UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeSystem];
       // CancleBtn.frame=CGRectMake(20, 160, 260, 40);
        CancleBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        CancleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [CancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CancleBtn.backgroundColor=RedButtonColor;
        CancleBtn.layer.cornerRadius=5.0;
        CancleBtn.clipsToBounds=YES;
        [CancleBtn setTitle:CancleTitle forState:UIControlStateNormal];
        [CancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:CancleBtn];
        [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(label2.mas_bottom).offset(10);
            make.left.equalTo(contentView.mas_left).offset(15);
            make.height.mas_equalTo(buttonHeight);
            make.right.equalTo(contentView.mas_right).offset(-15);
            
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
-(void)btnClick
{
    
    [self removeFromSuperview];
   
    
}
@end
