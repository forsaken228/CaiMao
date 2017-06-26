//
//  CMPersonerMsg.m
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMPersonerMsg.h"

@implementation CMPersonerMsg

-(id)init{
    self=[super init];
    if (self) {
        UILabel *tName=[[UILabel alloc]init];
        tName.text=@"姓名";
        tName.font=[UIFont systemFontOfSize:14.0];
        tName.textColor=UIColorFromRGB(0x333333);
        [self addSubview:tName];
        [tName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@70);
            make.left.equalTo(self.mas_left).offset(20);
            make.height.equalTo(@20);
            make.top.equalTo(self.mas_top).offset(20);
        }];
        
        
        [self addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.height.bottom.equalTo(tName);
            make.left.equalTo(tName.mas_right);
        }];
        
        
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CMScreenW);
            make.left.equalTo(self);
            make.height.equalTo(@0.5);
            make.top.equalTo(tName.mas_bottom).offset(10);
         
        }];
        
        UILabel *tNameID=[[UILabel alloc]init];
        tNameID.text=@"身份证号";
        tNameID.font=[UIFont systemFontOfSize:14.0];
        tNameID.textColor=UIColorFromRGB(0x333333);
        [self addSubview:tNameID];
        [tNameID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(tName);
            make.top.equalTo(line.mas_bottom).offset(10);
        }];
        
        [self addSubview:self.personerID];
        [self.personerID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.width.equalTo(self.userName);
            make.bottom.equalTo(tNameID);
        }];
        
        UILabel *line1=[[UILabel alloc]init];
        line1.backgroundColor=separateLineColor;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(line);
            make.top.equalTo(tNameID.mas_bottom).offset(10);
            
        }];
        UILabel *tBankNum=[[UILabel alloc]init];
        tBankNum.text=@"银行卡号";
        tBankNum.font=[UIFont systemFontOfSize:14.0];
        tBankNum.textColor=UIColorFromRGB(0x333333);
        [self addSubview:tBankNum];
        [tBankNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(tNameID);
            make.top.equalTo(line1.mas_bottom).offset(10);
        }];
        [self addSubview:self.bankID];
        [self.bankID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.width.equalTo(self.userName);
            make.bottom.equalTo(tBankNum);
        }];
        UILabel *line2=[[UILabel alloc]init];
        line2.backgroundColor=separateLineColor;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(line);
            make.top.equalTo(tBankNum.mas_bottom).offset(10);
            
        }];
        
        UILabel *tSFZ=[[UILabel alloc]init];
        tSFZ.text=@"身份证";
        tSFZ.font=[UIFont systemFontOfSize:14.0];
        tSFZ.textColor=UIColorFromRGB(0x333333);
        [self addSubview:tSFZ];
        [tSFZ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(tNameID);
            make.top.equalTo(line2.mas_bottom).offset(10);
        }];
        [self addSubview:self.UpLoadID];
        [self.UpLoadID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(self.userName);
            make.width.mas_equalTo(CMScreenW-100);
            make.bottom.equalTo(tSFZ);
        }];
        UIImage *image=[UIImage imageNamed:@"faceImage"];
        
        [self addSubview:self.FaceImageView];
        
        [self.FaceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.width.mas_equalTo(f_i5real(image.size.width));
            make.right.equalTo(self.mas_centerX).offset(-5);
            make.top.equalTo(tSFZ.mas_bottom).offset(10);
        }];
        [self addSubview:self.backImageView];
        
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.width.mas_equalTo(f_i5real(image.size.width));
            make.left.equalTo(self.mas_centerX).offset(5);
            make.top.equalTo(tSFZ.mas_bottom).offset(10);
        }];
        
        [self addSubview:self.errorLabel];
        
        [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(tSFZ);
            make.width.mas_equalTo(CMScreenW-100);
            make.top.equalTo(self.backImageView.mas_bottom).offset(10);

        }];
        
        [self addSubview:self.nextButton];
        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.errorLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(buttonHeight);
            
        }];
        

        
    }
    return self;
}
-(UITextField*)userName{
    if (!_userName) {
        _userName=[[UITextField alloc]init];
        _userName.userInteractionEnabled=NO;
        _userName.textColor=UIColorFromRGB(0x8e8e93);
        _userName.font=[UIFont systemFontOfSize:12.0];
    }
    return _userName;
}
-(UITextField*)personerID{
    if (!_personerID) {
        _personerID=[[UITextField alloc]init];
        _personerID.userInteractionEnabled=NO;
        _personerID.textColor=UIColorFromRGB(0x8e8e93);
        _personerID.font=[UIFont systemFontOfSize:12.0];
    }
    return _personerID;
}
-(UITextField*)bankID{
    if (!_bankID) {
        _bankID=[[UITextField alloc]init];
       _bankID.placeholder=@"请输入您解绑的银行卡号";
        _bankID.keyboardType=UIKeyboardTypeNumberPad;
        _bankID.textColor=UIColorFromRGB(0x8e8e93);
        _bankID.font=[UIFont systemFontOfSize:12.0];
    }
    return _bankID;
}
-(UITextField*)UpLoadID{
    if (!_UpLoadID) {
        _UpLoadID=[[UITextField alloc]init];
        _UpLoadID.userInteractionEnabled=NO;
        _UpLoadID.text=@"请选择小于2M的jpg/png文件进行上传";
        _UpLoadID.textColor=UIColorFromRGB(0x8e8e93);
        _UpLoadID.font=[UIFont systemFontOfSize:12.0];
    }
    return _UpLoadID;
}
-(UIImageView *)FaceImageView{
    if (!_FaceImageView) {
        _FaceImageView=[[UIImageView alloc]init];
        _FaceImageView.userInteractionEnabled=YES;
        _FaceImageView.image=[UIImage imageNamed:@"faceImage"];
    }
    return _FaceImageView;
}
-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView=[[UIImageView alloc]init];
         _backImageView.userInteractionEnabled=YES;
        _backImageView.image=[UIImage imageNamed:@"backimage"];
    }
    return _backImageView;
}
-(UILabel*)errorLabel{
    if (!_errorLabel) {
        _errorLabel=[[UILabel alloc]init];
        _errorLabel.font=[UIFont systemFontOfSize:12.0];
        _errorLabel.textColor=RedButtonColor;
    }
    return _errorLabel;
}

-(UIButton*)nextButton{
    if (!_nextButton) {
        _nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius=4.0;
        _nextButton.clipsToBounds=YES;
        [_nextButton setBackgroundColor:RedButtonColor];
        [_nextButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
-(void)nextClick{
    
    if ([_delegate respondsToSelector:@selector(goNextView)]) {
        [_delegate goNextView];
    }
}
@end
