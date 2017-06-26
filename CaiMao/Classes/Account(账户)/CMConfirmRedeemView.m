//
//  CMConfirmRedeemView.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMConfirmRedeemView.h"

@implementation CMConfirmRedeemView

-(id)init
{  self=[super init];
    if (self) {
        
        
        self.frame=[UIScreen mainScreen].bounds;
       
       
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
       
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        contentView.center=self.center;
        contentView.bounds=CGRectMake(0, 0, 310,180);
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        
        [contentView addSubview:self.totalMoneyLabel];
        [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.top.equalTo(contentView.mas_top).offset(10);
            make.width.centerX.equalTo(contentView);
        }];
     
        [contentView addSubview:self.MoneyLabel];
        [self.MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.top.equalTo(self.totalMoneyLabel.mas_bottom).offset(15);
            make.left.equalTo(contentView.mas_left).offset(10);
            make.width.mas_equalTo(130);
        }];
        
        [contentView addSubview:self.beginDateLabel];
        [self.beginDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(self.MoneyLabel);

            make.right.equalTo(contentView.mas_right).offset(-10);
            
        }];
        
        UIView *line=[UIView new];
        line.backgroundColor=ViewBackColor;
        [contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.centerX.equalTo(contentView);
            make.top.equalTo(self.beginDateLabel.mas_bottom).offset(10);
        }];
        
        [contentView addSubview:self.JXBeginDateLabel];
        [self.JXBeginDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(self.MoneyLabel);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.width.mas_equalTo(150);
        }];
        
        [contentView addSubview:self.JXDateLabel];
        [self.JXDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.equalTo(self.beginDateLabel);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.width.mas_equalTo(130);
        }];
        
        [contentView addSubview:self.yieldLabel];
        [self.yieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.width.equalTo(self.JXBeginDateLabel);
            make.top.equalTo(self.JXBeginDateLabel.mas_bottom).offset(10);
            
        }];
        
        [contentView addSubview:self.SJGetMoneyTotal];
        [self.SJGetMoneyTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.width.equalTo(self.JXDateLabel);
            make.top.equalTo(self.yieldLabel);
            
        }];
        UIView *kLine=[UIView new];
        kLine.backgroundColor=ViewBackColor;
        [contentView addSubview:kLine];
        [kLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.centerX.equalTo(contentView);
            make.top.equalTo(self.SJGetMoneyTotal.mas_bottom).offset(10);
        }];
        
        
        [contentView addSubview:self.cancleButton];
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(contentView.bounds.size.width/2.0);
            make.top.equalTo(kLine.mas_bottom);
            make.bottom.left.equalTo(contentView);
            
        }];
        [contentView addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(contentView.bounds.size.width/2.0);
            make.top.equalTo(kLine.mas_bottom);
            make.bottom.right.equalTo(contentView);
            
        }];
        
    }
    
    return self;
    
}








#pragma mark Lazy
-(UILabel*)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel=[[UILabel alloc]init];
        _totalMoneyLabel.font=[UIFont systemFontOfSize:13];
        _totalMoneyLabel.textAlignment=NSTextAlignmentCenter;
        _totalMoneyLabel.textColor=RedButtonColor;
        //_totalMoneyLabel.text=@"赎回收益+本金:110元";
    }
    return _totalMoneyLabel;
}
-(UILabel*)MoneyLabel{
    if (!_MoneyLabel) {
        _MoneyLabel=[[UILabel alloc]init];
        _MoneyLabel.font=[UIFont systemFontOfSize:12];
        _MoneyLabel.textAlignment=NSTextAlignmentLeft;
        _MoneyLabel.textColor=UIColorFromRGB(0x8f8e94);
      //  _MoneyLabel.text=@"金额:100000元";
    }
    return _MoneyLabel;
}
-(UILabel*)beginDateLabel{
    if (!_beginDateLabel) {
        _beginDateLabel=[[UILabel alloc]init];
        _beginDateLabel.font=[UIFont systemFontOfSize:12];
        _beginDateLabel.textAlignment=NSTextAlignmentRight;
        _beginDateLabel.textColor=UIColorFromRGB(0x8f8e94);
        //_beginDateLabel.text=@"存入时间:2016/10/10";
    }
    return _beginDateLabel;
}

-(UILabel*)JXBeginDateLabel{
    if (!_JXBeginDateLabel) {
        _JXBeginDateLabel=[[UILabel alloc]init];
        _JXBeginDateLabel.font=[UIFont systemFontOfSize:12];
        _JXBeginDateLabel.textAlignment=NSTextAlignmentLeft;
        _JXBeginDateLabel.textColor=RedButtonColor;
       // _JXBeginDateLabel.text=@"计息开始日期:2016/10/10";
    }
    return _JXBeginDateLabel;
}
-(UILabel*)JXDateLabel{
    if (!_JXDateLabel) {
        _JXDateLabel=[[UILabel alloc]init];
        _JXDateLabel.font=[UIFont systemFontOfSize:12];
        _JXDateLabel.textAlignment=NSTextAlignmentRight;
        _JXDateLabel.textColor=RedButtonColor;
        //_JXDateLabel.text=@"计息天数:30天";
    }
    return _JXDateLabel;
}

-(UILabel*)yieldLabel{
    if (!_yieldLabel) {
        _yieldLabel=[[UILabel alloc]init];
        _yieldLabel.font=[UIFont systemFontOfSize:12];
        _yieldLabel.textAlignment=NSTextAlignmentLeft;
        _yieldLabel.textColor=RedButtonColor;
      //  _yieldLabel.text=@"实际收益率:6.60%";
    }
    return _yieldLabel;
}


-(UILabel*)SJGetMoneyTotal{
    if (!_SJGetMoneyTotal) {
        _SJGetMoneyTotal=[[UILabel alloc]init];
        _SJGetMoneyTotal.font=[UIFont systemFontOfSize:12];
        _SJGetMoneyTotal.textAlignment=NSTextAlignmentRight;
        _SJGetMoneyTotal.textColor=UIColorFromRGB(0x8f8e94);
       // _SJGetMoneyTotal.text=@"收益:10.00元";
    }
    return _SJGetMoneyTotal;
}


-(UIButton*)cancleButton{
    
    if (!_cancleButton) {
        _cancleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_cancleButton setTitleColor:UIColorFromRGB(0x8f8e94) forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton*)confirmButton{
    
    if (!_confirmButton) {
        _confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_confirmButton setTitle:@"确定赎回" forState:UIControlStateNormal];
         [_confirmButton setTitleColor:RedButtonColor forState:UIControlStateNormal];
         [_confirmButton addTarget:self action:@selector(confirmButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}



-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];

    [window addSubview:self];
    
}
-(void)dismissView{
   
    [self removeFromSuperview];
    
}
-(void)confirmButtonEvent{
   // NSLog(@"button+++%@",_orderId);
    if (_orderId!=nil) {
        
    
    [CMRequestHandle AsDepositRedeemButtonEventWithOrderId:_orderId andSuccess:^(id responseObj) {
        
         [CMNSNotice postNotificationName:@"confirmButtonEvent" object:nil];
       // NSLog(@"button+++%@++%@++%@",responseObj,_orderId,[responseObj objectForKey:@"Result"]);
    }];
    }
    
   
    [self dismissView];
    
}

-(void)setOrderId:(NSString*)orderId{
    _orderId=orderId;
    [CMRequestHandle AsDepositRedeemAlertMessageWithOrderId:orderId andSuccess:^(id responseObj) {
       
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSDictionary *dict=[responseObj objectForKey:@"t"];
            self.totalMoneyLabel.text=[NSString stringWithFormat:@"赎回收益+本金:%.2f元",[[dict objectForKey:@"Amount"]floatValue] +[[dict objectForKey:@"Amount_Lx"]floatValue]];
            self.MoneyLabel.text=[NSString stringWithFormat:@"金额:%@元",[dict objectForKey:@"Amount"]];
       
            
            self.beginDateLabel.text=[NSString stringWithFormat:@"存入时间:%@",[dict objectForKey:@"IntoTime"]];
             self.JXBeginDateLabel.text=[NSString stringWithFormat:@"计息开始时间:%@",[dict objectForKey:@"JxDate"]];
             self.JXDateLabel.text=[NSString stringWithFormat:@"计息天数:%@天",[dict objectForKey:@"JxDays"]];
          
            self.yieldLabel.text=[[NSString stringWithFormat:@"实际收益率:%@",[dict objectForKey:@"Syl"]]stringByAppendingString:@"%"];
              self.SJGetMoneyTotal.text=[NSString stringWithFormat:@"收益:%@元",[dict objectForKey:@"Amount_Lx"]];
            [self OtherDoubleAttributedStringFromString:@"赎" andEndString:@":" FromLabel:self.totalMoneyLabel];
            [self OtherDoubleAttributedStringFromString:@"计" andEndString:@":" FromLabel:self.JXDateLabel];
        [self DoubleAttributedStringFromString:@":" andEndString:@"元" FromLabel: self.MoneyLabel];
       
        [self DoubleAttributedStringFromString:@":" andEndString:@"元" FromLabel: self.SJGetMoneyTotal];
        }
        [self OtherDoubleAttributedStringFromString:@"计" andEndString:@":" FromLabel: self.JXDateLabel];
        [self OtherDoubleAttributedStringFromString:@"计" andEndString:@":" FromLabel: self.JXBeginDateLabel];
        [self OtherDoubleAttributedStringFromString:@"实" andEndString:@":" FromLabel: self.yieldLabel];
    }];
}


-(void)DoubleAttributedStringFromString:(NSString*)FromStr andEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    NSRange qiFromRang = [FromLabel.text rangeOfString:FromStr];
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xfa3e19) range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
    FromLabel.attributedText = qixianStr;
    
}


-(void)OtherDoubleAttributedStringFromString:(NSString*)FromStr andEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    NSRange qiFromRang = [FromLabel.text rangeOfString:FromStr];
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x8f8e94) range:NSMakeRange(qiFromRang.location, qiToRang.location - qiFromRang.location+1)];
    FromLabel.attributedText = qixianStr;
    
}

@end
