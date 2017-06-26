//
//  CMAccountDespositTopView.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespositTopView.h"

@implementation CMAccountDespositTopView

-(instancetype)init{
    self=[super init];
    if (self) {
        
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
        bgView.backgroundColor=RedButtonColor;
        [self addSubview:bgView];
        
        [bgView addSubview:self.CYLabel];
        [self.CYLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(bgView);
            make.centerX.equalTo(bgView);
            make.bottom.equalTo(bgView.mas_centerY);
        }];
        
        
        UILabel *label=[[UILabel alloc]init];
        label.textColor=[UIColor whiteColor];
        label.alpha=0.70;
        label.font=[UIFont boldSystemFontOfSize:13.0];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"持有( 元 )";
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@13);
            make.centerX.equalTo(bgView);
            make.bottom.equalTo(self.CYLabel.mas_top).offset(-10);
        }];
        UILabel *OTabel=[[UILabel alloc]init];
        OTabel.textColor=[UIColor whiteColor];
        OTabel.alpha=0.70;
        OTabel.font=[UIFont boldSystemFontOfSize:13.0];
        OTabel.textAlignment=NSTextAlignmentCenter;
        OTabel.text=@"累计投资( 元 )";
        [bgView addSubview:OTabel];
        [OTabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@13);
            make.left.equalTo(bgView.mas_left).offset(10);
            make.bottom.equalTo(bgView.mas_bottom).offset(-50);
        }];
        [bgView addSubview:self.LJTZLabel];
        [self.LJTZLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@150);
            make.top.equalTo(OTabel.mas_bottom).offset(10);
            make.centerX.equalTo(OTabel);
        }];
        
        
        
        UILabel *TLabel=[[UILabel alloc]init];
        TLabel.textColor=[UIColor whiteColor];
        TLabel.alpha=0.70;
        TLabel.font=[UIFont boldSystemFontOfSize:13.0];
        TLabel.textAlignment=NSTextAlignmentCenter;
        TLabel.text=@"累计收益( 元 )";
        [bgView addSubview:TLabel];
        [TLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.width.height.equalTo(OTabel);
            make.right.equalTo(bgView.mas_right).offset(-10);
        }];
        [bgView addSubview:self.LJSYLabel];
        [self.LJSYLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.height.width.equalTo(self.LJTZLabel);
            make.centerX.equalTo(TLabel);
        }];

        
        self.circleProgress = [[CMProgressView alloc] initWithFrame:CGRectMake(CMScreenW/2.0-f_i5real(145/2.0), 10, f_i5real(145), f_i5real(145))];
        self.circleProgress.progress = 0.0;
        [self addSubview:self.circleProgress];
        
         if (self.circleProgress.progress<=0) {
       self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timeLabel) userInfo:nil repeats:YES];
        
         }
        [self Loaddata];
       
    }
    
    return self;
}
-(void)timeLabel{
    float a;
        a=self.circleProgress.progress;
        a += 0.4;
        self.circleProgress.progress=a;
        if (a >=1) {
            self.circleProgress.progress=1.0;
            [self.progressTimer  invalidate];
            self.progressTimer = nil;
            
        }

}
-(UILabel*)CYLabel{
    if (!_CYLabel) {
        _CYLabel=[[UILabel alloc]init];
        _CYLabel.textColor=[UIColor whiteColor];
        _CYLabel.font=[UIFont systemFontOfSize:20.0];
        _CYLabel.textAlignment=NSTextAlignmentCenter;
       _CYLabel.text=@"0.00";
    }
    return _CYLabel;
}

-(UILabel*)LJTZLabel{
    if (!_LJTZLabel) {
        
        _LJTZLabel=[[UILabel alloc]init];
        _LJTZLabel.textColor=[UIColor whiteColor];
        _LJTZLabel.font=[UIFont boldSystemFontOfSize:18.0];
        _LJTZLabel.textAlignment=NSTextAlignmentCenter;
        _LJTZLabel.text=@"0.00";
    }
    return _LJTZLabel;
}
-(UILabel*)LJSYLabel{
    if (!_LJSYLabel) {
        
        _LJSYLabel=[[UILabel alloc]init];
        _LJSYLabel.textColor=[UIColor whiteColor];
        _LJSYLabel.font=[UIFont boldSystemFontOfSize:18.0];
        _LJSYLabel.textAlignment=NSTextAlignmentCenter;
        _LJSYLabel.text=@"0.00";
    }
    return _LJSYLabel;
}

-(void)Loaddata{
    [CMRequestHandle getAsDepositTotalearningsSuccess:^(id responseObj) {
        
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
             CMAsDespositEarnModel *EarnModel=[CMAsDespositEarnModel objectWithKeyValues:[responseObj objectForKey:@"t"]];
            self.CYLabel.text=[NSString stringWithFormat:@"%.2f",EarnModel.Amount_ChiYou];
            self.LJSYLabel.text=[NSString stringWithFormat:@"%.2f",EarnModel.Amount_LiXi];
            self.LJTZLabel.text=[NSString stringWithFormat:@"%.2f",EarnModel.Amount_LeiJi];
            
            
        //  NSLog(@"dataArr+++%@",responseObj);
            
            
        }
    }];
    
    
}
@end
