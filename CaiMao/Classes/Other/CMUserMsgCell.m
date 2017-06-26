//
//  CMUserMsgCell.m
//  CaiMao
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMUserMsgCell.h"

@implementation CMUserMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        UIView *line1=[[UIView alloc]init];
        //line1.frame=CGRectMake(18, 68, 294, 1);
        line1.backgroundColor=separateLineColor;
        [self  addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(65);
            make.height.mas_equalTo(1);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        UILabel *name=[[UILabel alloc]init];
        //name.frame=CGRectMake(19 , 32 ,66,30 );
        name.font=[UIFont systemFontOfSize:13];
        name.text=@"真实姓名:";
        [self addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line1.mas_left);
            make.bottom.equalTo(line1.mas_top).offset(-5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(66);
            
        }];
        
        UITextField *tName=[[UITextField alloc]init];
        //tName.frame=CGRectMake(87, 33, 171, 30);
        tName.borderStyle=UITextBorderStyleNone;
        tName.font=[UIFont systemFontOfSize:13];
        self.realName=tName;
        tName.keyboardType=UIKeyboardTypeNamePhonePad;
        tName.placeholder=@"请填写您的真实姓名";
        [self addSubview:tName];
        [tName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(name);
            make.width.mas_equalTo(170);
            make.left.equalTo(name.mas_right).offset(5);
           
        }];
        UIButton *nameDetail=[UIButton buttonWithType:UIButtonTypeSystem];
        self.NameDetail=nameDetail;
        //nameDetail.frame=CGRectMake(281, 42, 20, 20);
        [nameDetail setBackgroundImage:[UIImage imageNamed:@"detail_normal"] forState:UIControlStateNormal];
        [self addSubview:nameDetail];
        [nameDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@20);
           
            make.right.equalTo(line1.mas_right).offset(-5);
            make.bottom.equalTo(name.mas_bottom);
            
        }];
        
        
        
        
        UILabel *ID=[[UILabel alloc]init];
        //ID.frame=CGRectMake(19 , 70 ,66,30 );
        ID.font=[UIFont systemFontOfSize:13];
        ID.text=@"身份证号:";
        [self addSubview:ID];
        [ID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(name);
            make.top.equalTo(line1.mas_bottom).offset(5);
          
            
        }];
        
        UITextField *tId=[[UITextField alloc]init];
        //tId.frame=CGRectMake(87, 70, 202, 30);
        tId.borderStyle=UITextBorderStyleNone;
        tId.font=[UIFont systemFontOfSize:13];
        tId.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        self.realNameId=tId;
        tId.placeholder=@"请填写您的真实身份证号";
        [self addSubview:tId];
        [tId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(ID);
            make.width.mas_equalTo(202);
            make.left.equalTo(ID.mas_right).offset(5);
            
        }];
        
   
      
        UIView *line2=[[UIView alloc]init];
       //line2.frame=CGRectMake(18, 106, 294, 1);
        line2.backgroundColor=separateLineColor;
        [self  addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.width.equalTo(line1);
            make.top.equalTo(ID.mas_bottom).offset(5);
       
        }];
        
        
        UILabel *bankID=[[UILabel alloc]init];
       // bankID.frame=CGRectMake(19 , 110 ,66,30 );
        bankID.font=[UIFont systemFontOfSize:13];
        bankID.text=@"银行卡号:";
        [self addSubview:bankID];
        [bankID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(name);
            make.top.equalTo(line2.mas_bottom).offset(5);
            
            
        }];
        
        
        
        UITextField *tBankId=[[UITextField alloc]init];
        //tBankId.frame=CGRectMake(87, 110, 191, 30);
        tBankId.borderStyle=UITextBorderStyleNone;
        tBankId.font=[UIFont systemFontOfSize:13];
        tBankId.keyboardType=UIKeyboardTypeNumberPad;
        self.tBankNum=tBankId;
        tBankId.placeholder=@"请填写您的银行卡号";
        [self addSubview:tBankId];
        [tBankId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(bankID);
            make.width.mas_equalTo(190);
            make.left.equalTo(bankID.mas_right).offset(5);
            
        }];
      
       
        UIButton *tBankDetail=[UIButton buttonWithType:UIButtonTypeSystem];
        self.bankDetail=tBankDetail;
        //tBankDetail.frame=CGRectMake(281, 117, 20, 20);
        [tBankDetail setBackgroundImage:[UIImage imageNamed:@"detail_normal"] forState:UIControlStateNormal];
        [self addSubview:tBankDetail];
        [tBankDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@20);
            
            make.right.equalTo(line1.mas_right).offset(-5);
            make.bottom.equalTo(bankID.mas_bottom);
            
        }];
        
        
        
        UIView *line3=[[UIView alloc]init];
        //line3.frame=CGRectMake(18, 145, 294, 1);
        line3.backgroundColor=separateLineColor;
        [self  addSubview:line3];
        
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.width.equalTo(line2);
            make.top.equalTo(bankID.mas_bottom).offset(5);
            
        }];

        UILabel *error=[[UILabel alloc]init];
        self.errorLabel=error;
       // error.frame=CGRectMake(48 , 155 ,219,26 );
        error.font=[UIFont systemFontOfSize:13];
        error.textColor=RedButtonColor;
        [self addSubview:error];
        [error mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@220);
            make.height.mas_equalTo(26);
            make.top.equalTo(line3.mas_bottom).offset(5);
            make.left.equalTo(bankID);
            
        }];
        
        
        
        UIButton *join=[UIButton buttonWithType:UIButtonTypeSystem];
        self.joinMakeSure=join;
        //join.frame=CGRectMake(45, 196, 235, 30);
        [join setTitle:@"立即认证" forState:UIControlStateNormal];
        [join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [join setBackgroundColor:RedButtonColor];
        join.layer.cornerRadius=5.0;
        join.clipsToBounds=YES;
        [self addSubview:join];
        [join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(235);
            make.top.equalTo(error.mas_bottom).offset(5);
            
        }];
        
       
        UIImageView *horn=[[UIImageView alloc]init];
        //horn.frame=CGRectMake(18, 264, 15, 15);
        horn.image=[UIImage imageNamed:@"renzheng_tixing_icon"];
        [self addSubview:horn];
        [horn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(18);
            make.height.width.mas_equalTo(15);
            make.top.equalTo(join.mas_bottom).offset(30);
            
        }];
        
        
        UILabel *tiShi=[[UILabel alloc]init];
        //tiShi.frame=CGRectMake(41 , 261 ,69,21 );
        tiShi.text=@"温馨提示";
        tiShi.font=[UIFont systemFontOfSize:13];
        tiShi.textColor=RedButtonColor;
        [self addSubview:tiShi];
        [tiShi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(horn.mas_right).offset(5);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(69);
            make.bottom.equalTo(horn.mas_bottom).offset(2);
            
        }];
        

        
        UILabel *content=[[UILabel alloc]init];
       // content.frame=CGRectMake(41 , 295 ,170,21 );
        content.font=[UIFont systemFontOfSize:12];
        content.textColor=[UIColor lightGrayColor];
        content.text=@"(1)只能绑定本人名下的储蓄卡";
        [self addSubview:content];
        
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tiShi.mas_left);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(170);
            make.top.equalTo(horn.mas_bottom).offset(5);
            
        }];
        
        UIButton *support=[UIButton buttonWithType:UIButtonTypeSystem];
        self.supportBank=support;
        //support.frame=CGRectMake(183, 291, 97, 30);
        [support setTitle:@"支持35家银行>>" forState:UIControlStateNormal];
        support.titleLabel.font=[UIFont systemFontOfSize:12.0f];
        [support setTitleColor:CMColor(243, 82, 33) forState:UIControlStateNormal];
        
        [self addSubview:support];
        
        [support mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content.mas_right);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(97);
            make.bottom.equalTo(content);
            
        }];
        
        UILabel *content1=[[UILabel alloc]init];
        //content1.frame=CGRectMake(41 ,321,259,30 );
        content1.font=[UIFont systemFontOfSize:12];
        content1.textColor=[UIColor lightGrayColor];
        content1.numberOfLines=0;
        content1.text=@"(2)该卡作为您充值和提现的唯一银行卡,且绑定后不能修改";
        [self addSubview:content1];
        
        [content1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(content.mas_bottom);
            
        }];
        
        UILabel *content2=[[UILabel alloc]init];
        //content2.frame=CGRectMake(41 ,355,259,30 );
        content2.font=[UIFont systemFontOfSize:12];
        content2.textColor=[UIColor lightGrayColor];
        content2.numberOfLines=0;
        content2.text=@"(3)请确保您填写的以下信息真实有效,否侧充值和提现无法成功";
        [self addSubview:content2];
        [content2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(content1.mas_bottom);
            
        }];
        
        UILabel *content3=[[UILabel alloc]init];
       // content3.frame=CGRectMake(41 ,393,259,45);
        content3.font=[UIFont systemFontOfSize:12];
        content3.textColor=[UIColor lightGrayColor];
        content3.numberOfLines=0;
        content3.text=@"(4)需要验证您的身份信息、卡号和预留手机号的一致性,认证过程中会扣款1元,成功后1元返回至您的账户余额";
        [self addSubview:content3];
        [content3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content);
            make.height.mas_equalTo(45);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(content2.mas_bottom);
            
        }];
      
        
        
        
        
        
    }
    return self;
}

@end
