//
//  CMDealRecordCell.m
//  CaiMao
//
//  Created by MAC on 16/8/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDealRecordCell.h"

@implementation CMDealRecordCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        UILabel *people=[UILabel new];
        self.JIPaiUser=people;
        people.textColor=UIColorFromRGB(0x999999);
        people.font=[UIFont systemFontOfSize:11.0];
        //people.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:people];
        [people mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(5);
            make.width.equalTo(@90);
        }];
        
        
        UILabel *jinEr=[UILabel new];
        self.TZJinEr=jinEr;
        jinEr.textColor=UIColorFromRGB(0x999999);
        jinEr.font=[UIFont systemFontOfSize:11.0];
        //jinEr.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:jinEr];
        [jinEr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.contentView);
            make.left.equalTo(people.mas_right);
            make.width.equalTo(@80);
        }];
       
        
        
        UILabel *time=[UILabel new];
        self.TZDealTime=time;
        time.textColor=UIColorFromRGB(0x999999);
        time.font=[UIFont systemFontOfSize:11.0];
        time.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
            make.width.equalTo(@70);
        }];
        
        UIImageView *state=[UIImageView new];
        self.TZState=state;
        [self.contentView addSubview:state];
        [state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@10);
            make.right.equalTo(time.mas_left).offset(-30);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        UILabel *fen=[UILabel new];
        self.TZFenNum=fen;
        fen.textColor=UIColorFromRGB(0x999999);
        fen.font=[UIFont systemFontOfSize:11.0];
        //jinEr.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:fen];
        [fen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.contentView);
            make.right.equalTo(state.mas_left).offset(-10);
            make.width.equalTo(@40);
        }];
        
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=separateLineColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.width.left.equalTo(self);
        }];
        
    }
    return self;
}

@end
