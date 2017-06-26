//
//  CMChageFootview.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChageFootview.h"

@implementation CMChageFootview


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor=ViewBackColor;
        //self.backgroundColor=[UIColor redColor];
        [self addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(15);
            make.height.mas_equalTo(13);
            make.left.equalTo(self.mas_left).offset(20);
            make.width.equalTo(@250);
        }];
        
        [self addSubview:self.SureBtn];
        [self.SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(buttonHeight);
          make.left.equalTo(self.mas_left).offset(15);
           make.right.equalTo(self.mas_right).offset(-15);
        }];
        [self addSubview:self.bottomLabel];
       [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.SureBtn.mas_bottom).offset(15);
           make.height.mas_equalTo(13);
           make.left.equalTo(self.SureBtn.mas_left);
           make.right.equalTo(self.SureBtn.mas_right);
        }];
        
    }
    return self;
}

-(UILabel*)topLabel{
    if (!_topLabel) {
        _topLabel=[[UILabel alloc]init];
        _topLabel.font=[UIFont systemFontOfSize:12.0];
        _topLabel.textColor=UIColorFromRGB(0x5a5655);
        _topLabel.text=@"*注:请登录邮箱,获得验证码";
        _topLabel.hidden=YES;
    }
    return _topLabel;
}
-(UIButton*)SureBtn{
    if (!_SureBtn) {
        _SureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_SureBtn setBackgroundColor:RedButtonColor];
        [_SureBtn setTitle:@"确认" forState:UIControlStateNormal];
        _SureBtn.layer.cornerRadius=4.0;
        _SureBtn.clipsToBounds=YES;
        [_SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _SureBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        
        
    }
    return _SureBtn;
}
-(UILabel*)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel=[[UILabel alloc]init];
        _bottomLabel.font=[UIFont systemFontOfSize:11.0];
        _bottomLabel.textColor=UIColorFromRGB(0x5a5655);
        _bottomLabel.text=@"为了您的资金更安全,不要把交易密码和登录密码设置相同!";
        _bottomLabel.textAlignment=NSTextAlignmentCenter;
        _bottomLabel.hidden=YES;

    }
    return _bottomLabel;
}
@end
