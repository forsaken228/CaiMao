//
//  CMDingQiView.m
//  CaiMao
//
//  Created by Fengpj on 15/12/7.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMDingQiView.h"

@implementation CMDingQiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        //self.frame=CGRectMake(0, 0, 260, 185);
        UIImageView *zhiShi=[[UIImageView alloc]init];
        zhiShi.image=[UIImage imageNamed:@"title_mark_icon"];
        [self addSubview:zhiShi];
        [zhiShi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@17);
            make.top.equalTo(self.mas_top).offset(15);
            make.left.equalTo(self.mas_left);

        }];
     
        [self addSubview:self.dingTitle];
        [self.dingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(200);
           make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(zhiShi.mas_right);
            
        }];
      
        UILabel *joinPeople=[[UILabel alloc]init];
       // joinPeople.frame=CGRectMake(185 , 8, 72, 30);
        joinPeople.font=[UIFont systemFontOfSize:13.0];
        joinPeople.textColor=[UIColor lightGrayColor];
        self.dingCanyu=joinPeople;
        [self addSubview:joinPeople];
        [joinPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(70);
            make.centerY.equalTo(self.dingTitle.mas_centerY);
            make.right.equalTo(self.mas_right);
            
        }];
    
        UIImageView *peopleImage=[[UIImageView alloc]init];
    
        peopleImage.image=[UIImage imageNamed:@"product_canyuren.png"];
        [self addSubview:peopleImage];
        [peopleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(12);
            make.centerY.equalTo(self.dingTitle.mas_centerY).offset(-1);
            make.right.equalTo(self.dingCanyu.mas_left).offset(-2);
            
        }];
        
        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];
        //Join.frame=CGRectMake(5, 143, 250, 30);
        [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.dingJoinBtn=Join;
        Join.backgroundColor=RedButtonColor;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.width.equalTo(self.mas_width);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        KDGoalBar *globe=[[KDGoalBar alloc]initWithFrame:CGRectMake(self.bounds.size.width-60, self.center.y-45, 50, 50)];
        globe.backgroundColor=[UIColor whiteColor];
        self.percentView=globe;
        [self addSubview:globe];
   
        
        
        UILabel *shouYiZhi=[[UILabel alloc]init];
        //shouYiZhi.frame=CGRectMake(0 , 41, 64, 58);
        self.dingShouyiZheng=shouYiZhi;
        //self.dingShouyiZheng.textAlignment=NSTextAlignmentRight;
        shouYiZhi.font=[UIFont systemFontOfSize:45.0];
        shouYiZhi.textColor=RedButtonColor;
        [self addSubview:shouYiZhi];
    
            [shouYiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@45);
                make.width.equalTo(@50);
                make.left.equalTo(Join.mas_left);
                make.bottom.equalTo(globe);
            }];
       
        
        UILabel *shouyi=[[UILabel alloc]init];
        //shouyi.frame=CGRectMake(71 , 73, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
            make.width.equalTo(@90);
            make.left.equalTo(shouYiZhi.mas_right);
            make.top.equalTo(shouYiZhi.mas_centerY).offset(5);
        }];
        
        
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
      //  shouYiZhiXiao.frame=CGRectMake(66 , 47, 67, 29);
        self.dingShouyiXiao=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:18];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=RedButtonColor;
        [self addSubview:shouYiZhiXiao];
        [shouYiZhiXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@67);
            make.left.equalTo(shouyi);
            make.bottom.equalTo(shouYiZhi.mas_centerY);
        }];
        
        
        
   
        UILabel *qiXian=[[UILabel alloc]init];
        //qiXian.frame=CGRectMake(10 , 107, 98, 30);
        self.dingQixian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:15.0];
       // qiXian.textAlignment=NSTextAlignmentCenter;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        [qiXian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(98);
            make.left.equalTo(Join);
            make.bottom.equalTo(Join.mas_top).offset(-5);
        }];
        UILabel *jinE=[[UILabel alloc]init];
       // jinE.frame=CGRectMake(172 , 107, 89, 30);
        self.dingJinE=jinE;
        jinE.font=[UIFont systemFontOfSize:15.0];
        jinE.textAlignment=NSTextAlignmentRight;
        jinE.textColor=[UIColor lightGrayColor];
        [self addSubview:jinE];
        [jinE mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(89);
            make.right.equalTo(Join);
            make.bottom.equalTo(Join.mas_top).offset(-5);
        }];

        
    
     
        
    }
    return self;
}
#pragma mark Lazy
-(UILabel*)dingTitle{
    
    if (!_dingTitle) {
        _dingTitle=[[UILabel alloc]init];
        _dingTitle.font=[UIFont systemFontOfSize:13.0];
        
    }
    
    return _dingTitle;
}

-(void)setDingQiBaoList:(CMDingQiBaoList *)DingQiBaoList{
    // 为CMDingQiView属性赋值
    self.dingTitle.text = DingQiBaoList.title;
    self.dingCanyu.text = [NSString stringWithFormat:@"%d人参与",DingQiBaoList.jbcnt];
    CGRect rect=[  self.dingCanyu.text boundingRectWithSize:CGSizeMake(80, 13) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [ self.dingCanyu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];
    
    [NSString LoneAttributedStringEndString:@"人" FromLabel:self.dingCanyu];
    // 设置年收益
    float shouyi = DingQiBaoList.nlv;
    int x = (int)shouyi;
    self.dingShouyiZheng.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        self.dingShouyiXiao.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        self.dingShouyiXiao.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    // 设置期限
    
    if (DingQiBaoList.jkqx_dw == 1) {    // 期限->天
        
        self.dingQixian.text =  [NSString stringWithFormat:@"期限%d天",DingQiBaoList.jkqx];
        [NSString DoubleStringChangeColer: self.dingQixian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (DingQiBaoList.jkqx_dw == 2) { // 期限->月
        
        self.dingQixian.text = [NSString stringWithFormat:@"期限%d个月",DingQiBaoList.jkqx];
        [NSString DoubleStringChangeColer: self.dingQixian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
    } else {                            // 期限->年
        
        self.dingQixian.text = [NSString stringWithFormat:@"期限%d年",DingQiBaoList.jkqx];
        [NSString DoubleStringChangeColer: self.dingQixian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额
    self.dingJinE.text = [NSString stringWithFormat:@"%d元起",DingQiBaoList.cpfe];
    [NSString LoneAttributedStringEndString:@"元" FromLabel:self.dingJinE];
    
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%f",(float)DingQiBaoList.jbfs / DingQiBaoList.zjfs] floatValue];
    
     [self.percentView setPercent:PercentNum * 100 animated:YES];
    // 设置产品是否结束
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *dqDate = [dateFormatter dateFromString:DingQiBaoList.dqtime]; // 格式化到期时间
    
    NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
    
    NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    
    //                dispatch_async(dispatch_get_main_queue(), ^{
    
    
    if (x<10) {
        [self.dingShouyiZheng mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@30);
        }];
    }
    
    if (time <= 0||DingQiBaoList.zjfs * 10 - 1 <= DingQiBaoList.jbfs) {
        [self.dingJoinBtn setTitle:@"已结束" forState:UIControlStateNormal];
        [self.dingJoinBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.dingJoinBtn.userInteractionEnabled = NO;
        
    }
   
    

 
    
}

@end
