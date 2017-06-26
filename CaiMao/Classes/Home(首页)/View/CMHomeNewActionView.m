//
//  CMHomeNewActionView.m
//  CaiMao
//
//  Created by WangWei on 16/12/3.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHomeNewActionView.h"

@implementation CMHomeNewActionView
-(instancetype)init{
    
    self=[super init];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        UILabel *title=[[UILabel alloc]init];
        title.text=@"最新动态";
        title.font=[UIFont systemFontOfSize:19.0];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@19);
            make.width.equalTo(@100);
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(8);
        }];
        
        UIButton *more=[UIButton buttonWithType:UIButtonTypeSystem];
        [more setTitle:@"更多 >" forState:UIControlStateNormal];
        [more setTitleColor:UIColorFromRGB(0x626262) forState:UIControlStateNormal];
        more.titleLabel.font=[UIFont systemFontOfSize:14.0];
        more.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self addSubview:more];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self).offset(-8);
            make.height.equalTo(@15);
            make.centerY.equalTo(title.mas_centerY);
            
        }];
        UIView *level=[UIView new];
        level.backgroundColor=separateLineColor;
        
        [self addSubview:level];
        
        [level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(10);
            make.left.right.width.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        [self addSubview:self.dongtaiImageView];
        [self.dongtaiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(level.mas_bottom).offset(10);
            make.height.equalTo(@140);
            make.left.equalTo(self.mas_left).offset(8);
            make.right.equalTo(self.mas_right).offset(-8);
        }];
  
       
       
        [self.dongtaiImageView addSubview:self.dongTitleLab];
        [self.dongTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.width.bottom.equalTo(self.dongtaiImageView);
            
        }];
    
        [self addSubview:self.dongBtn1];
        [self.dongBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.width.mas_equalTo(CMScreenW-8);
            make.height.equalTo(@20);
            make.top.equalTo(self.dongtaiImageView.mas_bottom).offset(8);
            
        }];
        
        UIView *level1=[UIView new];
        level1.backgroundColor=separateLineColor;
        
        [self addSubview:level1];
        
        [level1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo( self.dongBtn1.mas_bottom).offset(8);
            make.left.right.width.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
       
        [self addSubview:self.dongBtn2];
        [self.dongBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.width.mas_equalTo(CMScreenW-8);
            make.height.equalTo(@20);
            make.top.equalTo(level1.mas_bottom).offset(8);
            
        }];
        
        
        [more addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donghandleSingleTap)];
        [self.dongtaiImageView addGestureRecognizer:singleTap];
        
    
      
    
    }
    return self;
    
}
#pragma mark Lazy
-(UIButton*)dongBtn1{
    if (!_dongBtn1) {
       _dongBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        [_dongBtn1 setTitleColor:UIColorFromRGB(0x3a3836)  forState:UIControlStateNormal];
        _dongBtn1.titleLabel.font=[UIFont systemFontOfSize:12.5];
        _dongBtn1.contentHorizontalAlignment=    UIControlContentHorizontalAlignmentLeft;
        _dongBtn1.tag=101;
    [ _dongBtn1 addTarget:self action:@selector(dongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dongBtn1;
}

-(UIButton*)dongBtn2{
    if (!_dongBtn2) {
        
        _dongBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        [_dongBtn2 setTitleColor:UIColorFromRGB(0x3a3836) forState:UIControlStateNormal];
        _dongBtn2.titleLabel.font=[UIFont systemFontOfSize:12.5];
       _dongBtn2.contentHorizontalAlignment=    UIControlContentHorizontalAlignmentLeft;
     _dongBtn2.tag=102;
        
        [_dongBtn2 addTarget:self action:@selector(dongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dongBtn2;
}
-(UILabel*)dongTitleLab{
    if (!_dongTitleLab) {
        _dongTitleLab=[[UILabel alloc]init];
        _dongTitleLab.font=[UIFont systemFontOfSize:14.0];
        _dongTitleLab.textColor=[UIColor whiteColor];
        _dongTitleLab.textAlignment=NSTextAlignmentCenter;
        
    }
    return _dongTitleLab;
}
-(UIImageView*)dongtaiImageView{
    if (!_dongtaiImageView) {
        _dongtaiImageView=[[UIImageView alloc]init];
        _dongtaiImageView.userInteractionEnabled = YES;
    }
    return _dongtaiImageView;
}

-(NSMutableArray*)dongAdUrlArr{
    if (!_dongAdUrlArr) {
        _dongAdUrlArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dongAdUrlArr;
}
-(NSMutableArray*)dongTitleArr{
    if (!_dongTitleArr) {
        _dongTitleArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dongTitleArr;
}
-(NSMutableArray*)dongLinkUrlArr{
    if (!_dongLinkUrlArr) {
        _dongLinkUrlArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dongLinkUrlArr;
}
-(void)setResponseArr:(NSArray *)responseArr{
    [self.dongAdUrlArr removeAllObjects];
    [self.dongLinkUrlArr removeAllObjects];
    [self.dongTitleArr removeAllObjects];
    
    // 遍历数组取出最新动态标题、图片url、链接
    for (NSString *str in responseArr) {
        [self.dongTitleArr addObject:[str valueForKey:@"title"]];
        [self.dongAdUrlArr addObject:[str valueForKey:@"adUrl"]];
        [self.dongLinkUrlArr addObject:[str valueForKey:@"linkUrl"]];
    }
    
    NSString *str0 = [self.dongTitleArr objectAtIndex:0];
    self.dongTitleLab.text = str0;
    
    NSString *str1 = [NSString stringWithFormat:@"%@",[self.dongTitleArr objectAtIndex:1]];
    [self.dongBtn1 setTitle:str1 forState:UIControlStateNormal];
    
    NSString *str2 =[ NSString stringWithFormat:@"%@",[self.dongTitleArr objectAtIndex:2]];
    [self.dongBtn2 setTitle:str2 forState:UIControlStateNormal];
    
    // 最新动态展示图片
    NSURL *url = [self.dongAdUrlArr objectAtIndex:0];
    [self.dongtaiImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];


}
-(void)moreBtnClick{
    if ([self.delegate respondsToSelector:@selector(enterNewActionController)]) {
        [self.delegate enterNewActionController];
    }
    
}
-(void)dongBtnClick:(UIButton*)sender
{
    if (self.dongLinkUrlArr.count > 0) {
        ;

        
        if ([self.delegate respondsToSelector:@selector(enterProductWebController:)]) {
            [self.delegate enterProductWebController:[self.dongLinkUrlArr objectAtIndex:sender.tag - 100]];
        }
        
    }
}

-(void)donghandleSingleTap{
    
    if (self.dongLinkUrlArr.count > 0) {
        if ([self.delegate respondsToSelector:@selector(PicActionEnterProductWebController:)]) {
            [self.delegate PicActionEnterProductWebController:[self.dongLinkUrlArr objectAtIndex:0]];
        }
        
        
    }
}

@end
