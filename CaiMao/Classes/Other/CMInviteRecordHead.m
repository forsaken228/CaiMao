//
//  CMInviteRecordHead.m
//  CaiMao
//
//  Created by MAC on 16/8/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMInviteRecordHead.h"

@implementation CMInviteRecordHead

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        UIView *bgImage=[[UIView alloc]init];
        bgImage.userInteractionEnabled=YES;
        bgImage.backgroundColor=CMColor(253, 180, 80);
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@150);
            make.width.top.left.equalTo(self);
            
        }];
        UILabel *Yqing=[[UILabel alloc]init];
        Yqing.text=@"邀请总奖励(元)";
        Yqing.font=[UIFont systemFontOfSize:15.0];
        Yqing.textColor=[UIColor whiteColor];
        Yqing.textAlignment=NSTextAlignmentCenter;
        [bgImage addSubview:Yqing];
        [Yqing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@200);
            make.top.equalTo(bgImage.mas_top).offset(20);
            make.centerX.equalTo(bgImage.mas_centerX);
                
        }];
    
        
        [bgImage addSubview:self.QYQing];
        [self.QYQing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Yqing);
            make.height.equalTo(@25);
            make.width.equalTo(@80);
            make.right.equalTo(bgImage.mas_right);
        }];
        
   
        
        [bgImage addSubview:self.jLJE];
        [self.jLJE mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@200);
            make.top.equalTo(Yqing.mas_bottom).offset(5);
            make.centerX.equalTo(bgImage.mas_centerX);
            
        }];
        UILabel *line=[UILabel new];
        line.backgroundColor=CMColor(248, 205, 35);
        [bgImage addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(bgImage);
            make.height.equalTo(@0.5);
            make.top.equalTo(self.jLJE.mas_bottom).offset(10);
        }];
       
        UILabel *ShuLine=[UILabel new];
        ShuLine.backgroundColor=CMColor(248, 205, 35);
        [bgImage addSubview:ShuLine];
        [ShuLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgImage.mas_centerX);
            make.height.equalTo(@30);
            make.width.equalTo(@0.5);
            make.top.equalTo(line.mas_bottom).offset(10);
        }];
        
       
        [bgImage addSubview:self.ZCRS];
        [self.ZCRS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.mas_equalTo(self.bounds.size.width/2.0);
            make.right.equalTo(ShuLine.mas_left);
            make.top.equalTo(ShuLine.mas_top).offset(5);
            
        }];
       
        [bgImage addSubview:self.TZRS];
        [self.TZRS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.mas_equalTo(self.bounds.size.width/2.0);
            make.left.equalTo(ShuLine.mas_right);
            make.top.equalTo(ShuLine.mas_top).offset(5);
            
        }];
        
        UIButton *moring=[UIButton buttonWithType:UIButtonTypeCustom];
        moring.titleLabel.font=[UIFont systemFontOfSize:15];
        //[moring setTitle:@"早场9:00开始" forState:UIControlStateNormal];
        [moring setTitle:@"已邀请的好友" forState:UIControlStateNormal];
        [moring setTitleColor:CMColor(115, 116, 117) forState:UIControlStateNormal];
        moring.tag=10;
        self.selectButton=moring;
        self.selectButton.selected=YES;
        [moring addTarget:self action:@selector(inviteFriend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moring];
        [moring mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.mas_equalTo(self.bounds.size.width/2.0);
            make.left.equalTo(self.mas_left);
            make.top.equalTo(bgImage.mas_bottom).offset(10);
        }];
        

        
        UIButton *night=[UIButton buttonWithType:UIButtonTypeCustom];
        night.frame=CGRectMake(CMScreenW/2.0, 38+200, CMScreenW/2.0, 35);
        night.titleLabel.font=[UIFont systemFontOfSize:15];
        [night setTitle:@"奖励明细" forState:UIControlStateNormal];
        [night setTitleColor:CMColor(115, 116, 117) forState:UIControlStateNormal];
        night.tag=11;
        [night addTarget:self action:@selector(inviteFriend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:night];
        [night mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.mas_equalTo(self.bounds.size.width/2.0);
            make.right.equalTo(self);
            make.top.equalTo(bgImage.mas_bottom).offset(10);
        }];
     

        [self addSubview:self.redView];

        [self loadAuccountUpdate];
     }
    return self;
}
#pragma mark Lazy
-(UIButton*)QYQing{
    
    if (!_QYQing) {
        
        _QYQing=[UIButton buttonWithType:UIButtonTypeSystem];
        [_QYQing setBackgroundImage:[UIImage imageNamed:@"goInvite"] forState:UIControlStateNormal];

        
    }
    return _QYQing;
    
}
-(UILabel*)jLJE{
    if(!_jLJE){
        
        _jLJE=[[UILabel alloc]init];
        _jLJE.textAlignment=NSTextAlignmentCenter;
        _jLJE.font=[UIFont systemFontOfSize:30.0];
        _jLJE.textColor=[UIColor whiteColor];
        
    }
    return _jLJE;
}


-(UILabel*)ZCRS{
    if(!_ZCRS){
        
        _ZCRS=[[UILabel alloc]init];
        _ZCRS.textAlignment=NSTextAlignmentCenter;
        _ZCRS.font=[UIFont systemFontOfSize:15.0];
        _ZCRS.textColor=[UIColor whiteColor];
        
    }
    return _ZCRS;
}
-(UILabel*)TZRS{
    if(!_TZRS){
        
        _TZRS=[[UILabel alloc]init];
        _TZRS.textAlignment=NSTextAlignmentCenter;
        _TZRS.font=[UIFont systemFontOfSize:15.0];
        _TZRS.textColor=[UIColor whiteColor];
        
    }
    return _TZRS;
}
-(UIView*)redView{
    if (!_redView) {
       _redView=[[UIView alloc]init];
        _redView.frame=CGRectMake(0, 189, CMScreenW/2.0, 2);
        _redView.backgroundColor=RedButtonColor;
    }
    return _redView;
}
-(void)inviteFriend:(UIButton*)sender{
    
    if (self.selectButton==sender) {
        return;
        
    }
    self.selectButton.selected=NO;
    [self.selectButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    //点击btn
    sender.selected=YES;
    [sender setTitleColor:RedButtonColor forState:UIControlStateSelected];
    self.selectButton=sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.redView.center=CGPointMake(sender.center.x, self.redView.center.y);
    [UIView commitAnimations];
    if ([self.delegate respondsToSelector:@selector(inviteFriendListWithIndex:)]) {
        [self.delegate inviteFriendListWithIndex:sender.tag];
    }
   
}

#pragma mark 加载数据
-(void)loadAuccountUpdate{
 

    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=4",OnLineCode];
 
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"]};
   
    [CMHttpTool postWithURL:urlStr params:dict success:^(id responseObj) {
        
            
      
        self.jLJE.text=[NSString stringWithFormat:@"￥%.2f",[[responseObj objectForKey:@"AllAmount"]floatValue]];
        self.ZCRS.text=[NSString stringWithFormat:@"注册人数:%d人",[[responseObj objectForKey:@"BeInvitedCount"]intValue]];
        self.TZRS.text=[NSString stringWithFormat:@"投资人数:%d人",[[responseObj objectForKey:@"InvestCount"]intValue]];
     
        
    } failure:^(NSError *error) {
      
    }];
    
    
}


@end
