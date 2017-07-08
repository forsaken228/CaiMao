//
//  CMHeadView.m
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHeadView.h"

@interface CMHeadView ()
@property(nonatomic,strong)NSTimer *progressTimer;

@end


@implementation CMHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 180)];
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
        label.font=[UIFont boldSystemFontOfSize:12.0];
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
        OTabel.font=[UIFont boldSystemFontOfSize:12.0];
        OTabel.textAlignment=NSTextAlignmentCenter;
        OTabel.text=@"累计投资( 元 )";
        [bgView addSubview:OTabel];
        [bgView addSubview:self.LJTZLabel];
        
        [OTabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@13);
            make.left.equalTo(bgView.mas_left).offset(10);
            make.bottom.equalTo(bgView.mas_bottom).offset(-40);
        }];

        [self.LJTZLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@150);
            make.top.equalTo(OTabel.mas_bottom).offset(10);
            make.centerX.equalTo(OTabel);
        }];
        
        

        UILabel *TLabel=[[UILabel alloc]init];
        TLabel.textColor=[UIColor whiteColor];
        TLabel.alpha=0.70;
        TLabel.font=[UIFont boldSystemFontOfSize:12.0];
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
        
    
        
        UIView *bottomView=[[UIView alloc]init];
        bottomView.backgroundColor=UIColorFromRGB(0xfdf9dc);
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.left.equalTo(self);
            make.top.equalTo(bgView.mas_bottom);
        }];
        UIImage *image=[UIImage imageNamed:@"dingqilicaiImage"];
        UIImageView *left=[[UIImageView alloc]init];
        left.image=image ;
        [bottomView addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(image.size.height);
            make.width.mas_equalTo(image.size.width);
            make.centerY.equalTo(bottomView);
            make.left.equalTo(bottomView.mas_left).offset(20);
        }];
        [bottomView addSubview:self.DSTZLabel];
        [self.DSTZLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
            make.left.equalTo(left.mas_right).offset(5);
            make.width.equalTo(@110);
            make.centerY.equalTo(bottomView);
        }];
        
        [bottomView addSubview:self.DSSYLabel];
        [self.DSSYLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
            make.left.equalTo(self.DSTZLabel.mas_right);
            make.width.equalTo(@70);
            make.centerY.equalTo(bottomView);
        }];
        [bottomView addSubview:self.BJLabel];
        [self.BJLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
            make.left.equalTo(self.DSSYLabel.mas_right);
            make.width.equalTo(@100);
            make.centerY.equalTo(bottomView);
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=ViewBackColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.width.equalTo(self);
            make.top.equalTo(bottomView.mas_bottom);
        }];
//        UIView *bottomView_2=[[UIView alloc]init];
//        bottomView_2.backgroundColor=[UIColor whiteColor];
//        [self addSubview:bottomView_2];
//        [bottomView_2 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(line.mas_bottom);
//            make.width.left.equalTo(self);
//            make.height.equalTo(@40);
//        }];
//        
        NSArray *TitleArr=@[@"持有",@"预定",@"结清"];
        for (int i=0; i<TitleArr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i%3*CMScreenW/3.0, 180+30, CMScreenW/3.0, 40);
            self.headButton=btn;
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitle:TitleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            btn.tag=i+10;
            [btn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            if (i==0) {
                self.selectButton=btn;
               btn.selected=YES;
                [btn setTitleColor:RedButtonColor forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            
        }

      self.moveView.frame=CGRectMake(0,self.frame.size.height-2, CMScreenW/3.0, 2) ;
       [self addSubview:_moveView];

        self.circleProgress = [[CMProgressView alloc] initWithFrame:CGRectMake(CMScreenW/2.0-f_i5real(120/2.0), 10, f_i5real(120), f_i5real(120))];
        self.circleProgress.progress = 0.0;
        [self addSubview:self.circleProgress];
        if (self.circleProgress.progress<=0) {
            self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timeLabel) userInfo:nil repeats:YES];
            [self LoadHeadViewData];
        }
        
    }
    
 
    return self;
}
-(void)changeBtnClick:(UIButton*)btn{
    if (self.selectButton==btn) {
        return;
    }
    self.selectButton.selected=NO;
   [self.selectButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    //点击btn
    btn.selected=YES;
    [btn setTitleColor:RedButtonColor forState:UIControlStateSelected];
    self.selectButton=btn;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //小红条
    self.moveView.center=CGPointMake(btn.center.x, self.moveView.center.y);
    //获得点击按钮的标题
    
    [UIView commitAnimations];
    

    
    if ([_delegate respondsToSelector:@selector(addTargetWith:)]) {
        [_delegate addTargetWith:btn.tag];
    }
    
}
-(UIView*)moveView{
    
    if (!_moveView) {
        _moveView=[[UIView alloc]init];
        _moveView.backgroundColor=RedButtonColor;

    }
    return _moveView;
}
-(UILabel*)CYLabel{
    if (!_CYLabel) {
        _CYLabel=[[UILabel alloc]init];
        _CYLabel.textColor=[UIColor whiteColor];
        _CYLabel.font=[UIFont systemFontOfSize:20.0];
        _CYLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _CYLabel;
}

-(UILabel*)LJTZLabel{
    if (!_LJTZLabel) {
        _LJTZLabel=[[UILabel alloc]init];
        _LJTZLabel.textColor=[UIColor whiteColor];
        _LJTZLabel.font=[UIFont boldSystemFontOfSize:18.0];
        _LJTZLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _LJTZLabel;
}
-(UILabel*)LJSYLabel{
    if (!_LJSYLabel) {
        _LJSYLabel=[[UILabel alloc]init];
        _LJSYLabel.textColor=[UIColor whiteColor];
        _LJSYLabel.font=[UIFont boldSystemFontOfSize:18.0];
        _LJSYLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _LJSYLabel;
}
-(UILabel*)DSTZLabel{
    if (!_DSTZLabel) {
        _DSTZLabel=[[UILabel alloc]init];
        _DSTZLabel.textColor=UIColorFromRGB(0xf69220);
        _DSTZLabel.font=[UIFont systemFontOfSize:13.0];
        
    }
    return _DSTZLabel;
}
-(UILabel*)DSSYLabel{
    if (!_DSSYLabel) {
        _DSSYLabel=[[UILabel alloc]init];
        _DSSYLabel.textColor=UIColorFromRGB(0xf69220);
        _DSSYLabel.font=[UIFont systemFontOfSize:13.0];
        
    }
    return _DSSYLabel;
}
-(UILabel*)BJLabel{
    if (!_BJLabel) {
        _BJLabel=[[UILabel alloc]init];
        _BJLabel.textColor=UIColorFromRGB(0xf69220);
        _BJLabel.font=[UIFont systemFontOfSize:13.0];
        
    }
    return _BJLabel;
}
-(void)timeLabel
{   float a;
    a=self.circleProgress.progress;
    a += 0.4;
    self.circleProgress.progress=a;
    if (a >=1) {
        self.circleProgress.progress=1.0;
        [self.progressTimer invalidate];
        self.progressTimer= nil;
        
    }
    
}
-(void)LoadHeadViewData{

        [CMRequestHandle MyIncomeWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
            
          //  NSLog(@"我的理财++++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"]);
            
            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                NSDictionary *MyIncomeDict=[responseObj objectForKey:@"t"];
                NSString *str=[MyIncomeDict objectForKey:@"cyamount"];
                self.LJTZLabel.text=[MyIncomeDict objectForKey:@"tzamount"];
                self.LJSYLabel.text=[NSString stringWithFormat:@"%@",[MyIncomeDict objectForKey:@"syamount"]];
                self.DSTZLabel.text=[NSString stringWithFormat:@"本月投资到期:%@笔",[MyIncomeDict objectForKey:@"bycnt"]];
                self.DSSYLabel.text=[NSString stringWithFormat:@"收益:%@",[MyIncomeDict objectForKey:@"bysy"]];
                self.BJLabel.text=[NSString stringWithFormat:@"本金:%@",[MyIncomeDict objectForKey:@"bybj"]];
                CGRect rectSecond=[  self.DSSYLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
                [ self.DSSYLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(rectSecond.size.width+2);
                }];
                self.CYLabel.text=str;
                CGRect rectSize=[  self.BJLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
                [ self.BJLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(rectSize.size.width+2);
                }];
                
                //                if(str.length>=7){
                //                    head.animateNumber.center=CGPointMake(CMScreenW/2.0+40, f_i5real(80));
                //                }else if(str.length<7){
                //
                //                    head.animateNumber.center=CGPointMake(CMScreenW/2.0+80-(str.length-2)*8, f_i5real(80));
                //                    //                    if([str floatValue]==0){
                //                    //                         head.animateNumber.center=CGPointMake(CMScreenW/2.0+80, 100);
                //                    //                    }
                //
                //                }
                //                head.animateNumber.bounds=CGRectMake(0, 0, 200, 20);
                //                [head.animateNumber setNumbers:[NSString stringWithFormat:@"￥%@",str] animated:YES];
                //
                
            }
            
        }];
    
}





@end
