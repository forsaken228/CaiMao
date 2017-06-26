//
//  CMCaiFuBaoView.m
//  CaiMao
//
//  Created by MAC on 16/7/13.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCaiFuBaoView.h"


@implementation CMCaiFuBaoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel *title=[UILabel new];
        title.text=@"财富宝";
        title.font=[UIFont systemFontOfSize:19.0];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.mas_left).offset(8);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20.0);
        }];
        
        [self addSubview:self.caiFubaoDetailBtn];
        [self.caiFubaoDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(title);
            make.right.equalTo(self.mas_right).offset(-8);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15.0);
        }];
        

        UIView *level=[UIView new];
        level.backgroundColor=separateLineColor;
        
        [self addSubview:level];
        
        [level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(10);
            make.left.width.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *line=[[UILabel alloc]init];
        line.frame=CGRectMake(CMScreenW/2.0, 50, 0.5,70);
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        
        [self addSubview:self.joinBtnClick];
        [self.joinBtnClick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(line.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            
        }];
      
        UILabel *cunRu=[[UILabel alloc]init];
        // cunRu.frame=CGRectMake(169 , 22, 38, 20);
        cunRu.text=@"存入";
        cunRu.font=[UIFont systemFontOfSize:14.0];
        cunRu.textAlignment=NSTextAlignmentCenter;
        cunRu.textColor=[UIColor lightGrayColor];
        [self addSubview:cunRu];
        [cunRu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.joinBtnClick.mas_top).offset(-5);
            make.left.equalTo(self.joinBtnClick);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(35);
            
            
        }];
        
        UILabel *yuan=[[UILabel alloc]init];
        // yuan.frame=CGRectMake(277 , 22, 29, 20);
        yuan.font=[UIFont systemFontOfSize:14.0];
        yuan.text=@"元";
        yuan.textAlignment=NSTextAlignmentCenter;
        yuan.textColor=[UIColor lightGrayColor];
        [self addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(cunRu);
            make.width.mas_equalTo(25);
            make.right.equalTo(self.joinBtnClick.mas_right);
        }];
        
        
        [self addSubview:self.InPutText];
        [self.InPutText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.joinBtnClick.mas_top).offset(-5);
            make.height.mas_equalTo(30);
            make.left.equalTo(cunRu.mas_right);
            make.right.equalTo(yuan.mas_left);

            
            
        }];
        UILabel *shouYiZhi=[[UILabel alloc]init];
        //shouYiZhi.frame=CGRectMake(41 , 17, 41, 58);
        shouYiZhi.text=@"8";
        //self.CaiFuZhengshu=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:50.0];
        shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=RedButtonColor;
        [self addSubview:shouYiZhi];
        [shouYiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(15);
            make.centerX.equalTo(self.mas_centerX).offset(-CMScreenW/4.0-25);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(50);
            
            
        }];
        UILabel *zuiGao=[[UILabel alloc]init];
        //zuiGao.frame=CGRectMake(13 , 39, 39, 20);
        zuiGao.font=[UIFont systemFontOfSize:16.0];
        zuiGao.text=@"最高";
        zuiGao.textAlignment=NSTextAlignmentRight;
        [self addSubview:zuiGao];
        
        [zuiGao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(shouYiZhi);
            make.right.equalTo(shouYiZhi.mas_left);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(20);
            
            
        }];
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        //shouYiZhiXiao.frame=CGRectMake(85 ,15, 67, 49);
        shouYiZhiXiao.text=@".80%";
        //self.yinXiaoshu=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:19];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=RedButtonColor;
        [self addSubview:shouYiZhiXiao];
        [shouYiZhiXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(shouYiZhi.mas_centerY).offset(-2);
            make.left.equalTo(shouYiZhi.mas_right);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(20);
            
            
        }];
        
        UILabel *shouyi=[[UILabel alloc]init];
        //shouyi.frame=CGRectMake(85 , 50, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shouYiZhi.mas_centerY).offset(2);
            make.left.equalTo(shouYiZhiXiao);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(15.0);
            
            
        }];
        
      
        
        
       
        UIView *cLine=[UIView new];
        cLine.backgroundColor=UIColorFromRGB(0xb3b3b3);
        [self addSubview:cLine];
        [cLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(title.mas_right).offset(6);
            make.width.equalTo(@1);
            make.centerY.equalTo(title);
          
            
        }];
        
      
        UILabel *HQi=[UILabel new];
        HQi.textColor=UIColorFromRGB(0x626262);
        HQi.text=@"活期";
        HQi.font=[UIFont systemFontOfSize:15.0];
        [self addSubview:HQi];
        [HQi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15.0);
            make.left.equalTo(cLine.mas_right).offset(8);
            make.width.equalTo(@50);
            make.centerY.equalTo(title);
            
            
        }];
        
     
    }
    
        return self;
    }
#pragma mark Lazy
-(UIButton*)caiFubaoDetailBtn{
    
    if (!_caiFubaoDetailBtn) {
        _caiFubaoDetailBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _caiFubaoDetailBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [_caiFubaoDetailBtn setTitle:@"随存随取 每7天升息 >" forState:UIControlStateNormal];
        [_caiFubaoDetailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _caiFubaoDetailBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        
    }
    return _caiFubaoDetailBtn;
}
-(UIButton*)joinBtnClick{
    
    if (!_joinBtnClick) {
        _joinBtnClick=[UIButton buttonWithType:UIButtonTypeSystem];
        _joinBtnClick.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_joinBtnClick setTitle:@"立即存入" forState:UIControlStateNormal];
        [_joinBtnClick setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _joinBtnClick.backgroundColor=RedButtonColor;
        _joinBtnClick.layer.cornerRadius=5.0;
        _joinBtnClick.clipsToBounds=YES;
      
    }
    
    return _joinBtnClick;
}
-(UITextField*)InPutText{
    if (!_InPutText) {
       _InPutText=[[UITextField alloc]init];
        _InPutText.font=[UIFont systemFontOfSize:14];
        _InPutText.placeholder=@"1元起";
        _InPutText.borderStyle=UITextBorderStyleRoundedRect;
        _InPutText.keyboardType=UIKeyboardTypeNumberPad;
        _InPutText.textAlignment=NSTextAlignmentCenter;
    }
    
    return _InPutText;
}

@end
