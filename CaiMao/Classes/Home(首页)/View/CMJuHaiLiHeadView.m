//
//  CMJuHaiLiHeadView.m
//  CaiMao
//
//  Created by MAC on 16/7/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMJuHaiLiHeadView.h"

@implementation CMJuHaiLiHeadView

-(id)initWithFrame:(CGRect)frame{
   self= [super initWithFrame:frame];
    if (self) {
      //  [self creatDingQiHeadView];
    }
    return self;
}
-(UIView*)creatHeadViewWithTitle:(NSString*)aTitle WithDetailTitle:(NSString*)aDetail withMoringTitle:(NSString *)aMoring WithNight:(NSString *)aNight andDetailImage:(NSString *)aDetailImage{
    
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, f_i5real(275));
    UIImageView *detailImage=[[UIImageView alloc]init];
    detailImage.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, f_i5real(200));
    //detailImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:aDetailImage]];
   // detailImage.contentMode=UIViewContentModeScaleAspectFit;
    detailImage.image=[UIImage imageNamed:aDetailImage];
    [bgView addSubview:detailImage];
    
    UILabel *title=[UILabel new];
    //title.frame=CGRectMake(8, 3+200, 68, 27);
    //title.text=@"聚嗨利";
    title.text=aTitle;
    title.textColor=CMColor(255, 134, 46);
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.top.equalTo(detailImage.mas_bottom).offset(5);
        make.height.mas_equalTo(f_i5real(27));
        make.width.mas_equalTo(68);
        
    }];
    
    
    
    UILabel *right=[UILabel new];
    //right.frame=CGRectMake(149, 1+200, 163, 34);
    right.font=[UIFont systemFontOfSize:14.0];
    right.textAlignment=NSTextAlignmentRight;
   // right.text=@"200元起存,一起嗨翻天";
    right.text=aDetail;
    right.textColor=[UIColor lightGrayColor];
    [bgView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-8);
        make.top.height.equalTo(title);
        make.width.mas_equalTo(163);
        
    }];
    
    UIView *line=[UIView new];
    line.backgroundColor=separateLineColor;
    //line.frame=CGRectMake(0, 38+200, [UIScreen mainScreen].bounds.size.width,0.5);
    [bgView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom);
        make.left.width.equalTo(bgView);
        make.height.mas_equalTo(0.5);
        
    }];
    UIButton *moring=[UIButton buttonWithType:UIButtonTypeCustom];
    //moring.frame=CGRectMake(0, 38+200, CMScreenW/2.0, 35);
    [moring setImage:[UIImage imageNamed:@"details_jhl_zao.png"] forState:UIControlStateNormal];
    moring.titleLabel.font=[UIFont systemFontOfSize:15];
    [moring setTitle:aMoring forState:UIControlStateNormal];
    [moring setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.moringBtn=moring;
    [bgView addSubview:moring];

    [moring mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(f_i5real(275)-f_i5real(200)-f_i5real(27));
        make.width.mas_equalTo(CMScreenW/2.0);
        
    }];
    
    
    UIView *line1=[UIView new];
    line1.backgroundColor=separateLineColor;
   // line1.frame=CGRectMake(CMScreenW/2.0, 38+200, 0.5, 36);
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(moring);
        make.left.equalTo(moring.mas_right);
        make.width.mas_equalTo(0.5);
        
    }];
    
    
    
    UIButton *night=[UIButton buttonWithType:UIButtonTypeCustom];
   // night.frame=CGRectMake(CMScreenW/2.0, 38+200, CMScreenW/2.0, 35);
    [night setImage:[UIImage imageNamed:@"details_jhl_wan.png"] forState:UIControlStateNormal];
    night.titleLabel.font=[UIFont systemFontOfSize:15];
   
    [night setTitle:aNight forState:UIControlStateNormal];
    [night setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.nightBtn=night;
    [bgView addSubview:night];
    [night mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(moring);
        make.left.equalTo(line1.mas_right);
    }];
    
    UIView *moveView=[[UIView alloc]init];
    moveView.frame=CGRectMake(0, f_i5real(275)-2,CMScreenW/2.0,2);
    
 //   self.trackLineView=moveView;
    moveView.backgroundColor=RedButtonColor;
    self.redView=moveView;
    [bgView addSubview:moveView];
    
    
    
    
    
    return bgView;
    
}


@end
