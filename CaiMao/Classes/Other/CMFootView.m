//
//  CMFootView.m
//  CaiMao
//
//  Created by MAC on 16/11/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMFootView.h"

@implementation CMFootView

-(instancetype)init{
    self=[super init];
    if (self) {
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=UIColorFromRGB(0xff7500);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@2);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
        }];
        
        UILabel *Title=[[UILabel alloc]init];
        Title.text=@"VIP专属特权";
        Title.textColor=UIColorFromRGB(0xbbbbbb);
        Title.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:Title];
        [Title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(line);
            make.width.equalTo(@150);
            make.left.equalTo(line.mas_right).offset(5);
        }];
        UIView *bgView=[[UIView alloc]init];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(310);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.width.left.equalTo(self);
        }];
        NSArray *bgColorArr=@[UIColorFromRGB(0x3ebfab),UIColorFromRGB(0xff993c),UIColorFromRGB(0xf6b331),UIColorFromRGB(0xff5c5f),UIColorFromRGB(0xa350ea),UIColorFromRGB(0x6190e8),UIColorFromRGB(0x6c7de5),UIColorFromRGB(0xe4e6e5)];

        NSArray *midTitleArr=@[@"优先赔付权",@"专享投资权",@"提现免费权",@"奖励多多",@"专属理财咨询服务",@"VIP专属微信群",@"专属炫彩身份标识",@"更多尊贵VIP会员特权"];
        NSArray *BotoomTitleArr=@[@"优先本息垫付,安全再加倍",@"VIP产品你的专属理财产品",@"VIP专享,免提现手续费",@"生日、春节、等级提升 礼金不断",@"一对一贴心服务",@"每周固定活动、奖励多多",@"彰显最贵身份等级",@"将会陆续添加,敬请期待"];
        float interval = (CMScreenW-3*100)/4;
        float  ver= (310-3*90)/4;
        for (int i=0; i<midTitleArr.count; i++) {
        
            CMVIPCustomImage *custom=[[CMVIPCustomImage alloc]init];
            int x=(i%3 )* (100+interval)+interval;
            int y=(i/3) * (90+ver)+10;
            custom.frame=CGRectMake(x, y, 100,90);
            custom.backgroundColor=bgColorArr[i];
            custom.MidLabel.text=midTitleArr[i];
            custom.TopImage.image=[UIImage imageNamed:midTitleArr[i]];
            custom.bottomLabel.text=BotoomTitleArr[i];
            [bgView addSubview:custom];
            CGRect rect=[custom.bottomLabel.text boundingRectWithSize:CGSizeMake(100, 40) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]} context:nil];
            
          [custom.bottomLabel mas_updateConstraints:^(MASConstraintMaker *make) {
              make.height.mas_equalTo(rect.size.height+2);
          }];
            if (i==7) {
                custom.MidLabel.textColor=UIColorFromRGB(0x333333);
                custom.bottomLabel.textColor=UIColorFromRGB(0x8e8d93);
            }
            
            
        }
        
        UIView *line1=[[UIView alloc]init];
        line1.backgroundColor=UIColorFromRGB(0xff7500);
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@2);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(bgView.mas_bottom).offset(10);
        }];
        
        UILabel *Title1=[[UILabel alloc]init];
        Title1.text=@"如何成为VIP";
        Title1.textColor=UIColorFromRGB(0xbbbbbb);
        Title1.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:Title1];
        [Title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(line1);
            make.width.equalTo(@150);
            make.left.equalTo(line1.mas_right).offset(5);
        }];
        
        UILabel *Detail=[[UILabel alloc]init];
        Detail.text=@"会员通过投资、签到、邀请好友获得成长值,免费升级成VIP会员！VIP会员共划分为5个等级(VIP1-VIP5),通过成长值的累积从而提升VIP等级,享受更多、更丰厚特权!了解成长值>>";
        Detail.numberOfLines=0;
        Detail.userInteractionEnabled=YES;
        Detail.font=[UIFont systemFontOfSize:12.0];
        Detail.textColor=UIColorFromRGB(0x8e8e8e);
        Detail.backgroundColor=[UIColor whiteColor];
        Detail.textAlignment=NSTextAlignmentCenter;
        [self addSubview:Detail];
        CGRect rect1=[Detail.text boundingRectWithSize:CGSizeMake(CMScreenW, 50) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
        [Detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.mas_bottom).offset(10);
            make.right.left.equalTo(self);
            //make.left.equalTo(self.mas_left).offset(5);
            make.height.mas_equalTo(rect1.size.height+40);
        }];
        
        NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString:  Detail.text];
        NSRange PayFromRang1 = [ Detail.text rangeOfString:@"了"];
        [Pay addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(PayFromRang1.location, 7)];
        Detail.attributedText = Pay;
  
        UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick)];
        [Detail addGestureRecognizer:tap];
        
        
    }
    
    return self;
    
}
-(void)TapClick{
    if ([_delegate respondsToSelector:@selector(GoChengzhangZhi)]) {
        [_delegate GoChengzhangZhi];
    }
    
    
}
@end
