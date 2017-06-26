//
//  CMShouYiPlanCell.m
//  CaiMao
//
//  Created by MAC on 16/8/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMShouYiPlanCell.h"

@implementation CMShouYiPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        UILabel *CQiCi=[[UILabel alloc]init];
        
        CQiCi.font=[UIFont systemFontOfSize:12.0];
        CQiCi.textColor=UIColorFromRGB(0x3a3836);
        CQiCi.textAlignment=NSTextAlignmentLeft;
             self.QiCi=CQiCi;
        [self.contentView addSubview:CQiCi];
   
        
        UILabel *CSYFP=[[UILabel alloc]init];
        self.ShouYiDate=CSYFP;
        CSYFP.font=[UIFont systemFontOfSize:12.0];
        CSYFP.textColor=UIColorFromRGB(0x999999);
        CSYFP.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:CSYFP];
        
        
               
        UILabel *CYSBX=[[UILabel alloc]init];
        self.YSBenXi=CYSBX;
        CYSBX.font=[UIFont systemFontOfSize:12.0];
        CYSBX.textColor=UIColorFromRGB(0x3a3836);
        CYSBX.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:CYSBX];
        
                
        UILabel *YSBJ=[[UILabel alloc]init];
         self.YSBenJin=YSBJ;
        YSBJ.font=[UIFont systemFontOfSize:12.0];
        YSBJ.textColor=UIColorFromRGB(0x999999);
        YSBJ.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:YSBJ];
       
                
        
        UILabel *YSLX=[[UILabel alloc]init];
        self.YSLiXi=YSLX;
        YSLX.font=[UIFont systemFontOfSize:12.0];
        YSLX.textColor=UIColorFromRGB(0x3a3836);
        YSLX.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:YSLX];
         
        
        UILabel *CSYBJ=[[UILabel alloc]init];
       self.SYBenJin=CSYBJ;
        CSYBJ.font=[UIFont systemFontOfSize:12.0];
        CSYBJ.textColor=UIColorFromRGB(0x999999);
        CSYBJ.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:CSYBJ];
         
        
//        _title = [[UILabel  alloc] initWithFrame:CGRectZero];
//        [self addSubview:_title];
        [self.QiCi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@20);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            
        }];
        [self.ShouYiDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.left.height.equalTo(self.QiCi);
            make.top.equalTo(self.QiCi.mas_bottom);
            
            
        }];
        [self.YSBenXi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.ShouYiDate);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.QiCi);
            
        }];
        [self.YSBenJin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.YSBenXi);
            
            make.top.equalTo(self.ShouYiDate);
            
        }];
        [ self.YSLiXi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(self.YSBenXi);
            
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }];
        
        [self.SYBenJin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(self.YSBenJin);
            make.right.equalTo(self.YSLiXi);
            
        }];
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=separateLineColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.width.left.equalTo(self);
        }];
        
    }
    return self;
    
}

@end
