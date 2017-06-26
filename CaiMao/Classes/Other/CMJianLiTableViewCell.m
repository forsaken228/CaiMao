//
//  CMJianLiTableViewCell.m
//  CaiMao
//
//  Created by MAC on 16/8/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMJianLiTableViewCell.h"

@implementation CMJianLiTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UILabel *jiner=[UILabel new];
        jiner.text=@"奖励金额";
        jiner.font=[UIFont systemFontOfSize:14.0];
        jiner.textColor=[UIColor lightGrayColor];
        //jiner.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:jiner];
        [jiner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
        
        UILabel *JJInEr=[UILabel new];
        self.jinEr=JJInEr;
        JJInEr.font=[UIFont systemFontOfSize:14.0];
        // username.textColor=[UIColor lightGrayColor];
        //JJInEr.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:JJInEr];
        [JJInEr mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.centerX.width.equalTo(jiner);
            make.top.equalTo(jiner.mas_bottom).offset(5);
        }];
        
        
        UILabel *DTTime=[UILabel new];
        DTTime.text=@"到账时间";
        DTTime.font=[UIFont systemFontOfSize:14.0];
        DTTime.textColor=[UIColor lightGrayColor];
        DTTime.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:DTTime];
        [DTTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
        
        UILabel *DTime=[UILabel new];
        self.DZTime=DTime;
        DTime.font=[UIFont systemFontOfSize:14.0];
        // username.textColor=[UIColor lightGrayColor];
        DTime.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:DTime];
        [DTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.centerX.equalTo(DTTime);
            make.top.equalTo(JJInEr.mas_top);
           
        }];
        UILabel *FFriend=[UILabel new];
        FFriend.text=@"来自朋友";
        FFriend.font=[UIFont systemFontOfSize:14.0];
        FFriend.textColor=[UIColor lightGrayColor];
        FFriend.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:FFriend];
        [FFriend mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
        UILabel *Friend=[UILabel new];
        self.FromFriend=Friend;
        Friend.font=[UIFont systemFontOfSize:14.0];
        // username.textColor=[UIColor lightGrayColor];
        Friend.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:Friend];
        [Friend mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.centerX.equalTo(FFriend);
            make.top.equalTo(JJInEr.mas_top);
            
        }];
        
 
      
        UILabel *TZi=[UILabel new];
        TZi.text=@"投资金额";
        TZi.font=[UIFont systemFontOfSize:14.0];
        TZi.textColor=[UIColor lightGrayColor];
       
        [self.contentView addSubview:TZi];
        [TZi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@70);
            make.left.equalTo(jiner);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        UILabel *TZiJ=[UILabel new];
        self.TouZiJE=TZiJ;
        TZiJ.font=[UIFont systemFontOfSize:13.0];
      //  TZiJ.textColor=[UIColor lightGrayColor];
        TZiJ.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:TZiJ];
        [TZiJ mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@150);
            make.left.equalTo(TZi.mas_right);
            make.bottom.equalTo(TZi);
        }];
        UILabel *TDate=[UILabel new];
        self.TZDate=TDate;
        TDate.font=[UIFont systemFontOfSize:13.0];
       // TDate.textColor=[UIColor lightGrayColor];
        TDate.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:TDate];
        [TDate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@60);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        UILabel *TD=[UILabel new];
       TD.text=@"投资天数";
        TD.font=[UIFont systemFontOfSize:14.0];
        TD.textColor=[UIColor lightGrayColor];
        TD.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:TD];
        [TD mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@70);
            make.right.equalTo(TDate.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
    }
    return self;
}

@end
