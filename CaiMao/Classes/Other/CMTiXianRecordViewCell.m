//
//  CMTiXianRecordViewCell.m
//  CaiMao
//
//  Created by MAC on 16/6/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTiXianRecordViewCell.h"

@implementation CMTiXianRecordViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self addSubview:self.tDdateLabel];
        [self.tDdateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.mas_top).offset(8);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
            
        }];
        
      //提现金额
        [self addSubview:self.tTiXianLabel];
        [self.tTiXianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.height.mas_equalTo(13);
            make.width.equalTo(self.tDdateLabel);
            
        }];
        
        //手续费
        [self addSubview:self.tChargeLabel];
        
        [self.tChargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self.tDdateLabel);
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(65);
            
        }];
       
   
        [self addSubview:self.tShouXuLabel];
        
        [self.tShouXuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tChargeLabel);
             make.bottom.height.equalTo(self.tTiXianLabel);
            make.width.equalTo(@50);
            
        }];
        
  
        [self addSubview:self.tStateButton];
        
        [self.tStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(self.tDdateLabel);
            make.height.mas_equalTo(20);
            make.width.equalTo(@80);
            
        }];
        
        //提现实际费用
        
        [self addSubview:self.tStateMoneyLabel];
        [self.tStateMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tStateButton);
            make.bottom.height.equalTo(self.tTiXianLabel);
            make.width.equalTo(@80);
            
        }];
        
     
    }
    return  self;
}
-(UILabel*)tDdateLabel{
    if (!_tDdateLabel) {
        _tDdateLabel=[[UILabel alloc]init];
        _tDdateLabel.font=[UIFont boldSystemFontOfSize:13];
        _tDdateLabel.textAlignment=NSTextAlignmentCenter;
        _tDdateLabel.textColor=CMColor(180, 180, 180);
        
    }
    
    return _tDdateLabel;
    
}
-(UILabel*)tTiXianLabel{
    if (!_tTiXianLabel) {
      _tTiXianLabel=[[UILabel alloc]init];
        _tTiXianLabel.textAlignment=NSTextAlignmentCenter;
        _tTiXianLabel.font=[UIFont boldSystemFontOfSize:14];
        _tTiXianLabel.textColor=CMColor(26, 26, 26);
 
    }
    return _tTiXianLabel;
}
-(UILabel *)tChargeLabel{
    if (!_tChargeLabel) {
       _tChargeLabel=[[UILabel alloc]init];
        _tChargeLabel.textAlignment=NSTextAlignmentCenter;
        _tChargeLabel.numberOfLines=0;
        _tChargeLabel.font=[UIFont boldSystemFontOfSize:13];
        _tChargeLabel.textColor=CMColor(180, 180, 180);
        _tChargeLabel.text=@"手续费(元)";
        
        
    }
    return _tChargeLabel;
}

-(UILabel*)tShouXuLabel{
    if (!_tShouXuLabel) {
        _tShouXuLabel=[[UILabel alloc]init];
        _tShouXuLabel.textAlignment=NSTextAlignmentCenter;
        _tShouXuLabel.font=[UIFont boldSystemFontOfSize:14];
        _tShouXuLabel.textColor=CMColor(26, 26, 26);
        
    }
    return _tShouXuLabel;
}
-(UIButton*)tStateButton{
    if (!_tStateButton) {
        _tStateButton=[UIButton buttonWithType:UIButtonTypeCustom];
      
        [_tStateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _tStateButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        _tStateButton.titleLabel.font=[UIFont systemFontOfSize:13];
 
    }
    return _tStateButton;
}
-(UILabel*)tStateMoneyLabel{
    if (!_tStateMoneyLabel) {
        _tStateMoneyLabel=[[UILabel alloc]init];
        _tStateMoneyLabel.textAlignment=NSTextAlignmentRight;
        _tStateMoneyLabel.font=[UIFont boldSystemFontOfSize:13];
        _tStateMoneyLabel.textColor=CMColor(26, 26, 26);
        
    }
    return _tStateMoneyLabel;
}


@end
