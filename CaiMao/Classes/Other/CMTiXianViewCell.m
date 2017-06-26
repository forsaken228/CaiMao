//
//  CMTiXianViewCell.m
//  CaiMao
//
//  Created by MAC on 16/6/23.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTiXianViewCell.h"

@implementation CMTiXianViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *tLabel=[[UILabel alloc]init];
       // WithFrame:CGRectMake(10,10, 100, 30)
        self.BankName=tLabel;
        tLabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:tLabel];
        [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(self.mas_left).offset(10);
             make.top.mas_equalTo(self.mas_top).offset(10);
        }];
        UIButton *tButton=[UIButton buttonWithType:UIButtonTypeSystem];
        tButton.frame=CGRectMake(146, 8, 166, 30);
        tButton.titleLabel.font=[UIFont systemFontOfSize:15];
        self.choiceAddress=tButton;
        [self addSubview:tButton];
        
        [tButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self);
            make.width.mas_equalTo(166);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            
        }];
        
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=separateLineColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.width.left.equalTo(self);
        }];
        
    }
    
    return  self;
}

@end
