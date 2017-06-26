//
//  CMTIXianFootView.m
//  CaiMao
//
//  Created by MAC on 16/7/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTIXianFootView.h"

@implementation CMTIXianFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView*)creatTiXianFootView{
    
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
    bgView.backgroundColor=ViewBackColor;
    
    //注意
    UILabel *detail=[[UILabel alloc]init];
    //WithFrame:CGRectMake(5, 10, 310, 50)
    detail.font=[UIFont systemFontOfSize:12];
    detail.textColor=RedButtonColor;
    detail.numberOfLines=0;
    //MoneyLabel.textColor=CMColor(153, 153, 153);
    detail.text=@"* 开户行是指您的银行卡开户的支行或者分理处,例如：工商银行北京市魏公村支行,如果无法确认,建议您致电银行客户咨询。";
    [bgView addSubview:detail];
    
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(50);
        make.top.equalTo(bgView.mas_top);
        
        
    }];
    
    UIButton *Next=[UIButton buttonWithType:UIButtonTypeCustom];
    // Next.frame=CGRectMake(10,70, 300,40);
    [Next setBackgroundColor:RedButtonColor];
    [Next setTitle:@"下一步" forState:UIControlStateNormal];
    [Next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.NextBtn=Next;
    Next.layer.cornerRadius=5.0;
    Next.clipsToBounds=YES;
    //        [Next addTarget:self action:@selector(NextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:Next];
    
    [Next mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(40);
        make.top.equalTo(detail.mas_bottom);
        make.centerX.equalTo(bgView.mas_centerX);
        
    }];
    
    UILabel *tishi=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 115, 100, 20)
    tishi.text=@"温馨提示:\n  * 请输入您要提现的金额(单笔提现金额不超过五万元),以及正确无误的银行账户信息,并且银行卡户主姓名和您实名认证的姓名一致;\n  * 手续费为3‰,单笔手续费不满3元按3元收取,单笔手续费超过100元,按100元收取。若是财猫网VIP等级为1的用户,提现手续费9折优惠,等级为2的用户,提现手续费8.5折优惠,等级为3的用户,提现手续费7.5折优惠,等级为4的用户,提现手续费5折优惠,等级为5的用户,免手续费;\n  * 周一至周五每日16:00之前的提现,一般当日到账,最迟3个工作日内到账;\n  * 周五17点30分之前的提现,一般将在下周1到账;\n  * 节假日期间的提现,将在正式上班后的第二天到账。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tishi.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tishi.text length])];
    tishi.attributedText = attributedString;
    tishi.numberOfLines=0;
    tishi.font=[UIFont systemFontOfSize:13.0];
    tishi.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi];
    [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(400-40-50);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.top.equalTo(Next.mas_bottom);
        
    }];
    
    /*
    UILabel *tishi=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 115, 100, 20)
    tishi.text=@"温馨提示:";
    tishi.font=[UIFont systemFontOfSize:14];
    // tishi.textColor=CMColor(200, 200, 200);
    tishi.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi];
    
    [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.top.equalTo(Next.mas_bottom).offset(20);
        
    }];
    
    
    
    UILabel *tishi1=[[UILabel alloc]init];
    //ithFrame:CGRectMake(10, 125, 300, 80)
    tishi1.text=@"* 请输入您要提现的金额(单笔提现金额不超过五万元),以及正确无误的银行账户信息,并且银行卡户主姓名和您实名认证的姓名一致;";
    NSString *tiShiStr=tishi1.text;
    CGRect rect=[tiShiStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [tishi1 setNumberOfLines:0];
    tishi1.numberOfLines=0;
    tishi1.font=[UIFont systemFontOfSize:13];
    //tishi1.textColor=CMColor(200, 200, 200);
    tishi1.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi1];
    [tishi1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(rect.size.height+5);
        make.left.equalTo(tishi.mas_left);
        make.top.equalTo(tishi.mas_bottom).offset(5);
        make.width.mas_equalTo(rect.size.width);
    }];
    
    
    
    UILabel *tishi2=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 190, 300, 40)
    tishi2.text=@"* 手续费为3‰,单笔手续费不满3元按3元收取,单笔手续费超过100元,按100元收取。若是财猫网VIP等级为1的用户,提现手续费9折优惠,,等级为2的用户,提现手续费8.5折优惠,等级为3的用户,提现手续费7.5折优惠,等级为4的用户,提现手续费5折优惠,等级为5的用户,免手续费;";
    NSString *tiShiStr1=tishi1.text;
    CGRect rect1=[tiShiStr1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    tishi2.numberOfLines=0;
    tishi2.font=[UIFont systemFontOfSize:13];
    // tishi2.textColor=CMColor(200, 200, 200);
    tishi2.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi2];
    
    [tishi2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(rect1.size.width);
        make.height.mas_equalTo(rect1.size.height+50);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi1.mas_bottom);
        
    }];
    
    
    
    
    UILabel *tishi3=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 230, 300, 32)
    tishi3.text=@"* 周一至周五每日16:00之前的提现,一般当日到账,最迟3个工作日内到账;";
    NSString *tiShiStr2=tishi3.text;
    CGRect rect2=[tiShiStr2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    tishi3.numberOfLines=0;
    tishi3.font=[UIFont systemFontOfSize:13];
    //tishi3.textColor=CMColor(200, 200, 200);
    tishi3.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi3];
    [tishi3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(rect2.size.width);
        make.height.mas_equalTo(rect2.size.height+5);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi2.mas_bottom);
        
    }];
    
    
    
    UILabel *tishi4=[[UILabel alloc]init];
    // WithFrame:CGRectMake(10, 265, 300, 20)
    tishi4.text=@"* 周五17点30分之前的提现,一般将在下周1到账;";
    tishi4.numberOfLines=0;
    tishi4.font=[UIFont systemFontOfSize:13];
    //tishi4.textColor=CMColor(200, 200, 200);
    tishi4.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi4];
    [tishi4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi3.mas_bottom).offset(5);
        
    }];
    UILabel *tishi5=[[UILabel alloc]init];
    // WithFrame:CGRectMake(10, 290, 300,20)
    tishi5.text=@"* 节假日期间的提现,将在正式上班后的第2天到账。";
    tishi5.numberOfLines=0;
    tishi5.font=[UIFont systemFontOfSize:13];
    //tishi5.textColor=CMColor(200, 200, 200);
    tishi5.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi5];
    NSString *tiShiStr4=tishi5.text;
    CGRect rect4=[tiShiStr4 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
    [tishi5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(rect4.size.width);
        make.height.mas_equalTo(rect4.size.height);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi4.mas_bottom).offset(10);
        
    }];
    */
        return bgView;
   
    
}

-(UIView*)creatTiXianDetailFootView{
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 450)];
    bgView.backgroundColor=ViewBackColor;
    
    //注意
    UILabel *detail=[[UILabel alloc]init];
    detail.font=[UIFont systemFontOfSize:12];
    detail.textColor=RedButtonColor;
    detail.numberOfLines=0;
    //MoneyLabel.textColor=CMColor(153, 153, 153);
    //_detail.text=@"*请输入交易密码";
    detail.hidden=YES;
    self.errorLabel=detail;
    [bgView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.top.equalTo(bgView.mas_top).offset(10);
        make.height.mas_equalTo(35);
        make.right.equalTo(bgView.mas_right).offset(-10);
        
        
    }];
    
    UIButton *Next=[UIButton buttonWithType:UIButtonTypeCustom];
   // Next.frame=CGRectMake(10,70, 300,40);
    [Next setBackgroundColor:RedButtonColor];
    [Next setTitle:@"立即提现" forState:UIControlStateNormal];
    [Next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Next.layer.cornerRadius=5.0;
    Next.clipsToBounds=YES;
    self.TiXianBtnClick=Next;
   // [Next addTarget:self action:@selector(LiJiTiXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:Next];
    
    [Next mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(detail.mas_bottom).offset(10);
        make.height.equalTo(@40);
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.mas_equalTo(300);
        
    }];
//
    
    UILabel *tishi=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 115, 100, 20)
    tishi.text=@"温馨提示:\n  * 请输入您要提现的金额(单笔提现金额不超过五万元),以及正确无误的银行账户信息,并且银行卡户主姓名和您实名认证的姓名一致;\n  * 手续费为3‰,单笔手续费不满3元按3元收取,单笔手续费超过100元,按100元收取。若是财猫网VIP等级为1的用户,提现手续费9折优惠,等级为2的用户,提现手续费8.5折优惠,等级为3的用户,提现手续费7.5折优惠,等级为4的用户,提现手续费5折优惠,等级为5的用户,免手续费;\n  * 周一至周五每日16:00之前的提现,一般当日到账,最迟3个工作日内到账;\n  * 周五17点30分之前的提现,一般将在下周1到账;\n  * 节假日期间的提现,将在正式上班后的第二天到账。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tishi.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tishi.text length])];
    tishi.attributedText = attributedString;
    tishi.numberOfLines=0;
    tishi.font=[UIFont systemFontOfSize:13.0];
    tishi.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi];
    [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(450-10-40-10-35);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.top.equalTo(Next.mas_bottom).offset(-25);
        
    }];
    /*
    UILabel *tishi1=[[UILabel alloc]init];
   // WithFrame:CGRectMake(10, 125, 300, 80)
    tishi1.text=@"* 请输入您要提现的金额(单笔提现金额不超过五万元),以及正确无误的银行账户信息,并且银行卡户主姓名和您实名认证的姓名一致;";
    tishi1.numberOfLines=0;
    tishi1.font=[UIFont systemFontOfSize:13];
    tishi1.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi1];
    NSString *tiShiStr=tishi1.text;
    CGRect rect=[tiShiStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [tishi1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(rect.size.height+5);
        make.left.equalTo(tishi.mas_left);
        make.top.equalTo(tishi.mas_bottom).offset(5);
        make.width.mas_equalTo(rect.size.width);
    }];
    
    
    
    UILabel *tishi2=[[UILabel alloc]init];
   // WithFrame:CGRectMake(10, 190, 300, 40)
    tishi2.text=@"* 手续费为3‰,单笔手续费不满3元按3元收取,单笔手续费超过100元,按100元收取。若是财猫网VIP等级为1的用户,提现手续费9折优惠,,等级为2的用户,提现手续费8.5折优惠,等级为3的用户,提现手续费7.5折优惠,等级为4的用户,提现手续费5折优惠,等级为5的用户,免手续费;";
    tishi2.numberOfLines=0;
    tishi2.font=[UIFont systemFontOfSize:13];
    tishi2.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi2];
    NSString *tiShiStr1=tishi1.text;
    CGRect rect1=[tiShiStr1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
    [tishi2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(rect1.size.width);
        make.height.mas_equalTo(rect1.size.height+40);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi1.mas_bottom).offset(-5);
        
    }];
    
 
    UILabel *tishi3=[[UILabel alloc]init];//WithFrame:CGRectMake(10, 230, 300, 32)
    tishi3.text=@"* 周一至周五每日16:00之前的提现,一般当日到账,最迟3个工作日内到账;";
    tishi3.numberOfLines=0;
    tishi3.font=[UIFont systemFontOfSize:13];
    tishi3.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi3];
    
    NSString *tiShiStr2=tishi3.text;
    CGRect rect2=[tiShiStr2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [tishi3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(rect2.size.width);
        make.height.mas_equalTo(rect2.size.height+5);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi2.mas_bottom).offset(-5);
        
    }];
    
    
    
    
    UILabel *tishi4=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 265, 300, 20)
    tishi4.text=@"* 周五17点30分之前的提现,一般将在下周1到账;";
    tishi4.numberOfLines=0;
    tishi4.font=[UIFont systemFontOfSize:13];
    tishi4.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi4];
    [tishi4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi3.mas_bottom).offset(5);
        
    }];
    
    UILabel *tishi5=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 290, 300,20)
    tishi5.text=@"* 节假日期间的提现,将在正式上班后的第二天到账。";
    tishi5.numberOfLines=0;
    tishi5.font=[UIFont systemFontOfSize:13];
    tishi5.textColor=[UIColor lightGrayColor];
    [bgView addSubview:tishi5];
    NSString *tiShiStr4=tishi5.text;
    CGRect rect4=[tiShiStr4 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
    [tishi5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(rect4.size.width+2);
        make.height.mas_equalTo(rect4.size.height);
        make.left.equalTo(tishi1.mas_left);
        make.top.equalTo(tishi4.mas_bottom).offset(10);
        
    }];
     */
    return bgView;
}
#pragma mark 创建表头
-(UIView *)creatHeadView{
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    //日期
    
    UILabel *dateLabel=[[UILabel alloc]init];
    //WithFrame:CGRectMake(15,10, 30, 30)
    dateLabel.text=@"日期";
    dateLabel.textAlignment=NSTextAlignmentCenter;
    dateLabel.font=[UIFont boldSystemFontOfSize:15];
    [view  addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.top.equalTo(view.mas_top).offset(10);
        make.height.width.mas_equalTo(30);
        
        
    }];
    
    //金额费用
    UILabel *MoneyLabel=[[UILabel alloc]init];
    //WithFrame:CGRectMake(130,10, 30, 40)
    MoneyLabel.text=@"金额费用";
    MoneyLabel.numberOfLines=0;
    MoneyLabel.textAlignment=NSTextAlignmentCenter;
    MoneyLabel.font=[UIFont boldSystemFontOfSize:15];
    [view  addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.top.equalTo(view.mas_top).offset(10);
        make.height.width.mas_equalTo(30);
        
        
    }];
    
    
    
    
    UILabel *realAccount=[[UILabel alloc]initWithFrame:CGRectMake(240,10,70, 40)];
    realAccount.text=@"实际到账状态";
    realAccount.numberOfLines=0;
    realAccount.textAlignment=NSTextAlignmentCenter;
    realAccount.font=[UIFont boldSystemFontOfSize:15];
    [view  addSubview:realAccount];
    
    return view;
}

@end
