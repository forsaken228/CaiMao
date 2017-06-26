//
//  CMQQEmailCell.m
//  CaiMao
//
//  Created by WangWei on 16/12/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMQQEmailCell.h"

@implementation CMQQEmailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       [self addSubview:self.headIcon];
        [self addSubview:self.NinCheng];
        [self addSubview:self.EmailNum];
        [self addSubview:self.sendEmailBtn];
        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(9);
            make.centerY.equalTo(self);
            make.height.width.equalTo(@32);
        }];
      
        [self.NinCheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headIcon.mas_right).offset(5);
            make.bottom.equalTo(self.mas_centerY);
            make.height.equalTo(@15);
            make.width.equalTo(@250);
        }];
       
        [self.EmailNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.NinCheng);
            make.top.equalTo(self.mas_centerY).offset(2);
            make.height.equalTo(@12);
            make.width.equalTo(@200);
        }];
        [self.sendEmailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(51/2.0);
            make.width.mas_equalTo(150);
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
//头像

-(UIButton *)headIcon{
    if (!_headIcon) {
        _headIcon=[UIButton buttonWithType:UIButtonTypeCustom];
        _headIcon.layer.cornerRadius=32/2.0;
        _headIcon.layer.masksToBounds=YES;
        _headIcon.titleLabel.font=[UIFont systemFontOfSize:20.0];
        [_headIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_headIcon setBackgroundColor:[self randomColor]];
    }
    return _headIcon;
}


-(UILabel*)NinCheng{
    if (!_NinCheng) {
        _NinCheng=[[UILabel alloc]init];
        _NinCheng.font=[UIFont systemFontOfSize:14.0];
        _NinCheng.textColor=UIColorFromRGB(0x333333);
        
    }
    return _NinCheng;
}

-(UILabel*)EmailNum{
    if (!_EmailNum) {
        _EmailNum=[[UILabel alloc]init];
        _EmailNum.font=[UIFont systemFontOfSize:11.0];
        _EmailNum.textColor=UIColorFromRGB(0x8e8d93);
        
    }
    return _EmailNum;
}
-(UIButton*)sendEmailBtn{
    if (!_sendEmailBtn) {
        _sendEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendEmailBtn setBackgroundColor:RedButtonColor];
        [_sendEmailBtn setTitle:@"免费送好友80元红包" forState:UIControlStateNormal];
        [_sendEmailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendEmailBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        _sendEmailBtn.clipsToBounds=YES;
        _sendEmailBtn.layer.cornerRadius=4.0;
         [_sendEmailBtn addTarget:self action:@selector(InvatieBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendEmailBtn;
}
-(void)InvatieBtnClick{
    if (self.CMQQEmaildelegate) {
        if ([self.CMQQEmaildelegate respondsToSelector:@selector(invationBtnClickWith:)]) {
            [self.CMQQEmaildelegate invationBtnClickWith:self.indexPath];
        }
    }
    
    
}
-(UIColor *) randomColor
{
    
    NSArray *colorArr=@[UIColorFromRGB(0x8355e4),UIColorFromRGB(0x4c79fc),UIColorFromRGB(0xfc793d),UIColorFromRGB(0xfc5e66)];
    
    return colorArr[arc4random()%4];
}
@end
