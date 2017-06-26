//
//  CMXinKeCell.m
//  CaiMao
//
//  Created by Fengpj on 16/1/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMXinKeCell.h"

@implementation CMXinKeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
//        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 175);
//
        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];
        //Join.frame=CGRectMake(11, 112, 300, 30);
        [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.xinPaiBtn=Join;
        Join.backgroundColor=RedButtonColor;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            
        }];
        

        
        
        [self addSubview:self.xinTitle];
        [self.xinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(10);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(200);
            
        }];
        

       
        [self addSubview:self.xinShouZheng];
        [self.xinShouZheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@45);
            make.left.equalTo(Join);
            make.centerY.equalTo(self.mas_centerY).offset(-5);
            
        }];
        
        
   
        [self addSubview:self.xinShouXiao];
        [self.xinShouXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.height.equalTo(@22);
            make.bottom.equalTo(self.xinShouZheng.mas_centerY);
            make.left.equalTo(self.xinShouZheng.mas_right);
            
        }];
        
        UILabel *shouyi=[[UILabel alloc]init];
        //shouyi.frame=CGRectMake(72 , 76, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@90);
            make.height.equalTo(@20);
            make.top.equalTo(self.xinShouZheng.mas_centerY);
            make.left.equalTo(self.xinShouXiao);
            
        }];
        
        
        
        
       
        [self addSubview:self.xinQiTou];
        [self.xinQiTou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@80);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.xinShouZheng);
        }];
        
        UILabel *qiXian=[[UILabel alloc]init];
        //qiXian.frame=CGRectMake(117 , 50, 80, 21);
        self.xinQiXian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:13.0];
        qiXian.textAlignment=NSTextAlignmentRight;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        [qiXian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.height.width.equalTo(self.xinQiTou);
            make.bottom.equalTo(self.xinQiTou.mas_top).offset(-5);
        }];
        

        UILabel *qiShou=[[UILabel alloc]init];
       // qiShou.frame=CGRectMake(117 , 50, 80, 21);
        self.xinQiShou=qiShou;
        qiShou.font=[UIFont systemFontOfSize:12.0];
        //qiShou.textAlignment=NSTextAlignmentCenter;
        qiShou.textColor=[UIColor lightGrayColor];
        [self addSubview:qiShou];
        [qiShou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouyi.mas_right);
            make.bottom.width.height.equalTo(shouyi);
        }];
        
        
        
        
        
    }
    return self;
}
#pragma mark lazy

-(UILabel*)xinTitle{
    
    if (!_xinTitle) {
        _xinTitle=[[UILabel alloc]init];
        _xinTitle.font=[UIFont systemFontOfSize:15.0];

    }
    return _xinTitle;
}

-(UILabel*)xinShouZheng{
    if (!_xinShouZheng) {
        _xinShouZheng=[[UILabel alloc]init];
        _xinShouZheng.font=[UIFont systemFontOfSize:45.0];
        _xinShouZheng.textAlignment=NSTextAlignmentRight;
        _xinShouZheng.textColor=RedButtonColor;
        
    }
    return _xinShouZheng;
}
-(UILabel*)xinShouXiao{
    if (!_xinShouXiao) {
        _xinShouXiao=[[UILabel alloc]init];
        _xinShouXiao.font=[UIFont systemFontOfSize:18];
        _xinShouXiao.textAlignment=NSTextAlignmentLeft;
        _xinShouXiao.textColor=RedButtonColor;
    }
    return _xinShouXiao;
}
-(UILabel*)xinQiTou{
    if (!_xinQiTou) {
        _xinQiTou=[[UILabel alloc]init];
        _xinQiTou.font=[UIFont systemFontOfSize:13.0];
        _xinQiTou.textAlignment=NSTextAlignmentRight;
        _xinQiTou.textColor=[UIColor lightGrayColor];
    }
    return _xinQiTou;
}
-(void)setList:(CMXinKeList *)list{
    
    // 为CMXinKeCell属性赋值
    self.xinTitle.text = list.title;
    
    // 设置年收益
    float shouyi = list.nlv_max;
    int x = (int)shouyi;
    self.xinShouZheng.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        self.xinShouXiao.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        self.xinShouXiao.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    // 设置起始收益
    //NSString *qiShou = [NSString string];
    NSString *qiShou= [[NSString stringWithFormat:@"%.2f",list.nlv] stringByAppendingString:@"%"];
    NSMutableAttributedString *qiShouStr = [[NSMutableAttributedString alloc] initWithString:qiShou];
    
    [qiShouStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, qiShou.length)];
    self.xinQiShou.attributedText = qiShouStr;
    
    // 设置期限
    // NSString *qiStr = [NSString string];
    
    if (list.jkqx_dw == 1) {    // 期限->天
        
        self.xinQiXian.text= [NSString stringWithFormat:@"期限%d天",list.jkqx];
        [NSString DoubleStringChangeColer:self.xinQiXian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        self.xinQiXian.text=[NSString stringWithFormat:@"期限%d个月",list.jkqx];
        [NSString DoubleStringChangeColer:self.xinQiXian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        self.xinQiXian.text=[NSString stringWithFormat:@"期限%d年",list.jkqx];
        [NSString DoubleStringChangeColer:self.xinQiXian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额
    
    self.xinQiTou.text = [NSString stringWithFormat:@"%d元起",list.cpfe];
    [NSString LoneAttributedStringEndString:@"元" FromLabel:self.xinQiTou];
  
    
    
}
@end
