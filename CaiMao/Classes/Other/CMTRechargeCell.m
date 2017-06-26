//
//  CMTRechargeCell.m
//  CaiMao
//
//  Created by MAC on 16/7/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTRechargeCell.h"

@implementation CMTRechargeCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CMScreenW, 10)];
        
        view.backgroundColor = ViewBackColor;
        
        [self addSubview:view];
        
        UILabel *tTitle=[[UILabel alloc]init];
        self.lineRecharge=tTitle;
      
        tTitle.font=[UIFont systemFontOfSize:14.0];
        tTitle.textColor=CMColor(26, 26, 26);
        tTitle.textAlignment=NSTextAlignmentLeft;
        [self addSubview:tTitle];
         [tTitle mas_makeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(80);
             make.left.equalTo(self.mas_left).offset(8);
             make.top.equalTo(view.mas_bottom).offset(5);
         }];
        
        UILabel *tSource=[[UILabel alloc]init];
        self.sourceTitle=tSource;
        tSource.backgroundColor=[UIColor lightGrayColor];
        tSource.font=[UIFont systemFontOfSize:11.0];
        tSource.textColor=[UIColor whiteColor];
        tSource.clipsToBounds=YES;
        tSource.layer.cornerRadius=3.0;
        tSource.textAlignment=NSTextAlignmentCenter;
        [self addSubview:tSource];
        [tSource mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(30);
            make.left.equalTo(tTitle.mas_right).offset(8);
            make.top.equalTo(tTitle);
        }];
        
        UILabel *tJinE=[[UILabel alloc]init];
        self.jinE=tJinE;
        tJinE.font=[UIFont systemFontOfSize:14.0];
        tJinE.textColor=CMColor(251,63,25);
        tJinE.textAlignment=NSTextAlignmentRight;
        [self addSubview:tJinE];
        [tJinE mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(150);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(tTitle);
        }];
        
        
        UILabel *tDate=[[UILabel alloc]init];
        self.dateLabel=tDate;
        tDate.font=[UIFont systemFontOfSize:12.0];
        tDate.textColor=CMColor(180,180,180);
        tDate.textAlignment=NSTextAlignmentLeft;
        [self addSubview:tDate];
        [tDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(150);
            make.left.equalTo(tTitle);
            make.top.equalTo(tTitle.mas_bottom).offset(2);
        }];
        
        UIButton *tState=[UIButton buttonWithType:UIButtonTypeSystem];
        self.SateLabel=tState;
        tState.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        tState.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [self addSubview:tState];
        [tState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.equalTo(tJinE);
            make.top.equalTo(tDate);
        }];
        
        
        
    }
    
    return self;
}

@end
