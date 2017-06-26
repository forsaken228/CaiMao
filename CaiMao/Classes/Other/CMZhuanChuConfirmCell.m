//
//  CMZhuanChuConfirmCell.m
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuConfirmCell.h"

@implementation CMZhuanChuConfirmCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.amount];
        [self addSubview:self.Zdate];
        [self addSubview:self.JXBegindate];
        [self addSubview:self.JXTotalDate];
        [self addSubview:self.SJShouYi];
        [self addSubview:self.ZZShouYi];
        [self addSubview:self.BeiZhu];
        
        [self.amount  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.equalTo(@100);
            make.top.equalTo(self.mas_top).offset(10);
            
        }];
        
        [self.Zdate  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.amount);
            make.right.equalTo(self.mas_right).offset(-15);
            make.width.equalTo(@150);
    
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.equalTo(self);
            make.top.equalTo(self.amount.mas_bottom).offset(10);
        }];
        
        [self.JXBegindate  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(self.amount);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.width.equalTo(@200);
            
        }];
        
        [self.JXTotalDate  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.JXBegindate);
            make.right.equalTo(self.Zdate);
            make.width.equalTo(@100);
            
        }];
        
        [self.SJShouYi  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(self.amount);
            make.top.equalTo(self.JXBegindate.mas_bottom).offset(10);
            make.width.equalTo(@150);
            
        }];
        
        [self.ZZShouYi  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.equalTo(self.JXTotalDate);
            make.top.equalTo(self.SJShouYi);
            make.width.equalTo(@150);
            
        }];
        
        [self.BeiZhu  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(self.amount);
            make.top.equalTo(self.SJShouYi.mas_bottom).offset(10);
            make.width.equalTo(@250);
            
        }];
        
    }
    
    return self;
    
    
}

-(UILabel*)amount{
    if (!_amount) {
        _amount=[[UILabel alloc]init];
        _amount.textColor=UIColorFromRGB(0x4d4d4d);
        _amount.font=[UIFont systemFontOfSize:13];
        
    }
    
    return _amount;
}

-(UILabel*)Zdate{
    if (!_Zdate) {
        _Zdate=[[UILabel alloc]init];
        _Zdate.textColor=UIColorFromRGB(0x4d4d4d);
        _Zdate.font=[UIFont systemFontOfSize:13];
        _Zdate.textAlignment=NSTextAlignmentRight;
        
    }
    
    return _Zdate;
}

-(UILabel*)JXBegindate{
    if (!_JXBegindate) {
        _JXBegindate=[[UILabel alloc]init];
        _JXBegindate.textColor=UIColorFromRGB(0x8e8d93);
        _JXBegindate.font=[UIFont systemFontOfSize:13];
        _JXBegindate.textAlignment=NSTextAlignmentLeft;
        
    }
    
    return _JXBegindate;
}
-(UILabel*)SJShouYi{
    if (!_SJShouYi) {
        _SJShouYi=[[UILabel alloc]init];
        _SJShouYi.textColor=UIColorFromRGB(0x8e8d93);
        _SJShouYi.font=[UIFont systemFontOfSize:13];
        _SJShouYi.textAlignment=NSTextAlignmentLeft;
        
    }
    
    return _SJShouYi;
}
-(UILabel*)BeiZhu{
    if (!_BeiZhu) {
        _BeiZhu=[[UILabel alloc]init];
        _BeiZhu.textColor=UIColorFromRGB(0x8e8d93);
        _BeiZhu.font=[UIFont systemFontOfSize:13];
        _BeiZhu.textAlignment=NSTextAlignmentLeft;
        
    }
    
    return _BeiZhu;
}

-(UILabel*)JXTotalDate{
    if (!_JXTotalDate) {
        _JXTotalDate=[[UILabel alloc]init];
        _JXTotalDate.textColor=UIColorFromRGB(0x8e8d93);
        _JXTotalDate.font=[UIFont systemFontOfSize:13];
        _JXTotalDate.textAlignment=NSTextAlignmentRight;
        
    }
    
    return _JXTotalDate;
}
-(UILabel*)ZZShouYi{
    if (!_ZZShouYi) {
        _ZZShouYi=[[UILabel alloc]init];
        _ZZShouYi.textColor=UIColorFromRGB(0x8e8d93);
        _ZZShouYi.font=[UIFont systemFontOfSize:13];
        _ZZShouYi.textAlignment=NSTextAlignmentRight;
        
    }
    
    return _ZZShouYi;
}
@end
