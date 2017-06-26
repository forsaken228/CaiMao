//
//  CMChengzhangFootView.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChengzhangFootView.h"

@implementation CMChengzhangFootView

-(instancetype)init{
    self=[super init];
    if (self) {
       
        self.backgroundColor=[UIColor whiteColor];
        UILabel  *line=[[UILabel alloc]init];
        line.backgroundColor=ViewBackColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.width.centerX.equalTo(self);
            make.top.equalTo(self);
        }];
        
        UILabel  *First=[[UILabel alloc]init];
        First.text=@"如何获得成长值?";
        First.font=[UIFont boldSystemFontOfSize:13.5];
        First.textColor=UIColorFromRGB(0x585657);
        [self addSubview:First];
        [First mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.top.equalTo(line.mas_bottom).offset(15);
            make.left.equalTo(self.mas_left).offset(15);
        }];
        
        
        UIView *bgView=[[UIView alloc]init];
        bgView.backgroundColor=CMColor(252, 174, 72);
        bgView.layer.cornerRadius=10.0;
        bgView.layer.masksToBounds=YES;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@260);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(First.mas_bottom).offset(10);
        
        }];
        
        UILabel  *one=[[UILabel alloc]init];
        one.text=@"成长值获取方式";
        one.textColor=[UIColor whiteColor];
        one.font=[UIFont boldSystemFontOfSize:11.0];
        one.numberOfLines=0;
        one.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:one];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.equalTo(bgView.mas_left).offset(5);
            make.top.equalTo(bgView);
            make.width.equalTo(@50);
        }];
        UILabel  *Oline=[[UILabel alloc]init];
        Oline.backgroundColor=CMColor(255, 203, 73);
        [bgView addSubview:Oline];
        [Oline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.width.equalTo(bgView);
            make.bottom.equalTo(one);
        }];

        
        UILabel  *Tline=[[UILabel alloc]init];
        Tline.backgroundColor=CMColor(255, 203, 73);
        [bgView addSubview:Tline];
        [Tline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0.5);
            make.height.top.equalTo(bgView);
            make.left.equalTo(one.mas_right).offset(5);
        }];
        
        UILabel  *Second=[[UILabel alloc]init];
        Second.text=@"获取入口";
        Second.textColor=[UIColor whiteColor];
        Second.font=[UIFont boldSystemFontOfSize:11.0];
        Second.numberOfLines=0;
        Second.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:Second];
        [Second mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.top.equalTo(bgView);
            make.right.equalTo(bgView.mas_right);
            make.width.equalTo(@70);
        }];
        
        UILabel  *Rline=[[UILabel alloc]init];
        Rline.backgroundColor=CMColor(255, 203, 73);
        [bgView addSubview:Rline];
        [Rline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0.5);
            make.height.top.equalTo(bgView);
            make.right.equalTo(Second.mas_left).offset(-5);
        }];

        UILabel  *third=[[UILabel alloc]init];
        third.text=@"获取比例";
        third.textColor=[UIColor whiteColor];
        third.font=[UIFont boldSystemFontOfSize:11.0];
        third.numberOfLines=0;
        third.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:third];
        [third mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.top.equalTo(bgView);
            make.right.equalTo(Rline.mas_right);
            make.left.equalTo(Tline);
        }];
        
        UILabel  *four=[[UILabel alloc]init];
        four.text=@"投资理财收益";
        four.textColor=[UIColor whiteColor];
        four.font=[UIFont boldSystemFontOfSize:11.0];
        four.numberOfLines=0;
        four.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:four];
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(one);
            make.height.equalTo(@125);
            make.top.equalTo(Oline);
           
        }];
        
        UILabel  *OlineB=[[UILabel alloc]init];
        OlineB.backgroundColor=CMColor(255, 203, 73);
        [bgView addSubview:OlineB];
        [OlineB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.width.equalTo(bgView);
            make.bottom.equalTo(four);
        }];
        
        [bgView addSubview:self.TouZiBtn];
        [bgView  addSubview:self.QianDaoBtn];
        [bgView addSubview:self.YaoQingBtn];
        [self.TouZiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(Second);
            make.bottom.top.equalTo(four);
        
        }];
        
        
        
        UILabel  *aFour=[[UILabel alloc]init];
        aFour.text=@"按投资收益累计值:";
        aFour.textColor=[UIColor whiteColor];
        aFour.font=[UIFont boldSystemFontOfSize:11.0];
        [bgView addSubview:aFour];
        [aFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Tline.mas_left).offset(5);
            make.top.equalTo(Oline.mas_top).offset(5);
            make.height.equalTo(@15);
            make.width.equalTo(@100);
            
        }];
        UILabel  *bFour=[[UILabel alloc]init];
        bFour.text=@"成长值=投资收益/10";
        bFour.textColor=[UIColor whiteColor];
        bFour.font=[UIFont boldSystemFontOfSize:11.0];
        [bgView addSubview:bFour];
        [bFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(aFour.mas_left).offset(10);
            make.top.equalTo(aFour.mas_bottom);
            make.height.equalTo(@15);
            make.right.equalTo(Rline.mas_left);
            
        }];
        
        UILabel  *CFour=[[UILabel alloc]init];
        CFour.text=@"举例如下:喵客张先生投资财猫2年来,累计投资收益已达10000元 成长值=10000/10=1000达到我们的VIP1标准,成为财猫VIP1会员。";
        CFour.textColor=[UIColor whiteColor];
        CFour.font=[UIFont systemFontOfSize:10.0];
        CFour.numberOfLines=0;
        CFour.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:CFour];
        [CFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(aFour);
            make.right.equalTo(Rline.mas_left);
            make.top.equalTo(bFour.mas_bottom);
            make.bottom.equalTo(OlineB.mas_top).offset(15);
        }];
        
        
        
        UILabel  *five=[[UILabel alloc]init];
        five.text=@"签到";
        five.textColor=[UIColor whiteColor];
        five.font=[UIFont boldSystemFontOfSize:11.0];
        five.numberOfLines=0;
        five.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:five];
        [five mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(one);
            make.height.equalTo(@50);
            make.top.equalTo(OlineB);
            
        }];
        
        UILabel  *Fline=[[UILabel alloc]init];
        Fline.backgroundColor=CMColor(255, 203, 73);
        [bgView addSubview:Fline];
        [Fline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.width.equalTo(bgView);
            make.bottom.equalTo(five);
        }];

        
        [self.QianDaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(Second);
            make.bottom.top.equalTo(five);
            
        }];
        
        
        UILabel  *Dfive=[[UILabel alloc]init];
        Dfive.text=@"连续签到5日得1个成长值,连续签到30天再送5个成长值。";
        Dfive.textColor=[UIColor whiteColor];
        Dfive.font=[UIFont systemFontOfSize:10.0];
        Dfive.numberOfLines=0;
        Dfive.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:Dfive];
        [Dfive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(aFour);
            make.right.equalTo(Rline.mas_left);
            make.top.equalTo(OlineB.mas_top);
            make.height.equalTo(five);
        }];
        
        
        UILabel  *six=[[UILabel alloc]init];
        six.text=@"邀请好友";
        six.textColor=[UIColor whiteColor];
        six.font=[UIFont boldSystemFontOfSize:11.0];
        six.numberOfLines=0;
        six.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:six];
        [six mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(one);
            make.height.equalTo(@50);
            make.top.equalTo(Fline);
            
        }];
        [self.YaoQingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(Second);
            make.bottom.top.equalTo(six);
            
        }];
        

        UILabel  *DSix=[[UILabel alloc]init];
        DSix.text=@"通过财猫邀请码邀请亲朋好友来赚钱,成功邀请1位的5成长值。";
        DSix.textColor=[UIColor whiteColor];
        DSix.font=[UIFont systemFontOfSize:10.0];
        DSix.numberOfLines=0;
        DSix.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:DSix];
        [DSix mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(aFour);
            make.right.equalTo(Rline.mas_left);
            make.top.equalTo(Fline.mas_top);
            make.height.equalTo(six);
        }];
    }
    
    return self;
}
-(UIButton*)TouZiBtn{
    if (!_TouZiBtn) {
        _TouZiBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_TouZiBtn setTitle:@"立即投资>>" forState:UIControlStateNormal];
        [_TouZiBtn setTitleColor:CMColor(255, 246, 75) forState:UIControlStateNormal];
        _TouZiBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        _TouZiBtn.tag=10;
    }
    return _TouZiBtn;
    
}
-(UIButton*)QianDaoBtn{
    if (!_QianDaoBtn) {
        _QianDaoBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_QianDaoBtn setTitle:@"去签到>>" forState:UIControlStateNormal];
        [_QianDaoBtn setTitleColor:CMColor(255, 246, 75) forState:UIControlStateNormal];
        _QianDaoBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        _QianDaoBtn.tag=11;
    }
    return _QianDaoBtn;
    
}
-(UIButton*)YaoQingBtn{
    if (!_YaoQingBtn) {
        _YaoQingBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_YaoQingBtn setTitle:@"立即邀请>>" forState:UIControlStateNormal];
        [_YaoQingBtn setTitleColor:CMColor(255, 246, 75) forState:UIControlStateNormal];
        _YaoQingBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
         _YaoQingBtn.tag=12;
    }
    return _YaoQingBtn;
    
}
@end
