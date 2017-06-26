//
//  CMTestWealthView.m
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMTestWealthView.h"

@implementation CMTestWealthView

-(instancetype)init{
    self=[super init];
    if (self) {
        
        self.backgroundColor=UIColorFromRGB(0xfdf9dc);
        UIView *bg=[UIView new];
        bg.backgroundColor=ViewBackColor;
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.left.right.equalTo(self);
            make.height.equalTo(@10);

        }];
        [self addSubview:self.joinLabel];
        [self.joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(bg.mas_bottom);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self);
            
        }];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent)];
        [self.joinLabel addGestureRecognizer:tap];
    }
    
    return self;
}
-(UILabel*)joinLabel{
    if (!_joinLabel) {
       _joinLabel=[[UILabel alloc]init];
        _joinLabel.numberOfLines=0;
       _joinLabel.font=[UIFont systemFontOfSize:11];
        _joinLabel.textColor=UIColorFromRGB(0xfba363);
       _joinLabel.text=@"测测您的财富指数有多高,全面了解您的风险承受能力,给您的资产配置提供最优的建议,立即测试和查看>>";
        _joinLabel.userInteractionEnabled=YES;
        NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: _joinLabel.text];
        NSRange PayFromRang1 = [_joinLabel.text rangeOfString:@"立"];
        NSRange PayToRang1 = [ _joinLabel.text rangeOfString:@">"];
        [Pay addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1daaf6) range:NSMakeRange(PayFromRang1.location, PayToRang1.location-PayFromRang1.location+2)];
        _joinLabel.attributedText = Pay;

    }
    return _joinLabel;
}
-(void)tapGestureEvent{

    self.testBlockClick();
}
@end
