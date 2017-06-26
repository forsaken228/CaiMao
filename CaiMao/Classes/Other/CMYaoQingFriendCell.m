//
//  CMYaoQingFriendCell.m
//  CaiMao
//
//  Created by MAC on 16/8/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMYaoQingFriendCell.h"

@implementation CMYaoQingFriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *user=[UILabel new];
        user.text=@"用户名";
        user.font=[UIFont systemFontOfSize:14.0];
        user.textColor=[UIColor lightGrayColor];
        user.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:user];
        [user mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
        
        UILabel *username=[UILabel new];
       self.phoneNum=username;
        username.font=[UIFont systemFontOfSize:14.0];
       // username.textColor=[UIColor lightGrayColor];
        username.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:username];
        [username mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.centerX.equalTo(user);
            make.top.equalTo(user.mas_bottom).offset(5);
        }];
         
        
        UILabel *RTime=[UILabel new];
        RTime.text=@"注册时间";
        RTime.font=[UIFont systemFontOfSize:14.0];
        RTime.textColor=[UIColor lightGrayColor];
        RTime.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:RTime];
        [RTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
        
       
        UILabel *LJ=[UILabel new];
        LJ.text=@"累计奖励";
        LJ.font=[UIFont systemFontOfSize:14.0];
        LJ.textColor=[UIColor lightGrayColor];
        LJ.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:LJ];
        [LJ mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
        
        UILabel *registTim=[UILabel new];
        self.registTime=registTim;
        registTim.font=[UIFont systemFontOfSize:14.0];
        // username.textColor=[UIColor lightGrayColor];
        registTim.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:registTim];
        [registTim mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.top.equalTo(username.mas_top);
            make.centerX.equalTo(RTime);
        }];
        UILabel *total=[UILabel new];
        self.totalJiang=total;
        total.font=[UIFont systemFontOfSize:14.0];
        // username.textColor=[UIColor lightGrayColor];
        total.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:total];
        [total mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.top.equalTo(username.mas_top);
            make.centerX.equalTo(LJ);
        }];
        
        
    }
    return self;
}

@end
